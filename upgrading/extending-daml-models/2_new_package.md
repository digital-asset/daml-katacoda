In this step, you'll create a new package depending on `create-daml-app` from scratch. We will be
implementing the back-end for a discussion forum. The users will be identified by their user data
from the mini social network of the Getting Started Guide. Thus we don't need to reimplement the
user roles.

In the terminal, change directory to your home directory and create a new empty DAML project:

```
cd ..
daml new forum
cd forum
```{{execute T1}}

The new project is also visible in the Visual Studio Code IDE. The first thing you need to do is to add the `create-daml-app` to the dependencies in the `/forum/daml.yaml`{{open}} file. After, the file will look like this:

<pre class="file" data-target="clipboard">
sdk-version: 1.1.1
name: forum
source: daml
parties:
  - Alice
  - Bob
version: 0.0.1
dependencies:
  - daml-prim
  - daml-stdlib
  - daml-script
  - ../create-daml-app/.daml/dist/create-daml-app-0.1.0.dar
sandbox-options:
  - --wall-clock-time
</pre>

A package is simply added by pointing to file location of its `dar` (**D**AML **ar**chive) archive.
When you build a `dar` package with `daml build` within a project without an additional output
argument, the `dar` will be under the path `.daml/dist/` relativ to your project root.

Remove the two files `daml/Main.daml` and `daml/Setup.daml`. These were added as a starting point,
but we have our own ideas.

```
rm daml/Main.daml
rm daml/Setup.daml
```{{execute T1}}

Now open a new file `/forum/daml/Forum.daml`{{open}}. The data model for the forum consists of two
templates `Post` and `Comment`, where `Post` has a non-consuming choice to add comments. Copy the
following to the file:

<pre class="file" data-filename="/forum/daml/Forum.daml" data-target="append">
module Forum where

import User

template Post with
    user: User
    title: Text
    body: Text
  where
    signatory user.username
    observer user.following

    nonconsuming choice DoComment: ContractId Comment
      with
        commenter: User
        comment: Text
      controller commenter.username
      do
        create Comment with post = self, ..

template Comment with
    commenter: User
    comment: Text
    post: ContractId Post
  where
    signatory commenter.username
    observer commenter.following
</pre>

Notice how we reuse the `User` template imported from the `create-daml-app` package. Thus a forum
post will be linked to a `User` profile of the Getting Started Guide social network.

As usual, you build the package with

```
daml build
```{{execute T1}}

and you'll find the created package under `.daml/dist/forum-0.1.0.dar`.

In the next step we upload the extension package to the local sandbox ledger. After that, the forum
is ready to be used for all social network users!
