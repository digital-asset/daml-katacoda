Let's test our new model with a Daml scenario. First, let's create two users:

<pre class="file" data-filename="daml/User.daml" data-target="append">


test = scenario do
  alice <- getParty "Alice"
  bob <- getParty "Bob"
  submit alice $ create $ User with username=alice
  submit bob $ create $ User with username=bob
</pre>

Now `Alice` can create a `FriendRequest` with her `User` role contract:

<pre class="file" data-filename="daml/User.daml" data-target="append">
  submit alice $ exerciseByKey @User alice $ NewFriendRequest with friend=bob
</pre>

`Bob` accepts it

<pre class="file" data-filename="daml/User.daml" data-target="append">
  submit bob $ exerciseByKey @FriendRequest (alice, bob) Accept
  return ()
</pre>

and you can see in the scenario results that a new `Friendship` has been created between `Alice`
and `Bob`

![friendship](assets/friendship.png)

Because a `Friendship` contract has been established between the two parties, they can now start
sending messages to each other. Replace the last line of the scenario with:

<pre class="file" data-target="clipboard">
  submit bob $ exerciseByKey @Friendship (alice, bob) $ SendMessage2 with content="Hey Alice, long time no see!"
</pre>

Notice, how `Bob` uses the `SendMessage2` choice because he is in the 'friend2' field of the
`Friendship` contract.

You can see in the scenario results that `Alice` indeed receives this message:

![message](assets/message.png)
