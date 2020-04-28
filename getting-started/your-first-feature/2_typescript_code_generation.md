
Remember that we interface with the DAML model from the UI components using generated TypeScript. Since we have changed our DAML code, we also need to rerun the TypeScript code generator. Run the following commands in terminal1 by clicking on the code below:

```
cd create-daml-app
daml build
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o daml.js
```{{execute T1}}

The result is an up-to-date TypeScript interface to our DAML model, in particular to the new Message template and SendMessage choice.

After the above commands have been executed run Yarn to install the project dependencies by clicking on the code below. *Do not run the below commands until the first set of commands in terminal1 have been executed*.

```
cd create-daml-app/ui
yarn install
```{{execute T2}}

Once that command finishes, you have to close Visual Studio Code and restart it by running daml studio from the root directory of your project.

We can now implement our messaging feature in the UI!
