
DAML provides a [codegen tool](https://docs.daml.com/app-dev/bindings-ts/daml2js.html) to easily interact with an application on a DAML ledger via the JSON API. To generate this code we run:

```
daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o daml.js
```{{execute T1}}

> Note: Our UI will later use this code to interact with our DAML application over the JSON API

Now, change to the `ui/` folder use Yarn to install the dependencies for the UI:

```
cd ui
yarn install
```{{execute T1}}

This step may take a couple of moments. You'll see `success Saved lockfile` in the terminal when it's done.

