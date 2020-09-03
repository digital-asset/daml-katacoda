Before we think about deployment, we want to build a DAML application that was tested agains the
local sandbox ledger. For this scenario we'll take the mini social network of the `create-daml-app`
template.

Change to the create-daml-app directory

```
cd create-daml-app
```{{execute T1}}

where you'll find the plain `create-daml-app` template application. If you haven't already, I
recommend you run through the [Getting Started
Guide](https://daml.com/learn/getting-started/build-and-run) to get you familiar with the
`create-daml-app` template application.

Compile the application with

```
daml build -o create-daml-app-0.1.0.dar
```{{execute T1}}

and start the local sandbox ledger by executing

```
daml start
```{{execute T1}}

Now build the JavaScript bindings for the UI in the second terminal with

```
cd create-daml-app
daml codegen js -o ui/daml.js create-daml-app-0.1.0.dar
```{{execute T2}}

Change to the `ui` directory and build and run the UI with

```
cd ui
npm install
npm start
```{{execute T2}}

Now [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com)
and check that you'll find the `create-daml-app` live and running.

Once you confirmed that your application runs on the local sandbox ledger, **you can tear the sandbox
and the UI down by emitting a Ctrl-C in terminal 1 and 2**.
