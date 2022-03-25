#!/bin/bash

echo initializing...

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb

wget https://github.com/digital-asset/daml/releases/download/v2.0.0/canton-open-source-2.0.0.tar.gz

tar xzf canton-open-source-2.0.0.tar.gz
