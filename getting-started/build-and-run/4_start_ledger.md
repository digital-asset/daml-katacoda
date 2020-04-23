We can now run the app in two steps. The first is to run the DAML Ledger.

In terminal 2 run the command:

```
cd create-daml-app
daml start
```{{execute T2}}

You will know that the command has started successfully when you see the

```INFO  com.daml.http.Main$ - Started server: ServerBinding(/0:0:0:0:0:0:0:0:7575)```

message in the terminal. The command does a few things:

1. Compiles the DAML code to a DAR file as in the previous `daml build` step.
1. Starts an instance of the [Sandbox](https://docs.daml.com/tools/sandbox.html), an in-memory ledger useful for development, loaded with our DAR.
1. Starts a server for the [HTTP JSON API](https://docs.daml.com/json-api/index.html), a simple way to run commands against a DAML ledger (in this case the running Sandbox).

We’ll leave these processes running to serve requests from our UI.
