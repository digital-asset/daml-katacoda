#!/bin/bash

echo initializing...

wget https://katacoda.com/daml/courses/fundamental-concepts/propose-accept-pattern/assets/create-daml-app.tar.gz

daml new create-daml-app empty-skeleton

tar xzf create-daml-app.tar.gz

sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "DAML SDK version is" $sdk_version
sed -i "/sdk-version: /c\sdk-version: $sdk_version" /root/create-daml-app/daml.yaml

cd create-daml-app

echo done
