Luckily, the `User` template has a contract key:

![contract_key](assets/contract_key.png)

Contract keys are not changed by the execution of a choice. If we use a contract key instead of a
contract ID to specify the contract we want to exercise a choice on, we can keep using the same
contract key. For the `User` template the contract key is given by it's `username` field.  For
`Alice`s' `User` template this is `Alice`:

```
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d '{
    "templateId": "User:User",
    "key": "Alice",
    "choice": "Follow",
    "argument": {
        "userToFollow": "Doris"
}}' localhost:7575/v1/exercise
```{{execute T1}}

And you can exercise the choice again with the same key:

```
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d '{
    "templateId": "User:User",
    "key": "Alice",
    "choice": "Follow",
    "argument": {
        "userToFollow": "Eve"
}}' localhost:7575/v1/exercise
```{{execute T1}}

Daml allows you to specify one field of your template to be a [Contract Key](https://docs.daml.com/daml/reference/contract-keys.html).

While the uniqueness of contract IDs is guaranteed by any Daml ledger, you as a Daml model writer
need to know upfront that the specified contract key is unique among all instantiated contracts of
the template. Creating a contract twice with the same key will result in a runtime error:

```
curl -s -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d '{
  "templateId": "User:User",
  "payload": {
    "username": "Alice",
    "following": []
  }}' localhost:7575/v1/create
```{{execute T1}}

The server responds with a `DuplicatedKey` error:

```
{"errors":["io.grpc.StatusRuntimeException: INVALID_ARGUMENT: Disputed: DuplicateKey: Contract Key not unique"],"status":500}
```
