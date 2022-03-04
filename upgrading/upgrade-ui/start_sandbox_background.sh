#!/usr/bin/env bash
cd /root/create-daml-app
daml sandbox --port-file portfile &
while [ ! -f portfile ]; do sleep 0.5; done
daml ledger upload-dar create-daml-app-0.1.0.dar
daml ledger upload-dar create-daml-app-0.1.1.dar
daml ledger upload-dar forum-0.1.0.dar
daml ledger upload-dar forum-0.1.1.dar
daml ledger upload-dar migration-0.1.0.dar
daml script --dar forum-0.1.0.dar --script-name Init:initialize --ledger-host localhost --ledger-port 6865 --wall-clock-time
daml script --dar forum-0.1.1.dar --script-name Init:initialize --ledger-host localhost --ledger-port 6865 --wall-clock-time
daml json-api --ledger-host=localhost --ledger-port=6865 --http-port=7575 --address=0.0.0.0 --allow-insecure-tokens &
