Let’s start with looking at some smart contract code. In our example, we’ll have three parties, Alice, Bob and the Bank. In the scenario, Alice and Bob will agree that Bob has to paint her house. In exchange, Bob will get a digital bank note (I-Owe-You, IOU) from Alice, issued by a bank.

First, we need to add the Bank as a party:

```val bank = participant2.parties.enable("Bank", waitForDomain = DomainChoice.All)```{{execute T1}}

You might have noticed that we’ve added a `waitForDomain` argument here. This is necessary to force some synchronisation between the nodes to ensure that the new party is known within the distributed system before it is used.

> Note: Canton alleviates most synchronization issues when interacting with Daml contracts. Nevertheless, Canton is a concurrent, distributed system. All operations happen asynchronously. Creating the `Bank` party is an operation local to `participant2`, and `mydomain` becomes aware of the party with a delay (see [Topology Transactions](https://www.canton.io/docs/dev/user-manual/usermanual/identity_management.html#identity-transactions) for more detail). Processing and network delays also exist for all other operations that affect multiple nodes, though everyone sees the operations on the domain in the same order. When you execute commands interactively, the delays are usually too small to notice. However, if you’re programming Canton scripts or applications that talk to multiple nodes, you might need some form of manual synchronization. Most Canton console commands have some form of synchronisation to simplify your life and sometimes, using `utils.retry_until_true(...)` comes in as a handy solution.

Now, the corresponding Daml contracts that we are going to use for this example are:

```
module Iou where

import Daml.Script

data Amount = Amount {value: Decimal; currency: Text} deriving (Eq, Ord, Show)

amountAsText (amount : Amount) : Text = show amount.value <> amount.currency

template Iou
  with
    payer: Party
    owner: Party
    amount: Amount
    viewers: [Party]
  where

    ensure (amount.value >= 0.0)

    signatory payer
    observer viewers

    controller owner can
      Call : ContractId GetCash do
        create GetCash with payer; owner; amount
      Transfer : ContractId Iou
         with newOwner: Party do
           create this with owner = newOwner; viewers = []
      Share : ContractId Iou
            with viewer : Party
          do
            create this with viewers = (viewer :: viewers)
module Paint where
```

```
import Daml.Script
import Iou

template PaintHouse
  with
    painter: Party
    houseOwner: Party
  where
    signatory painter, houseOwner
    agreement
      show painter <> " will paint the house of " <> show houseOwner

template OfferToPaintHouseByPainter
  with
    houseOwner: Party
    painter: Party
    bank: Party
    amount: Amount
  where
    signatory painter
    controller houseOwner can
      AcceptByOwner : ContractId Iou with iouId : ContractId Iou
        do
          iouId2 <- exercise iouId Transfer with newOwner = painter
          paint <- create $ PaintHouse with painter; houseOwner
          return iouId2
```

We won’t dive into the details of Daml, as this is [explained elsewhere](https://docs.daml.com/daml/intro/0_Intro.html). But one key observation is that the contracts themselves are passive. The contract instances represent the ledger and only encode the rules according to which the ledger state can be changed. Any change requires to trigger some Daml contract execution by sending the appropriate commands over the Ledger API.

The Canton console gives you interactive access to this API, together with some utilities that can be useful for some first experimentation. The Ledger API is using [GRPC](http://grpc.io/).

In theory, we would need to compile the Daml code into a DAR and then subsequently upload it to the participant nodes. We actually did this already by uploading the CantonExamples.dar, where the contracts are already included. Therefore, let’s create our first contract using the template Iou.Iou. The name of the template is not enough to uniquely identify it. We need in addition the package id, which is just the sha256 hash of the binary module containing the respective template.

Let’s find that package by running ```val pkgIou = participant1.packages.find("Iou").head```{{execute T1}}. You will see an output like the one below:

```
@ val pkgIou = participant1.packages.find("Iou").head
pkgIou : com.digitalasset.canton.participant.admin.v0.PackageDescription = PackageDescription(
  packageId = "d96d66fa42dc72a667e0ab0f55ae9ad5a20848e11afe9008eb75aadcd786960b",
  sourceDescription = "CantonExamples"
)
```

Using this package-id, we can create the paint offer

```
val createIouCmd = ledger_api_utils.create(pkgIou.packageId,"Iou","Iou",Map("payer" -> bank,"owner" -> alice,"amount" -> Map("value" -> 100.0, "currency" -> "EUR"),"viewers" -> List()))
```{{execute T1}}

This will result in an output like the one below:

```
@ val createIouCmd = ledger_api_utils.create(pkgIou.packageId,"Iou","Iou",Map("payer" -> bank,"owner" -> alice,"amount" -> Map("value" -> 100.0, "currency" -> "EUR"),"viewers" -> List()))
createIouCmd : com.daml.ledger.api.v1.commands.Command = Command(
  command = Create(
    value = CreateCommand(
      templateId = Some(
        value = Identifier(
          packageId = "d96d66fa42dc72a667e0ab0f55ae9ad5a20848e11afe9008eb75aadcd786960b",
..
```

Then subsequently send that command to the Ledger Api ```participant2.ledger_api.commands.submit(Seq(bank), Seq(createIouCmd))```{{execute T1}} resulting in

```
@ participant2.ledger_api.commands.submit(Seq(bank), Seq(createIouCmd))
res27: com.daml.ledger.api.v1.transaction.TransactionTree = TransactionTree(
  transactionId = "12202dbbcb3c113b510aaa839db35173d30af6c5e03aa9310dc252a9870f5b1b10f4",
  commandId = "500f8df8-1985-48b3-990e-7aa102fcafd2",
  workflowId = "",
  effectiveAt = Some(
    value = Timestamp(
      seconds = 1644924293L,
      nanos = 934405000,
      unknownFields = UnknownFieldSet(fields = Map())
    )
  ),
  offset = "00000000000000000f",
..
```

Here, we’ve submitted this command as party `Bank` on `participant2`. Interestingly, we can test here the Daml authorization logic. As the signatory of the contract is `Bank`, we can’t have `Alice` submitting the contract:

```
participant1.ledger_api.commands.submit(Seq(alice), Seq(createIouCmd))
```{{execute T1}}

This will throw an error:

```
@ participant1.ledger_api.commands.submit(Seq(alice), Seq(createIouCmd))
ERROR com.digitalasset.canton.integration.EnterpriseEnvironmentDefinition$$anon$3 - Request failed for participant1.
  GrpcClientError: INVALID_ARGUMENT/DAML_AUTHORIZATION_ERROR(8,a79c195e): Interpretation error: Error: node NodeId(0) (d96d66fa42dc72a667e0ab0f55ae9ad5a20848e11afe9008eb75aadcd786960b:Iou:Iou) requires authorizers Bank::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa, but only Alice::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5 were given
  Request: SubmitAndWaitTransactionTree(actAs = Alice::12205f1c1f45..., commandId = '', workflowId = '', submissionId = '', deduplicationPeriod = None(), ledgerId = 'participant1', commands = ...)
  CorrelationId: a79c195e-cd00-40ad-8981-767af22d80d6
..
```

And `Alice` can not impersonate the `Bank` by pretending to be it (on her participant)

```
participant1.ledger_api.commands.submit(Seq(bank), Seq(createIouCmd))
```{{execute T1}}

This will throw an error:

```
@ participant1.ledger_api.commands.submit(Seq(bank), Seq(createIouCmd))
ERROR com.digitalasset.canton.integration.EnterpriseEnvironmentDefinition$$anon$3 - Request failed for participant1.
  GrpcRequestRefusedByServer: NOT_FOUND/NO_DOMAIN_ON_WHICH_ALL_SUBMITTERS_CAN_SUBMIT(11,c6273deb): This participant can not submit as the given submitter on any connected domain
  Request: SubmitAndWaitTransactionTree(actAs = Bank::12209ca4ab4f..., commandId = '', workflowId = '', submissionId = '', deduplicationPeriod = None(), ledgerId = 'participant1', commands = ...)
  CorrelationId: c6273debfb890d800a0761fe21357dfd
..
```

Now, `Alice` can observe the contract on her participant, by searching her *Active Contract Set (ACS)* for it ```val aliceIou = participant1.ledger_api.acs.find_generic(alice, _.templateId == "Iou.Iou")```{{execute T1}}

```
@ val aliceIou = participant1.ledger_api.acs.find_generic(alice, _.templateId == "Iou.Iou")
aliceIou : com.digitalasset.canton.admin.api.client.commands.LedgerApiTypeWrappers.WrappedCreatedEvent = WrappedCreatedEvent(
  event = CreatedEvent(
    eventId = "#12202dbbcb3c113b510aaa839db35173d30af6c5e03aa9310dc252a9870f5b1b10f4:0",
    contractId = "009edd811753317e39cff4f652b6965acd251a0f9f4fa53510c9d64f70baffc7eeca001220cda8c12637b5199f1a402f13c3c249fae6da144cf49d5425c112b8fd88a7a9b7",
..
```

We can check now the ACS of `Alice`, which will show us all contracts `Alice` knows about ```participant1.ledger_api.acs.of_party(alice)```{{execute T1}} resulting in the following output:

```
@ participant1.ledger_api.acs.of_party(alice)
res29: Seq[com.digitalasset.canton.admin.api.client.commands.LedgerApiTypeWrappers.WrappedCreatedEvent] = List(
  WrappedCreatedEvent(
    event = CreatedEvent(
      eventId = "#12202dbbcb3c113b510aaa839db35173d30af6c5e03aa9310dc252a9870f5b1b10f4:0",
      contractId = "009edd811753317e39cff4f652b6965acd251a0f9f4fa53510c9d64f70baffc7eeca001220cda8c12637b5199f1a402f13c3c249fae6da144cf49d5425c112b8fd88a7a9b7",
      templateId = Some(
        value = Identifier(
          packageId = "d96d66fa42dc72a667e0ab0f55ae9ad5a20848e11afe9008eb75aadcd786960b",
..
```

As expected, `Alice` does see exactly the contract that the Bank previously created. The command returns a sequence of wrapped `CreatedEvent`s. This Ledger API data type represents the event of a contract’s creation. The output is a bit verbose, but the wrapper provides convenient functions to manipulate the `CreatedEvents` in the Canton console ```participant1.ledger_api.acs.of_party(alice).map(x => (x.templateId, x.arguments))```{{execute T1}}:

```
@ participant1.ledger_api.acs.of_party(alice).map(x => (x.templateId, x.arguments))
res30: Seq[(String, Map[String, Any])] = List(
  (
    "Iou.Iou",
    HashMap(
      "payer" -> "Bank::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa",
      "viewers" -> List(elements = Vector()),
      "owner" -> "Alice::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5",
      "amount.currency" -> "EUR",
      "amount.value" -> "100.0000000000"
    )
  )
)
```

Going back to our story, `Bob` now wants to offer Alice to paint her house in exchange for money. Again, we need to grab the package id, as the Paint contract is in a different module ```val pkgPaint = participant1.packages.find("Paint").head```{{execute T1}}:

```
@ val pkgPaint = participant1.packages.find("Paint").head
pkgPaint : com.digitalasset.canton.participant.admin.v0.PackageDescription = PackageDescription(
  packageId = "d96d66fa42dc72a667e0ab0f55ae9ad5a20848e11afe9008eb75aadcd786960b",
  sourceDescription = "CantonExamples"
)
````

Note that the modules are compositional. The `Iou` module is not aware of the `Paint` module, but the `Paint` module is using the `Iou` module within its workflow. This is how we can extend any workflow in Daml and just build in top of it. In particular, the `Bank` does not need to know about the `Paint` module at all, but can still participate in the transaction, without any adverse effect. As a result, everybody can extend the system with their own functionality. Let’s create and submit the offer now

```
val createOfferCmd = ledger_api_utils.create(pkgPaint.packageId, "Paint", "OfferToPaintHouseByPainter", Map("bank" -> bank, "houseOwner" -> alice, "painter" -> bob, "amount" -> Map("value" -> 100.0, "currency" -> "EUR")))
participant2.ledger_api.commands.submit_flat(Seq(bob), Seq(createOfferCmd))
```{{execute T1}}

```
@ val createOfferCmd = ledger_api_utils.create(pkgPaint.packageId, "Paint", "OfferToPaintHouseByPainter", Map("bank" -> bank, "houseOwner" -> alice, "painter" -> bob, "amount" -> Map("value" -> 100.0, "currency" -> "EUR")))
createOfferCmd : com.daml.ledger.api.v1.commands.Command = Command(
  command = Create(
    value = CreateCommand(
      templateId = Some(
        value = Identifier(
          packageId = "d96d66fa42dc72a667e0ab0f55ae9ad5a20848e11afe9008eb75aadcd786960b",
..
@ participant2.ledger_api.commands.submit_flat(Seq(bob), Seq(createOfferCmd))
res33: com.daml.ledger.api.v1.transaction.Transaction = Transaction(
  transactionId = "1220e4ee04d8e47509c67017af3a0aa55eec22588c4961ac775a5bcca01262f9d1a4",
  commandId = "acf8b5db-fc4d-446f-b666-715a37ddbb14",
  workflowId = "",
  effectiveAt = Some(
    value = Timestamp(
..
```

`Alice` will observe this offer now on her node ```val paintOffer = participant1.ledger_api.acs.find_generic(alice, _.templateId == "Paint.OfferToPaintHouseByPainter")```{{execute T1}}

```
@ val paintOffer = participant1.ledger_api.acs.find_generic(alice, _.templateId == "Paint.OfferToPaintHouseByPainter")
paintOffer : com.digitalasset.canton.admin.api.client.commands.LedgerApiTypeWrappers.WrappedCreatedEvent = WrappedCreatedEvent(
  event = CreatedEvent(
    eventId = "#1220e4ee04d8e47509c67017af3a0aa55eec22588c4961ac775a5bcca01262f9d1a4:0",
    contractId = "00a5931b6b533a8f90523601167ba13a2044ff4a34c9911fe6ecf9d364358b9cf6ca0012202e46ef10c42c05d0b98b10167d531f20193d6293203f106ee03c45916d1d23ec",
    templateId = Some(
      value = Identifier(
..
```
