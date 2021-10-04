#!/bin/bash
export SDK_VERSION=1.17.0

curl https://get.daml.com | sh -s $SDK_VERSION \
    && printf "auto-install: false\nupdate-check: never\n" >> $HOME/.daml/daml-config.yaml

# Hack to not show the release notes
mkdir -p /opt/.katacodacode/user-data/User/state/ \
    && echo "[[\"DigitalAssetHoldingsLLC.daml-bundled\", \"{\\\"version\\\":\\\"${SDK_VERSION}\\\", \\\"telemetry-consent\\\": false}\"]]" > /opt/.katacodacode/user-data/User/state/global.json

# Opt out of telemetry
mkdir -p $HOME/.daml \
    && touch $HOME/.daml/.opted_out
