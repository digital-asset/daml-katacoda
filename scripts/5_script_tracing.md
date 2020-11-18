In this final step, you will learn how to query the ledger and add assertions to your DAML scripts.

There are four different `query` commands:

  * `query: Template c => Party -> Script [(ContractId c, c)]` This queries the ledger for all
    active contracts for a given party and template.
  * `queryFilter: Template c => Party -> (c -> Bool) -> Script [(ContractId c, c)]` This is
    analogous to `query`, but you can filter the result by specifying a predicate function.
  * `queryContractId: Template t => Party -> ContractId t -> Script (Optional t)` This returns the
    contract of the given contract ID. This will return `None` if the contract is not active or the
    party is not observing the contract.
  * `queryContractByKey: TemplateKey t k => Party -> k -> Script (Optional (ContractId t, t))`
    This function is analogous to `queryContractId`, but it lets you query by contract keys instead
    of contract IDs.

We use the `queryContractId` function to have `Alice` query for her `User` contract:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    aliceUser <- do
      mbAliceUser <- queryContractId alice newAliceCid
      case mbAliceUser of
        None -> fail "Alice doesn't have a User contract"
        Some aliceUser -> return aliceUser
    return ()
</pre>

We first query the contract for `newAliceCid` and fail if we can't find the `User` contract for
`Alice`.

Once we succeeded in fetching the contract, we can add an assertion on its content. Remove the last
`return ()` and click on `Copy to Editor`.

<pre class="file" data-filename="daml/User.daml" data-target="append">
    assertMsg "Whoops!" (aliceUser.following == [bob])
</pre>

The `assertMsg` takes a text that is printed in case the assertion doesn't hold and a boolean
expression. If you replace the last line with an assertion that doesn't hold, you'll see the error
message in the script results.

<pre class="file" data-filename="daml/User.daml" data-target="append">
    assertMsg "Whoops!" (aliceUser.following == [alice])
</pre>

Let's **remove the failing line again**.

Once your scripts grow bigger, it's helpful to trace the execution flow of your script. With the
function `trace : Text -> a -> a` you can add tracing information to any expression, not just
script expressions. For example, you can add a trace just before a new `User` contract is created
after the `Follow` choice by replacing the line

<pre>
      create this with following = userToFollow :: following
</pre>

with

<pre class="file" data-target="clipboard">
      trace "adding new follower" (create this with following = userToFollow :: following)
</pre>

Make sure that `trace` has the same indentation as `archive self`. If you look at the transaction
view of the script result panel now, you see your trace at the very bottom.

![[Script Result]](/daml/scenarios/scripts/assets/script-result-traces.png)

Finally, you can also add `printf` style output to your scripts with the `debug` statement:

<pre class="file" data-filename="daml/User.daml" data-target="append">
    debug "done!"
</pre>

The `debug x` script command does not have any effect on the ledger, but will add `x` to the trace.
