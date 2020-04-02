#!/bin/bash

# Following https://adoptopenjdk.net/installation.html
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

# Following https://classic.yarnpkg.com/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Following https://github.com/nodesource/distributions/blob/master/README.md#deb
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -

sudo add-apt-repository ppa:ubuntu-toolchain-r/test

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y gcc-4.9
sudo apt-get upgrade -y libstdc++6
sudo apt install adoptopenjdk-11-hotspot-jre nodejs yarn
