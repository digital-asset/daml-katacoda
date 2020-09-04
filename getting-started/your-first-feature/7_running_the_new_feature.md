It's time to run the app with the newly added feature!

In the root create-daml-app folder of terminal 1 run the below command by clicking on it.

```
daml start
```{{execute T1}}

Wait for the above terminal command to fnish (it is done once you see the `INFO  com.daml.http.Main$ - Started server: ServerBinding(/0:0:0:0:0:0:0:0:7575)` line).

Once the above command has finished, run the below command in terminal 2 by clicking on it.

```
yarn start
```{{execute T2}}

which will start the UI. As a reminder, this starts the web UI connected to the running Sandbox and JSON API server. Once the web UI has been compiled and started, you should see `Compiled successfully!` in your terminal. You can now [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com), where you should see the same login page as before

![Login Screen](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-login-screen.png)

Once you’ve logged in, you’ll see a familiar UI but with our new Messages panel at the bottom!

![Messaging Feature](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-messaging-feature.png)

Go ahead and follow some more users. Then, log in as some of those users by [right clikcing on this link and opening a separate tab in your browser](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com) to follow yourself back. Then, if you click on the dropdown menu in the Messages panel, you’ll be able to see some followers to message!

![Select User](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-messaging-select-user.png)

Send some messages between users and make sure you can see each one from the other side. You’ll notice that new messages appear in the UI as soon as they are sent (due to the streaming React hooks).

![Message Received](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-message-received.png)

## You completed the second part of the Getting Started Guide!
[Join our forum](https://discuss.daml.com) and share a screenshot of your accomplishment to [get your second of 3 badges](https://discuss.daml.com/badges/126/hey-look-what-i-can-do)!