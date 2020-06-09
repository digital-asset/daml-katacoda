Now we'll need to install some Fabric dependencies (Java, Scala, and SBT), using SDKMan for convenience:

```
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java 8.0.252-zulu
sdk use java 8.0.252-zulu

sdk install scala 2.12.7
sdk use scala 2.12.7

sdk install sbt 1.2.8
sdk use sbt 1.2.8
```{{execute T1}}