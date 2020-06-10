We start with the following setup (currently being setup in terminal 1): Your social network of
`create-daml-app-0.1.0` and `forum-0.1.0` are running and your users have been happily posting
messages in the forum. You decide to upgrade to `create-daml-app-0.1.1` and hence you write a
migration package `migration-0.1.0` and deploy it together with the new packages
`create-daml-app-0.1.1`, `forum-0.1.1`.

Now you want to drive the upgrade process of the `create-daml-app-0.1.0` DAML application from the
UI.  If a user wants to login, whose `User` contract is still of the old `create-daml-app-0.1.0`
package, you ask her kindly to upgrade to the newer package. 

In order to do so, you need the generated JavaScript bindings for the newly available packages.
**Wait for the sandbox to boot in the background**. Then create them with the DAML Assistant like
so:

```
daml codegen js create-daml-app-0.1.0.dar -o daml.js
daml codegen js create-daml-app-0.1.1.dar -o daml.js
daml codegen js forum-0.1.0.dar -o daml.js
daml codegen js migration-0.1.0.dar -o daml.js
```{{execute T1}}

Once finished, open `ui/package.json`{{open}} in the IDE and add the new dependencies for the
`create-daml-app-0.1.1`, `forum-0.1.0` and `migration-0.1.0` packages

<pre class="file" data-target="clipboard">
  "dependencies": {
    "@daml.js/create-daml-app-0.1.0": "file:../daml.js/create-daml-app-0.1.0",
    "@daml.js/create-daml-app": "file:../daml.js/create-daml-app-0.1.1",
    "@daml.js/forum-0.1.0": "file:../daml.js/forum-0.1.0",
    "@daml.js/migration-v0-v1": "file:../daml.js/migration-0.1.0",
    "@daml/ledger": "1.1.1",
    "@daml/react": "1.1.1",
    "@daml/types": "1.1.1",
    "jwt-simple": "^0.5.6",
    "react": "^16.12.0",
    "react-dom": "^16.12.0",
    "dotenv": "^8.2.0",
    "semantic-ui-css": "^2.4.1",
    "semantic-ui-react": "^0.88.1"
  }
</pre>

and install them with

```
cd ui
yarn install
```{{execute T1}}

Notice that the `create-daml-app` import now points to the `create-daml-app-0.1.1` package, while we
refer to imports from the old `create-daml-app-0.1.0` package by `create-daml-app-0.1.0`. This
guarantees that all UI code is importing the newly generated `create-daml-app-0.1.1` JavaScript
bindings except when we explicitly want to use the old `create-daml-app-0.1.0` bindings.
