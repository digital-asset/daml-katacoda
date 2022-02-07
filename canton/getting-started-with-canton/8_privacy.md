Looking at the ACS of `Alice`, `Bob` and the `Bank`, we note that Bob sees only the paint offer ```participant2.ledger_api.acs.of_party(bob).map(x => (x.templateId, x.arguments))```{{execute T1}}

```
@ participant2.ledger_api.acs.of_party(bob).map(x => (x.templateId, x.arguments))
res35: Seq[(String, Map[String, Any])] = List(
  (
    "Paint.OfferToPaintHouseByPainter",
    HashMap(
      "painter" -> "Bob::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa",
      "houseOwner" -> "Alice::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5",
      "bank" -> "Bank::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa",
      "amount.currency" -> "EUR",
      "amount.value" -> "100.0000000000"
    )
  )
)
```

while the `Bank` sees the `Iou` contract ```participant2.ledger_api.acs.of_party(bank).map(x => (x.templateId, x.arguments))```{{execute T1}}

```
@ participant2.ledger_api.acs.of_party(bank).map(x => (x.templateId, x.arguments))
res36: Seq[(String, Map[String, Any])] = List(
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

But `Alice` is seeing both on her participant ```participant1.ledger_api.acs.of_party(alice).map(x => (x.templateId, x.arguments))```{{execute T1}}

```
@ participant1.ledger_api.acs.of_party(alice).map(x => (x.templateId, x.arguments))
res37: Seq[(String, Map[String, Any])] = List(
  (
    "Iou.Iou",
    HashMap(
      "payer" -> "Bank::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa",
      "viewers" -> List(elements = Vector()),
      "owner" -> "Alice::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5",
      "amount.currency" -> "EUR",
      "amount.value" -> "100.0000000000"
    )
  ),
  (
    "Paint.OfferToPaintHouseByPainter",
    HashMap(
      "painter" -> "Bob::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa",
      "houseOwner" -> "Alice::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5",
      "bank" -> "Bank::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa",
      "amount.currency" -> "EUR",
      "amount.value" -> "100.0000000000"
    )
  )
)
```

If there would be a third participant node, it wouldn’t have even noticed that there was anything happening, and even less would have received any contract data. Or if we would have deployed the `Bank` on that third node, that node would not have been informed about the `Paint` offer at all. This privacy feature goes so far in Canton that not even everybody within a single atomic transaction is aware of each other. This is a property unique to the Canton synchronization protocol, which we call sub-transaction privacy. The protocol ensures that only eligible participants will receive any data. Furthermore, while the node running mydomain does receive this data, the data is encrypted and mydomain cannot read it.

We can run such a step with sub-transaction privacy by accepting the offer, which will lead to the transfer of the Bank Iou, without the Bank actually learning about the `Paint` agreement

```
import com.digitalasset.canton.protocol.LfContractId
val acceptOffer = ledger_api_utils.exercise("AcceptByOwner", Map("iouId" -> LfContractId.assertFromString(aliceIou.event.contractId)),paintOffer.event)
participant1.ledger_api.commands.submit_flat(Seq(alice), Seq(acceptOffer))
```{{execute T1}}

resulting in

```
@ import com.digitalasset.canton.protocol.LfContractId
@ val acceptOffer = ledger_api_utils.exercise("AcceptByOwner", Map("iouId" -> LfContractId.assertFromString(aliceIou.event.contractId)),paintOffer.event)
acceptOffer : com.daml.ledger.api.v1.commands.Command = Command(
  command = Exercise(
    value = ExerciseCommand(
      templateId = Some(
        value = Identifier(
          packageId = "d96d66fa42dc72a667e0ab0f55ae9ad5a20848e11afe9008eb75aadcd786960b",
..
@ participant1.ledger_api.commands.submit_flat(Seq(alice), Seq(acceptOffer))
res40: com.daml.ledger.api.v1.transaction.Transaction = Transaction(
  transactionId = "122006497c7c192469131795ab705ce3bdbc1b8867f7fb7e9d7013b912cea754d0f6",
  commandId = "ff1887e5-dc2a-4a61-87fa-d74aec02dc22",
  workflowId = "",
  effectiveAt = Some(
    value = Timestamp(
..
```

Note that the conversion to `LfContractId` was required to pass in the `Iou` contract id as the correct type.
