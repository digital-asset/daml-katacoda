Let's clone the DAML on Sawtooth repository:

```
git clone https://github.com/blockchaintp/daml-on-sawtooth.git
```{{execute T2}}

and set the build identifier environment variable:

```
cd daml-on-sawtooth
export ISOLATION_ID=my-local-build
```{{execute T2}}

You're now ready to build Sawtooth:

```
./bin/build.sh
```{{execute T2}}

Go grab a coffee, this will take some time...
