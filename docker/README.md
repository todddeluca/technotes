

https://jira.dealer.com/browse/SHARKNADO-2814


## Mac OS X

http://www.alexecollins.com/first-steps-with-docker/

Forward a port from localhost to the boot2docker VirtualBox VM.  For example,
if we expose a container port as the host port 8080, and now we want to expose
that as localhost:8080 on our laptop:

    VBoxManage controlvm boot2docker-vm natpf1 "8080,tcp,127.0.0.1,8080,,8080"


## Understanding Docker

https://docs.docker.com/introduction/understanding-docker/

Concepts:

- Docker image: build.  A read-only template.
- Docker registry: distribute.  public and private stores of images, like Docker Hub.
- Docker container: run.  Containers can be run, started, stopped, moved, and deleted.

Dockerfile

Layer



## Jenkins Integration

https://github.com/groupon/DotCi


## Docker Installation

## Boot2Docker

How to install boot2docker:

    homebrew update
    homebrew boot2docker

To have launchd start boot2docker at login:

    ln -sfv /usr/local/opt/boot2docker/*.plist ~/Library/LaunchAgents

Then to load boot2docker now:

    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.boot2docker.plist

Initialize and run boot2docker:

    boot2docker init
    boot2docker start
    $(boot2docker shellinit)

How to upgrade boot2docker:

    boot2docker stop
    boot2docker download
    boot2docker start

Container port redirection

The latest version of boot2docker sets up a host-only network adaptor which
provides access to the container's ports.  If you run a container with an exposed port, like:

    docker run --rm -i -t -p 80:80 nginx

then you should be able to access that Nginx server using the IP address reported by:

    boot2docker ip

The username for the boot2docker default user is docker and the password is tcuser.




