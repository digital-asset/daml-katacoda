#!/bin/bash

echo initializing...

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb

wget https://github.com/digital-asset/daml/releases/download/v2.1.1/canton-open-source-2.1.1.tar.gz

tar xzf canton-open-source-2.1.1.tar.gz
