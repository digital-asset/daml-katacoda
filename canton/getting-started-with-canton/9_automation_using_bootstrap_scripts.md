To avoid having to manually complete routine tasks such as starting nodes or provisioning parties each time Canton is started, a bootstrap script can be configured. Bootstrap scripts are automatically run after Canton has started and can contain any valid Canton Console commands. A bootstrap script is passed via the `--bootstrap` CLI argument when starting Canton. By convention, we use a `.canton` file ending.

For example, the corresponding bootstrap script to connect the participant nodes to the local domain and `ping` `participant1` from `participant2` (see [Starting and Connecting The Nodes](https://www.canton.io/docs/dev/user-manual/tutorials/getting_started.html#connecting-the-nodes)) is:

```
nodes.local start
participant1.domains.connect_local(mydomain)
participant2.domains.connect("mydomain", "http://localhost:5018")
utils.retry_until_true {
    participant2.domains.active("mydomain")
}

participant2.health.ping(participant1)
```

to set it up as a bootstrap script let's first stop Canton by running ```exit```{{execute T1}}.

To run the bootstrap script at Canton startup we can run the following command:

```
bin/canton -c examples/01-simple-topology/simple-topology.conf --bootstrap examples/01-simple-topology/simple-ping.canton
```{{execute T1}}

To check if everything is set up correctly we can run ```health.status```{{execute T1}} which will result in a terminal ouput like this one:

```
res0: CantonStatus = Status for Domain 'mydomain':
Domain id: mydomain::1220d0d7565ff40929d7ac6463bb6a5120299e8ada4c4f9493798687155c0295df9d
Uptime: 41.237788s
Ports:
        public: 5018
        admin: 5019
Connected Participants:
        PAR::participant1::122063af7872c34bb6a1ca2ac91a14f09250c09a704f4c0228379af361a73f7111b6
        PAR::participant2::12208c67ff9f248a557e64df4478a8d985fd5e3e3a0c11773e7e61da698739d4cc5a
Sequencer: Some(SequencerHealthStatus(isActive = true))

Status for Participant 'participant1':
Participant id: PAR::participant1::122063af7872c34bb6a1ca2ac91a14f09250c09a704f4c0228379af361a73f7111b6
Uptime: 34.470268s
Ports:
        ledger: 5011
        admin: 5012
Connected Domains:
        mydomain::1220d0d7565ff40929d7ac6463bb6a5120299e8ada4c4f9493798687155c0295df9d
Active: true

Status for Participant 'participant2':
Participant id: PAR::participant2::12208c67ff9f248a557e64df4478a8d985fd5e3e3a0c11773e7e61da698739d4cc5a
Uptime: 32.034863s
Ports:
        ledger: 5021
        admin: 5022
Connected Domains:
        mydomain::1220d0d7565ff40929d7ac6463bb6a5120299e8ada4c4f9493798687155c0295df9d
Active: true
```

Note how we again use `retry_until_true` to add a manual synchronization point, making sure that `participant2` is registered, before proceeding to ping `participant1`.
