Daml contracts are immutable. The only way to change them, is to archive a contract and create a new
one with updated fields.

In the terminal you can see the sandbox ledger spinning up. Open `daml/User.daml`{{open}} in the IDE
and have a look at the `Follow` choice.

If your application maintains state, like a counter, or the parties following a user in the social
network of `create-daml-app`, you will need store that state in a contract that exposes either a
consuming choices to change it, or a choice that explicitly archives the contract and creates a new
one.

![consuming_choice](assets/consuming_choice.png)

Contract IDs identify a contract uniquely. Every two contracts, even if they have the same field
values and are of the same template, will have different contract IDs. If your application exposes
an interaction with a contract via a consuming choice like above, the contract ID of the contract
will constantly change and your clients will have to keep track of it.

First, we have to allocate parties for Alice, Bob, Charlie, Doris & Eve which we’ll use throughout the tutorial. The
JSON API requires an authorization token so we first create one using
for the participant admin that we use for party allocations and then
one for each party once we allocated it.

```
ADMIN_JWT=$(./jwt encode --secret secret '{"https://daml.com/ledger-api": {"admin": true, "ledgerid": "sandbox"}}')
allocate() { curl -sf -H "Content-Type: application/json" -H "Authorization: Bearer $ADMIN_JWT" -d "{\"identifierHint\":
 \"$1\"}" localhost:7575/v1/parties/allocate | jq -r '.result.identifier'; }
ALICE=$(allocate Alice)
BOB=$(allocate Bob)
CHARLIE=$(allocate Charlie)
DORIS=$(allocate Doris)
EVE=$(allocate Eve)
jwt_for() { ./jwt encode --secret secret "{\"https://daml.com/ledger-api\": {\"ledgerId\": \"sandbox\", \"applicationId\": \"foobar\", \"actAs\": [\"$1\"]}}"; }
ALICE_JWT=$(jwt_for $ALICE)
BOB_JWT=$(jwt_for $BOB)
CHARLIE_JWT=$(jwt_for $CHARLIE)
DORIS_JWT=$(jwt_for $DORIS)
EVE_JWT=$(jwt_for $EVE)
```{{execute T2}}

Try executing the `Follow` choice a couple of times and see how the returned contract ID changes
every time. First create a new `User` contract for `Alice` via the JSON API:

```
curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $ALICE_JWT" -d "{
  \"templateId\": \"User:User\",
  \"payload\": {
    \"username\": \"$ALICE\",
    \"following\": []
  }}" localhost:7575/v1/create | tee result
```{{execute T2}}

Now let `Alice` follow first `Bob`, then `Charlie`:

```
ALICE_USER_CONTRACT=`cat result | jq .result.contractId`
rm result
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $ALICE_JWT" -d "{
    \"templateId\": \"User:User\",
    \"contractId\": $ALICE_USER_CONTRACT,
    \"choice\": \"Follow\",
    \"argument\": {
        \"userToFollow\": \"$BOB\"
}}" localhost:7575/v1/exercise | tee result
```{{execute T2}}

```
ALICE_USER_CONTRACT=`cat result | jq .result.exerciseResult`
rm result
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $ALICE_JWT" -d "{
    \"templateId\": \"User:User\",
    \"contractId\": $ALICE_USER_CONTRACT,
    \"choice\": \"Follow\",
    \"argument\": {
        \"userToFollow\": \"$CHARLIE\"
}}" localhost:7575/v1/exercise | tee result
```{{execute T2}}

Notice how the contract ID of `Alice`s  `User` in the `exerciseResult` field of the server
response changes with every execution of a successful `Follow` choice.
