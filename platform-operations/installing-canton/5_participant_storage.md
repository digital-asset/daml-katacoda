While in-memory and H2 are great for testing and demos, for more serious tasks, we recommend you to use Postgres. For this, make sure that you have a running Postgres server and you need to create one database per node. The recommended Postgres version to use is 11, as this is tested the most thoroughly.

The Postgres storage mixin is provided by the file `storage/postgres.conf`.

If you just want to experiment, you can use Docker to get a Postgres database up and running quickly. Here are a few commands that come in handy.

First, pull Postgres and start it up.

```
docker pull postgres:11
docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 postgres:11
```{{execute T1}}

Then, let’s define a shortcut to invoke `psql`:

```
docker exec -it pg-docker psql -U postgres -d postgres
```{{execute T1}}

This will invoke `psql` interactively. You can exit the prompt with `Ctrl-D`. If you want to just cat commands, change `-it` to `-i` in above command.

Then, create a user for the database using the following SQL command

```
create user canton with encrypted password 'supersafe';
```{{execute T1}}

and create a new database for each node, granting the newly created user appropriate permissions

```
create database participant1;
grant all privileges on database participant1 to canton;
```{{execute T1}}

These commands create a database named `participant1` and grant the user named `canton` access to it using the password `supersafe`. These are the default unsafe settings that the storage mixins use. You can and should use other credentials by either setting them as environment variables (inspect (storage/postgres.conf) for details) or by changing the configuration file directly. If you want to run also other nodes with Postgres, you need to create additional databases, one for each.

In order to use the storage mixin, you need to either write these settings into the configuration file, or pass them using environment variables:

```
export POSTGRES_USER=canton
export POSTGRES_PASSWORD=supersafe
```{{execute T2}}

If you want to run also other nodes with Postgres, you need to create additional databases, one for each.

You can reset the database by dropping then re-creating it:

```
drop database participant1;
create database participant1;
grant all privileges on database participant1 to canton;
```{{execute T1}}

>Note: The storage mixin provides you with an initial configuration. Please consult the [more extended documentation] (https://docs.daml.com/canton/usermanual/static_conf.html#persistence-config) for further options.
