The trigger is ready. You can start a local sandbox ledger with

```
cd market
daml start
```{{execute T1}}

There is a small demo UI in the market folder. Get the JavaScript bindings,

```
cd market
daml codegen js -o ui/daml.js .daml/dist/market-0.1.0.dar
```{{execute T2}}

and install the UI dependencies:

```
cd ui
npm install
```{{execute T2}}

Finally, start the UI:

```
npm start
```{{execute T2}}

Triggers are started from the command line with the `daml trigger` command

```
cd market
daml trigger --dar .daml/dist/market-0.1.0.dar --trigger-name Market:deleteInvoiceTrigger --ledger-host localhost --ledger-port 6865 --ledger-user bob
```{{execute T3}}

- the `--dar` argument points to the location of the compiled `.dar` file
- the `--trigger-name` is the full name of the trigger, i.e. the module name, a colon, then the
  function name of the trigger.
- the `--ledger-user` argument gives the trigger the user id for which it should execute the
  trigger

Once the trigger is running and waiting for ledger events you see the output

```
Trigger is running as Bob
```

In a production environment the party running the trigger needs to authenticate itself agains the
ledger. You can do this by passing the argument

```
--access-token-file token.jwt

```

to the trigger command, where the `token.jwt` file contains the authentication JWT token for the
party.
