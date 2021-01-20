#!/bin/bash

echo initializing...

tar xzf create-daml-app.tar.gz

cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "Daml SDK version is" $sdk_version
sed -i "s/__SDK_VERSION__/$sdk_version/g" $(find ~/ -name daml.yaml -or -name package.json)
cd /root/create-daml-app
mkdir .daml

echo done
