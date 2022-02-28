#!/bin/bash
setup_vs_extension()
{
    ~/.daml/bin/daml install 2.0.0-snapshot.20220225.9368.0.b291a57e
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

echo initializing...
setup_vs_extension

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb
wget https://katacoda.com/daml/courses/upgrading/upgrade-ui/assets/create-daml-app.tar.gz

tar xzf create-daml-app.tar.gz
cd create-daml-app
sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' ui/src/config.ts
mkdir .daml
cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')

echo "Daml SDK version is" $sdk_version
sed -i "s/__SDK_VERSION__/$sdk_version/g" $(find ~/ -name daml.yaml -or -name package.json)
cd /root
rm create-daml-app.tar.gz

echo done
