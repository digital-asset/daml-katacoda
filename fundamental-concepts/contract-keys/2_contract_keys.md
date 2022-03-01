Luckily, the `User` template has a contract key:

![contract_key](assets/contract_key.png)

Contract keys are not changed by the execution of a choice. If we use a contract key instead of a
contract ID to specify the contract we want to exercise a choice on, we can keep using the same
contract key. For the `User` template the contract key is given by it's `username` field.  For
`Alice`s' `User` template this is `Alice`:

```
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $ALICE_JWT" -d "{
    \"templateId\": \"User:User\",
    \"key\": \"$ALICE\",
    \"choice\": \"Follow\",
    \"argument\": {
        \"userToFollow\": \"$DORIS\"
}}" localhost:7575/v1/exercise
```{{execute T1}}

And you can exercise the choice again with the same key:

```
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $ALICE_JWT" -d "{
    \"templateId\": \"User:User\",
    \"key\": \"$ALICE\",
    \"choice\": \"Follow\",
    \"argument\": {
        \"userToFollow\": \"$EVE\"
}}" localhost:7575/v1/exercise
```{{execute T1}}

Daml allows you to specify one field of your template to be a [Contract Key](https://docs.daml.com/daml/reference/contract-keys.html).

While the uniqueness of contract IDs is guaranteed by any Daml ledger, you as a Daml model writer
need to know upfront that the specified contract key is unique among all instantiated contracts of
the template. Creating a contract twice with the same key will result in a runtime error:

```
curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $ALICE_JWT" -d "{
  \"templateId\": \"User:User\",
  \"payload\": {
    \"username\": \"$ALICE\",
    \"following\": []
  }}" localhost:7575/v1/create
```{{execute T1}}

The server responds with a `DuplicatedKey` error:

```
{"errors":["ALREADY_EXISTS: DUPLICATE_CONTRACT_KEY(10,99d02a30): Inconsistent rejected transaction would create a key that already exists (DuplicateKey); category=10, domain=local, participant=sandbox"],"status":409}
```
