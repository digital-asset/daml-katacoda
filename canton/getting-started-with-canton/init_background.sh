#!/bin/bash

echo initializing...

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb

wget https://www.canton.io/releases/canton-community-1.0.0-rc8.tar.gz

tar xzf canton-community-1.0.0-rc8.tar.gz
