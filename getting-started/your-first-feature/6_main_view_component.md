Finally we can see these components come together in the `MainView` component. We want to add a new panel to house our messaging UI. Open the `ui/src/components/MainView.tsx`{{open}} file and start by adding imports for the two new components.

<pre class="file" data-target="clipboard">
import MessageEdit from './MessageEdit';
import MessageList from './MessageList';
</pre>

Next, find where the `Network Segment` closes, towards the end of the component. This is where we’ll add a new `Segment` for `Messages`. Make sure you’ve saved the file after copying the code.

<pre class="file" data-target="clipboard">
            &lt;Segment&gt;
              &lt;Header as='h2'&gt;
                &lt;Icon name='pencil square' /&gt;
                &lt;Header.Content&gt;
                  Messages
                  &lt;Header.Subheader&gt;Send a message to a follower&lt;/Header.Subheader&gt;
                &lt;/Header.Content&gt;
              &lt;/Header&gt;
              &lt;MessageEdit
                followers={followers.map(follower =&gt; follower.username)}
              /&gt;
              &lt;Divider /&gt;
              &lt;MessageList /&gt;
            &lt;/Segment&gt;
</pre>

You can see we simply follow the formatting of the previous panels and include the new messaging components: `MessageEdit` supplied with the usernames of all visible parties as props, and `MessageList` to display all messages.

That is all for the implementation! Let’s give the new functionality a spin.
