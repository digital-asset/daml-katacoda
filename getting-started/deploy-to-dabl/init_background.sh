#!/bin/bash

init()
{
    ls
    rm -rf /root/create-daml-app
    daml new create-daml-app create-daml-app
    cd create-daml-app
}

echo Initialising...
init
echo Done!
