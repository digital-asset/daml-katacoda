We can now run the app in two steps. The first is to run the DAML Ledger. 

Because we are running in a special environment, we need to configure the API to listen to external connections. To do so, we add the following two lines to the `daml.yaml`{{open}} project definition:

<pre class="file" data-filename="daml.yaml" data-target="replace">json-api-options:
- --address=0.0.0.0
</pre>

In a new terminal window run the command:

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

