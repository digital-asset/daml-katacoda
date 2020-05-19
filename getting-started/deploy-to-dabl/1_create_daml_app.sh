#!/bin/bash

init()
{
    daml new create-daml-app create-daml-app
    cd /root/create-daml-app
}

echo Initialising...
init
echo Done!
