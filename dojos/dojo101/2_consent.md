Before we move forward, we will learn how to test a DAML `template`

With DAML scenarios you can specify a linear sequence of actions that different parties take, and
these are evaluated in order, according to the same consistency, authorization and privacy rules as
they would be on any production ledger.


A scenario starts with a name assigned to a scenario `do` block.

<pre class="file" data-filename="daml/Rentals.daml" data-target="append">
test = scenario do
</pre>
## Task 2

We want two parties `Alice` and `Bob` to be known identities on our simulated ledger. You can
allocate them with the `getParty` function:

<pre class="file" data-filename="daml/Rentals.daml" data-target="append">
  alice <- getParty "Alice"
  bob <- getParty "Bob"
</pre>

The ledger is now ready and you can simulate how the two parties submit transactions.

Suppose, `Alice` is the `landlord` and `Bob` is the `tenant` and they want to execute a `RentAgreement`

<pre class="file" data-filename="daml/Rentals.daml" data-target="append">
  aliceAgreement <- submit alice do
    create RentAgreement 
      with
        landlord = alice
        tenant = bob
        address = "1 King William Street"
        rent = 1000.0
        terms = ["term1","term2"]
  return ()
</pre>

Did you notice the popped up `Scenario results`? The transaction failed!! :-(

### Somewhere, something went wrong!! 

The reason it failed, as per the error, `Bob` never gave his consent to this agreement and DAML has built in checks around this where any party cannot be put into an obligatory position. 