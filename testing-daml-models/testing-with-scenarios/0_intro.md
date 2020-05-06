Once you've written a DAML model, you want to be certain that it behaves the way you imagined. DAML
scenarios are a good way to unit test your DAML model and make sure it stays correct in further
iterations.

This tutorial will teach you how to

1. write DAML scenarios 
1. add assertions to you scenarios
1. trace through your scenarios and output debug information

We'll take the DAML model of the social network of the [GettingStarted](https://daml.com/learn/getting-started/)
guide and extend it with tests. After that, we'll be 100% certain that we're not sending any
messages to the wrong person!

The full documentation on DAML scenarios is available [here](https://docs.daml.com/daml/testing-scenarios.html).
