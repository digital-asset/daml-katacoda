#!/bin/bash

# Configuring the environment for more file watchers
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Following https://adoptopenjdk.net/installation.html
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

# Following https://github.com/nodesource/distributions/blob/master/README.md#deb
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -

sudo add-apt-repository ppa:ubuntu-toolchain-r/test

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y gcc-4.9
sudo apt-get upgrade -y libstdc++6
sudo apt install adoptopenjdk-11-hotspot-jre nodejs
