The `MessageList` component queries all `Message` contracts where the receiver is the current user, and display their contents and senders in a list. The entire component is shown below.

First, we have created a new empty file `MessageList.tsx` in the `ui/src/components` folder.

Copy the below code into the `MessageList.tsx` file by clicking on the `Copy to Editor` button. Make sure to save the file in order for the changes to take effect.

<pre class="file" data-filename="ui/src/components/MessageList.tsx" data-target="append">
import React from 'react'
import { List, ListItem } from 'semantic-ui-react';
import { User } from '@daml.js/create-daml-app';
import { userContext } from './App';

type Props = {
  partyToAlias: Map&lt;string, string&gt;
}
/**
 * React component displaying the list of messages for the current user.
 */
const MessageList: React.FC&lt;Props&gt; = ({partyToAlias}) =&gt; {
  const messagesResult = userContext.useStreamQueries(User.Message);

  return (
    &lt;List relaxed&gt;
      {messagesResult.contracts.map(message =&gt; {
        const {sender, receiver, content} = message.payload;
        return (
          &lt;ListItem
            className='test-select-message-item'
            key={message.contractId}&gt;
            &lt;strong&gt;{partyToAlias.get(sender) ?? sender} &rarr; {partyToAlias.get(receiver) ?? receiver}:&lt;/strong&gt; {content}
          &lt;/ListItem&gt;
        );
      })}
    &lt;/List&gt;
  );
};

export default MessageList;
</pre>

This is how the code works: The `messagesResult` gets the stream of all `Message` contracts where the receiver is our username. The streaming aspect means that we don’t need to reload the page when new messages come in. We extract the payload of every `Message` contract (the data as opposed to metadata like the contract ID) in messages. The rest of the component simply constructs a React List element with an item for each message.

There is one important point about privacy here. No matter how we write our `Message` query in the UI code, it is impossible to break the privacy rules given by the Daml model. That is, it is impossible to see a `Message` contract of which you are not the sender or the receiver (the only parties that can observe the contract). This is a major benefit of writing apps on Daml: the burden of ensuring privacy and authorization is confined to the Daml model.
