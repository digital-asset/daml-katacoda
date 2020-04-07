#!/bin/bash
export SDK_VERSION=0.13.55

curl https://get.daml.com | sh -s $SDK_VERSION \
    && printf "auto-install: false\nupdate-check: never\n" >> $HOME/.daml/daml-config.yaml

# Hack to not show the release notes
mkdir -p opt/.katacodacode/user-data/User/state/
    && echo '[["DigitalAssetHoldingsLLC.daml-bundled", "{\"version\":\"0.13.55\"}"]]' > /opt/.katacodacode/user-data/User/state/global.json

# Opt out of telemetry
mkdir ~/.daml
    && touch ~/.daml/.opted_out
