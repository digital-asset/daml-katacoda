Next we need to compile the DAML code to a DAR file:

```
daml build
```{{execute T1}}

Once the DAR file is created you will see this message in terminal: 

```
Created .daml/dist/create-daml-app-0.1.0.dar.
```

> Note: A DAR file is much like a Java JAR file, it's a zip file of all compiled components.