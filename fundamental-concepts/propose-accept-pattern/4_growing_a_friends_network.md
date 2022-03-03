The new Daml model is complete and tested. Now it's time to include the new `FriendRequest` feature
in the UI.

You can find the updated UI in the `ui` directory. Have a look at
`ui/src/components/MainView.tsx`{{open}}. We included 4 new functions to create/cancel
`FriendRequests` and accept/cancel `Friendships`:

![ui_ledger_interactions](assets/ui_ledger_interactions.png)

- We make use of the defined contract keys and only use `exerciesByKey`.
- In `cancelFriendship` we need to make sure we call the right `CancelFriendship` choice for the
  acting user. We can do this by comparing the `username` with the first factor of the `Friendship`
  contract key.

To display the list of friends, received and sent friend requests, we use queries:

![ui_queries](assets/ui_queries.png)

- We use `useStreamQuery` to continuously update the results in the UI.
- We filter the results by comparing the `username` to the returned keys.

To display (outstanding) friend requests, we wrote two new React components
`ui/src/components/FriendRequestList.tsx`{{open}} and
`ui/src/components/OutstandingFriendRequestList.tsx`{{open}}.

These are straight forward components that display the requests and have a button to cancel them.

Now let us compile our Daml model, generate the new JavaScript bindings, and start the Sandbox with

```
cd create-daml-app
daml start
```{{execute T1}}

As a reminder, compiling the Daml model and generating the JavaScript bindings can be done via Daml assistant commands if necessary: the corresponding commands are `daml build` and `daml daml codegen js .daml/dist/create-daml-app-0.1.0.dar -o ui/daml.js` in this example.

Next, let's install the necessary UI dependencies in the second terminal, including the generated JavaScript files with

```
cd create-daml-app/ui
npm install
```{{execute T2}}

Finally, let's start the new UI

```
npm start
```{{execute T2}}
