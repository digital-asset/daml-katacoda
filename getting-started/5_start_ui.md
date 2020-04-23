Back in our original terminal, we can now start the UI. Before we do so, we need to make a small adjustments for this environment.

First, add the below line to `ui/.env`{{open}}

<pre class="file" data-filename="ui/.env" data-target="append">DANGEROUSLY_DISABLE_HOST_CHECK=true
</pre>

Secondly, edit the websocket URL in `ui/src/config.ts`{{open}} to 

<pre class="file" data-target="clipboard">wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/</pre>

To do so, you can run

```
sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' src/config.ts
```{{execute T1}}

Finally, run `yarn start`{{execute T1}}

This starts the web UI connected to the running Sandbox and JSON API server. Once the web UI has been compiled and started, you should see `Compiled successfully!` in your terminal. You can now [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com). 
