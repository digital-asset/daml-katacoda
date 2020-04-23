
Remember that we interface with the DAML model from the UI components using generated TypeScript. Since we have changed our DAML code, we also need to rerun the TypeScript code generator. Open a new terminal and run the following commands:

```
daml build
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o daml.js
```{{execute T1}}

The result is an up-to-date TypeScript interface to our DAML model, in particular to the new Message template and SendMessage choice.

To make sure that Yarn picks up the newly generated JavaScript code, we have to run the following command in the ui directory:

```
cd ui
yarn install --force --frozen-lockfile
```{{execute T2}}

Once that command finishes, you have to close Visual Studio Code and restart it by running daml studio from the root directory of your project.

We can now implement our messaging feature in the UI!
