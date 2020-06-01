```
daml create-daml-app my-app
cd my-app
```{{execute T1}}

Next we need to compile the DAML code to a DAR file:

```
daml build
```{{execute T1}}

Once the DAR file is created you will see this message in terminal: 

```
Created .daml/dist/my-app-0.1.0.dar.
```

In order to connect the UI code to this DAML, we need to run a code generation step:

```
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o daml.js
```{{execute T1}}

Now, changing to the ui folder, use Yarn to install the project dependencies:

```
cd ui
yarn install
yarn build
```{{execute T1}}

This step may take a couple of moments (it’s worth it!). You should see `success Saved lockfile.` in the output if everything worked as expected.

Let's install Fabric
```
cd /root
mkdir fabric
cd fabric
curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.0.0 -s
export PATH=fabric/bin:$PATH
```{{execute T1}}

Now let's run a local Fabric network that we'll then connect the DAML Runtime to
```
cd /root
git clone https://github.com/digital-asset/daml-on-fabric.git
cd /root/daml-on-fabric/src/test/fixture/
./gen.sh
./restart_fabric.sh
```{{execute T1}}

And connect the runtime, we'll do this from another terminal
```
cd /root/daml-on-fabric
sbt "run --port 6865 --role provision,time,ledger" -J-DfabricConfigFile=config.json
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

Now let's deploy our DAML application
```
cd /root/my-app
daml deploy --host localhost --port 6865
daml json-api --ledger-host localhost --ledger-port 6865 --http-port 7575
```{{execute T3}}

And now let's start our UI
```
cd /root/my-app
yarn start
```{{execute T4}}

This starts the web UI connected to the running JSON API server, which in turn talks to the DAML Runtime, which talks to the underlying Fabric ledger. But your end user application only needs to make regular JSON API requests. Once the web UI has been compiled and started, you should see `Compiled successfully!` in your terminal. You can then [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com).