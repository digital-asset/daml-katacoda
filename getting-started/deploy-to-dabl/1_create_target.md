First off, let's navigate to the parent folder of your app

```
cd create-daml-app
```{{execute T1}}

If we check your present working directory with `pwd` we should see `/root/create-daml-app` as the output.

```
pwd
```{{execute T1}}


We'll start by creating a `target` folder which will eventually contain all the artifacts we will use for deployment.

```
mkdir -p target/
```{{execute T1}}

Before we move on to the next step let's list the contents of the parent folder. You should see your new target folder:

```
ls
```{{execute T1}}

`daml  daml.yaml  README.md  target  ui`
