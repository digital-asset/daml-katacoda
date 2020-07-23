#!/bin/bash

echo initializing...

wget https://katacoda.com/daml/courses/fundamental-concepts/propose-accept-pattern/assets/create-daml-app.tar.gz

daml new create-daml-app empty-skeleton

tar xzf create-daml-app.tar.gz

cd create-daml-app

echo done
