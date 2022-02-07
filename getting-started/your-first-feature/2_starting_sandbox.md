Next let's run the `daml start` command from the project's root folder.

```
cd create-daml-app
daml start
```{{execute T1}}

As a reminder the commmand will:

- Compile our Daml code into a DAR file containing the new feature
- Update the JavaScript library under ui/daml.js to connect the UI with your Daml code
- Upload the new DAR file to the Daml Sandbox

As mentioned previously, Daml Sandbox uses an in-memory store, which means it loses its state – which here includes all user data and follower relationships – when stopped or restarted.

Now let’s integrate the new functionality into the UI.
