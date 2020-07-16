#!/bin/bash

echo initializing...

tar xzf create-daml-app.tar.gz

sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "DAML SDK version is" $sdk_version
sed -i "/sdk-version: /c\sdk-version: $sdk_version" /root/create-daml-app/daml.yaml

cd create-daml-app
mkdir .daml

echo done
