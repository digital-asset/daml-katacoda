Let's go back to the wine vendor/client example and think about a distributed ledger you're fairly
familiar with: email.

Let's say `Alice` is a restaurant owner and every morning she goes through a seemingly endless email
inbox. For every payment receipt of a bottle of wine, she needs to open her database and mark the
invoice she received as paid and archived. So she decides to write a small script on her computer
that does the following:

- Every few minutes it checks whether the inbox contains a new email
- If it is a receipt, it queries the database and tries to find a matching invoice. 
- If found, it archives the invoice.

With DAML you don't need to use an external scripting language for the task. You can define `rules`
right away in your code and start such a trigger from the command line.

In the next steps, we model the wine market and see how we can solve `Alice`s inbox problem with
DAML triggers.
