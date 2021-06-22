#!/bin/bash

init()
{
    ls
    rm -rf $HOME/my-app
    rm -rf $HOME/daml-on-fabric
    rm -rf $HOME/fabric
}

echo Initialising...
init
echo Done!
