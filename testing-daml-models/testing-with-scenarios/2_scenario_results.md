If you click on the `Scenario results` pop-up over your `test` scenario, a table view of active
contracts is opened in the right panel of the IDE.

![[Scenario Result]](/daml/courses/testing-daml-models/testing-with-scenarios/assets/scenario-result1.png)

You see that two contracts of your test scenario have been created together with their parameters.
Alice's `User` contract has the contract ID `#0:0` and Bob's `#1:0`. In the left column of the
table, an `x` indicates which party can observer the contract. As expected, Alice can see her `User`
contract but not Bob's and vice versa. Now try clicking on the `Show transaction view` button.

![[Scenario Result]](/daml/courses/testing-daml-models/testing-with-scenarios/assets/scenario-result2.png)

This shows you a full transaction graph of your scenario. Right now, it consists of the two
creations of `User` contracts. Try clicking the links! Clicking the link next to a transaction
time-stamp will take you to the exact place in the scenario where the transaction was created.
Clicking on a template name will take you to the definition of the template in the source code. At
the end of the transaction view you see a list of active contracts. Clicking on them will take you
to the location of their creation within the transaction.

In the next step, you will learn how to submit `exercise` transactions.  Keep an eye on the scenario
results to see how they change when you extend your test scenario!
