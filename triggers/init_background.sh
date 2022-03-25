#!/bin/bash

echo initializing...

wget https://katacoda.com/daml/scenarios/triggers/assets/market.tar.gz

daml new market empty-skeleton

tar xzf market.tar.gz

cd market

cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "Daml SDK version is" $sdk_version
sed -i "s/__SDK_VERSION__/$sdk_version/g" $(find ~/ -name daml.yaml -or -name package.json)


cd /root/market
mkdir .daml
cd ui
echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> .env

echo done
