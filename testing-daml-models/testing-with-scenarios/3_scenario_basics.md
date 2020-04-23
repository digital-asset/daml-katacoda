In the previous step, you created a `User` template for both parties `Alice` and `Bob` in your test
scenario. Now you can start exercising choices on them:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    newAliceCid <- submit alice do
      exercise aliceCid $ Follow bob
    return ()
</pre>

The scenario results on the right have changed and you see that `Alice`'s original `User` contract
has been archived and replaced with a new one, where she now follows `Bob`. The last `return ()` is
needed, because the last statement in a `do` block must always be an expression (i.e. the last
statement in a `do` block can not contain a `<-` binding which would be unused). We'll remove it in
a second and replace it with a more interesting expression.

What happens if `Alice` would submit a command that should fail? Let's see if we can double spend
`Alice`'s contract ID. Remove the `return ()` of the last line and add

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submit alice do
      exercise aliceCid $ Follow bob
</pre>

You will see that the scenario fails now and the IDE loudly complains about an attempted exercise on
an already consumed contract. It tells you the exact line number in your scenario where things go
wrong and prints the partial transaction graph that was committed so far.

In the next step you learn how to test for failure and how to put assertions and trace messages in
your scenario code.
