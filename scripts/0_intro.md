Once you've written a Daml model, you want to be certain that it behaves the way you imagined. Daml
scripts are a good way to unit test your Daml model and make sure it stays correct in future
iterations. Furthermore, Daml script commands can also be run interactively in the REPL, allowing
you to interact with and inspect a Daml ledger from the command line.

This tutorial will teach you how to

1. write Daml scripts
1. add assertions to your scripts
1. trace through your scripts and output debug information
1. run Daml scripts against a ledger
1. start the REPL and interact with a ledger

We'll take the Daml model of the social network of the [Getting Started](https://digitalasset.com/developers/interactive-tutorials/getting-started/)
guide and extend it with tests. After that, we'll be 100% certain that we're not sending any
messages to the wrong person!

A good introduction to testing with Daml scripts is available [here](https://docs.daml.com/daml/intro/11_Testing.html).
