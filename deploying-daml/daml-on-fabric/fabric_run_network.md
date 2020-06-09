Now let's run a local Fabric network that we'll then connect the DAML Runtime to
```
cd $HOME
git clone https://github.com/digital-asset/daml-on-fabric.git
cd $HOME/daml-on-fabric/src/test/fixture/
./gen.sh
./restart_fabric.sh
```{{execute T1}}