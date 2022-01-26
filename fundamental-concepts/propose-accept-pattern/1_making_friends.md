To showcase the Propose/Accept pattern, we'll take the `User` contract of the `create-daml-app`
social network and change the way users can follow each other to work by proposing and then
accepting **Friend requests** to create a `Friendship` contract.

We start by creating a `User` contract offering two choices to create a friend request, and to
accept one. Click on the IDE tab, wait for it to load and copy paste the new `User` contract to
`daml/User.daml`{{open}}:

<pre class="file" data-filename="daml/User.daml" data-target="append">
module User where

import Daml.Script

template User with
    username: Party
  where
    signatory username

    key username: Party
    maintainer key

    nonconsuming choice NewFriendRequest: ContractId FriendRequest with
        friend: Party
      controller username
      do
        create $ FriendRequest with requester = username, ..

    nonconsuming choice AcceptFriendRequest: ContractId Friendship with
        friendRequest: (Party, Party)
      controller username
      do
        exerciseByKey @FriendRequest friendRequest Accept
</pre>

- Notice that we removed the `Follow` choice and replaced it with two choices implementing the
  Propose/Accept pattern: The `NewFriendRequest` **proposes** to enter a friendship, the
  `AcceptFriendRequest` **accepts** the requests and enters the friendship contract.
- Now all choices have become truly non-consuming, hence our `User` contract implements the **Role
  pattern**. We could also drop the `following` field from the `User` contract, so it doesn't store
  any state anymore.
- The `NewFriendRequest` choice simply creates a `FriendRequest` contract. We use the record punning
  syntax `..`, to automatically assign the `friend` field of the choice argument to the `friend`
  field of the `FriendRequest` contract
- We use [contract keys](https://daml.com/interactive-tutorials/fundamental-concepts/contract-keys) instead of
  contract IDs in the `AcceptFriendRequest` choice to make the code and API simpler.

Let's see how we can implement the `FriendRequest` and `Friendship` contracts to complete the model.
