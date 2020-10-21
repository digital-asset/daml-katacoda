#!/bin/bash

echo initializing...

wget https://katacoda.com/daml/courses/fundamental-concepts/propose-accept-pattern/assets/create-daml-app.tar.gz

daml new create-daml-app empty-skeleton

tar xzf create-daml-app.tar.gz

cd create-daml-app

cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "DAML SDK version is" $sdk_version
sed -i "s/__SDK_VERSION__/$sdk_version/g" $(find ~/ -name daml.yaml -or -name package.json)

cd /root/create-daml-app
mkdir .daml
rm /root/create-daml-app/ui/._package.json

echo done
