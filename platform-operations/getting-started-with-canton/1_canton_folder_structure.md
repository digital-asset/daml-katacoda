To start, download our community edition latest release and extract the archive. You can also use the enterprise edition if you have access to it. The extracted archive has the following structure:

```
.
├── bin
├── daml
├── dars
├── demo
├── deployment
├── drivers (enterprise)
├── examples
├── lib
└── ...
```

- `bin`: contains the scripts for running Canton (canton under Unix-like systems and canton.bat under Windows)

- `daml`: contains the source code of some sample smart contracts

- `dars`: contains compiled and packaged code of the above contracts

- `demo`: contains everything needed for running the interactive Canton demo

- `deployment`: contains a few example deployments to cloud or docker

- `examples`: contains sample configuration and script files for the Canton console

- `lib`: contains the Java executables (JARs) for running Canton
