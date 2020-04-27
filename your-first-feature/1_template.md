As mentioned in the ([application architecture](https://docs.daml.com/getting-started/app-architecture.html)) section, the DAML code defines the data and workflow of the application. The workflow aspect refers to the interactions between parties that are permitted by the system. In the context of a messaging feature, these are essentially the authorization and privacy concerns listed above.

For the authorization part, we take the following approach: a user Bob can message another user Alice when Alice starts following Bob back. When Alice starts following Bob back, she gives permission or authority to Bob to send her a message.

To implement this workflow, let’s start by adding the new data for messages. Navigate to the daml/User.daml file and copy the following Message template to the bottom. Indentation is important: it should be at the top level like the original User template.

- First, **open the IDE tab and wait for it to load**
- After that click on this link `daml/User.daml`{{open}} to open the User.daml file
- Finally click on the button "Copy to Editor" to add the code snippet to the end of the User.daml file

<pre class="file" data-filename="daml/User.daml" data-target="append">
<br>
<br>
<br>
template Message with
    sender: Party
    receiver: Party
    content: Text
  where
    signatory sender, receiver
</pre>

This template is very simple: it contains the data for a message and no choices. The interesting part is the signatory clause: both the sender and receiver are signatories on the template. This enforces the fact that creation and archival of Message contracts must be authorized by both parties.

Now we can add messaging into the workflow by adding a new choice to the User template.

- Open `daml/User.daml`{{open}} file
- Copy the below choice by clicking on the "Copy to Clipboard" button
<pre class="file" data-target="clipboard">
        nonconsuming choice SendMessage: ContractId Message with
            sender: Party
            content: Text
        controller sender
        do
            assertMsg "Designated user must follow you back to send a message" (elem sender following)
            create Message with sender, receiver = username, content
</pre>

- Finally paste the code into the User template after the Follow choice. **The indentation for the SendMessage choice must match the one of Follow. Make sure you save the file after copying the code.**

As with the Follow choice, there are a few aspects to note here.

- By convention, the choice returns the ContractId of the resulting Message contract.
- The parameters to the choice are the sender and content of this message; the receiver is the party named on this User contract.
- The controller clause states that it is the sender who can exercise the choice.
- The body of the choice first ensures that the sender is a user that the receiver is following and then creates the Message contract with the receiver being the signatory of the User contract.
- This completes the workflow for messaging in our app. Now let’s integrate this functionality into the UI.
