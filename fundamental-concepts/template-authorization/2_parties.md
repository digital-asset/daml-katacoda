Like the UNIX file system has `users`, every Daml ledger has a concept of identity.

Because the representation of identities are different from one ledger to another, Daml has an
identity abstraction. This is the `Party` type. So for example if we **open the IDE** and look at
the `User` template of the `create-daml-app` package in `daml/User.daml`{{open}}, the line

```
username: Party
```

says that the field `username` of the `User` contract will be stored on the underlying ledger in
whatever representation that ledger uses for identities. This could be public keys or simply a
unique identifier. It is also the underlying ledger that will check the authenticity of these
identities before any issued commands are accepted.

A Daml model doesn't specify the identities for a deployment upfront, it doesn't know whether there
will be an `Alice` or a `Bob`, or an `sshd` and a `root` on the ledger. The parties are allocated
not in the Daml model, but by the underlying ledger once the model is deployed. This is also why
actual party identifiers don't appear in Daml contract templates.

For example, here we allocate new parties `Alice`, `Bob` and `Charlie`, and create a new `User`
contract for `Alice` on the simple in-memory ledger of the IDE:

<pre class="file" data-filename="daml/User.daml" data-target="append">
test = script do
  alice <- allocateParty "Alice"
  bob <- allocateParty "Bob"
  charlie <- allocateParty "Charlie"
  submit alice $ createCmd User with username = alice, following = []
</pre>

Note that `alice` is just a variable chosen by us, we have no idea how the in-memory ledger
actually represents the `Alice` party.
