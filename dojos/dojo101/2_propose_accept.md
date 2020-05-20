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

<pre class="file" data-filename="daml/Excercise.daml" data-target="append">
aliceProposal <- submit alice do
    create RentalProposal with
      landlord = alice
      tenant = bob
      address = "1 King William Street"
      rent = 1000.0
      terms = ["term1","term2"]
</pre>

If you click on the `Scenario results` pop-up over your `test` scenario, a table view of active contracts is opened in the right panel of the IDE.

### Somethign is still not right!!

As you can see, `Bob` does not even have visibility to the proposal contract. Thats by design as DAML is built on the principle of least privilege. This comes to an interesting concept of stakeholders in DAML. A contract is ONLY visible to its stakeholders and a party can only be a stakeholder if they are in one of the three category:
1. `signatory` - w/o thier signature or contsent a contract CANNOT be created or archived, in other words who have obligations
2. `conroller` - parties who have a rights on that contract
3. `observer` - parties who have read access to the contracts

## Task 4
Now lets give some righst to the tenant, we will start with the basic right of `Accept`:

1. Using `controller` block give a `choice` to the tenant to `accept` the `RentalProposal` in a way that it creates a `RentAgreement` when the `choice` is `excercise`. 
2. Now add the corresponding step in the `scenario` bu submitting an `excercise` command.

## Task 5

If you want to start the project, run `daml start --open-browser=no`{{execute}}. Once started, you can then open the Navigator at https://[[HOST_SUBDOMAIN]]-7500-[[KATACODA_HOST]].environments.katacoda.com/, and the JSON API at https://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/.