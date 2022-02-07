While Canton supports a daemon mode for production purposes, in this tutorial we will use its console which is a built-in interactive read-evaluate-print loop (REPL). The REPL gives you an out-of-the-box interface to all Canton features. However, as it’s built using [Ammonite](https://ammonite.io/), you also have the full power of Scala if you need to extend it with new scripts.

Navigate your shell to the directory where you extracted Canton. Then, run

```
bin/canton --help
```{{execute T1}}

to see the command line options that Canton supports. Next, run

```
bin/canton -c examples/01-simple-topology/simple-topology.conf
```{{execute T1}}

This starts the console, with the command line parameters specifying that Canton should use the configuration file `examples/01-simple-topology/simple-topology.conf`.

```
   _____            _
  / ____|          | |
 | |     __ _ _ __ | |_ ___  _ __
 | |    / _` | '_ \| __/ _ \| '_ \
 | |___| (_| | | | | || (_) | | | |
  \_____\__,_|_| |_|\__\___/|_| |_|

  Welcome to Canton!
  Type `help` to get started. `exit` to leave.
```

Run ```help```{{execute T1}} to see the available commands in the console.

```
@ help
Top-level Commands
------------------
exit - Leave the console
help - Help with console commands; type help("<command>") for detailed help for <command>

Generic Node References
-----------------------
domainManagers - All domain manager nodes
..
````

You can also get help for specific Canton objects and commands, for example ```help("participant1")```{{execute T1}} or ```participant1.help("start")```{{execute T1}}.

```
@ help("participant1")
participant1
Manage participant 'participant1'; type 'participant1 help' or 'participant1 help("<methodName>")' for more help
@ participant1.help("start")
start
Start the instance
```
