Next we need to compile the Daml code, doing this will give us a DAR file which contains our executable code. DAR files are structurally similar to Java's JAR files and you could even unzip them to have a look inside. But don't do that now. We must stay on task!

```
cd $HOME/my-app
daml build
```{{execute T1}}

Okay so now our backend code is compiled but we also want our frontend to be able to interface with it. We could do this all manually but we also [have several codegen](https://docs.daml.com/tools/codegen.html) options available so in this case we'll have our handy `daml` assistant do this for us.

```
daml codegen js .daml/dist/my-app-0.1.0.dar -o ui/daml.js
```{{execute T1}}
