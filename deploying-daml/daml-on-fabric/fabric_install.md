Alright now it's time to install Fabric. This command has to download some large packages so it will take a few minutes. Perhaps take this moment to do a few minutes of meditation or browse the [Q&A section on our forum](https://discuss.daml.com/c/questions/5), either one works.

```
cd $HOME
mkdir fabric
cd fabric
curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.0.0 -s
echo "export PATH=/root/fabric/bin:$PATH" >> $HOME/.bashrc
source $HOME/.bashrc
```{{execute T1}}