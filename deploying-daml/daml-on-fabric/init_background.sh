#!/bin/bash

init()
{
    ls
    rm -rf $HOME/my-app
    rm -rf $HOME/daml-on-fabric
    rm -rf $HOME/fabric
    rm -f $HOME/daml.yaml
}

echo Initialising...
init
echo Done!
