

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

Docker images are then built from these base images using a simple, descriptive set of steps we call instructions. Each instruction creates a new layer in our image. Instructions include actions like:

- Run a command.
- Add a file or directory.
- Create an environment variable.
- What process to run when launching a container from this image.


## Container Management

Managing the lifecycle of a set of containers

### Libswarm

https://gist.github.com/aaronfeng/221f853350ce04976036
https://github.com/docker/libswarm


### Fig

Awesome!
Fast, isolated development environments using Docker.
http://www.fig.sh/
Fig is a vagrant-esque tool for running a set of docker applications and linking them together on localhost.

### Dynamic Reverse Proxy

Using docker-gen, we can generate Nginx config files automatically and reload nginx when they change. The same approach can also be used for docker log management.
http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/

How To Use the Ambassador Pattern to Dynamically Configure Services on CoreOS
https://www.digitalocean.com/community/tutorials/how-to-use-the-ambassador-pattern-to-dynamically-configure-services-on-coreos

Link via an Ambassador Container
http://docs.docker.com/articles/ambassador_pattern_linking/


## Volumes

Advanced Docker Volumes
http://crosbymichael.com/advanced-docker-volumes.html

A bit dated (over a year old) but gives the an interesting example of a
minecraft server container with a VOLUME for its data, a webserver container
with a volume for its static website, and a transformer container that is
run using --volumes-from options for the minecraft and web servers and then
it transforms the minecraft map data into static HTML files that render the
world.  To update the website showing the world, just run the transformer
container, hooking it up to the volumes of each other container.

Here the volume of a container is like a known location that other containers
can read from or write to. 

http://stackoverflow.com/questions/24308760/running-app-inside-docker-as-non-root-user
This SO post points out that a VOLUME is something that is created at run time,
not build time.  Any work that you do in the VOLUME at build time (like
changing permissions/ownership, installing files, etc.) will be discarded when
the volume is mounted at runtme.


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




