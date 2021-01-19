#!/bin/bash

echo initializing...

wget https://katacoda.com/daml/courses/fundamental-concepts/stdlib-tour/assets/organizer.tar.gz

daml new organizer empty-skeleton

tar xzf organizer.tar.gz

cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "Daml SDK version is" $sdk_version
sed -i "s/__SDK_VERSION__/$sdk_version/g" $(find ~/ -name daml.yaml -or -name package.json)

cd /root/organizer
mkdir .daml

echo done
