#!/bin/bash

echo Starting sandbox

rm -rf create-daml-app
daml create-daml-app create-daml-app
cd create-daml-app
sed -i "6i import Daml.Script hiding (User)" ./daml/User.daml
sed -i "7i import DA.Optional" ./daml/User.daml
sed -i '8i \
' ./daml/User.daml
daml build

daml sandbox --dar .daml/dist/create-daml-app-0.1.0.dar &
daml json-api --ledger-host=localhost --ledger-port=6865 --http-port=7575 --address=0.0.0.0 --allow-insecure-tokens &

echo Done!
