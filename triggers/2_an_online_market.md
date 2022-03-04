Let's create a very simple model for a market in Daml. Click on the IDE tab and wait for it to
load, then open `daml/Market.daml`{{open}}. Copy paste the following Daml code:

<pre class="file"i data-filename="daml/Market.daml" data-target="append">
module Market where

import DA.Date

-- MAIN_TEMPLATE_BEGIN
template User with
    username: Party
    following: [Party]
  where
    signatory username
    observer following
-- MAIN_TEMPLATE_END

    key username: Party
    maintainer key

    -- FOLLOW_BEGIN
    nonconsuming choice Follow: ContractId User with
        userToFollow: Party
      controller username
      do
        assertMsg "You cannot follow yourself" (userToFollow /= username)
        assertMsg "You cannot follow the same user twice" (notElem userToFollow following)
        archive self
        create this with following = userToFollow :: following
    -- FOLLOW_END

    nonconsuming choice NewSellOffer : ()
      with
        observers : [Party]
        title : Text
        description : Text
        price : Int
      controller username
        do
          now <- getTime
          create $ SellOffer {seller = username, date = toDateUTC now, ..}
          pure ()

    nonconsuming choice TakeSellOffer : ()
      with
        offer : ContractId SellOffer
      controller username
        do
          exercise offer DoTrade with tradePartner = username
          pure ()

    nonconsuming choice ConfirmPayment : ()
      with
        invoice : ContractId Invoice
      controller username
        do
          Invoice{..} <- fetch invoice
          assert $ owner == username
          create $ PaymentConfirmation
                      with
                        invoice = invoice
                        party = username
                        obligor = obligor
          pure ()

-- ALIAS_BEGIN
template Alias with
    username: Party
    alias: Text
    public: Party
  where
    signatory username
    observer public

    key (username, public) : (Party, Party)
    maintainer key._1

    nonconsuming choice Change: ContractId Alias with
        newAlias: Text
      controller username
      do
        archive self
        create this with alias = newAlias
-- ALIAS_END

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

- Our market model follows the [Role pattern](https://digitalasset.com/developers/interactive-tutorials/fundamental-concepts/choices-role-pattern). It defines a `User` template and offers non-consuming choices to
  - create a new offer
  - take an offer
  - create a payment confirmation to signal that a payment has been received for the offer
- Every `SellOffer` template has a self-archiving choice `DoTrade` to take the offer from the market
  and automatically create an `Invoice` contract for the buyer.
- Every `PaymentConfirmation` contract has a self-archiving choice that offers the obligor of the
  invoice to archive the referenced `Invoice`.
