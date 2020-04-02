#!/bin/bash

echo "PATH=\$PATH:\$HOME/.daml/bin" >> ~/.bashrc
source ~/.bashrc

# uninstall unnecessary VSCode extensions
rm -rf /opt/.katacodacode/extensions/redhat.vscode-openshift-connector-0.0.19

# install the daml extension (the hard way)
cd /tmp & mkdir daml-bundled
unzip $(find ~/.daml/sdk/*/studio/daml-bundled.vsix) -d daml-bundled
mv daml-bundled/extension /opt/.katacodacode/extensions/daml-bundled
rm -Rf /tmp/daml-bundled