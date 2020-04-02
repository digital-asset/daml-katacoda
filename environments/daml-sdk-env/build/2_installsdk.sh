#!/bin/bash
export SDK_VERSION=0.13.55

curl https://get.daml.com | sh -s $SDK_VERSION \
    && printf "auto-install: false\nupdate-check: never\n" >> /home/daml/.daml/daml-config.yaml