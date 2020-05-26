DAML code gets compiled to DAR files. Just like your local development sandbox environment accepts DAML models in the form of DAR files, so does project:DABL.

So let's go ahead and compile the DAML code to a DAR file. We will use the `-o` option to specify the output path and file name.

```
daml build -o target/create-daml-app.dar
```{{execute T1}}

Once the DAR file is created you will see this message in terminal:

```
Created target/create-daml-app.dar
```
