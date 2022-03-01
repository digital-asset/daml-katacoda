Daml Triggers are provided by the `daml-trigger` package. Like the standard library, we can import
the package by adding it to the dependencies in the `daml.yaml`{{open}} file:

<pre class="file" data-filename="daml.yaml" data-target="append">
- daml-trigger
</pre>

Now we can add the `Daml.Trigger` import to the imports of the `daml/Market.daml`{{open}} module:

<pre class="file" data-target="clipboard">
import Daml.Trigger
</pre>

To implement a trigger, we need to implement a `Trigger` data structure. After compilation triggers
can be referenced and run from the command line. You can find the definition `Trigger` data
structure in the
[documentation](https://docs.daml.com/triggers/trigger-docs.html#type-daml-trigger-trigger-65529):

<pre class="file">
data Trigger s = Trigger
  { initialize : ACS -> s
  , updateState : ACS -> Message -> s -> s
  , rule : Party -> ACS -> Time -> Map CommandId [Command] -> s -> TriggerA ()
  , registeredTemplates : RegisteredTemplates
  , heartbeat : Optional RelTime
  }
</pre>

- The `ACS` data type is the **Active Contract Set**. It contains a list of all currently active
  contract IDs and their template name.
- Your trigger can have local state of type `s`. The `initialize` function lets you initialize the
  state from the current active contract set.
- The `updateState` lets you update the trigger state based on the current active contract set and
  the last received transaction or completion of your command.
- The `rule` function is the heart of your trigger. It defines what commands to emit to the ledger
  given the acting party, the current active contract set, the current time, the commands that are
  still in-flight and the state of your trigger. We'll have a close look at the `rule` field in the next
  step.
- The `registeredTemplates` field defines the templates for which contract changes should trigger a
  a rule.
- The optional `heartbeat` field is an optional time span for which to emit a heartbeat against the
  ledger. This can be useful to keep the connection alive.

Here's `Alice`s `deleteInvoiceTrigger`, we will implement the `deleteInvoiceRule` function in the
next step:

<pre class="file" data-filename="daml/Market.daml" data-target="append">
deleteInvoiceTrigger : Trigger ()
deleteInvoiceTrigger = Trigger
  { initialize = return ()
  , updateState = const ( return () )
  , rule = deleteInvoiceRule
  , registeredTemplates = RegisteredTemplates
      [ registeredTemplate @Invoice
      , registeredTemplate @PaymentConfirmation
      ]
  , heartbeat = None
  }
</pre>

- Alice's trigger doesn't need any state, hence we set it to `()`. We also don't need to update it, so we set `updateState` also to always return `()`.
- In the `registeredTemplates` field we make the trigger monitor changes to contracts of the
  `Invoice` and `PaymentConfirmation` templates.
- This trigger doesn't need a heartbeat, hence we set it to `None`.
