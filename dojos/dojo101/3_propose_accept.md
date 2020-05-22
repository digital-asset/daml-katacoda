Now that we understand that DAML does not let you put any party into an obligatory position, lets discuss how we can solve this problem. If you consider real-life the way agreements work, someone starts with a proposal and then if teh counter party likes the terms and conditions they agree to execute an agreement.  

Similarly in DAML, we will add a step in our business-workflow.
![RentalProposal](/vivek-da/courses/dojos/dojo101/assets/proposal.png)

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

## Task 4

Given, `Alice` is the `landlord` and `Bob` is the `tenant` and `Alice` has to create a `RentalProposal`, change the scenario so that `Alice` is creating a  `RentalProposal` in place of `RentAgreement`.

If you click on the `Scenario results` pop-up over your `test` scenario, a table view of active contracts is opened in the right panel of the IDE.


![[Scenario Result]](/vivek-da/courses/dojos/dojo101/assets/scenario-result1.png)

You see that one contract of your test scenario have been created together with its parameters.
`Alice` as the `landlord` created contract that has the contract ID `#0:0`. In the left column of the
table, an `x` indicates which party can observe the contract. As expected, Alice can see the `RentalProposal`
contract. Now try clicking on the `Show transaction view` button.

![[Scenario Result]](/vivek-da/courses/dojos/dojo101/assets/scenario-result2.png)

This shows you a full transaction graph of your scenario. Right now, it consists of the one
creations of `RentalProposal` contract. Try clicking the links! Clicking the link next to a transaction
time-stamp will take you to the exact place in the scenario where the transaction was created.
Clicking on a template name will take you to the definition of the template in the source code. At
the end of the transaction view you see a list of active contracts. Clicking on them will take you
to the location of their creation within the transaction.


### Something is still not right!!

As you can see, `Bob` does not even have visibility to the proposal contract. That's by design as DAML is built on the principle of least privilege. This comes to an interesting concept of stakeholders in DAML. A contract is ONLY visible to its stakeholders and a party can only be a stakeholder if they are in one of the three category:
1. `signatory` - w/o their signature or consent a contract CANNOT be created or archived, in other words who have obligations
2. `controller` - parties who have a rights on that contract
3. `observer` - parties who have read access to the contracts

## Task 5
Now let's give some rights to the tenant, we will start with the basic right of `Accept`:

1. Using a `controller` block gives a `choice` to the tenant to `accept` the `RentalProposal` in a way that it creates a `RentAgreement` when the `choice` is `exercise`. 
2. Now add the corresponding step in the `scenario` by submitting an `exercise` command.

## Task 6

If you want to start the project, run `daml start --open-browser=no`{{execute}}. Once started, you can then open the Navigator at https://[[HOST_SUBDOMAIN]]-7500-[[KATACODA_HOST]].environments.katacoda.com/, and the JSON API at https://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/.