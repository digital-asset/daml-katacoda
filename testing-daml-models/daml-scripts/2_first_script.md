Next to a fixed `operator` party we want to also allocate a list of parties given as an argument to the
`initialize` script. These parties will follow the operator and the operator will follow them back.

As before, we will be using the `allocatePartyWithHint` function. Replace the initialize script
with:

<pre class="file" data-target="clipboard">
initialize: [Text] -> Script ()
initialize initialParties = do
    operator <- allocatePartyWithHint "operator" (PartyIdHint "operator")
    ps <- forA initialParties $ \partyStr -> do
      allocatePartyWithHint partyStr (PartyIdHint partyStr)
    debug "done!"
</pre>

Easy! Scripts are just like usual DAML functions and follow the same syntax to declare arguments and
type signatures.

1. Now we get the other party names from the `initialParties` argument to the script. 

1. `forA: (Applicative m) => [a] -> (a -> m b) -> m [b]` starts a `for loop` that you can
use to map anything that returns an `Applicative` (such as `Script`) over an input list and returns
the collected results. In fact, `forA` is just `mapA` with it's arguments flipped, but it's often a
bit more convenient to write when your lambda spans several lines.

To issue ledger updates, you can use the `createCmd` and `exerciseCmd` commands. These are the
equivalents for scripts to the usual `create` and `exercise` commands you use in updates. Let's
create `User` contracts for all allocated parties and have the `initialParties` follow the
`operator`.

Add the following import under the line `module User where` to have the function `forA_` available:

<pre class="file" data-target="clipboard">
import DA.Foldable (forA_)
</pre>

Next, paste the following before the final `debug` line at the same indentation level as `ps <- ...`:

<pre class="file" data-target="clipboard">
    submit operator $ createCmd User with username = operator, following = ps
    forA_ ps $ \p -> do
      h <- submit p $ createCmd User with username = p, following = []
      submit p $ exerciseCmd h  Follow with userToFollow = operator
</pre>


1. `forA_` is just like `forA`, but it forgets about the return value and just returns `()`.
1. note how the syntax is almost exactly the same as for scenarios, only that `create` has been
   replaced with `createCmd` and `exercise` with `exerciseCmd`.
1. you could have just given the `operator` as the `following` parties when you create the `User`
   contract for the `initialParties`, but for the sake of the exposition we choose to do it in a
   second step with an `exerciseCmd`.

Your ledger is initialized! In the next step, you'll learn how to submit queries against the ledger
and how to make assertions on what contracts exist and are active.
