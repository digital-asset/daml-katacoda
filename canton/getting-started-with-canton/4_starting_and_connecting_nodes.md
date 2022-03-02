When using the console, we can run commands on each of the configured (participant or domain) nodes. As such, we can check the health of a node using the respective ```health.status```{{execute T1}} command:

You will see an output like this one:

```
@ health.status
res5: EnterpriseCantonStatus = Status for Domain 'mydomain':
Domain id: mydomain::122090f6f2fc3efc248a6606e7dc0249c9bb24a8ffcdf1083c5e005a8b01d671a5f4
Uptime: 3.478292s
Ports:
    admin: 15023
    public: 15022
Connected Participants: None
Sequencer: SequencerHealthStatus(isActive = true)

Status for Participant 'participant1':
Participant id: PAR::participant1::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5
Uptime: 2.75695s
Ports:
    ledger: 15018
    admin: 15019
Connected domains: None
Unhealthy domains: None
Active: true

Status for Participant 'participant2':
Participant id: PAR::participant2::12209ca4ab4f8d6467df28b5f74276900426f9ef539a1f656c9c1d63804fafd55efa
Uptime: 2.097157s
Ports:
    ledger: 15020
    admin: 15021
Connected domains: None
Unhealthy domains: None
Active: true
```

We can do this also individually on each node. As an example, we can query the status of `participant1`by running the ```participant1.health.status```{{execute T1}} command. You will get an output in the terminal similar to this one:

```
@ participant1.health.status
res6: com.digitalasset.canton.health.admin.data.NodeStatus[com.digitalasset.canton.health.admin.data.ParticipantStatus] = Participant id: PAR::participant1::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5
Uptime: 2.921713s
Ports:
    ledger: 15018
    admin: 15019
Connected domains: None
Unhealthy domains: None
Active: true
or for the domain

@ mydomain.health.status
res7: com.digitalasset.canton.health.admin.data.NodeStatus[com.digitalasset.canton.health.admin.data.DomainStatus] = Domain id: mydomain::122090f6f2fc3efc248a6606e7dc0249c9bb24a8ffcdf1083c5e005a8b01d671a5f4
Uptime: 3.85286s
Ports:
    admin: 15023
    public: 15022
Connected Participants: None
Sequencer: SequencerHealthStatus(isActive = true)
```

Recall that the aliases `mydomain`, `participant1` and `participant2` come from the configuration file. The nodes are obviously up and running. By default, Canton will start and initialize the nodes automatically. This behavior can be overridden using the `--manual-start` command line flag or appropriate configuration settings.

For the moment, ignore the long hexadecimal strings that follow the node aliases; these have to do with Canton’s identities, which we will explain shortly. As you see, the domain doesn’t have any connected participants, and the participants are also not connected to any domains.

Proceed to connect the participants to the domain by running the following command:

```
participant1.domains.connect_local(mydomain)
participant2.domains.connect_local(mydomain)
```{{execute T1}}

Now, check the status again by running ```health.status```{{execute T1}}. You will see an output in the terminal like the one below:

```
@ health.status
res10: EnterpriseCantonStatus = Status for Domain 'mydomain':
Domain id: mydomain::122090f6f2fc3efc248a6606e7dc0249c9bb24a8ffcdf1083c5e005a8b01d671a5f4
Uptime: 6.443618s
Ports:
    admin: 15023
    public: 15022
Connected Participants:
    PAR::participant1::12205f1c1f45...
    PAR::participant2::12209ca4ab4f...
Sequencer: SequencerHealthStatus(isActive = true)

Status for Participant 'participant1':
Participant id: PAR::participant1::12205f1c1f45e8e0a536ab0b7f4c97895b7b28139b940234f8bd8966f70782e65bd5
Uptime: 5.685561s
Ports:
..
```

As you can read from the status, both participants are now connected to the domain. You can test the connection with the following diagnostic command, inspired by the ICMP ping ```participant1.health.ping(participant2)```{{execute T1}}. If everything is set up correctly, this will report the “roundtrip time” between the Ledger APIs of the two participants.

```
@ participant1.health.ping(participant2)
res11: concurrent.duration.Duration = 538 milliseconds
```

On the first attempt, this time will probably be several seconds, as the JVM is warming up. It’ll decrease significantly on the next attempt, and also once again after JVM’s just-in-time compilation really kicked in (though this is by default only after 10000 iterations!).

In fact, you have just executed your first smart contract transaction over Canton. Every participant node also has an associated built-in party that can take part in smart contract interactions. The `ping` command uses a particular smart contract that is by default pre-installed on every Canton participant. In fact, the command uses the Admin API to access a pre-installed application, which then issues Ledger API commands operating on this smart contract.

While you could use in theory the built-in party of your participant for all smart contract interactions of your applications, it’s often useful to have more parties than participants. For example, you might want to run a single participant node within a company, with each employee being a separate party. For this, you need to be able to provision parties.
