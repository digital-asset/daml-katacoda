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


setup_vs_extension

cd /tmp
~/.daml/bin/daml new create-daml-app create-daml-app
mkdir -p /root/create-daml-app
mv create-daml-app/* /root/create-daml-app/
cd /root/create-daml-app/
echo "json-api-options:" >> daml.yaml
echo "- --address=0.0.0.0" >> daml.yaml
cd /root/create-daml-app/ui
echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> .env
sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' src/config.ts
cd /root
tar xzf forum.tar.gz
cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "Daml SDK version is" $sdk_version
sed -i "s/__SDK_VERSION__/$sdk_version/g" $(find ~/ -name daml.yaml -or -name package.json)
cd /root
rm forum.tar.gz
