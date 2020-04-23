
In order to connect the UI code to this DAML, we need to run a code generation step:

```
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o daml.js
```{{execute T1}}

Now, changing to the ui folder, use Yarn to install the project dependencies:

```
cd ui
yarn install
```{{execute T1}}

This step may take a couple of moments (it’s worth it!). You should see `success Saved lockfile.` in the output if everything worked as expected.

