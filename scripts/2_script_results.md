If you click on the `Script results` pop-up over your `test` script, a table view of active
contracts is opened in the right panel of the IDE.

![[Script Result]](/daml/scenarios/scripts/assets/script-result1.png)

You see that two contracts of your test script have been created together with their parameters.
Alice's `User` contract has the contract ID `#0:0` and Bob's `#1:0`. In the left column of the
table, an `x` indicates which party can observe the contract. As expected, Alice can see her `User`
contract but not Bob's and vice versa. Now try clicking on the `Show transaction view` button.

![[Script Result]](/daml/scenarios/scripts/assets/script-result2.png)

This shows you a full transaction graph of your script. Right now, it consists of the two
creations of `User` contracts. Try clicking the links! Clicking the link next to a transaction
time-stamp will take you to the exact place in the script where the transaction was created.
Clicking on a template name will take you to the definition of the template in the source code. At
the end of the transaction view you see a list of active contracts. Clicking on them will take you
to the location of their creation within the transaction.

In the next step, you will learn how to submit `exerciseCmd` transactions.  Keep an eye on the
script results to see how they change when you extend your test script!
