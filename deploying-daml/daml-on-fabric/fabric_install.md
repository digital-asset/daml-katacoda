Let's install Fabric. This has to pull down a lot of packages so it will take a few minutes.

```
cd $HOME
mkdir fabric
cd fabric
curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.0.0 -s
echo "export PATH=/root/fabric/bin:$PATH" >> $HOME/.bashrc
source $HOME/.bashrc
```{{execute T1}}