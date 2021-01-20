Okay now that Fabric is up and running we need a way for our Daml code to be able to talk to it. In order to do this we'll start our Daml Runtime, this magical piece of tech essentially serves as the communication layer between a distributed ledger (in this case Fabric), and our Daml code. This is where our Daml code that we compiled earlier will actually run.

```
cd $HOME/daml-on-fabric
sbt "run --port 6865 --role provision"
sbt "run --port 6865 --role time,ledger" -J-DfabricConfigFile=config-local.yaml -Xss2M -XX:MaxMetaspaceSize=1024M
```{{execute T2}}

Give the `sbt` a few minutes to install dependencies. You can check out the [Daml Cheat Sheet](https://docs.daml.com/cheat-sheet/) while you wait. When `sbt` is ready the output will look like:

```
13:57:11.931 INFO  c.d.p.a.LedgerApiServer - Listening on 0.0.0.0:6865 over plain text.
13:57:11.934 INFO  c.d.p.a.StandaloneApiServer - Initialized API server version 1.1.1 with ledger-id = fabric-ledger, port = 6865, dar file = List()
```
