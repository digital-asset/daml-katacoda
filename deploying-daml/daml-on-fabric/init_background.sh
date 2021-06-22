#!/bin/bash

init()
{
    ls
    rm -rf $HOME/my-app
    rm -rf $HOME/daml-on-fabric
    rm -rf $HOME/fabric
    daml install --install-assistant=yes 1.10.0
    echo "export DAML_SDK_VERSION=1.10.0" >> $HOME/.bashrc
}

echo Initialising...
init
echo Done!
