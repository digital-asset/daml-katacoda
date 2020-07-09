#!/bin/bash

echo initializing...

wget https://katacoda.com/daml/courses/fundamental-concepts/stdlib-tour/assets/organizer.tar.gz

daml new organizer empty-skeleton

tar xzf organizer.tar.gz


sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "DAML SDK version is" $sdk_version
sed -i "/sdk-version: /c\sdk-version: $sdk_version" /root/organizer/daml.yaml

cd organizer

echo done
