Now let's deploy our DAML application
```
cd $HOME/my-app
daml deploy --host localhost --port 6865
daml json-api --ledger-host localhost --ledger-port 6865 --http-port 7575
```{{execute T3}}