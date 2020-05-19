# Propose/Accept

Now that we understand that DAML does not let you put any party into an obligatory position, lets discuss how we can solve this problem. If you consider real-life the way agreements work, someone starts with a proposal and then if teh counter party likes the terms and conditions they agree to execute an agreement.  

Similarly in DAML, we will add a step in our business-workflow.

## RentalProposal
Let's assume for now that its always landlord that propose as he/she put his/her property up for rental.

## Task 3

Create a template named `RentalProposal`.
Add following fields:
1. `tenant` - what should be the data type?
2. `landlord` - what should be the data type?
3. `address` - what should be the data type?
4. `rent` - what should be the data type?
5. `terms` - this should be a list of terms, what should be the data type?


Given, `Alice` is the `landlord` and `Bob` is the `tenant` and `Alice` has to create a `RentalProposal`

<pre class="file" data-filename="daml/User.daml" data-target="append">
aliceProposal <- submit alice do
    create RentalProposal with
      landlord = alice
      tenant = bob
      address = "1 King William Street"
      rent = 1000.0
      terms = ["term1","term2"]
</pre>

If you click on the `Scenario results` pop-up over your `test` scenario, a table view of active
contracts is opened in the right panel of the IDE.

