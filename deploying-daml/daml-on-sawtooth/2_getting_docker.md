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

When you see this message `INFO[2020-07-27T07:37:35.133160954Z] API listen on /var/run/docker.sock` your docker container has started and you can proceed to the next step.
