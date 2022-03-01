In the previous step you created a new Daml package that extends the Getting Started social network
with a forum. Now it's time to deploy it.

We assume that the social network is already deployed and running. Hence, change directory to
```
cd ../create-daml-app
```{{execute T1}}

and run

```
daml sandbox --dar .daml/dist/create-daml-app-0.1.0.dar
```{{execute}}

Make sure to wait until the sandbox is up and ready and you see

```
Starting Canton sandbox.
Listening at port 6865
Uploading .daml/dist/create-daml-app-0.1.0.dar to localhost:6865
DAR upload succeeded.
Canton sandbox is ready.
```

In the second terminal change directory to the `forum` project.

```
cd daml-projects/forum
```{{execute T2}}

To extend your application with the new data model, simply upload the package:

```
daml ledger upload-dar .daml/dist/forum-0.0.1.dar
```{{execute T2}}

```
Uploading .daml/dist/daml-forum-0.0.1.dar to localhost:6865
DAR upload succeeded.
```

And that's it! Your backend now supports the forum, all that's missing is a nice UI and all users of
the social network can write posts and comments in it.
