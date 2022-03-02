Next we need the `MessageEdit` component to compose and send messages to our followers. Again we show the entire component here.

First, we have created a new empty file `MessageEdit.tsx` in the `ui/src/components` folder. Copy the below code into the `MessageEdit.tsx` file by clicking on the `Copy to Editor` button. Make sure to save the file in order for the changes to take effect.
<pre class="file" data-filename="ui/src/components/MessageEdit.tsx" data-target="append">
import React from 'react'
import { Form, Button } from 'semantic-ui-react';
import { Party } from '@daml/types';
import { User } from '@daml.js/create-daml-app';
import { userContext } from './App';

type Props = {
  followers: Party[];
  partyToAlias: Map&lt;string, string&gt;;
}

/**
 * React component to edit a message to send to a follower.
 */
const MessageEdit: React.FC&lt;Props&gt; = ({followers, partyToAlias}) =&gt; {
  const sender = userContext.useParty();
  const [receiver, setReceiver] = React.useState&lt;string | undefined&gt;();
  const [content, setContent] = React.useState("");
  const [isSubmitting, setIsSubmitting] = React.useState(false);
  const ledger = userContext.useLedger();

  const submitMessage = async (event: React.FormEvent) =&gt; {
    try {
      event.preventDefault();
      if (receiver === undefined) {
        return;
      }
      setIsSubmitting(true);
      await ledger.exerciseByKey(User.User.SendMessage, receiver, {sender, content});
      setContent("");
    } catch (error) {
      alert(`Error sending message:\n${JSON.stringify(error)}`);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    &lt;Form onSubmit={submitMessage}&gt;
      &lt;Form.Select
        fluid
        search
        className='test-select-message-receiver'
        placeholder={receiver ? partyToAlias.get(receiver) ?? receiver : "Select a follower"}
        value={receiver}
        options={followers.map(follower =&gt; ({ key: follower, text: partyToAlias.get(follower) ?? follower, value: follower }))}
        onChange={(event, data) =&gt; setReceiver(data.value?.toString())}
      /&gt;
      &lt;Form.Input
        className='test-select-message-content'
        placeholder="Write a message"
        value={content}
        onChange={event =&gt; setContent(event.currentTarget.value)}
      /&gt;
      &lt;Button
        fluid
        className='test-select-message-send-button'
        type="submit"
        disabled={isSubmitting || receiver === undefined || content === ""}
        loading={isSubmitting}
        content="Send"
      /&gt;
    &lt;/Form&gt;
  );
};

export default MessageEdit;
</pre>

You will first notice a `Props` type near the top of the file with a single following field. A prop in React is an input to a component; in this case a list of users from which to select the message receiver. The prop will be passed down from the `MainView` component, reusing the work required to query users from the ledger. You can see this following field bound at the start of the `MessageEdit` component.

We use the React `useState` hook to get and set the current choices of message receiver and content. The Daml-specific `useLedger` hook gives us an object we can use to perform ledger operations. The call to `ledger.exerciseByKey` in `sendMessage` looks up the `User` contract with the receiver’s username and exercises `SendMessage` with the appropriate arguments. The `sendMessage` wrapper reports potential errors to the user, and `submitMessage` additionally uses the `isSubmitting` state to ensure message requests are processed one at a time. The result of a successful call to `submitMessage` is a new `Message` contract created on the ledger.

The return value of this component is the React `Form` element. This contains a dropdown menu to select a receiver from the following, a text field for the message content, and a Send button which triggers `submitMessage`.

There is again an important point here, in this case about how authorization is enforced. Due to the logic of the `SendMessage` choice, it is impossible to send a message to a user who is not following us (even if you could somehow access their `User` contract). The assertion that elem sender following in `SendMessage` ensures this: no mistake or malice by the UI programmer could breach this.
