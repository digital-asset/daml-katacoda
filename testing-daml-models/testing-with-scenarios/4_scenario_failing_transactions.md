In the previous step, we added a scenario update that fails, because it tries to double spend an
already archived contract ID. With a `submitMustFail` command, you can simulate parties submitting
commands that you expect to fail.

Remove the previous scenario update and replace it with a `submitMustFail` statement:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submitMustFail alice do
      exercise aliceCid $ Follow bob
    return ()
</pre>


Now you can also test that the assertions in the `Follow` choice work as expected.

The following will fail, because the assertion in line 23 forbids to follow alice herself. Don't
forget to remove the last `return ()` statement.

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submitMustFail alice do
      exercise newAliceCid $ Follow alice
    return ()
</pre>

And this will fail, because the `User` template forbids to follow a user twice.

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submitMustFail alice do
      exercise newAliceCid $ Follow bob
</pre>
