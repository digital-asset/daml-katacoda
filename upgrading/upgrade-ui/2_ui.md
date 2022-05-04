The extension we have in mind for the UI of the `create-daml-app` is fairly simple: Whenever a user
tries to log-in for which there is still an active `User` contract of `create-daml-app-0.1.0` on the
ledger, we ask her with a pop-up alert to carry out the upgrade to `0.1.1`. If she agrees, we
execute the `DoMigrateUser` choice on the active `MigrateUser` contract on the ledger. In addition,
we find all of her `Post` and `Comment` contracts of the `forum-0.1.0` package and migrate them with
the appropriate choice of the `MigrateUser` contract.

Open `ui/src/components/MainScreen.tsx`{{open}} and add the imports for the generated
`create-daml-app-0.1.0`, `forum-0.1.0` and `migrate-0.1.0` JavaScript bindings libraries:

<pre class="file" data-target="clipboard">
import * as cdaV0 from '@daml.js/create-daml-app-0.1.0';
import * as forumV0 from '@daml.js/forum-0.1.0';
import {MigrateUser} from '@daml.js/migration-v0-v1/lib/Migrate';
</pre>

Then replace the `createUserMemo` function in `ui/src/components/MainScreen.tsx`{{open}} with the following
implementation that has the necessary UI prompts and ledger queries to perform the update:

<pre class="file" data-target="clipboard">
  const [userContract, setUserContract] = useState&lt;User.User | undefined&gt;(undefined);
  const createUserMemo = useCallback(async () =&gt; {
    try {
      /* check whether the user has already upgraded */
      const v0userContract = await ledger.fetchByKey(cdaV0.User.User, party);
      if (v0userContract !== null) {
        const accept = window.confirm("Would you like to upgrade to version 0.1.1 of create-daml-app?");
        if (accept) {
          /* create the `Migration` contract */
          const migration = await ledger.create(MigrateUser, {username: party});
          /* migrate the `User` contract */
          const r = await ledger.exercise(MigrateUser.DoMigrateUser, migration.contractId, {userCid: v0userContract.contractId});
          setUserContract((await ledger.fetch(User.User, r[0]))!.payload);
          /* find `Post`s of the forum-0.1.0 package */
          const oldPosts = await ledger.query(forumV0.Forum.Post, {user: {username: v0userContract.payload.username}});
          oldPosts.forEach(async oldPost =&gt; {
            /* migrate the post */
            const newPost = await ledger.exercise(MigrateUser.DoMigratePost, migration.contractId, {postCid: oldPost.contractId});
            /* get all `Comment`s for the post of the user */
            const oldComments  = await ledger.query(forumV0.Forum.Comment, {post: oldPost.contractId, commenter: {username: party}});
            oldComments.forEach(async oldComment =&gt; { await
              /* migrate the `Comment` */
              ledger.exercise(MigrateUser.DoMigrateComment, migration.contractId, {commentCid: oldComment.contractId, newPostCid: newPost[0]})
            });
          });
          window.alert("Welcome to create-daml-app 0.1.1.");
          setCreatedUser(true);
        }
      } else {
        let userContract = await ledger.fetchByKey(User.User, party);
        if (userContract === null) {
          const user = {username: party, following: [], email: null};
          userContract = await ledger.create(User.User, user);
        }
        setUserContract(userContract.payload);
        setCreatedUser(true);
      }
    } catch(error) {
      alert(`Unknown error:\n${JSON.stringify(error)}`);
    }
  }, [ledger, party]);
</pre>

1. On login, we issue a query against the ledger to find a `User` contract of the
   `create-daml-app-0.1.0` package.
1. If we find one, we want to upgrade it. We ask the user to upgrade and if she confirms, we carry
   out the migration.
1. First, we create a `MigrateUser` command and exercise the `DoMigrateUser` choice on it.
1. Then we collect all `Post` contracts and linked `Comments` of the user and migrate them as well.
1. If there is no `User` contract of the old `create-daml-app-0.1.0` package, that means that the
   user has already upgraded or has not yet registered and we proceed as usual.

To make things a bit more interesting, we update the
`ui/src/components/MainScreen.tsx`{{open}} component to display the
email address of a user, which we added in
`create-daml-app-0.1.1`. For that, replace the welcome message at the
end of `ui/src/components/MainScreen.tsx`{{open}}:

<pre class="file" data-target="clipboard">
            &lt;Menu.Item position='right'&gt;
              You are logged in as {user.userId} ({userContract?.email ? userContract?.email : "no email"}).
            &lt;/Menu.Item&gt;
</pre>


Finally, because not all users upgrade at the same time, we need to
make sure that we read `Alias` contracts in both the old and the new
version.

Your final `ui/src/components/MainScreen.tsx`{{open}} file should look like this:

```
// Copyright (c) 2022 Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import React, { useCallback, useEffect, useState } from 'react'
import { Image, Menu } from 'semantic-ui-react'
import MainView from './MainView';
import { User } from '@daml.js/create-daml-app';
import { PublicParty } from '../Credentials';
import { userContext } from './App';
import * as cdaV0 from '@daml.js/create-daml-app-0.1.0';
import * as forumV0 from '@daml.js/forum-0.1.0';
import {MigrateUser} from '@daml.js/migration-v0-v1/lib/Migrate';

type Props = {
  onLogout: () => void;
  getPublicParty : () => PublicParty;
}

const toAlias = (userId: string): string =>
  userId.charAt(0).toUpperCase() + userId.slice(1);

/**
 * React component for the main screen of the `App`.
 */
const MainScreen: React.FC<Props> = ({onLogout, getPublicParty}) => {
  const user = userContext.useUser();
  const party = userContext.useParty();
  const {usePublicParty, setup} = getPublicParty();
  const setupMemo = useCallback(setup, [setup]);
  useEffect(setupMemo);
  const publicParty = usePublicParty();

  const ledger = userContext.useLedger();

  const [createdUser, setCreatedUser] = useState(false);
  const [createdAlias, setCreatedAlias] = useState(false);

  const [userContract, setUserContract] = useState<User.User | undefined>(undefined);
  const createUserMemo = useCallback(async () => {
    try {
      /* check whether the user has already upgraded */
      const v0userContract = await ledger.fetchByKey(cdaV0.User.User, party);
      if (v0userContract !== null) {
        const accept = window.confirm("Would you like to upgrade to version 0.1.1 of create-daml-app?");
        if (accept) {
          /* create the `Migration` contract */
          const migration = await ledger.create(MigrateUser, {username: party});
          /* migrate the `User` contract */
          const r = await ledger.exercise(MigrateUser.DoMigrateUser, migration.contractId, {userCid: v0userContract.contractId});
          setUserContract((await ledger.fetch(User.User, r[0]))!.payload);
          /* find `Post`s of the forum-0.1.0 package */
          const oldPosts = await ledger.query(forumV0.Forum.Post, {user: {username: v0userContract.payload.username}});
          oldPosts.forEach(async oldPost => {
            /* migrate the post */
            const newPost = await ledger.exercise(MigrateUser.DoMigratePost, migration.contractId, {postCid: oldPost.contractId});
            /* get all `Comment`s for the post of the user */
            const oldComments  = await ledger.query(forumV0.Forum.Comment, {post: oldPost.contractId, commenter: {username: party}});
            oldComments.forEach(async oldComment => { await
              /* migrate the `Comment` */
              ledger.exercise(MigrateUser.DoMigrateComment, migration.contractId, {commentCid: oldComment.contractId, newPostCid: newPost[0]})
            });
          });
          window.alert("Welcome to create-daml-app 0.1.1.");
          setCreatedUser(true);
        }
      } else {
        let userContract = await ledger.fetchByKey(User.User, party);
        if (userContract === null) {
          const user = {username: party, following: [], email: null};
          userContract = await ledger.create(User.User, user);
        }
        setUserContract(userContract.payload);
        setCreatedUser(true);
      }
    } catch(error) {
      alert(`Unknown error:\n${JSON.stringify(error)}`);
    }
  }, [ledger, party]);

  const createAliasMemo = useCallback(async () => {
    if (publicParty) {
      try {
        let userAlias = await ledger.fetchByKey(User.Alias, {_1: party, _2: publicParty});
        if (userAlias === null) {
           await ledger.create(User.Alias, {username: party, alias: toAlias(user.userId), public: publicParty});
        }
      } catch(error) {
        alert(`Unknown error:\n${JSON.stringify(error)}`);
      }
      setCreatedAlias(true);
    }
  }, [ledger, user, publicParty, party]);

  useEffect(() => {createUserMemo();} , [createUserMemo])
  useEffect(() => {createAliasMemo();} , [createAliasMemo])

  if (!(createdUser && createdAlias)) {
    return <h1>Logging in...</h1>;
  } else {
    return (
      <>
        <Menu icon borderless>
          <Menu.Item>
            <Image
              as='a'
              href='https://www.daml.com/'
              target='_blank'
              src='/daml.svg'
              alt='Daml Logo'
              size='mini'
            />
          </Menu.Item>
          <Menu.Menu position='right' className='test-select-main-menu'>
            <Menu.Item position='right'>
              You are logged in as {user.userId} ({userContract?.email ? userContract?.email : "no email"}).
            </Menu.Item>
            <Menu.Item
              position='right'
              active={false}
              className='test-select-log-out'
              onClick={onLogout}
              icon='log out'
            />
          </Menu.Menu>
        </Menu>
        <MainView />
      </>
    );
  }
};

export default MainScreen;
```
