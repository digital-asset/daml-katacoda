We will run Hyperledger Sawtooth in a [Docker](https://www.docker.com/) container. Let's install the
`docker` daemon and `docker-compose`. When asked, confirm the installation by pressing `Y` in the
first terminal:

```
apt-get install docker docker-compose
```{{execute T1}}

After a succesful installation, we can launch `dockerd` in terminal 1:

```
dockerd
```{{execute T1}}
