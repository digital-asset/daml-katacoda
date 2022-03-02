#!/bin/bash

echo Starting sandbox

cd create-daml-app

daml sandbox --port-file portfile &
while [ ! -f portfile ]; do sleep 0.5; done
daml json-api --ledger-host=localhost --ledger-port=6865 --http-port=7575 --address=0.0.0.0 --allow-insecure-tokens &
daml ledger upload-dar create-daml-app-0.1.0.dar

echo Done!
