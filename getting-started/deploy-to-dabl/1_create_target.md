[Daml Hub](https://hub.daml.com) is the speediest way of deploying a daml app to production. It is a hosted and scalable environment which supports all your application management needs out of the box.
> If you would like to learn more, you can check out the [Daml Hub Product Knowledge Base](https://hub.daml.com/use-cases)

Preparing your app for deployment does not deviate from building it locally. In brief, you just need to gather all your deployment artifacts in one place and then drop them into a DABL ledger.

First off, let's navigate to the parent folder of your app:

```
cd create-daml-app
```{{execute T1}}

If you check your present working directory with `pwd` you should see `/root/create-daml-app` as the output.

```
pwd
```{{execute T1}}


We'll start by creating a `target` folder which will eventually contain all the artifacts you will use for deployment.

```
mkdir -p target/
```{{execute T1}}

Before we move on to the next step let's list the contents of the parent folder. You should see your new target folder:

```
ls
```{{execute T1}}

`daml  daml.yaml  README.md  target  ui`
