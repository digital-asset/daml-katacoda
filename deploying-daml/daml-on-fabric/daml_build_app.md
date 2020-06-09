Next we need to compile the DAML code to a DAR file:

```
cd $HOME/my-app
daml build
```{{execute T1}}

Once the DAR file is created you will see this message in terminal: 

```
Created .daml/dist/my-app-0.1.0.dar.
```

In order to connect the UI code to this DAML, we need to run a code generation step:

```
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o daml.js
```{{execute T1}}