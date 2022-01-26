Let's create a very simple model for a market in Daml. Click on the IDE tab and wait for it to
load, then open `daml/Market.daml`{{open}}. Copy paste the following Daml code:

<pre class="file"i data-filename="daml/Market.daml" data-target="append">
module Market where

import DA.Date

template User
  with
    party : Party
  where
    signatory party
    key party : Party
    maintainer key

    nonconsuming choice NewSellOffer : ()
      with
        observers : [Party]
        title : Text
        description : Text
        price : Int
      controller party
        do
          now <- getTime
          create $ SellOffer {seller = party, date = toDateUTC now, ..}
          pure ()

    nonconsuming choice TakeSellOffer : ()
      with
        offer : ContractId SellOffer
      controller party
        do
          exercise offer DoTrade with tradePartner = party
          pure ()

    nonconsuming choice ConfirmPayment : ()
      with
        invoice : ContractId Invoice
      controller party
        do
          Invoice{..} <- fetch invoice
          assert $ owner == party
          create $ PaymentConfirmation
                      with
                        invoice = invoice
                        party = party
                        obligor = obligor
          pure ()

template SellOffer
  with
    observers : [Party]
    title : Text
    description : Text
    price : Int
    seller : Party
    date : Date
  where
    signatory seller
    observer observers

    nonconsuming choice DoTrade : ()
      with
        tradePartner : Party
      controller tradePartner
        do
          assert $ tradePartner `elem` observers
          archive self
          create $ Invoice {owner = seller, obligor = tradePartner, amount = price, description = title}
          pure ()

template Invoice
  with
    owner : Party
    obligor : Party
    amount : Int
    description : Text
  where
    signatory obligor
    observer owner

template PaymentConfirmation
  with
    invoice : ContractId Invoice
    party : Party
    obligor : Party
  where
    signatory party
    observer obligor

    nonconsuming choice ArchiveInvoice : ()
      controller obligor
      do
        archive invoice
        archive self
</pre>

- Our market model follows the [Role pattern](https://daml.com/interactive-tutorials/fundamental-concepts/choices-role-pattern). It defines a `User` template and offers non-consuming choices to
  - create a new offer
  - take an offer
  - create a payment confirmation to signal that a payment has been received for the offer
- Every `SellOffer` template has a self-archiving choice `DoTrade` to take the offer from the market
  and automatically create an `Invoice` contract for the buyer.
- Every `PaymentConfirmation` contract has a self-archiving choice that offers the obligor of the
  invoice to archive the referenced `Invoice`.
