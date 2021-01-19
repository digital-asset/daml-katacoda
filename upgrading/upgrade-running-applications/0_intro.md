In the [previous tutorial](https://daml.com/learn/upgrading/extending-daml-models) you extended the
social network application of the Getting Started Guide with a new forum feature.

The new `forum` package depends now on the `create-daml-app` package. So what happens if you have
deployed the two packages and decide to change the `create-daml-app` package?

In this tutorial you learn how to write a migration contract to upgrade a deployed package and
migrate contracts that have already been created to the new model. All of this within a strict Daml
model without compromising the integrity of your data!

You can find the documentation on Daml contract upgrades
[here](https://docs.daml.com/upgrade/index.html).

![MigrateCode](assets/migrate_code.png)
