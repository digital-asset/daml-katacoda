First thing we'll need to do is get our Daml application. In this case we'll be using an example application that's also used in our getting started guide. It's called `create-daml-app` because, well, you can use it as a base for creating Daml apps. Brilliant!

```
export DAML_SDK_VERSION=1.10.0
daml install --install-assistant=yes 1.10.0
daml create-daml-app my-app
```{{execute T1}}
