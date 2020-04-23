#!/bin/bash

init()
{
    cd /root/create-daml-app/
    echo "json-api-options:" >> daml.yaml
    echo "- --address=0.0.0.0" >> daml.yaml
    cd /root/create-daml-app/ui
    echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> .env
    sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' src/config.ts
}

echo Initialising...
init
echo Done!
