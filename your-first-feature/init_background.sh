#!/bin/bash

init()
{
    rm -rf create-daml-app
    daml new create-daml-app create-daml-app
    cd create-daml-app/ui
    yarn install
    cd ..
}

echo Initialising...
init
echo Done!
