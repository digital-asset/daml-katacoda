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
curl -s -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d '{
  "templateId": "User:SpecialOffer",
  "payload": {
    "offeringParty": "Alice",
    "receivingParty": "Bob",
    "offer": "Get Alices Barbeque Sauce 50% off!"
  }}' localhost:7575/v1/create | tee result

```{{execute T1}}

and get a response

```
{"result":{"agreementText":"","contractId":"0060809eb719f9d28a2d783369440d85630dbc8069c8d7b859556cf8765e4a0858","observers":["Bob"],"payload":{"offeringParty":"Alice","receivingParty":"Bob","offer":"Get
Alices Barbeque Sauce 50%
off!"},"signatories":["Alice"],"templateId":"78b4e7ce7dc580ccbc77aa2d05b6659e2df24047af5f72db131cfb0b56d6a943:User:SpecialOffer"},"status":200}%
```

Once the receiving party takes your offer, you'd like the offer to be removed from the ledger.
Otherwise `Bob` would get `Alice` barbeque sauce for half the price forever! A good way to get this
semantic would be to add a `consuming` choice `TakeOffer` to the `SpecialOffer` template:

<pre class="file" data-target="clipboard">
    choice TakeOffer: ()
      controller receivingParty
        do
          return ()
</pre>

Note that we dropped the `nonconsuming` before the `choice` keyword. This makes the choice
`consuming`.

Because the `receivingParty` is the controller of the choice only she can take the offer (check out
the previous [Katacoda](https://daml.com/learn/fundamental-concepts/template-authorization) for more
on authorization and controllers). As soon as she takes the offer, the `SpecialOffer` is archived on
the ledger, marked as inactive and the choice can not be executed any longer.

```
SPECIAL_OFFER_CONTRACT=`cat result | jq .result.contractId`
curl -s -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJCb2IiXX19.zU-iMSFG90na8IHacrS25xho3u6AKnSlTKbvpkaSyYw' -d "{
    \"templateId\": \"User:SpecialOffer\",
    \"contractId\": $SPECIAL_OFFER_CONTRACT,
    \"choice\": \"TakeOffer\",
    \"argument\": {
    }
}" localhost:7575/v1/exercise

```{{execute T1}}

The sandbox responds that it has indeed archived the `SpecialOffer` contract and that the return
value of the choice is empty, exactly as specified in the `TakeOffer` choice:

```
{"result":{"events":[{"archived":{"contractId":"0060809eb719f9d28a2d783369440d85630dbc8069c8d7b859556cf8765e4a0858","templateId":"78b4e7ce7dc580ccbc77aa2d05b6659e2df24047af5f72db131cfb0b56d6a943:User:SpecialOffer"}}],"exerciseResult":{}},"status":200}%
```

Now let's try to get more cheap barbeque sauce:

```
curl -s -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJCb2IiXX19.zU-iMSFG90na8IHacrS25xho3u6AKnSlTKbvpkaSyYw' -d "{
    \"templateId\": \"User:SpecialOffer\",
    \"contractId\": $SPECIAL_OFFER_CONTRACT,
    \"choice\": \"TakeOffer\",
    \"argument\": {
    }
}" localhost:7575/v1/exercise

```{{execute T1}}

As expected the ledger responds with

```
{"errors":["io.grpc.StatusRuntimeException: INVALID_ARGUMENT: Command interpretation error in LF-Damle: dependency error: couldn't find contract ContractId(0060809eb719f9d28a2d783369440d85630dbc8069c8d7b859556cf8765e4a0858). Details: N/A."],"status":500}%
```

The contract is not available anymore because it was already consumed when we executed the consuming
choice in the previous call.
