#!/bin/bash

init()
{
    cd /tmp
    ~/.daml/bin/daml new create-daml-app create-daml-app
    mkdir -p /root/create-daml-app
    mv create-daml-app/* /root/create-daml-app/
    cd /root/create-daml-app/
    ls
    cd ui/
    ls
    touch MessageList.tsx
    touch MessageEdit.tsx
    ls
}

echo Initialising...
init
echo Done!
