Instead of writing a script in a DAML source file, you can also connect to the ledger with the `DAML REPL`
and run your commands interactively step by step. This is very helpful if you are trying to
get a better feel for how your code works.

First, kill the running sandbox in the first terminal (ctrl-c) and restart it to get back into a clean state.

```
daml sandbox .daml/dist/create-daml-app-0.1.0.dar
```{{execute T1}}

To start the `DAML REPL` run

```
daml repl --ledger-host=localhost --ledger-port=6865 .daml/dist/create-daml-app-0.1.0.dar
```{{execute T2}}

in the **second** terminal. After a few seconds you'll see the REPL prompt:

```
daml>
```

You can always exit the DAML REPL by pressing `ctrl-c` and get help with

```
:help
```{{execute T2}}

At the REPL prompt you can issue an arbitrary DAML script command. As before we'll allocate a new party:

```
alice <- allocatePartyWithHint "Alice" (PartyIdHint "Alice")
```{{execute T2}}

To have definitions of the `User.daml` module in scope, we need to load it first with

```
:m User
```{{execute T2}}

You can create a new `User` contract for `Alice` by submitting a `createCmd` command:

```
aliceCid <- submit alice (createCmd User with username = alice, following = [])
```{{execute T2}}

Here `aliceCid` is the contract ID of the `User` contract that just got created. We can confirm that
the contract has been created by a query:

```
contracts <- query @User alice
```{{execute T2}}

To inspect the contracts variable, you can simply use a `debug` statement:

```
debug contracts
```{{execute T2}}

```
[DA.Internal.Prelude:540]: [(<contract-id>,User {username = 'Alice', following = []})]
```

1. as expected, the `contracts` variable contains the single contract `Alice` we just created
1. note that the first entry of the tuple is an opaque contract ID, indicated by
   `<contract-id>`. The representation of contract ID's is internal to the ledger you are using.
   Hence it's represented as an opaque in the `REPL`.

As an exercise, try to allocate another party `Bob` and issue an `exerciseCmd` to make `Alice`
follow `Bob`! Step by step you can build your social network.

Everything you learned for DAML scripts also works in the DAML REPL! This can be a powerful tool to
run through your DAML code and check the ledger state with queries and `debug` statements.
