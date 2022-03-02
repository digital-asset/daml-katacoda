#!/bin/bash

echo "PATH=\$PATH:\$HOME/.daml/bin" >> ~/.bashrc
source ~/.bashrc

# uninstall unnecessary VSCode extensions
rm -rf /opt/.katacodacode/extensions/redhat.vscode-openshift-connector-0.0.19

# install the daml extension (the hard way)
cd /tmp
curl -sSL https://gist.githubusercontent.com/cocreature/b616b7ff1244b227ee17cdc476695435/raw/fd337aab4460e2e81074bc3dfd3e527b52c233d5/patch-extension.sh > patch-extension.sh
chmod +x patch-extension.sh
./patch-extension.sh $(find ~/.daml/sdk/2.*/studio/daml-bundled.vsix) patched-daml-bundled.vsix
unzip patched-daml-bundled.vsix -d daml-bundled
mv daml-bundled/extension /opt/.katacodacode/extensions/daml-bundled
rm -Rf daml-bundled
rm patched-daml-bundled.vsix
rm patch-extension.sh
