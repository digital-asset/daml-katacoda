And now let's build and start our UI
```
cd $HOME/my-app/ui
yarn install
yarn build
export REACT_APP_LEDGER_ID=fabric-ledger
yarn start
```{{execute T4}}

This starts the web UI connected to the running JSON API server, which in turn talks to the DAML Runtime, which talks to the underlying Fabric ledger. But your end user application only needs to make regular JSON API requests. Once the web UI has been compiled and started, you should see `Compiled successfully!` in your terminal. You can then [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com).