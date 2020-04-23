In the root create-daml-app folder of terminal 1 run

```
daml start
```{{execute T1}}

In terminal 2 run

```
cd ui
yarn start
```{{execute T2}}

which will start the UI. As a reminder, this starts the web UI connected to the running Sandbox and JSON API server. Once the web UI has been compiled and started, you should see `Compiled successfully!` in your terminal. You can now [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com), where you should see the same login page as before

![Login Screen](/nemanja/scenarios/your-first-feature/assets/create-daml-app-login-screen.png)

Once you’ve logged in, you’ll see a familiar UI but with our new Messages panel at the bottom!

![Messaging Feature](/nemanja/scenarios/your-first-feature/assets/create-daml-app-messaging-feature.png)

Go ahead and add follow more users, and log in as some of those users in separate browser windows to follow yourself back. Then, if you click on the dropdown menu in the Messages panel, you’ll be able to see some followers to message!


![Select User](/nemanja/scenarios/your-first-feature/assets/create-daml-app-messaging-select-user.png)

Send some messages between users and make sure you can see each one from the other side. You’ll notice that new messages appear in the UI as soon as they are sent (due to the streaming React hooks).

![Message Received](/nemanja/scenarios/your-first-feature/assets/create-daml-app-message-received.png)
