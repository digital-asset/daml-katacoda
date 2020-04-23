#!/bin/bash

cd /tmp
wget https://raw.githubusercontent.com/digital-asset/daml-katacoda/master/environments/daml-sdk-env/assets/patched-extension.js
mv patched-extension.js /opt/.katacodacode/extensions/katacoda.katacoda-vscodeeditor-extension-0.0.1/extension.js
