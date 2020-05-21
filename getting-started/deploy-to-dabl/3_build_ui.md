Time to start packaging our UI code for deployment.
The UI package will be the result of the auto-generated javascript objects from our daml model along with our custom html/js/css. It will all be converted into static assets using `react-scripts` and then zipped up into a deployable archive.

Let's first run the code generation step by pointing the codegen tool to the `.dar` we created in the previous step:

```
daml codegen js target/create-daml-app.dar -o daml.js
```{{execute T1}}

A successful run of the `codegen js` should jave created a set of packages in the `daml.js` directory.

Now onto building our UI code. We change directory into `ui` and we invoke a `yarn install` followed by a `yarn build`:

```
cd ui && yarn install && yarn build
```{{execute T1}}

Remember that these steps take a couple of moments..

Finally we will zip up our build folder and drop it in our `target/` folder:

```
zip -r ../target/create-daml-app-ui.zip build
```{{execute T1}}
