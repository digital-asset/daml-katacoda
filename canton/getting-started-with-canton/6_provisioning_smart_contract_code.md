To create a contract between Alice and Bob, you will first have to provision the contract’s code to both of their hosting participants. Canton supports smart contracts written in Daml. A Daml contract’s code is specified using a Daml **contract template**; an actual contract is then a template instance. Daml templates are packaged into Daml archives, or DARs for short. For this tutorial, use the pre-packaged dars/CantonExamples.dar file. To provision it to both participant1 and participant2, you can use the participants.all console macro:

```
participants.all.dars.upload("dars/CantonExamples.dar")
```{{execute T1}}

You will see an output like this one:

```
@ participants.all.dars.upload("dars/CantonExamples.dar")
res19: Map[com.digitalasset.canton.console.ParticipantReference, String] = Map(
  Participant 'participant1' -> "122005de2cec7642d2bfa682a04fbb447ff11161930cd5e5760739dcbb92ab59f93e",
  Participant 'participant2' -> "122005de2cec7642d2bfa682a04fbb447ff11161930cd5e5760739dcbb92ab59f93e"
)
```

The bulk operator allows to run some commands on a series of nodes. Canton supports the bulk operators on the generic nodes, for example ```nodes.local```{{execute T1}} resulting in

```
@ nodes.local
res20: Seq[com.digitalasset.canton.console.LocalInstanceReference] = ArraySeq(Participant 'participant1', Participant 'participant2', Domain 'mydomain')
```

or on the specific node type, for example ```participants.all```{{execute T1}} resulting in

```
@ participants.all
res21: Seq[com.digitalasset.canton.console.ParticipantReference] = List(Participant 'participant1', Participant 'participant2')
```

Allowed suffixes are `.local`, `.all` or `.remote`, where the remote refers to remote nodes, which we won’t use here.

To validate that the DAR has been uploaded, run:

```
participant1.dars.list()
participant2.dars.list()
```{{execute T1}}

You will see an output like this one:

```
@ participant1.dars.list()
res22: Seq[com.digitalasset.canton.participant.admin.v0.DarDescription] = Vector(
  DarDescription(
    hash = "1220c5a4ac582223dcf2a59d323e474b3411df96f39cfa1304e2739ab7ca97f3b6b8",
    name = "AdminWorkflows"
  ),
  DarDescription(
    hash = "122005de2cec7642d2bfa682a04fbb447ff11161930cd5e5760739dcbb92ab59f93e",
    name = "CantonExamples"
  )
)

@ participant2.dars.list()
res23: Seq[com.digitalasset.canton.participant.admin.v0.DarDescription] = Vector(
  DarDescription(
    hash = "1220c5a4ac582223dcf2a59d323e474b3411df96f39cfa1304e2739ab7ca97f3b6b8",
    name = "AdminWorkflows"
  ),
  DarDescription(
    hash = "122005de2cec7642d2bfa682a04fbb447ff11161930cd5e5760739dcbb92ab59f93e",
    name = "CantonExamples"
  )
)
```

One important observation is that you can not list the uploaded DARs on the domain `mydomain`. You will simply get an error if you run `mydomain.dars.list()`. This is due the fact that the domain does not know anything about Daml or smart contracts. All the contract code is only executed by the involved participants on a need to know basis and needs to be explicitly enabled by them.

Now you are finally ready to actually start running smart contracts using Canton.
