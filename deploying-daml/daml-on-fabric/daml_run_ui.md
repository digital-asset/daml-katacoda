Alright now our entire backend is up and running, participant nodes are participating, runtimes are running, and json apis are json-ing. All that's left is to build and start our UI.

```
cd $HOME/my-app/ui
export REACT_APP_LEDGER_ID=fabric-ledger
npm install
npm start
```{{execute T4}}

Once the web UI has been compiled and started, you should see `Compiled successfully! You can now view create-daml-app in the browser.` in your terminal. You can then [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com) and login as one of the users on the system (ie. `Alice`, `Bob`, or `Charlie`). Try it out, you can even add other users as friends.

If you want to dive in further and understand the guarantees DAML gives you, or learn more about how it works then jump over to our [getting started exercises](https://docs.daml.com/getting-started/index.html) and try running DAML locally. We even have a [Sandbox mode](https://docs.daml.com/tools/sandbox.html) so you don't need to do a full distributed ledger deployment if you just want to play around with DAML.
