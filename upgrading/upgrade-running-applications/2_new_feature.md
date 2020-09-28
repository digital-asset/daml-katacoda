In this step we add a new feature to the `create-daml-app` code. Change directory to the
`create-daml-app` project

```
cd ../create-daml-app
```{{execute T2}}

and open `daml/User.daml`{{open}} in the IDE tab and wait for it to load. We'll extend the `User`
data with a `nickname` field, such that the beginning of the template looks like

<pre class="file" data-target="clipboard">
template User
  with
    username: Party
    following: [Party]
    nickname: Optional Text
  where
</pre>

Of course you could make a lot more involved changes to the template, but for the sake of the
presentation we restrict ourself to a simple additional data field. Now open the
`daml.yaml`{{open}}
file and increase the version of the package to `0.1.1`.

In the terminal, build the new package with

```
daml build -o create-daml-app-0.1.1.dar
```{{execute T2}}

We can already deploy the new package to the local sandbox ledger with

```
daml ledger upload-dar create-daml-app-0.1.1.dar
```{{execute T2}}

Recall from the first tutorial, that the package ID of the new `create-daml-app` package has
changed. Hence, you will also have to upgrade the `forum` package that depends on `create-daml-app`,
such that users can create posts and comments again with their upgraded `User` contracts.

Change directory to the `forum` project with

```
cd ../forum
```{{execute T2}}

and edit the `../forum/daml.yaml`{{open}} file to update the `create-daml-app` dependency to 0.1.1.
Your `daml.yaml` file should look like

<!-- TODO: automate having the right sdk-version in the snippet-->
<pre class="file" data-target="clipboard">
sdk-version: 1.5.0
name: forum
source: daml
parties:
  - Alice
  - Bob
  - Charlie
version: 0.1.1
dependencies:
  - daml-prim
  - daml-stdlib
  - daml-script
  - ../create-daml-app/create-daml-app-0.1.1.dar
sandbox-options:
  - --wall-clock-time
</pre>

Don't forget to update the `version` field **and** the `dar` filepath under `dependencies`. We'll
remove the initialization module as well because we don't need it anymore and don't want to upgrade
it.

```
rm daml/Init.daml
```{{execute T2}}

Now build the new forum package with

```
daml build -o forum-0.1.1.dar
```{{execute T2}}

and deploy it with

```
daml ledger upload-dar forum-0.1.1.dar
```{{execute T2}}

The next step is to write a migration contract.
