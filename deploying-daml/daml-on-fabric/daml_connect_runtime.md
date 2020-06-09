And connect the DAML Runtime to our Fabric network, we'll do this from another terminal
```
cd $HOME/daml-on-fabric
sbt "run --port 6865 --role provision,time,ledger" -J-DfabricConfigFile=config-local.yaml
```{{execute T2}}

Give the `sbt` process a moment to start, when it's ready the output will look like:

```
13:57:06.404 INFO  c.d.p.a.ApiServices - DAML LF Engine supports LF versions: 0, 0.dev, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.dev; Transaction versions: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10; Value versions: 1, 2, 3, 4, 5, 6, 7
13:57:11.307 INFO  c.d.p.a.s.LedgerConfigProvider - No ledger configuration found, submitting an initial configuration 4f751996-52ab-44fb-b218-effb74b88fe6
13:57:11.354 INFO  c.d.p.a.s.LedgerConfigProvider - Initial configuration submission 4f751996-52ab-44fb-b218-effb74b88fe6 was successful
Received 2 tx proposal responses. Successful+verified: 2 . Failed: 0  - Fcn: RawBatchWrite 
13:57:11.793 INFO  c.d.p.a.s.LedgerConfigProvider - New ledger configuration Configuration(1,TimeModel(PT0S,PT2M,PT2M),PT24H) found at Absolute(00000000000000010000000000000000)
13:57:11.931 INFO  c.d.p.a.LedgerApiServer - Listening on 0.0.0.0:6865 over plain text.
13:57:11.934 INFO  c.d.p.a.StandaloneApiServer - Initialized API server version 1.2.0-snapshot.20200520.4224.0.2af134ca with ledger-id = fabric-ledger, port = 6865, dar file = List()
```