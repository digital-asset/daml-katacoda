Finally we can see these components come together in the MainView component. We want to add a new panel to house our messaging UI. Open the `ui/src/components/MainView.tsx`{{open}} file and start by adding imports for the two new components.

<pre class="file" data-target="clipboard">
import MessageEdit from './MessageEdit';
import MessageList from './MessageList';
</pre>

Next, find where the Network Segment closes, towards the end of the component. This is where we’ll add a new Segment for Messages. Make sure you’ve saved the file after copying the code.

<pre class="file" data-target="clipboard">
            <Segment>
              <Header as='h2'>
                <Icon name='pencil square' />
                <Header.Content>
                  Messages
                  <Header.Subheader>Send a message to a follower</Header.Subheader>
                </Header.Content>
              </Header>
              <MessageEdit
                followers={followers.map(follower => follower.username)}
              />
              <Divider />
              <MessageList />
            </Segment>
</pre>

You can see we simply follow the formatting of the previous panels and include the new messaging components: MessageEdit supplied with the usernames of all visible parties as props, and MessageList to display all messages.

That is all for the implementation! Let’s give the new functionality a spin.
