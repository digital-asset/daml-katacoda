[Open the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com) and
try to order some wine for `Alice`. Here is a recording of the workflow:

![trigger_screencast](assets/trigger_screencast.gif)

1. `Alice` logs in and creates a new wine offer for `Bob`.
1. The offer is created and displayed. Both `Alice` and `Bob` can see the offer.
1. `Bob` takes the offer and an invoice is automatically created and is displayed in the `Debits` list.
1. For `Alice` a new `Credit` item is created for the successful sale.
1. `Alice` receives the payment and confirms it by clicking on the `Confirm Payment` button. This
   creates a `PaymentConfirmation` contract.
1. Notice how the `Invoice` disappears immediately for both `Alice` and `Bob`!

The `deleteInvoiceTrigger` that is running for `Bob` noticed the new `PaymentConfirmation` contract
and the matching `Invoice` and the trigger fired. The `ArchiveInvoice` choice was executed and the
`Invoice` disappeared for `Bob` as well as `Alice`.

Try to login as `Alice` again. Then create a new offer and let `Bob` take it. Check that the
`Invoice` disappears as soon as `Alice` confirms the payment! Now shut the trigger down with
`Ctrl-C` in terminal 3 and check that the `Invoice`s continue to be displayed even when `Alice`
confirms the payment.
