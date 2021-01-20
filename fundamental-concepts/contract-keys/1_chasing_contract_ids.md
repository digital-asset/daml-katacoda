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

Try executing the `Follow` choice a couple of times and see how the returned contract ID changes
every time. First create a new `User` contract for `Alice` via the JSON API:


```
curl -s -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d '{
  "templateId": "User:User",
  "payload": {
    "username": "Alice",
    "following": []
  }}' localhost:7575/v1/create | tee result
```{{execute T1}}

Now let `Alice` follow first `Bob`, then `Charlie`:

```
ALICE_USER_CONTRACT=`cat result | jq .result.contractId`
rm result
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d "{
    \"templateId\": \"User:User\",
    \"contractId\": $ALICE_USER_CONTRACT,
    \"choice\": \"Follow\",
    \"argument\": {
        \"userToFollow\": \"Bob\"
}}" localhost:7575/v1/exercise | tee result
```{{execute T1}}

```
ALICE_USER_CONTRACT=`cat result | jq .result.exerciseResult`
rm result
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d "{
    \"templateId\": \"User:User\",
    \"contractId\": $ALICE_USER_CONTRACT,
    \"choice\": \"Follow\",
    \"argument\": {
        \"userToFollow\": \"Charlie\"
}}" localhost:7575/v1/exercise | tee result
```{{execute T1}}

Notice how the contract ID of `Alice`s  `User` in the `exerciseResult` field of the server
response changes with every execution of a successful `Follow` choice.
