#!/bin/bash
cd /tmp
~/.daml/bin/daml new create-daml-app create-daml-app
mkdir -p /root/create-daml-app
mv create-daml-app/* /root/create-daml-app/
cd /root/create-daml-app/
echo "json-api-options:" >> daml.yaml
echo "- --address=0.0.0.0" >> daml.yaml
cd /root/create-daml-app/ui
echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> .env
sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' src/config.ts
cd /root
tar xzf forum.tar.gz
cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "DAML SDK version is" $sdk_version
sed -i "/sdk-version: /c\sdk-version: $sdk_version" /root/forum/daml.yaml
cd /root
rm forum.tar.gz
