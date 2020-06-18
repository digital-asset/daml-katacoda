#!/bin/bash

echo Starting sandbox

rm -rf create-daml-app
daml create-daml-app create-daml-app
cd create-daml-app
daml build

daml sandbox --ledgerid MyLedger &
sleep 5
daml json-api --ledger-host=localhost --ledger-port=6865 --http-port=7575 --address=0.0.0.0 --allow-insecure-tokens &
daml ledger upload-dar .daml/dist/create-daml-app-0.1.0.dar

echo Done!
