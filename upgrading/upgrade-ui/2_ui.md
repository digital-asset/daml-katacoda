The extension we have in mind for the UI of the `create-daml-app` is fairly simple: Whenever a user
tries to log-in for which there is still an active `User` contract of `create-daml-app-0.1.0` on the
ledger, we ask her with a pop-up alert to carry out the upgrade to `0.1.1`. If she agrees, we
execute the `DoMigrateUser` choice on the active `MigrateUser` contract on the ledger. In addition,
we find all of her `Post` and `Comment` contracts of the `forum-0.1.0` package and migrate them with
the appropriate choice of the `MigrateUser` contract.

Open `ui/src/components/LoginScreen.tsx`{{open}} and add the imports for the generated
`create-daml-app-0.1.0`, `forum-0.1.0` and `migrate-0.1.0` JavaScript bindings libraries:

<pre class="file" data-target="clipboard">
import * as cdaV0 from '@daml.js/create-daml-app-0.1.0';
import * as forumV0 from '@daml.js/forum-0.1.0';
import {MigrateUser} from '@daml.js/migration-v0-v1/lib/Migrate';
</pre>

Then replace the `login` function in `ui/src/components/LoginScreen.tsx`{{open}} with the following
implementation that has the necessary UI prompts and ledger queries to perform the update:

<pre class="file" data-target="clipboard">
  const login = useCallback(async (credentials: Credentials) => {
    try {
      const ledger = new Ledger({token: credentials.token, httpBaseUrl, wsBaseUrl});
      /* check whether the user has already upgraded */
      const v0userContract = await ledger.fetchByKey(cdaV0.User.User, credentials.party)
      if (!(v0userContract === null)) {
        const accept = window.confirm("Would you like to upgrade to version 0.1.1 of create-daml-app?")
        if (accept) {
          /* create the `Migration` contract */
          const migration = await ledger.create(MigrateUser, {username: credentials.party})
          /* migrate the `User` contract */
          ledger.exercise(MigrateUser.DoMigrateUser, migration.contractId, {userCid: v0userContract.contractId})
          /* find `Post`s of the forum-0.1.0 package */
          const oldPosts = await ledger.query(forumV0.Forum.Post, {user: {username: v0userContract.payload.username}})
          oldPosts.forEach(async oldPost => {
            /* migrate the post */
            const newPost = await ledger.exercise(MigrateUser.DoMigratePost, migration.contractId, {postCid: oldPost.contractId})
            /* get all `Comment`s for the post of the user */
            const oldComments  = await ledger.query(forumV0.Forum.Comment, {post: oldPost.contractId, commenter: {username: credentials.party}})
            oldComments.forEach(async oldComment => { await
              /* migrate the `Comment` */
              ledger.exercise(MigrateUser.DoMigrateComment, migration.contractId, {commentCid: oldComment.contractId, newPostCid: newPost[0]})
            })
          })
          window.alert("Welcome to create-daml-app 0.1.1. You can now login as usual.")
        }
      }
      else {
        let userContract = await ledger.fetchByKey(User.User, credentials.party);
        if (userContract === null) {
          const user = {username: credentials.party, following: [], nickname: null};
          userContract = await ledger.create(User.User, user);
        }
        onLogin(credentials);
      }
    } catch(error) {
      alert(`Unknown error:\n${JSON.stringify(error)}`);
    }
  }, [onLogin]);

</pre>

1. On login, we issue a query against the ledger to find a `User` contract of the
   `create-daml-app-0.1.0` package.
1. If we find one, we want to upgrade it. We ask the user to upgrade and if she confirms, we carry
   out the migration.
1. First, we create a `MigrateUser` command and exercise the `DoMigrateUser` choice on it.
1. Then we collect all `Post` contracts and linked `Comments` of the user and migrate them as well.
1. If there is no `User` contract of the old `create-daml-app-0.1.0` package, that means that the
   user has already upgraded or has not yet registered and we proceed as usual.

To make things a bit more interesting, we update the `ui/src/components/MainView.tsx`{{open}}
component to welcome the users with their chosen nicknames, which we added in
`create-daml-app-0.1.1`:

<pre class="file" data-filename="ui/src/components/MainView.tsx" data-target="replace">
// Copyright (c) 2020 Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import React, { useMemo } from 'react';
import { Container, Grid, Header, Icon, Segment, Divider } from 'semantic-ui-react';
import { Party } from '@daml/types';
import { User } from '@daml.js/create-daml-app';
import { useParty, useLedger, useStreamFetchByKey, useStreamQuery} from '@daml/react';
import UserList from './UserList';
import PartyListEdit from './PartyListEdit';

// USERS_BEGIN
const MainView: React.FC = () =&gt; {
  const username = useParty();
  const myUserResult = useStreamFetchByKey(User.User, () =&gt; username, [username]);
  const myUser = myUserResult.contract?.payload;

  /* welcome users with their nickname if set */
  const mySalut = myUser?.nickname ? myUser?.nickname : myUser?.username

  const allUsers = useStreamQuery(User.User).contracts;
// USERS_END

  // Sorted list of users that are following the current user
  const followers = useMemo(() =&gt;
    allUsers
    .map(user =&gt; user.payload)
    .filter(user =&gt; user.username !== username)
    .sort((x, y) =&gt; x.username.localeCompare(y.username)),
    [allUsers, username]);

  // FOLLOW_BEGIN
  const ledger = useLedger();

  const follow = async (userToFollow: Party): Promise&lt;boolean&gt; =&gt; {
    try {
      await ledger.exerciseByKey(User.User.Follow, username, {userToFollow});
      return true;
    } catch (error) {
      alert(&quot;Unknown error:\n&quot; + JSON.stringify(error));
      return false;
    }
  }
  // FOLLOW_END


  return (
    &lt;Container&gt;
      &lt;Grid centered columns={2}&gt;
        &lt;Grid.Row stretched&gt;
          &lt;Grid.Column&gt;
            &lt;Header as='h1' size='huge' color='blue' textAlign='center' style={{padding: '1ex 0em 0ex 0em'}}&gt;
                {mySalut ? `Welcome, ${mySalut}!` : 'Loading...'}
            &lt;/Header&gt;

            &lt;Segment&gt;
              &lt;Header as='h2'&gt;
                &lt;Icon name='user' /&gt;
                &lt;Header.Content&gt;
                  {myUser?.username ?? 'Loading...'}
                  &lt;Header.Subheader&gt;Users I'm following&lt;/Header.Subheader&gt;
                &lt;/Header.Content&gt;
              &lt;/Header&gt;
              &lt;Divider /&gt;
              &lt;PartyListEdit
                parties={myUser?.following ?? []}
                onAddParty={follow}
              /&gt;
            &lt;/Segment&gt;
            &lt;Segment&gt;
              &lt;Header as='h2'&gt;
                &lt;Icon name='globe' /&gt;
                &lt;Header.Content&gt;
                  The Network
                  &lt;Header.Subheader&gt;My followers and users they are following&lt;/Header.Subheader&gt;
                &lt;/Header.Content&gt;
              &lt;/Header&gt;
              &lt;Divider /&gt;
              {/* USERLIST_BEGIN */}
              &lt;UserList
                users={followers}
                onFollow={follow}
              /&gt;
              {/* USERLIST_END */}
            &lt;/Segment&gt;
          &lt;/Grid.Column&gt;
        &lt;/Grid.Row&gt;
      &lt;/Grid&gt;
    &lt;/Container&gt;
  );
}

export default MainView;
</pre>
