In the previous step you made the two versions of the `create-daml-app` and `forum` packages
available as imports.  Now we can write the contract to migrate between the two packages.

In the IDE, open a new file `../migration/daml/Migrate.daml`{{open}} and paste the following code.
Read it carefully, the comments will help you understand how this module is working.

<pre class="file" data-filename="../migration/daml/Migrate.daml" data-target="append">

module Migrate where

-- Notice the renamed module names
import qualified V1.User
import qualified V2.User
import qualified V1.Forum
import qualified V2.Forum

-- These are pure functions describing how data of V1 is moved to V2 and back.
upgradeUser : V1.User.User -> V2.User.User
upgradeUser V1.User.User{..} = V2.User.User with email = None, ..

rollbackUser : V2.User.User -> V1.User.User
rollbackUser V2.User.User{..} = V1.User.User with ..

upgradePost : V1.Forum.Post -> V2.Forum.Post
upgradePost V1.Forum.Post{..} = V2.Forum.Post with user = upgradeUser user, ..

rollbackPost : V2.Forum.Post -> V1.Forum.Post
rollbackPost V2.Forum.Post{..} = V1.Forum.Post with user = rollbackUser user, ..

upgradeComment : V1.Forum.Comment -> ContractId V2.Forum.Post -> V2.Forum.Comment
upgradeComment V1.Forum.Comment{..} newPostCid
  = V2.Forum.Comment with commenter = upgradeUser commenter, post = newPostCid, ..

rollbackComment : V2.Forum.Comment -> ContractId V1.Forum.Post -> V1.Forum.Comment
rollbackComment V2.Forum.Comment{..} oldPostCid
  = V1.Forum.Comment with commenter = rollbackUser commenter, post = oldPostCid, ..

-- The actual MigrateUser contract describes what is the procedure and authorization to upgrade
-- existing contracts.
template MigrateUser
  with
    username: Party
  where
    signatory username
    key username: Party
    maintainer key

    -- we want a non-consuming choice such that the we can migrate/rollback more contracts.
    nonconsuming choice DoMigrateUser : ContractId V2.User.User
      with
        -- we choose a contract of V1 ...
        userCid : ContractId V1.User.User
      controller username
      do
        user <- fetch userCid
        archive userCid
        -- ... and upgrade it to V2
        create $ upgradeUser user

    -- this is the same as DoMigrateUser but with V1/V2 flipped.
    nonconsuming choice DoRollbackUser : ContractId V1.User.User
      with
        userCid : ContractId V2.User.User
      controller username
      do
        user <- fetch userCid
        archive userCid
        create $ rollbackUser user

    -- analogous to the previous choices
    nonconsuming choice DoMigratePost : ContractId V2.Forum.Post
      with
        postCid : ContractId V1.Forum.Post
      controller username
      do
        V1.Forum.Post{..} <- fetch postCid
        archive postCid
        create $ V2.Forum.Post with user = upgradeUser user, ..

    nonconsuming choice DoRollbackPost : ContractId V1.Forum.Post
      with
        postCid : ContractId V2.Forum.Post
      controller username
      do
        V2.Forum.Post{..} <- fetch postCid
        archive postCid
        create $ V1.Forum.Post with user = rollbackUser user, ..

    nonconsuming choice DoMigrateComment : ContractId V2.Forum.Comment
      with
        commentCid : ContractId V1.Forum.Comment
        newPostCid : ContractId V2.Forum.Post
      controller username
      do
        comment <- fetch commentCid
        archive commentCid
        create $ upgradeComment comment newPostCid

    nonconsuming choice DoRollbackComment : ContractId V1.Forum.Comment
      with
        commentCid : ContractId V2.Forum.Comment
        oldPostCid : ContractId V1.Forum.Post
      controller username
      do
        comment <- fetch commentCid
        archive commentCid
        create $ rollbackComment comment oldPostCid
</pre>

1. The `MigrateUser` template offers every user of the mini social network of the
   create-daml-app-0.1.0 package to migrate his `User`, `Post` and `Comment` contracts to the
   updated version of the packages.
1. We use qualified imports to avoid name clashes of the two imported modules. Note how we can
   import the two equally named modules of the two packages with the given prefix we added in the
   `../migration/daml.yaml`{{open}} file in the previous step.
1. We use Daml's `..` record punning syntax to avoid boilerplate code in the pure upgrade functions
   like `upgradeUser`. `User{..}` brings all the fields of the `User` template in scope and

   ```
   V2.User with email = None, ..
   ```

   assigns each equally named field of V2.User the field in scope except `email`, which is
   set to `None`.
1. Since the new `email` field is optional, a straight forward migration is just to set it to
   `None` in `upgradeUser`. Another possibility would be to add a choice argument specifying the
   chosen email.
1. The `Comment` contract of the `forum` package contains a reference to `Post` contracts in
   the form of a contract ID in the field `post`. If we upgrade a `Post`, we want to upgrade the
   `Comment`s as well and update the contract ID to the contract ID of the new post. Hence the
   `upgradeComment` function has the contract ID of the new post as the second argument.
1. Notice that the authorization rules of Daml ensure that for example a `User` contract can only
   be migrated by its `user` party, because this party is the signatory of the `User` contract and
   it needs to authorize the archival of the old contract and the creation of the new one.
1. When migrating data, it's generally a good idea to have the possibility to reverse the migration
   and rollback. The `DoRollback` choices are exactly like `DoMigrate` but undo the migration.
   Hence, first doing a `DoMigrate` followed by a `DoRollback` will yield the original contract
   (with a new contract ID).
