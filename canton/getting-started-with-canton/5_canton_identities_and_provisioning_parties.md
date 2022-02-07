In Canton, all identities: of parties, participants, and domains, are represented by a unique identifier. A unique identifier consists of two components: a human-readable string, and the fingerprint of a public key. When displayed in Canton, the components are separated by a double colon. You can see the identifiers of the participants and the domains by running the following in the console:

```
mydomain.id
participant1.id
participant2.id
```{{execute T1}}

You will see an output like this one:

```
@ mydomain.id
res12: com.digitalasset.canton.DomainId = mydomain::122090f6f2fc...
@ participant1.id
res13: ParticipantId = PAR::participant1::12205f1c1f45...
@ participant2.id
res14: ParticipantId = PAR::participant2::12209ca4ab4f...
```

The human-readable strings in these unique identifiers are derived from the local aliases by default, but can be set to any string of your choice. The public key, which is called a **namespace**, is the root of trust for this identifier. This means that in Canton, any action taken in the name of this identity must be either:

- signed by this namespace key, or
- signed by a key that is authorized by the namespace key to speak in the name of this identity, either directly or indirectly (e.g., if `k1` can speak in the name of `k2` and `k2` can speak in the name of `k3`, then `k1` can also speak in the name of `k3`).

In Canton, it’s perfectly possible to have several unique identifiers that share the same namespace - you’ll see examples of that shortly. However, if you look at the identities resulting from your last console commands, you will see that they belong to different namespaces. By default, each Canton node generates a fresh asymmetric key pair (the secret and public keys) for its own namespace when first started. The key is then stored in the storage, and reused later in case the storage is persistent (recall that `simple-topology.conf` uses memory storage, which is not persistent).

You will next create a couple of parties, Alice and Bob. Alice will be hosted at `participant1`, and her identity will use the namespace of `participant1`. Similarly, Bob will use `participant2`. Canton provides a handy macro for this:

```
val alice = participant1.parties.enable("Alice")
val bob = participant2.parties.enable("Bob")
```{{execute T1}}

This creates the new parties in the participants’ respective namespaces. Furthermore, it notifies the domain of the new parties, and allows the participants to submit commands on the behalf of those parties. The domain allows this since, e.g., Alice’s unique identifier uses the same namespace as `participant1` and `participant1` holds the secret key of this namespace. You can check that the parties are now known to `mydomain` by running the following:

```
mydomain.parties.list("Alice")
mydomain.parties.list("Bob")
```{{execute T1}}

You will see an output like this one:

```
@ mydomain.parties.list("Alice")
res17: Seq[ListPartiesResult] = Vector(
  ListPartiesResult(
    party = Alice::12205f1c1f45...,
    participants = Vector(
      ParticipantDomains(
        participant = PAR::participant1::12205f1c1f45...,
        domains = Vector(
          DomainPermission(domain = mydomain::122090f6f2fc..., permission = Submission)
        )
      )
    )
  )
)

@ mydomain.parties.list("Bob")
res18: Seq[ListPartiesResult] = Vector(
  ListPartiesResult(
    party = Bob::12209ca4ab4f...,
    participants = Vector(
      ParticipantDomains(
        participant = PAR::participant2::12209ca4ab4f...,
        domains = Vector(
          DomainPermission(domain = mydomain::122090f6f2fc..., permission = Submission)
        )
      )
    )
  )
)
```
