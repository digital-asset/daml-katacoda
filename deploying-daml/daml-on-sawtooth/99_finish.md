Congratulations, you deployed your DAML app on the Hyperledger Sawtooth distributed ledger!

For now, your Sawtooth ledger consists only of a single node. If you want to test your application
against a ledger consisting of multiple nodes, please have a look at the Hyperledger Sawtooth
[documentation](https://sawtooth.hyperledger.org/docs/core/releases/latest/sysadmin_guide/pbft_adding_removing_node.html#adding-a-pbft-node-label)
and change the corresponding configuration values in the file
[docker/compose/daml-local.yaml](https://github.com/blockchaintp/daml-on-sawtooth/blob/master/docker/compose/daml-local.yaml).
Then start multiple docker containers running each node.

If you have any questions, insights or suggestions, please come and connect with the DAML Community
on the [DAML forum](https://discuss.daml.com)!
