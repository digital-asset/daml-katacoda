Over the next 15-20 minutes we're going to be deploying a fully end-to-end DAML application that runs on top of the Fabric distributed ledger.

More specifically we will be:

1. Setting up our DAML App, in this case a project called `create-daml-app`
1. Building and running a local Fabric ledger with DAML support through the `daml-on-fabric` project
1. Deploying our `create-daml-app` code to our Fabric ledger where it will record its state
1. Running a JSON endpoint that automatically creates every endpoint we need for our DAML application
1. Starting up a React UI that will consume these JSON endpoints with no lower level interaction with DAML or Fabric necessary