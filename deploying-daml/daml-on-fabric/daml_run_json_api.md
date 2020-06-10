Okay now that our code is deployed if we wanted to we could talk directly to it using gRPC, but that's a bit cumbersome and not really what we want to build our user-facing applications against. Lucky for us our `daml` assistant also gives us the ability to automatically generate JSON-API endpoints based on our code. So we can just start up this service and our UI will have an API to consume.

```
cd $HOME/my-app
daml json-api --ledger-host localhost --ledger-port 6865 --http-port 7575 --address 0.0.0.0 --allow-insecure-tokens
```{{execute T3}}