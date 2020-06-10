Now we'll need to install some Fabric dependencies (SBT), using SDKMan for convenience. Typically you also need a [few other dependencies](https://github.com/digital-asset/daml-on-fabric#prerequisites) but we already have those available in this environment.

If you decide to try this out on your computer you can use SDKMan to manage most of Fabric's dependencies.

```
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install sbt 1.2.8
sdk use sbt 1.2.8
```{{execute T1}}