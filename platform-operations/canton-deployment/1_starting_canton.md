Cereate the `create-daml-app` example into a directory named `create-daml-app` (as the example configuration files of `examples/04-create-daml-app` expect the files to be there):

```
daml new create-daml-app --template create-daml-app
```{{execute T1}}

Then, compile the Daml code into a DAR file (this will create the file `.daml/dist/create-daml-app-0.1.0.dar`), and run the code generation step used by the UI:

```
cd create-daml-app
daml build
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o ui/daml.js
```{{execute T1}}

You will also need to install the dependencies for the UI:

```
cd ui
npm install
```{{execute T1}}

Next, the original tutorial would ask you to start the Daml Sandbox and the HTTP JSON API with `daml start`. We will instead start Canton using the distributed setup in `examples/04-create-daml-app`, and will later start the HTTP JSON API separately.

Return to the directory where you unpacked the Canton distribution and start Canton with:

```
cd ../..
bin/canton -c examples/04-create-daml-app/canton.conf --bootstrap examples/04-create-daml-app/init.canton
```{{execute T1}}

> Note :If you get an Compilation Failed error, you may have to make the Canton binary executable with `chmod +x bin/canton`

This will start two participant nodes, and will allocate the parties Alice and Bob. Each participant node will expose its own ledger API:

1. Alice will be hosted by participant1, with its ledger API on port `12011`

2. Bob will be hosted by participant2, with its ledger API on port `12021`

Note that the `examples/04-create-daml-app/init.canton` script performs a few setup steps to permission the parties and upload the DAR.

Leave Canton running and switch to a new terminal window.
