Consuming choices add complexity to your API. If a client wants to exercise a consuming choice, it
needs to be sure that the contract it wants to exercise the choice on is active. This means your API
is stateful and your clients need to keep track of the contracts that are still active. Also, if
another client happens to exercise a consuming choice on the same contract at the same time, the two
clients are in a race and only one will succeed.

A contract with only non-consuming choices expresses a much easier API. There are no races and
tracking of activeness of the contract is not necessary. We say a contract that has only
non-consuming choices implements the **Role Pattern**.

This naming expresses the fact that often applications assign a role with certain capabilities to a
user. The capabilities need to be active as long as the user exists on the system. In Daml, the role
is given by a contract such as `User` and the capabilities by its non-consuming choices.

For example, we could extend our `User` contract of the `create-daml-app` with another capability
with an additional choice:

<pre class="file" data-target="clipboard">
    nonconsuming choice CreateSpecialOffer: ContractId SpecialOffer
      with
        receivingParty: Party
        offer: Text
      controller username
        do
          create SpecialOffer with offeringParty=username, ..
</pre>

Now every party with an active `User` contract can send special offers to other parties on the
ledger. We can create as many `SpecialOffers` as we want, the `User` contract is invariant and its
contract ID won't change. For instance,

```
curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $JWT_ALICE" -d "{
    \"templateId\": \"User:User\",
    \"contractId\": $ALICE_USER_CONTRACT,
    \"choice\": \"CreateSpecialOffer\",
    \"argument\": {
      \"receivingParty\": $BOB,
      \"offer\": \"A bottle of my newest barbeque sauce for free! \"
  }}" localhost:7575/v1/exercise
```{{execute T2}}

You'll get a response from the ledger with the result of the choice execution:

```
{"result":{"events":[{"created":{"agreementText":"","contractId":"0047ee350b6e9a4604fd6eaa493b6d442d49ffba601fa212ded1611014510d5c6fca001220d1316b8ed3911087b20cee6679844d1674402571e2b126097286dadef8108403","observers":["Bob::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb"],"payload":{"offeringParty":"Alice::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb","receivingParty":"Bob::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb","offer":"A bottle of my newest barbeque sauce for free! "},"signatories":["Alice::12206f7e61b3c755b6f4e5cef0b3106f53113e924b3149f839d749b56eaab85572eb"],"templateId":"edbbd9f58ba7dd64e12bdd438f394bcdf640046f61d81db92b16bf48a330f7c2:User:SpecialOffer"}}],"exerciseResult":"0047ee350b6e9a4604fd6eaa493b6d442d49ffba601fa212ded1611014510d5c6fca001220d1316b8ed3911087b20cee6679844d1674402571e2b126097286dadef8108403"},"status":200}
```

Now if `Alice` wants to create another offer, she can execute the `CreateSpecialOffer` choice on the
same contract ID again:

```
curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $JWT_ALICE" -d "{
    \"templateId\": \"User:User\",
    \"contractId\": $ALICE_USER_CONTRACT,
    \"choice\": \"CreateSpecialOffer\",
    \"argument\": {
      \"receivingParty\": $BOB,
      \"offer\": \"Try the new extra spicy for free! \"
  }}" localhost:7575/v1/exercise
```{{execute T2}}

Contracts that have consuming choices make your application interface stateful. By applying the
*Role Pattern* and group non-consuming choices together as much as possible in role contracts, you
reduce the overall complexity of your API.
