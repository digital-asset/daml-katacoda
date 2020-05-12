The script is ready for testing! Switch to the first terminal tab, then build the `dar` archive
with

```
daml build
```{{execute T1}}

and fire up the sandbox ledger loaded with our `dar`:

```
daml sandbox .daml/dist/create-daml-app-0.1.0.dar
```{{execute T1}}

Wait a few seconds for the sandbox ledger to come up. Once it's up you'll see

```
   ____             ____
  / __/__ ____  ___/ / /  ___ __ __
 _\ \/ _ `/ _ \/ _  / _ \/ _ \\ \ /
/___/\_,_/_//_/\_,_/_.__/\___/_\_\

INFO: Initialized sandbox version 1.1.0-snapshot.20200430.4057.0.681c862d with ledger-id = 7b4a418b-dd4b-479b-9771-611d4ec7d98b, port = 6865, dar file = List(.daml/dist/create-daml-app-0.1.0.dar), time mode = wall-clock time, ledger = in-memory, auth-service = AuthServiceWildcard$, contract ids seeding = strong

```
in the terminal.

Remember that your script needed an input argument? Where does it come from? The argument to the
script is specified as the `--input-file` argument to the `daml script` command. The content of
that input file needs to be encoded in the [DAML-LF-JSON
format](https://docs.daml.com/json-api/lf-value-specification.html). In our case it's just a list
of strings. Paste the following in a new `initialParties.json`{{open}} file.

<pre class="file" data-filename="initialParties.json" data-target="append">
["Alice", "Bob", "Charlie"]
</pre>

Now you can run your script against the local sandbox ledger. In the **second** terminal, change
directory to `create-daml-app` and execute the script with

```
cd create-daml-app
daml script --dar .daml/dist/create-daml-app-0.1.0.dar --script-name User:initialize --ledger-host localhost --ledger-port 6865 --wall-clock-time --input-file initialParties.json
```{{execute T2}}

1. the `script-name` argument needs to be the fully qualified name of your script. Our script is
   in the `User` module and its name is `initialize`, hence `User:initialize`.
1. the `ledger-host`, `ledger-port` is the network address and port of the ledger you want to run
   your script against. Our sandbox runs locally, hence `ledger-host` is `localhost`.
1. `wall-clock-time` tells the script that the ledger runs in wall clock time mode, as opposed to
   static time (where time is advanced manually).


The script finishes and outputs the final debug statement:

```
[DA.Internal.Prelude:540]: "done!"

```

Nice! The sandbox ledger is initialized now, `Alice`, `Bob`, `Charlie` and `operator` exist and
form a mini social network together! In the next step you learn how to run DAML scripts
interactively against a running ledger.
