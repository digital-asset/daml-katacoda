Time to start packaging our UI code for deployment.

The UI package will be the result of the auto-generated javascript objects from our daml model along with our custom html/js/css. It will all be converted into static assets using `react-scripts` and then zipped up into a deployable archive.

Let's first run the code generation step by pointing the codegen tool to the `.dar` we created in the previous step:

```
daml codegen js target/create-daml-app.dar -o daml.js
```{{execute T1}}

A successful run of the `codegen js` should have created a set of packages in the `daml.js` directory.

Now onto building our UI code. Let's change directories to `ui` and invoke a `yarn install` followed by a `yarn build`:

```
cd ui && yarn install && yarn build
```{{execute T1}}

Remember that these steps usually take a couple of moments..

Finally we will zip up your build folder and drop it in the `target/` folder you created previously:

```
zip -r ../target/create-daml-app-ui.zip build
```{{execute T1}}

Before we move on, let's take a look at the contents of your target folder to make sure you have everything. There should be two files:

- `create-daml-app.dar` for your daml model and
- `create-daml-app-ui.zip` for your app's UI.

```
cd /root/create-daml-app/target
ls
```{{execute T1}}
