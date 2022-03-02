Now that you have made your persistence choice (assuming Postgres here), you could start your participant just by using one of the example files such as `$CONF/nodes/participant1.conf` and start the Canton process using the `Postgres` persistence mixin:

```
$CANTON/bin/canton -c $CONF/storage/postgres.conf -c $CONF/nodes/participant1.conf
```{{execute T2}}

While this would work, we recommend that you rename your node by changing the configuration file appropriately.

> Note: By default, the node will initialise itself automatically using the identity commands [Topology Administration](https://docs.daml.com/canton/user-manual/usermanual/console.html#identity-commands). As a result, the node will create the necessary keys and topology transactions and will initialise itself using the name used in the configuration file. Please consult the [identity management section]((https://docs.daml.com/canton/user-manual/usermanual/identity_management.html#identity-management-user-manual)) for further information.

This was everything necessary to startup your participant node. However, there are a few steps that you want to take care of in order to secure the participant and make it usable.

## Secure the APIs

1. By default, all APIs in Canton are only accessible from localhost. If you want to connect to your node from other machines, you need to bind to `0.0.0.0` instead of localhost. You can do this by setting `address = 0.0.0.0` within the respective API configuration sections.

2. The participant node is managed through the administration API. If you use the console, almost all requests will go through the administration API. We recommend that you setup mutual TLS authentication as described in the [TLS documentation section](https://docs.daml.com/canton/user-manual/usermanual/static_conf.html#tls-configuration).

3. Applications and users will interact with the participant node using the ledger API. We recommend that you secure your API by using TLS. You should also authorize your clients using either [JWT](https://jwt.io/) or TLS client certificates. The TLS configuration is the same as on the administration API.

In the example set, there are a set of additional configuration options which allow you to define various JWT based authorizations checks, enforced by the ledger API server. The settings map exactly to the options documented as part of the [Daml SDK](https://docs.daml.com/tools/sandbox.html#running-with-authentication).

## Configure Applications, Users and Connection

Canton distinguishes static configuration from dynamic configuration. Static configuration are items which are not supposed to change and are therefore captured in the configuration file. An example is to which port to bind to. Dynamic configuration are items such as Daml archives (DARs), domain connections or parties. All such changes are effected through the administration API or the console.

> Note: Please consult the section on the [console commands](https://docs.daml.com/canton/user-manual/usermanual/console.html#canton-console) and [administration APIs](https://docs.daml.com/canton/user-manual/usermanual/administration.html#administration-apis).

If you don’t know how to connect to domains, onboard parties or provision Daml code, please go through [Canton's  getting started guide](https://www.digitalasset.com/developers/interactive-tutorials/canton/getting-started-with-canton).
