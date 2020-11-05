In the previous step, we added a script update that fails because it tries to double spend an
already archived contract ID. With a `submitMustFail` command, you can simulate parties submitting
commands that you expect to fail.

Remove the last submission of `Alice` and replace it with a `submitMustFail` statement:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submitMustFail alice do
      exerciseCmd aliceCid $ Follow bob
    return ()
</pre>

Note how the error in the transaction view disappears again.

Now you can also test that the assertions in the `Follow` choice work as expected.

The following will fail, because the assertions in the `Follow` choice forbid `Alice` to follow
herself.  Don't forget to remove the last `return ()` statement.

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submitMustFail alice do
      exerciseCmd newAliceCid $ Follow alice
    return ()
</pre>

And this will fail, because the assertions in the `Follow` choice forbid to follow a user twice.
Remove the last `return ()` and copy

<pre class="file" data-filename="daml/User.daml" data-target="append">
    submitMustFail alice do
      exerciseCmd newAliceCid $ Follow bob
</pre>
