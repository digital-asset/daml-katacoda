Before we move forward, we will learn how to test a Daml `template`

With Daml scenarios you can specify a linear sequence of actions that different parties take, and
these are evaluated in order, according to the same consistency, authorization and privacy rules as
they would be on any production ledger.


Scenarios are specified as top-level variables using `scenario do`. `do` always introduces a block.
<pre class="file" data-filename="daml/Rentals.daml" data-target="append">
test = scenario do
</pre>
## Task 2

We want two parties `Alice` and `Bob` to be known identities on our simulated ledger. You can
allocate them with the `getParty` function. The `getParty` function allows the specification of parties in a `scenario` context. The `<-` notation _binds_ the result to a variable.

<pre class="file" data-filename="daml/Rentals.daml" data-target="append">
  alice <- getParty "Alice"
  bob <- getParty "Bob"

</pre>

The ledger is now ready and you can simulate how the two parties submit transactions.

Suppose, `Alice` is the `landlord` and `Bob` is the `tenant` and they want to execute a `RentAgreement`

The `submit` keyword allows a party to submit a transaction to the ledger.


<pre class="file" data-filename="daml/Rentals.daml" data-target="append">
  aliceAgreement <- submit alice do
    create RentAgreement
      with
        landlord = alice
        tenant = bob
        address = "1 King William Street"
        rent = 1000.0
  return ()
</pre>

Did you notice the popped up `Scenario results`? If you click on the `Scenario results` pop-up over your `test` scenario, the IDE will split and you will see something like:
![Initialfailure](/vivek-da/courses/dojos/dojo101/assets/initialfailure.png)


**The transaction failed!! :-(**

### Somewhere, something went wrong!!

The reason it failed, as per the error, `Bob` never gave his consent to this agreement and Daml has built in checks around this where any party cannot be put into an obligatory position.

If a single statement in a scenario fails, the whole scenario fails at that point. To test failure of more than one submission in a single scenario, we need a different keyword `submitMustFail`, which succeeds when the submitted transaction fails. `Alice` and `Bob` cannot create `RentAgreement` unilaterally, as neither has the authority to put the other's signature on the `RentAgreement`.

## Task 3
Now, change the `submit alice` to `submitMustFail alice` and check the results.
![SubmitMustFail](/vivek-da/courses/dojos/dojo101/assets/SubmitMustFail.png)
