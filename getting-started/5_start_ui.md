Back in our original terminal, we can now start the UI. Before we do so, we need to make a small adjustments for this environment.

First, add the below line to `ui/.env`{{open}}

<pre class="file" data-target="clipboard">DANGEROUSLY_DISABLE_HOST_CHECK=true
</pre>

Secondly, edit the websocket URL in `ui/src/config.ts`{{open}} to 

<pre class="file" data-target="clipboard">wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/</pre>

```
yarn start
```{{execute T1}}

This starts the web UI connected to the running Sandbox and JSON API server. Once the web UI has been compiled and started, you should see `Compiled successfully!` in your terminal. You can now [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com). 
