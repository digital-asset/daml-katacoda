In this tutorial you learned how to write migration contracts to migrate live data of a Daml
application and perform a rollback if necessary.

The central takeaway is that you can migrate Daml contracts by extending your Daml model with a
migration contract. This contract will offer a choice that takes contracts as input argument and
returns the upgraded contract.

This method also guarantees that the signatories of the contracts need to authorize the migration
and all parties observing the contract will be aware of the migration.

In the final tutorial on upgrading Daml applications, we will automate the process of upgrading Daml
contracts by extending the UI of the Getting Started social network with an upgrade option for users
to authorize the migration of their data to the new model.

If you have any questions or problems, don't hesitate to connect with the Daml Community on the
[Daml forum](https://discuss.daml.com).
