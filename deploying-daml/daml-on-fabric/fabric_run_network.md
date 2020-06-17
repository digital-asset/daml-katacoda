Alright time to start up Fabric. The git repo we're cloning has an example configuration for running a few peers and is a great starting point if you decide to do your own deployment. If you go that route the DAML-on-Fabric [README](https://github.com/digital-asset/daml-on-fabric/blob/master/README.md) and [DEPLOYMENT GUIDE](https://github.com/digital-asset/daml-on-fabric/blob/master/DEPLOYMENT_GUIDE.md) are must-reads.

```
cd $HOME
git clone https://github.com/digital-asset/daml-on-fabric.git
cd $HOME/daml-on-fabric/src/test/fixture/
./gen.sh
./restart_fabric.sh
```{{execute T1}}

This process is ready once you see a line similar to `peer0.org2.example.com_1 | 2020-06-16 17:18:36.639 UTC [fsblkstorage] preResetHtFiles -> INFO 01d No active channels passed` in the terminal. It'll start fairly quickly.