It's time to run the app with the newly added feature!

As we're running the build process from scratch for the project, we need to install the project dependencies again. This wouldn't be necessary in case where project dependencies would have been previoulsy installed.

Let's install the dependencies by running the below commands in the second terminal:

```
cd create-daml-app/ui
npm install
```{{execute T2}}

Now we're ready to start the UI by running:

```
npm start
```{{execute T2}}

As a reminder, this starts the web UI connected to the running Daml Sandbox and JSON API server. In case where we would have an already running UI this step wouldn't be necessary.

Once the web UI has been compiled and started, you should see `Compiled successfully!` in your terminal. You can now [open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com), where you should see the same login page as before

![Login Screen](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-login-screen.png)

Once you’ve logged in, you’ll see a familiar UI but with our new Messages panel at the bottom!

![Messaging Feature](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-messaging-feature.png)

Go ahead and follow some more users. Then, log in as some of those users by [right clikcing on this link and opening a separate tab in your browser](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com) to follow yourself back. Then, if you click on the dropdown menu in the Messages panel, you’ll be able to see some followers to message!

![Select User](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-messaging-select-user.png)

Send some messages between users and make sure you can see each one from the other side. You’ll notice that new messages appear in the UI as soon as they are sent (due to the streaming React hooks).

![Message Received](/daml/courses/getting-started/your-first-feature/assets/create-daml-app-message-received.png)
