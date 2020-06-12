You have been working with a permissioned multi-party ledger before. In fact, your looking at one
right now: The unix file system.

Run a

```
id
```{{execute T1}}

and you'll see your current identity on the system:

```
uid=0(root) gid=0(root) groups=0(root)
```

Of course there are other identities as well, for example system daemons. Here is the `sshd` user

```
id sshd
```{{execute T1}}

The unix file system is a file based database. And every file comes with a set of permissions. Run

```
ls -l
```{{execute T1}}

and you'll see the permissions of each file and directory in the `/root` directory:

```
$ ls -l
total 16
drwxrwxr-x 4 packer packer 4096 Jun  9 14:02 create-daml-app
-rw-r--r-- 1 root   root   1126 Jun  9 14:02 create-daml-app.tar.gz
drwxr-xr-x 2 root   root   4096 May 14 15:06 daml-bundled
drwxr-xr-x 2 root   root   4096 Apr 24 14:45 Desktop
```

The first column specifies the file permissions in the letters 

- `r` - **read**
- `w` - **write**
- `x` - **execute**

for the owner, group and other identities on the system. 

Exactly as the UNIX file system, DAML has a concept of identities. In DAML they are called `parties`.

And exactly as the UNIX file permissions, with DAML you set permissions on each contract
corresponding to `read`, `write` and `execute` rights.

In the next step we look at DAMLs equivalent of a UNIX user, the DAML `party`.
