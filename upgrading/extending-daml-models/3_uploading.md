In the previous step you created a new DAML package that extends the Getting Started social network
with a forum. Now it's time to deploy it.

We assume that the social network is already deployed and running. Hence, change directory to
```
cd ../create-daml-app
```{{execute T1}}

and run

```
daml sandbox .daml/dist/create-daml-app-0.1.0.dar
```{{execute}}

Make sure to wait until the sandbox is up and ready and you see

```
INFO: Slf4jLogger started
INFO: Listening on localhost:6865 over plain text.
   ____             ____
  / __/__ ____  ___/ / /  ___ __ __
 _\ \/ _ `/ _ \/ _  / _ \/ _ \\ \ /
/___/\_,_/_//_/\_,_/_.__/\___/_\_\

INFO: Initialized sandbox version 1.1.1 with ledger-id = e0e24b63-322c-4d72-8774-8df61bdb4ab7, port = 6865, dar file = List(.daml/dist/create-daml-app-0.1.0.dar), time mode = wall-clock time, ledger = in-memory, auth-service = AuthServiceWildcard$, contract ids seeding = strong

```

In the second terminal change directory to the `forum` project.

```
cd forum
```{{execute T2}}

To extend your ledger with the new data model, simply upload the package:

```
daml ledger upload-dar .daml/dist/forum-0.0.1.dar
```{{execute T2}}

```
Uploading .daml/dist/daml-forum-0.0.1.dar to localhost:6865
DAR upload succeeded.
```

And that's it! Your backend now supports the forum, all that's missing is a nice UI and all users of
the social network can write posts and comments in it.
