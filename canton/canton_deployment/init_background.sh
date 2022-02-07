#!/bin/bash

echo initializing...

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb
# wget https://github.com/digital-asset/canton/releases/download/v0.27.1/canton-community-0.27.1.tar.gz
#tar xzf canton-community-0.27.1.tar.gz

wget https://www.canton.io/releases/canton-community-1.0.0-rc8.tar.gz

tar xzf canton-community-1.0.0-rc8.tar.gz
