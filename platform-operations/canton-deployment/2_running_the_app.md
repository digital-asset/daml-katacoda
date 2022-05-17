Once Canton is running, start the HTTP JSON API:

- Connected to the ledger api on port `12011` (corresponding to Alice’s participant)

- And connected to the UI on the default expected port `7575`

```
DAML_SDK_VERSION=2.2.0 daml json-api \
    --ledger-host localhost \
    --ledger-port 12011 \
    --http-port 7575 \
    --allow-insecure-tokens
```{{execute T2}}

Leave this running. The UI can then be started from a 3rd terminal window with:

```
cd canton-open-source-2.2.0/create-daml-app/ui
REACT_APP_LEDGER_ID=participant1 npm start
    ```{{execute T3}}

Note that we have to configure the ledger ID used by the UI to match the name of the participant that we’re running against. This is done using the environment variable `REACT_APP_LEDGER_ID`.

We can now login as `alice`.
