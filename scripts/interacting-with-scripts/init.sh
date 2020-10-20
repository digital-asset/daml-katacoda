#!/bin/bash

rm -rf create-daml-app
daml new create-daml-app --template create-daml-app
cd create-daml-app
# daml-trigger isn't needed and becomes a problem for the REPL
sed -i -e "s/- daml-trigger//" daml.yaml
