Now let's start our JSON API that is automatically generated from our DAML code and lets our user's UI easily talk to our backend systems (DAML Runtime and Fabric)
```
daml json-api --ledger-host localhost --ledger-port 6865 --http-port 7575 --allow-insecure-tokens
```{{execute T3}}