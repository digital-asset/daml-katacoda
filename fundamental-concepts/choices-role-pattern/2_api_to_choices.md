First, some good news: The Daml ecosystem will generate the `createUser` endpoint automatically and
there is nothing to do for us. In fact, it will provide a general `create` endpoint for all defined
contract templates in your Daml model. For the provided HTTP JSON API this is the `v1/create`
[endpoint](https://docs.daml.com/json-api/index.html#http-request). It will take the template name
and its arguments as POST arguments to the call. In addition, there will also be an `archive`
endpoint at `v1/archive` to archive an active contract and mark it inactive.

Try to create `Alice`'s `User` contract by running a `create` request:

```
curl -s -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJBbGljZSJdfX0.VdDI96mw5hrfM5ZNxLyetSVwcD7XtLT4dIdHIOa9lcU' -d '{
  "templateId": "User:User",
  "payload": {
    "username": "Alice",
    "following": ["Bob"]
  }}' localhost:7575/v1/create | tee result
```{{execute T2}}

1. The `Authorization` header authorizes the request with a dummy JWT token for `Alice`. You can
   read more about authorization [here](https://docs.daml.com/json-api/index.html#with-authentication).
1. The template identifier for the contract we want to create is specified in the `templateId`
   field. In our case this is `User:User`.
1. The arguments for the new contract are specified in the `payload`.
1. We make `Alice` follow `Bob`, such that `Bob` can send her a message in the next command, by
   adding him to the `following` list.
1. We pipe the output of the command to `tee` and store it in a file `result` for later use.

The sandbox ledger returns the created contract ID in the response:

```
{"result":{"observers":["Bob"], "agreementText":"","contractId":"00dc73ac11bbe3181ffd74d1843a108ea2c625cdd5749624feeb2acbd670413fcf","key":"Alice","payload":{"username":"Alice","following":["Bob"]},"signatories":["Alice"],"templateId":"7ec600d1f061bd68a3aa3cf7b315d8d486cb3f6d05e8a341a2328039358888b8:User:User"},"status":200}
```

Note that the output might slightly vary and that the contract ID string will be different.

To execute the `sendMessage` endpoint we require as a first argument an active `User` contract, to
ensure that the sending party has opened an account in our application. Making the availability of
an endpoint dependent on the existence of some contract on the ledger is such a common pattern when
designing an API for a multi-user system, that in Daml it's embedded in the syntax in the form of
`choices`.  Let's implement `sendMessage` with a choice called `SendMessage`. Add the following
choice to the `User` template:

<pre class="file" data-target="clipboard">
    nonconsuming choice SendMessage: ContractId Message with
          sender: Party
          content: Text
        controller sender
        do
          assertMsg "Designated user must follow you back to send a message" (elem sender following)
          create Message with sender, receiver = username, content
</pre>

Compare this to what we want the API to look like:

```
sendMessage: Existing User -> Party -> Text -> Update (Existing Message)
```

We made the `SendMessage` choice part of the `User` contract. This guarantees that it can only be
called for an existing `User` contract. Thus we've taken care of the functionality of the first
argument to our endpoint.

The choice takes two arguments of type `Party` and `Text` which are specified after the `with`
keyword. That's exactly what we want the other arguments of our API call to be.

![choice_arguments](assets/choice_arguments.png)

Once the choice is called, it will execute the `Update` in the `do` block:

![choice_update](assets/choice_update_block.png)

If the `Update` block succeeds, a `ContractId` of a newly created `Message` is returned. It could
fail, if for example an assertion is not fulfilled or it tries to reference an inactive contract.
You can see the return type of the choice after the choice name `SendMessage`

![choice_return_type](assets/choice_return_type.png)

The Daml ecosystem makes this choice available as an API call. For example on the JSON API this
choice can be called by the `v1/exercise` [endpoint](https://docs.daml.com/json-api/index.html#id2)
. The call takes as arguments the `User:User` template identifier, the contract ID and the choice
arguments `sender` and `content`. And the call will return the contract ID of the created `Message`
contract in the server response. Hence we get exactly the endpoint `sendMessage`, where contract
ID's play the role of asserting that a contract exists.

Let's try this on the command line. We parse the last returned contract ID for Alice's `User`
contract from the returned result and then run a request against the `v1/exercise` endpoint:

```
ALICE_USER_CONTRACT=`cat result | jq .result.contractId`
curl -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2RhbWwuY29tL2xlZGdlci1hcGkiOnsibGVkZ2VySWQiOiJNeUxlZGdlciIsImFwcGxpY2F0aW9uSWQiOiJmb29iYXIiLCJhY3RBcyI6WyJCb2IiXX19.zU-iMSFG90na8IHacrS25xho3u6AKnSlTKbvpkaSyYw' -d "{
    \"templateId\": \"User:User\",
    \"contractId\": $ALICE_USER_CONTRACT,
    \"choice\": \"SendMessage\",
    \"argument\": {
        \"sender\": \"Bob\",
        \"content\": \"Hi Alice! \"
}}" localhost:7575/v1/exercise
```{{execute T2}}

The ledger answers with a list of created contracts, which contains the created `Message` contract,
and the result of the execution of the choice, which is the contract ID of the created `Message`
contract.

```
{"result":{"events":[{"created":{"agreementText":"","contractId":"002d843cb8f14eeac714ea0f8538a32942c84f0d4fa1b9a26ec9a9f56c230b2c4a","observers":[],"payload":{"sender":"Bob","receiver":"Alice","content":"Hi Alice!"},"signatories":["Alice","Bob"],"templateId":"7ec600d1f061bd68a3aa3cf7b315d8d486cb3f6d05e8a341a2328039358888b8:User:Message"}}],"exerciseResult":"002d843cb8f14eeac714ea0f8538a32942c84f0d4fa1b9a26ec9a9f56c230b2c4a"},"status":200}%
```


In the next step you'll learn about the `consuming/nonconsuming` keyword and how you can use it to
design API's that make sure that a resource is only consumed once.
