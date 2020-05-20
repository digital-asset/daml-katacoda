#!/bin/bash

init()
{
    cd /root/create-daml-app/target
    /usr/bin/python2 -m SimpleHTTPServer 8080 &
}

echo Initialising...
init
echo Done!
