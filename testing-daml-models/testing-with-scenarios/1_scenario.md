With DAML scenarios you can specify a linear sequence of actions that different parties take, and
these are evaluated in order, according to the same consistency, authorization and privacy rules as
they would be on any production ledger.

In this Katacoda, we'll extend the social network defined in `daml/User.daml` with scenarios.

- First, **open the IDE and wait for it to load**.
- After that click on `daml/User.daml`{{open}} to open the `User.daml` file.
- You can click on `Copy to Editor` to append the following code snippets to the file as you go.
  **Note that intentation matters**.

A scenario starts with a name assigned to a scenario `do` block.

<pre class="file" data-filename="daml/User.daml" data-target="append">
test = 
  scenario do
</pre>

We want two parties `Alice` and `Bob` to be known identites on our simulated ledger. You can
allocate them with the `getParty` function:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    alice <- getParty "Alice" 
    bob <- getParty "Bob"
</pre>

The ledger is now ready and you can simulate how the two parties submit transactions.  Suppose,
`Alice` and `Bob` sign up to your social network. For this they will create a `User` template each.

<pre class="file" data-filename="daml/User.daml" data-target="append">
    aliceCid <- submit alice do
      create User with username = alice; following = []
    submit bob do
      create User with username = bob; following = []
</pre>

Note how both parties submit their action as a transaction contained in a do block. Further, we bind
the result of `Alice`'s submission to a variable `aliceCid`. We will be using this contract ID in
the next step.

Did you notice the popped up `Scenario results`? Indeed, `Alice`'s and `Bob`'s transaction were
successful and the ledger has changed. In the next step, you'll find out how to inspect the ledger
in the IDE.
