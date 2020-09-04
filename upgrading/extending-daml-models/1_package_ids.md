You've already learned how to extend a DAML model when you added the messaging feature to the mini
social network of the [Getting Started
Guide](https://daml.com/learn/getting-started/your-first-feature).

There's a catch though with extending a DAML model like this. A [DAML
archive](https://docs.daml.com/daml/reference/packages.html) is build with the `daml build` command.
It contains the compiled artefact of your DAML code that will be deployed and run on the ledger.
The package ID of a DAML archive depends on the contents of the compiled DAML code. Changing the
code results in a different package ID. This means that contracts created with the old package will
be different from contracts created with the updated code and if you would just upload the new
package to your ledger and replace the old one, you couldn't execute any choices on contracts
anymore, that have been created with the original code.

While this behaviour presents a challenge to a ledger operator, it is a blessing for your data
integrity. It gives you a guarantee that the read and write rights to your data can not be changed
in hindsight, and stay exactly as you defined it.

Let's verify this.

First, open the IDE and **wait for it to load**. After that open the `/create-daml-app/daml/User.daml`{{open}} file.
This is the familiar `User` module of the Getting Started Guide.

In the terminal build the `create-daml-app` package with

```
daml build
```{{execute T1}}

Now inspect the package ID of the freshly package:

```
daml damlc inspect-dar .daml/dist/create-daml-app-0.1.0.dar
```{{execute T1}}

You will see a lengthy output listing the files and packages contained within your `create-daml-app`
package. In the list of contained packages you see the main package:

```
DAR archive contains the following packages:

create-daml-app-0.1.0-236ffa0c1026e82f9d531126d841cf857c0145c6b07a31e739a97c2f39b6d109 "236ffa0c1026e82f9d531126d841cf857c0145c6b07a31e739a97c2f39b6d109"
daml-prim-a284919a95c4a515cd1efac0d89be302d0e9d61e692a2176128c871ad8067e36 "a284919a95c4a515cd1efac0d89be302d0e9d61e692a2176128c871ad8067e36"
daml-prim-DA-Internal-Erased-76bf0fd12bd945762a01f8fc5bbcdfa4d0ff20f8762af490f8f41d6237c6524f "76bf0fd12bd945762a01f8fc5bbcdfa4d0ff20f8762af490f8f41d6237c6524f"
daml-prim-DA-Internal-PromotedText-d58cf9939847921b2aab78eaa7b427dc4c649d25e6bee3c749ace4c3f52f5c97 "d58cf9939847921b2aab78eaa7b427dc4c649d25e6bee3c749ace4c3f52f5c97"
daml-prim-DA-Types-40f452260bef3f29dede136108fc08a88d5a5250310281067087da6f0baddff7 "40f452260bef3f29dede136108fc08a88d5a5250310281067087da6f0baddff7"
daml-prim-GHC-Prim-e491352788e56ca4603acc411ffe1a49fefd76ed8b163af86cf5ee5f4c38645b "e491352788e56ca4603acc411ffe1a49fefd76ed8b163af86cf5ee5f4c38645b"
...
```

The output might be **different** depending on the SDK version you're running. The string in the
second column is the package ID. In fact, it's a hash of the compiled package contents.

Now in the IDE, we change the `User` template just slightly by adding a new field `nickname` to it.
Replace the `User` data fields with

<pre class="file" data-target="clipboard">
template User with
    username: Party
    following: [Party]
    nickname: Text
  where
</pre>

while keeping everything below `where` the same.

Now we recompile the package and inspect the package again:

```
daml build
daml damlc inspect-dar .daml/dist/create-daml-app-0.1.0.dar
```{{execute T1}}

Notice how the package ID has changed!

```
create-daml-app-0.1.0-2a378474354837985d60ab1249da40a0e1334947d2701c0f0902cf4ef908cdcc "2a378474354837985d60ab1249da40a0e1334947d2701c0f0902cf4ef908cdcc"
daml-prim-a284919a95c4a515cd1efac0d89be302d0e9d61e692a2176128c871ad8067e36 "a284919a95c4a515cd1efac0d89be302d0e9d61e692a2176128c871ad8067e36"
daml-prim-DA-Internal-Erased-76bf0fd12bd945762a01f8fc5bbcdfa4d0ff20f8762af490f8f41d6237c6524f "76bf0fd12bd945762a01f8fc5bbcdfa4d0ff20f8762af490f8f41d6237c6524f"
daml-prim-DA-Internal-PromotedText-d58cf9939847921b2aab78eaa7b427dc4c649d25e6bee3c749ace4c3f52f5c97 "d58cf9939847921b2aab78eaa7b427dc4c649d25e6bee3c749ace4c3f52f5c97"
daml-prim-DA-Types-40f452260bef3f29dede136108fc08a88d5a5250310281067087da6f0baddff7 "40f452260bef3f29dede136108fc08a88d5a5250310281067087da6f0baddff7"
...
```

It's important to understand that your package ID will also change, if there is a change in any of
the packages it depends on. So if you have a package hierarchy like

```
A
├── B
└── C
```

a change in any of the packages `B` or `C` is enough to change the ID of `A`. On the other side, if
you change package `A`, packages `B` and `C` remain the same. For example, both versions of your
`create-daml-app` package depend on the `daml-prim` package. If you look at the outputs above you
see that it's package ID stayed constant.

In the next step you'll learn how to extend your DAML model by creating a new `forum` package
depending on the `create-daml-app` package. This way you don't touch the package ID of your already
deployed packages.

Then, in the second tutorial on upgrading we will change the `create-daml-app` package itself and
you'll learn how to migrate your data on a live system, without violating any data integrity
guarantees.
