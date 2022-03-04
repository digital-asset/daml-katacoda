A choice can be `consuming` or `nonconsuming`.

![choice_consuming](assets/choice_consuming.png)

A `nonconsuming` choice doesn't affect the contract it's contained in. You can execute it as many
times as you want. In contrast, a `consuming` choice can be called exactly once. As soon as the call
happens, the containing contract is marked as inactive and a subsequent call will fail.

Clearly, this is not what we want for an endpoint like

<pre>
sendMessage: Existing User -> Party -> Text -> Update (Existing Message)
</pre>

It would be really annoying if you would loose your account on the social network whenever you want
to send a message to someone else. Hence, the corresponding choice `SendMessage` is declared as
`nonconsuming`.

But let's imagine we want an additional contract template to make special offers to other users in
`create-daml-app`:

<pre class="file" data-filename="daml/User.daml" data-target="append">
template SpecialOffer
  with
    offeringParty: Party
    receivingParty: Party
    offer: Text
  where
    signatory offeringParty
    observer receivingParty
</pre>

You can create it again with the `v1/create` endpoint:

```
rm result
curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $JWT_ALICE" -d "{
  \"templateId\": \"User:SpecialOffer\",
  \"payload\": {
    \"offeringParty\": $ALICE,
    \"receivingParty\": $BOB,
    \"offer\": \"Get Alices Barbeque Sauce 50% off! \"
  }}" localhost:7575/v1/create | tee result

```{{execute T2}}

and get a response

```
{"result":{"agreementText":"","contractId":"0095d5c6c1694603c34836b16cf0b31c5fe95ec55c4cd55240360a5df803095a35ca001220f9e1adb32899e68cc13445221ac0c36b6f5392cea2f2891f264fe381ea084c0f","observers":["Bob::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb"],"payload":{"offeringParty":"Alice::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb","receivingParty":"Bob::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb","offer":"Get Alices Barbeque Sauce 50% off"},"signatories":["Alice::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb"],"templateId":"edbbd9f58ba7dd64e12bdd438f394bcdf640046f61d81db92b16bf48a330f7c2:User:SpecialOffer"},"status":200}
```

Once the receiving party takes your offer, you'd like the offer to be removed from the ledger.
Otherwise `Bob` would get `Alice` barbeque sauce for half the price forever! A good way to get this
semantic would be to add a `consuming` choice `TakeOffer` to the `SpecialOffer` template:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    choice TakeOffer: ()
      controller receivingParty
        do
          return ()
</pre>

Note that we dropped the `nonconsuming` before the `choice` keyword. This makes the choice
`consuming`.

Because the `receivingParty` is the controller of the choice only she can take the offer (check out
the previous [Katacoda](https://digitalasset.com/developers/interactive-tutorials/fundamental-concepts/template-authorization) for more
on authorization and controllers). As soon as she takes the offer, the `SpecialOffer` is archived on
the ledger, marked as inactive and the choice can not be executed any longer.

```
SPECIAL_OFFER_CONTRACT=`cat result | jq .result.contractId`
curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $JWT_BOB" -d "{
    \"templateId\": \"User:SpecialOffer\",
    \"contractId\": $SPECIAL_OFFER_CONTRACT,
    \"choice\": \"TakeOffer\",
    \"argument\": {
    }
}" localhost:7575/v1/exercise

```{{execute T2}}

The sandbox responds that it has indeed archived the `SpecialOffer` contract and that the return
value of the choice is empty, exactly as specified in the `TakeOffer` choice:

```
{"result":{"events":[{"archived":{"contractId":"0095d5c6c1694603c34836b16cf0b31c5fe95ec55c4cd55240360a5df803095a35ca001220f9e1adb32899e68cc13445221ac0c36b6f5392cea2f2891f264fe381ea084c0f","templateId":"edbbd9f58ba7dd64e12bdd438f394bcdf640046f61d81db92b16bf48a330f7c2:User:SpecialOffer"}}],"exerciseResult":{}},"status":200}
```

Now let's try to get more cheap barbeque sauce:

```
curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $JWT_BOB" -d "{
    \"templateId\": \"User:SpecialOffer\",
    \"contractId\": $SPECIAL_OFFER_CONTRACT,
    \"choice\": \"TakeOffer\",
    \"argument\": {
    }
}" localhost:7575/v1/exercise

```{{execute T2}}

As expected the ledger responds with

```
{"errors":["NOT_FOUND: CONTRACT_NOT_FOUND(11,5084bd3c): Contract could not be found with id 0095d5c6c1694603c34836b16cf0b31c5fe95ec55c4cd55240360a5df803095a35ca001220f9e1adb32899e68cc13445221ac0c36b6f5392cea2f2891f264fe381ea084c0f"],"status":404}
```

The contract is not available anymore because it was already consumed when we executed the consuming
choice in the previous call.
