It's time to move our users to the newest version of the `create-daml-app` and `forum` packages.
Daml contracts can only be modified as specified by Daml contract choices. Hence, the only way to
migrate a Daml contract `A` to a contract `B` is to create a new contract `X` with a choice taking
`A` as input and creating `B` as output.

Let's create a new project to write such a migration contract:

```
cd ..
daml new migration skeleton
cd migration
rm -rf daml
mkdir daml
``` {{execute T2}}

To write a migration contract, we need to import the two versions of each package in the migration
project. Open the
`../migration/daml.yaml`{{open}} file and change it to

<!-- TODO: automate having the right sdk-version in the snippet-->
<pre class="file" data-target="clipboard">
sdk-version: 1.14.0
name: migration
source: daml
parties:
  - Alice
  - Bob
  - Charlie
version: 0.0.1
dependencies:
  - daml-prim
  - daml-stdlib
  - daml-script
sandbox-options:
  - --wall-clock-time
data-dependencies:
  - ../create-daml-app/create-daml-app-0.1.0.dar
  - ../forum/forum-0.1.0.dar
  - ../create-daml-app/create-daml-app-0.1.1.dar
  - ../forum/forum-0.1.1.dar
build-options:
- '--package'
- 'create-daml-app-0.1.0 with (User as V1.User)'
- '--package'
- 'create-daml-app-0.1.1 with (User as V2.User)'
- '--package'
- 'forum-0.1.0 with (Forum as V1.Forum)'
- '--package'
- 'forum-0.1.1 with (Forum as V2.Forum)'
</pre>

1. The four `dar` packages are imported as `data-dependencies`. `data-dependencies` are independent
   of the SDK version used to compile the package. This is important because you may have compiled
   the 0.1.1 version of the package with a newer SDK or you chose to use the newest compiler to
   build the `migration` package. You can find more information on `data-dependencies`
   [here](https://docs.daml.com/daml/reference/packages.html#id4).
1.  To avoid name clashes, we give the contained modules different names. Under `build-options` we
    rename the contained modules of the two packages and give them a `V1` or `V2` prefix to
    distinguish them. The syntax for renaming imported modules is documented
    [here](https://docs.daml.com/daml/reference/packages.html#id5)

In the next step we'll write the actual migration contract.
