Now we'll need to install some Fabric dependencies (SBT), using SDKMan for convenience:

```
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install sbt 1.2.8
sdk use sbt 1.2.8
```{{execute T1}}