#!/bin/bash

init()
{
    cd /tmp
    ~/.daml/bin/daml new create-daml-app create-daml-app
    mkdir -p /root/daml-projects
    mkdir - /root/daml-projects/create-daml-app
    mv create-daml-app/* /root/daml-projects/create-daml-app/
}

echo Initialising...
init
echo Done!
