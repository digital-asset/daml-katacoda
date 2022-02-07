In order to run any kind of node, you need to decide how and if you want to persist the data. You currently have three choices: don’t persist and just use in-memory stores which will be deleted if you restart your node, persist using H2-file based stores, or persist to Postgres databases.

For this purpose, there are three storage mixin configurations (`storage/`) defined. These storage mixins can be used with any of the node configurations. The H2 and in-memory configurations just work out of the box without further configuration. The Postgres based persistence will be explained in a subsequent section, as you first need to initialise the database.

The mixins work by defining a shared variable which can be referenced by any node configuration

```
storage = ${_shared.storage}
storage.config.url = ${?_shared.url-prefix}"participant1"${?_shared.url-suffix}
```

The `storage.config.url` will define the filename for the H2 persistence and the database name for Postgres (participant1 in the above example).

If you ever see the following error: `Could not resolve substitution to a value: ${_shared.storage}`, then you forgot to add the persistence mixin configuration file.

> Note: Please also consult the more detailed section on [persistence configurations](https://docs.daml.com/canton/usermanual/static_conf.html#persistence-config).
