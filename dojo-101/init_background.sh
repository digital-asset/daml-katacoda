#!/bin/bash

init()
{
    cd /tmp
    git clone https://github.com/LeventeBarczyDA/daml-race.git
    mkdir -p /root/daml-race
    cp -r daml-race/* /root/daml-race
    rm -rf daml-race
}

echo Initialising...
init
echo Done!
