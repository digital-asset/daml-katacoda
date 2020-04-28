With DAML scripts you can run a sequence of commands against any DAML ledger. DAML scripts look and
feel almost identical to DAML scenarios. But while scenarios are run against a simulated ledger in
your IDE for quick testing, DAML scripts interact with real ledgers via their external API. With
DAML scripts you can

1. test that your ledger interacts with the outside world as expected
1. test how other components of the stack, such as the UI, react to changes to the ledger
1. initialize a ledger to an initial state

DAML scripts inherit the DAML types and logic of your DAML code. In fact, exactly as scenarios, they
are specified in your DAML source files. This makes them a powerful tool to get tasks as above done
quickly.

In this Katacoda scenario, you'll learn how to write a DAML script to initialize the social network
you built in the [Getting Started Guide](https://daml.com/learn/getting-started). This way, your
social network doesn't start off as a ghost town. 

Once you've developed a feel for DAML script, you're ready to use the DAML REPL and run DAML script
commands interactively against your ledger.

TODO (drsk) : gif of REPL in action here
