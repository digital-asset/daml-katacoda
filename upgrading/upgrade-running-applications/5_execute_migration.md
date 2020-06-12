To allow users to upgrade to the `create-daml-app-0.1.1` and `forum-0.1.1` packages we need to
deploy the the `migration-0.1.0` package. 

We build the migration package as usual with

```
daml build -o migration-0.1.0.dar
```{{execute T2}}

and upload it with

```
daml ledger upload-dar migration-0.1.0.dar
```{{execute T2}}

Finally, it is possible for a user of the sandbox ledger to upgrade his contracts by connecting
with the `daml navigator`, creating a `MigrateUser` contract of the `migration` package and
manually execute the `DoMigrate` choice on his `User` contract. We go through this process in the
next steps.
