The `FriendRequest` can be created by any party, should be signed by the requesting party and
observed by the potential new friend.

<pre class="file" data-filename="daml/User.daml" data-target="append">


template FriendRequest
  with
    requester: Party
    friend: Party
  where
    signatory requester
    observer friend

    key (requester, friend): (Party, Party)
    maintainer key._1

    nonconsuming choice Accept: ContractId Friendship
      controller friend
      do
        archive self
        create $ Friendship with friend1 = requester, friend2 = friend

    nonconsuming choice CancelFriendRequest: ()
      controller requester
      do
        archive self
</pre>

- The `FriendRequest` has two choices, one to accept and one to cancel a friend request. If the
  `FriendRequest` gets accepted, it is archived and a `Friendship` is created.
- It is sensible to assume, that in our system every `FriendRequest` can be uniquely identified by
  the requesting party and the new friend. Hence, we add a contract key `(requester, friend)`
  maintained by the single signatory.

Once the `FriendRequest` gets accepted via the `Accept` choice a new `Friendship` contract will get
created. Because the `Friendship` contracts gets created in a choice controlled by the `friend` and
is part of a contract signed by the `requester`, the `Friendship` contracts can be created with both
of these parties as signatories. In particular, all choices of the `Friendship` contract have the
authority of both signatories!

<pre class="file" data-filename="daml/User.daml" data-target="append">


template Friendship
  with
    friend1: Party
    friend2: Party
  where
    signatory friend1, friend2
    key (friend1, friend2): (Party, Party)
    maintainer [key._1, key._2]

    nonconsuming choice SendMessage1: ContractId Message
      with
        content: Text
      controller friend1
      do
        create $ Message with sender=friend1, receiver=friend2, ..

    nonconsuming choice SendMessage2: ContractId Message
      with
        content: Text
      controller friend2
      do
        create $ Message with sender=friend2, receiver=friend1, ..

    nonconsuming choice CancelFriendship1: ()
      controller friend1
      do
        archive self

    nonconsuming choice CancelFriendship2: ()
      controller friend2
      do
        archive self
</pre>

- Sadly, sometimes friendships end, so we added choices `CancelFriendship1` and `CancelFriendship2`
  to cancel the friendship. Each can be executed by one of the friends and will simply archive the
  `Friendship` contract.
- Because all choices of the `Friendship` contract are executed with the authority of both friends,
  we can now very simply choices `SendMessage1` and `SendMessage2` to send messages between the two
  friends that are signed by both. Again, each of the two choice can be executed by one of the two
  friends respectively.

Finally, here's the missing `Message` contract:

<pre class="file" data-filename="daml/User.daml" data-target="append">

template Message
  with
    sender: Party
    receiver: Party
    content: Text
  where
    signatory sender, receiver
</pre>
