In this final step, you will learn how to add assertions and good old `printf` debugging to DAML
scenarios.

First, we'll have `Alice` check that she now really follows `Bob`:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submit alice do 
      aliceUser <- fetch newAliceCid
      assertMsg "Whoops!" (aliceUser.following == [bob])
</pre>

The `fetch` command simulates `Alice` getting her contract data from the ledger. The `assertMsg`
takes a text that is printed in case the assertion doesn't hold and a boolean expression. If you
replace the last line with an assertion that doesn't hold, you'll see the error message in the
scenario results.

<pre class="file" data-filename="daml/User.daml" data-target="append">
      assertMsg "Whoops!" (aliceUser.following == [alice])
</pre>

Let's remove the failing line again.

Once your scenarios grow bigger, it's helpful to trace the execution flow of your scenario. With the
function `trace : Text -> a -> a` you can add tracing information to any expression, not just
scenario expressions. For example, you can add a trace just before a new `User` contract is created
after the `Follow` choice by replacing the line 

<pre>
      create this with following = userToFollow :: following
</pre>

with

<pre class="file" data-target="clipboard">
      trace "adding new follower" (create this with following = userToFollow :: following)
</pre>

Make sure that `trace` has the same indentation as `archive self`. If you look at the transaction view of the scenario result panel now, you see your trace at the very
bottom.

![[Scenario Result]](/drsk/courses/testing-daml-models/testing-with-scenarios/assets/scenario-result-traces.png)
