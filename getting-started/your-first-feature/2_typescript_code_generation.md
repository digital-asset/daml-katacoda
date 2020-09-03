Remember that we interface with the DAML model from the UI components using generated TypeScript. Since we have changed our DAML code, we also need to rerun the TypeScript code generator. Run the following commands in terminal 1 by clicking on the code below:

```
cd create-daml-app
daml build
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o ui/daml.js
```{{execute T1}}

The result is an up-to-date TypeScript interface to our DAML model, in particular to the new `Message` template and `SendMessage` choice.

Now we can start implementing our messaging feature in the UI!
