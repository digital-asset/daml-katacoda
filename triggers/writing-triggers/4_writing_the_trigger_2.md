The trigger `rule` is the actual logic of your trigger. You will need to add the following imports
to the header of the `daml/Market.daml`{{open}} module:

<pre class="file" data-target="clipboard">
import DA.Next.Map
import DA.Foldable(forA_)
</pre>

For our rule we will need to check all active `Invoice`s and `PaymentConfirmation`s. We can query
the active contract set with the `query` function that tajes the template name
preceded with a `@` as an argument.

<pre class="file" data-filename="daml/Market.daml" data-target="append">
deleteInvoiceRule : Party -> TriggerA () ()
deleteInvoiceRule party = do
  invoices <- query @Invoice
  confirmations <- query @PaymentConfirmation
</pre>

Now we want to match `PaymentConfirmation`s with their corresponding open `Invoice`s. We store all
`Invoice` contract IDs that are ready for archiving in the `ready` variable. This can be nicely
expressed with `do` notations for lists:

<pre class="file" data-filename="daml/Market.daml" data-target="append">
  let ready = do
              (confirmationCid, PaymentConfirmation{invoice, obligor}) <- confirmations
              (invoiceCid, Invoice{}) <- invoices
              guard $ invoiceCid == invoice
              guard $ party == obligor
              pure confirmationCid

</pre>

For every pair of a `PaymentConfirmation` and an `Invoice` we check that the invoice field of the
`PaymentConfirmation` matches the invoice contract ID. Then we check that the `obligor` is actually
the `party` for which this trigger is run. If all conditions are satisfied we return the contract ID
of the confirmation. This constructs the list of confirmations on which we can exercise the
`ArchiveInvoice` choice.

Finally, we loop over all ready `PaymentConfirmation`s and exercise the `ArchiveInvoice` choice.

<pre class="file" data-filename="daml/Market.daml" data-target="append">
  forA_ ready $ \confirmationCid -> dedupExercise confirmationCid ArchiveInvoice
</pre>

- The loop is performed with `forA_: (Foldable t, Applicative f) => t a -> (a -> f b) -> f ()` of
  `DA.Traversable`. We use the variant of `forA` with a trailing underscore, because we're not
  interested in the return value of the action.
- To exercise the choice we use `dedupExercise` provided by `Daml.Trigger`. `dedupExercise` will
  make sure that we have not already tried to exercise the choice in the same transaction, which
  would result in an error. `Daml.Trigger` also provides the functions `dedupCreate` and
  `dedupExerciseByKey` with the analogous deduplication semantic.
