#!/bin/bash

echo initializing...

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb
wget https://katacoda.com/daml/courses/upgrading/upgrade-ui/assets/create-daml-app.tar.gz

tar xzf create-daml-app.tar.gz
cd create-daml-app
sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' ui/src/config.ts
mkdir .daml

# make sure there are enough filewatchers for `yarn start`
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
sysctl -p

echo done
