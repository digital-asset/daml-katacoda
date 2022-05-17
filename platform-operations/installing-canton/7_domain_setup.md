In order to setup a domain, you need to decide what kind of domain you want to run. We provide integrations for different domain infrastructures. These integrations have different levels of maturity. Your current options are

1. In-Process Postgres based domain (simplest choice)
2. Hyperledger Fabric based domain
3. Secure enclave based domain
4. Ethereum based domain (demo)

This manual will explain you how to setup an in-process based domain using Postgres. All other domains are a set of microservices. However, in any case, you will need to operate the main domain process which is the point of contact where participants connect to for the initial handshake and parameter download. The details of how to set this up for other domains than the in-process based Postgres domain are covered by the individual documentations.

> Note: Please contact us at <a href="mailto:sales@digitalasset.com">sales@digitalasset.com</a> to get access to the Fabric, Ethereum or enclave based integration.

The domain requires independent of the underlying ledger a place to store some governance data (or also the messages in transit in the case of Postgres based domains). The configuration settings for this storage are equivalent to the settings used for the participant node.

In a production environment you might be running the domain on a separate infrastructure and allow external participants to connect to it. In this case we would set up another Postgres installation with a different `user`, but for this tutorial let us set up the underlying domain storage on our already running Postgres database and existing `user`:

```
create database domain1;
grant all privileges on database domain1 to canton;
```{{execute T1}}

Next we set up the environment variables mentioned at the beginning of this guide (in Step 3) for our convenience.

```
cd ./canton-open-source-2.2.0
export CANTON=`pwd`
export CONF="$CANTON/examples/03-advanced-configuration"
```{{execute T3}}

We then set up the environment variables so that we can use the storage mixin:

```
export POSTGRES_USER=canton
export POSTGRES_PASSWORD=supersafe
```{{execute T3}}

Note that, if this would have been a separate Pstgres installation we would need to set up the above environment variables used for accessing the sotrage mixin accordingly, with the right user and password paramteres.

Once this is all done you can start the domain using

```
$CANTON/bin/canton -c $CONF/storage/postgres.conf -c $CONF/nodes/domain1.conf
```{{execute T3}}

We can now connect `participant1`  with `domain1`:

```
participant1.domains.connect("domain1", "http://127.0.0.1:10018")
```{{execute T2}}

You will see a confirmation message like this one after running the command:

```
res0: DomainConnectionConfig = DomainConnectionConfig(
  domain = Domain 'domain1',
  sequencerConnection = GrpcSequencerConnection(
    endpoints = http://127.0.0.1:10018,
    transportSecurity = false,
    customTrustCertificates = None()
  ),
  manualConnect = false,
  domainId = None(),
  priority = 0,
  initialRetryDelay = None(),
  maxRetryDelay = None()
)
```

## Secure the APIs

As with the participant node, all APIs bind by default to localhost. You need to bind to `0.0.0.0` if you want to access the APIs from other machines.

The administration API should be secured using client certificates as described in [TLS documentation section](https://docs.daml.com/canton/user-manual/usermanual/static_conf.html#tls-configuration).

The public API needs to be properly secured using TLS. Please follow the [corresponding instructions](https://docs.daml.com/canton/user-manual/usermanual/static_conf.html#public-api-configuration).
