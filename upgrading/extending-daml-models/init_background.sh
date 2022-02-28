#!/bin/bash

setup_vs_extension()
{
    ~/.daml/bin/daml install 2.0.0-snapshot.20220222.9362.0.1af680cd
    rm -rf daml-bundled
    rm -rf /opt/.katacodacode/extensions/daml-bundled
    echo "Removed the VS"
    curl -sSL https://gist.githubusercontent.com/cocreature/b616b7ff1244b227ee17cdc476695435/raw/fd337aab4460e2e81074bc3dfd3e527b52c233d5/patch-extension.sh > patch-extension.sh
    echo "Got the extension"
    chmod +x patch-extension.sh
    ./patch-extension.sh $(find ~/.daml/sdk/2.*/studio/daml-bundled.vsix) patched-daml-bundled.vsix
    echo "Patched it"
    unzip patched-daml-bundled.vsix -d daml-bundled
    echo "unzipped it"
    mv daml-bundled/extension /opt/.katacodacode/extensions/daml-bundled
    echo "moved it"
    rm -rf daml-bundled
    rm patched-daml-bundled.vsix
    rm patch-extension.sh
}

init()
{
    cd /tmp
    ~/.daml/bin/daml new create-daml-app create-daml-app
    mkdir -p /root/daml-projects
    mkdir - /root/daml-projects/create-daml-app
    mv create-daml-app/* /root/daml-projects/create-daml-app/
}

echo Initialising...
setup_vs_extension
init
echo Done!
