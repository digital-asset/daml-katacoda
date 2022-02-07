Your Daml scripts aren't restrained to the in-memory ledger of the IDE. You can run your scripts
against any live Daml ledger!

Let's try this with the local sandbox ledger. You can start the sandbox by running

```
daml start
```{{execute T1}}

in the terminal. Wait a few seconds for the sandbox ledger to start. Once it's up you'll see

```
.......
Press 'r' to re-build and upload the package to the sandbox.
Press 'Ctrl-C' to quit.
```
in the terminal.

Now you can run your script against    the local sandbox ledger. In the **second** terminal, change
directory to `create-daml-app` and execute the script with

```
cd create-daml-app
daml script --dar .daml/dist/create-daml-app-0.1.0.dar --script-name User:test --ledger-host localhost --ledger-port 6865 --wall-clock-time
```{{execute T2}}

1. the `script-name` argument needs to be the fully qualified name of your script. Our script is
   in the `User` module and its name is `test`, hence `User:test`.
1. the `ledger-host`, `ledger-port` is the network address and port of the ledger you want to run
   your script against. Our sandbox runs locally, hence `ledger-host` is `localhost`.
1. `wall-clock-time` tells the script that the ledger runs in wall clock time mode, as opposed to
   static time (where time is advanced manually).

The script finishes and outputs the final trace:

```
[DA.Internal.Prelude:555]: "done!"
```
