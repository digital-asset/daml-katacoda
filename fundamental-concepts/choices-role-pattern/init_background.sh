#!/bin/bash

echo initializing...

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb
wget https://katacoda.com/daml/courses/fundamental-concepts/choices-role-pattern/assets/create-daml-app.tar.gz

tar xzf create-daml-app.tar.gz
cd create-daml-app
mkdir .daml

echo done
