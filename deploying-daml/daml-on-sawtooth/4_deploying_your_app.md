After a succesful build of Hyperledger Sawtooth, you can now launch your local Sawtooth node:

```
./docker/run.sh start
```{{execute T2}}

Once Sawtooth is up, you will see output similar to

![sawtooth_running](./assets/sawtooth_running.png)

You can deploy your application comfortable with the `daml ledger` commands from the
`create-daml-app` project folder. Let's upload the `create-daml-app-0.1.0.dar` package. By default,
the Sawtooth ledger listens on port `9000` for DAML ledger administration commands:

```
cd create-daml-app
daml ledger upload-dar create-daml-app-0.1.0.dar --host localhost --port 9000
```{{execute T3}}

Since this is a production ledger, we also need to allocate parties on the ledger:

```
daml ledger allocate-parties Alice Bob --host localhost --port 9000
```{{execute T3}}

Finally, we also need to start the HTTP JSON API server for our application to interact:


```
daml json-api --ledger-host=localhost --ledger-port=9000 --http-port=7575 --address=0.0.0.0 --allow-insecure-tokens
```{{execute T3}}
