#!/bin/bash

init()
{
    ls
    rm -rf /root/my-app
    rm -rf /root/daml-on-fabric
    rm -rf /root/fabric
}

echo Initialising...
init
echo Done!
