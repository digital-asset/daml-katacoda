We’ll start by getting the app up and running, and then explain the different components.

First off, open a terminal and instantiate the template project. You can click on the below snippets to run them in the terminal.

```
daml new create-daml-app --template create-daml-app
```{{execute T1}}

This creates a new folder with contents from our template. To see a list of all available templates run `daml new --list`. Change to the new folder:

```
cd create-daml-app
```{{execute T1}}

Any commands starting with `daml` are using the [Daml Assistant](https://docs.daml.com/tools/assistant.html), a command line tool in the Daml SDK for building and running Daml apps.
