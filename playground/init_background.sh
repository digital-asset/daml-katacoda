#!/bin/bash

init()
{
    cd /tmp
    /root/.daml/bin/daml new playground_project
    mkdir -p /root/playground_project
    mv playground_project/* /root/playground_project/
    cd /root/playground_project/
}

echo Initialising...
init
echo Done!
