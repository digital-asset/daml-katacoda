In this first step we deploy the two packages `create-daml-app` and `forum` to the sandbox ledger
and create some initial contracts. This is the typical situation you usually find yourself in when
you decide to upgrade a package. In particular you don't only need to care about deploying new code
but also about migrating active contracts.

You find the two source directories for the `create-daml-app` and `forum` packages in your home
directory. The `forum` package has been extended to contain an initialization script.

```
ls
```{{execute T1}}

Change directory to `create-daml-app`

```
cd create-daml-app
```{{execute T1}}

and build the `0.1.0` version of the package with

```
daml build -o create-daml-app-0.1.0.dar
```{{execute T1}}

The `-o` option for `daml build` lets you specify the output filename and location. We do the same
for the `forum` package:

```
cd ../forum
daml build -o forum-0.1.0.dar
```{{execute T1}}

No we can start a local sandbox ledger with

```
daml sandbox
```{{execute T1}}

and deploy the packages **in the second terminal after the sandbox has fully started** with

```
cd forum
daml ledger upload-dar forum-0.1.0.dar
```{{execute T2}}

To create a few users, posts and comments of the social network run the `initialize` script in the
`forum-0.1.0.dar` package:

```
daml script --dar forum-0.1.0.dar --script-name Init:initialize --ledger-host localhost --ledger-port 6865
```{{execute T2}}

Nice, your social network is running and users are happily posting and commenting in the forum
(look at the `../forum/daml/Init.daml`{{open}} module in the forum source code to see what). In the next
step we'll upgrade the `create-daml-app` package with a new feature.
