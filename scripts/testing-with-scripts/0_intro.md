Once you've written a DAML model, you want to be certain that it behaves the way you imagined. DAML
scripts are a good way to unit test your DAML model and make sure it stays correct in further
iterations.

This tutorial will teach you how to

1. write DAML scripts
1. add assertions to your scripts
1. trace through your scripts and output debug information

We'll take the DAML model of the social network of the [Getting Started](https://daml.com/learn/getting-started/)
guide and extend it with tests. After that, we'll be 100% certain that we're not sending any
messages to the wrong person!

A good introduction to testing with DAML scripts is available [here](https://docs.daml.com/daml/intro/11_Testing.html).
