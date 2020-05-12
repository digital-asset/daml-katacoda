Just as in scenarios, with DAML script you can issue queries against the ledger and make assertions
on the results.

Let's query the ledger for `User` contracts from the operator point of view. Paste the following
line before the final `debug` line.

<pre class="file" data-target="clipboard">
    users <- query @User operator
</pre>

1. `query` is parameterized over the template type you are looking for. In this case we're
   interested in `User` contracts.
1. `query` takes a party as an argument. It only returns active contracts that are visible to this party.
1. The returned `users` variable is a list of `(ContractId, User)` tuples, i.e. the contract ID and the
   contract data for it.

To write assertions you need to import the `DA.Assert` module. We also import the `sort` function
that we will be using later. Replace 

<pre class="file">
module User where
</pre>

with

<pre class="file" data-target="clipboard">
module User where

import Daml.Script
import DA.Foldable (forA_)
import DA.Assert ((===))
import DA.List (sort)
</pre>

The `===` is an assertion for equality. You can test for things not to be equal with the related
`=/=` operator. There are more assertion operators, have a look at the
[documentation](https://docs.daml.com/daml/reference/base.html#function-da-assert-asserteq-67100).

Since we made all parties follow the operator, all `User` contracts should be visible to the
`operator` now, in particular its own `User` contract. You can check for this by inserting the
following assertion before the final `debug` line.

<pre class="file" data-target="clipboard">
    sort (map (username . snd) users) === sort (operator::ps)
</pre>

1. we use the `sort` function here on both lists, to make sure they are equally ordered.
2. since `query` returns a list of tuples, we map `username . snd` over the list to extract the
   second field of the tuple (the contract data) and from that data the `username` field. The dot `.` in `username . snd` is just function composition.

Our initialization script is finished. In the next step you'll learn how to run it against a ledger.
