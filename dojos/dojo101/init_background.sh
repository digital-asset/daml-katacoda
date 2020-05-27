#!/bin/bash

init()
{
    cd /tmp
    git clone https://github.com/vivek-DA/damldojo.git
    mkdir -p /root/dojo101
    cp -r damldojo/dojo101/* /root/dojo101
    rm -rf damldojo
}

echo Initialising...
init
echo Done!
