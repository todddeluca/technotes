

# DOCUMENTATION AND TUTORIALS

http://docs.fabfile.org/


# THE FABRIC PARADIGM

Fabric is a tool for running *tasks* on *groups* of *remote hosts via ssh*.

## Command Line Tasks

In Fabric you declare functions as tasks and fabric provides a convenient
command line interface to access the tasks.  Tasks similar to "targets" in
Apache Ant, gnu make, or Ruby Rake or Capistrano.  One important difference is that tasks in
Fabric do not declare dependencies that must be run before they are executed.
If you need to organize your functions as a dependency graph, you should use
another tool.

## Groups of Hosts

As a host-centric tool, Fabric supports running tasks on multiple hosts.
Tasks in fabric are always run on a host or group of hosts.  A lot of the
usefulness of fabric comes from organizing what tasks run on what hosts.  The
hosts for a task can be declared on the command line, in `fabfile.py`, as a
task decorator.  When fabric runs a task, it starts by generating a list of
hosts.  Then it runs the task once for each host in the hosts list.  This makes
it very easy to run a task on many hosts.  Fabric also provides *roles* as a
way of organizing conceptual groups of hosts.

Some examples of logical combinations of roles would be: servers, services, and
deployment environments.  One might want to execute a task that updates
configuration.  If you have two servers, localhost and ec2, two services,
webserver and database, and two deployment environments, dev and prod, you have
8 possible combinations that might vary in how configuration is updated.

## Remote Hosts Via SSH

Fabric is meant to execute tasks on remote hosts.  It can also run tasks on
localhost.  However if you want to run a task on localhost AND remote hosts,
you should run an SSH daemon on localhost so fabric can access localhost *as
if* it were a remote host.

When I first started using fabric, I used it to deploy an application (copying
files, running commands) to a remote machine for production or localhost for
development.  My `deploy` task had lots of if statements in my fabfile.py to
detect when I was deploying to localhost and use `shutil.copy()` and
`fabric.api.local()` instead of `fabric.api.put()` and `fabric.api.run()`. This
was really messy and complicated and only got moreso as my needs grew.  Then I
started an ssh server daemon (sshd) on my localhost (laptop) and voila!
Everything worked the same whether I was deploying to a remote host or
localhost.

## What Fabric Is Not

Fabric does not have good support for
configuration that varies by host or role, e.g. where to deploy code, where
executables are located.  Since roles are simple groups of hosts and tasks
operate on hosts, Fabric does not support tasks that vary by logical
combinations of roles.

Fabric does not implement a dependency graph among targets like make, Rake,
Ant, etc.  If you are used to working with those tools, Fabric can be confusing
at first.


# ALTERNATIVE FABRIC IMPLEMENTATIONS 

Fabric, done better!
http://tav.espians.com/fabric-python-with-cleaner-api-and-parallel-deployment-support.html
http://zcentric.com/2011/03/07/tavs-fabric-fork-quick-start/
One thing I like about this is contexts.  A context is a separate env for each
host or role, so I do not have to fiddle with saying on this host the python
executable is here and on this other host it is here, etc.

I found this via this fabfile: 
https://github.com/tkopczuk/one_second_django_deployment/blob/master/fabfile.py


# FABRIC PRACTICES

In a task, env.host and env.user contain the current user and host.  There is
no env.role equivalent, since roles are just lists of hosts merged to form the
task host list.  Use env.roles if you want to inspect the current roles.

Do not use `fabric.api.env` to store configuration.  You run the risk of
overwriting keys used by fabric, like `env.port`, and you can not vary
configuration by host.


# FABRIC GOTCHAS

Avoid tilde (~) in a call to fabric.api.cd when combined with fabric.api.get().
At least on my Mac OS X 10.6 laptop, tilde did not properly resolve to the home
dir and the sftp layer failed to get the file.  Tilde worked fine in the call
to get(). Here is the code I tried:

    @task
    def test_get_from_localhost():
        '''
        YMMV, but avoid cd() + ~ when doing get().
        '''
        # this works
        get('~/tmp/foo/bar', '~/foodir/argh') 

        # this works
        with cd('tmp'), lcd('~/foodir'):
            get('foo/bar', 'argh')

        # this does not work 
        with cd('~/tmp'), lcd('~/foodir'):
            get('foo/bar', 'argh')


# DEPLOYING TO LOCALHOST

In some projects I use fabric to deploy code to remote hosts and to localost.
Fabric is mainly geared toward interacting with a remote host.  I tend to
deploy to a localhost development environment as well as remote hosts.  The
best way to maintain the fabric world-view is to let it interact with localhost
as if it were a remote host.


## Enable the ssh daemon, sshd, on Mac OS X

How to:
http://osxdaily.com/2011/09/30/remote-login-ssh-server-mac-os-x/

On my mac laptop, here is how I enabled remote logins via ssh:

1. Go to System Preferences
2. Choose Sharing
3. Select Remote login, and optionally specify all users or specific users.


## Use a key-pair to avoid typing your password over and over again.

Generate ~/.ssh/id_dsa and ~/.ssh/id_dsa.pub using `ssh-keygen` or the like.

Add ~/.ssh/id_dsa.pub to ~/.ssh/authorized_keys

    cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

Fix the permissions on your files and dirs.  SSH is finicky about permissions.
In my experience it expects files and dirs to be writable only by you and
readable by either only you (for private keys, etc.) or by anyone (for public
keys, etc.):

    chmod 755 ~
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_dsa
    chmod 644 ~/.ssh/id_dsa.pub
    chmod 600 ~/.ssh/authorized_keys


## Stumbling Blocks

Being able to ssh to localhost had a few stumbling blocks:

- My perms for ~/ were too permissive.  Took a long time to find the log file
  telling me so.  This was causing key file authentication to fail.
- I was running in ~/.bashrc some commands that I only should have been 
  running in an interactive shell, like ssh-add and rvm stuff.  This was 
  causing sftp to fail.
- I was using a tilde (~) in the fabric.api.cd() command I was using to test
  running get() against localhost. 


## Deprecated approach to deploying to localhost

I used to deploy locally by following the advice here:
http://stackoverflow.com/questions/6725244/running-fabric-script-locally
This got smellier when I started rsyncing, since I had to write a local
version and remote version of rsync.  Then when I started using
`fabric.api.get`, I realized that I would have to write a API compatible 
version of `get` and `put` if I wanted to continue down this path. This
approach of putting the local or remote version of each command in env is
contrary to the world-view (aka mental model) in fabric.  By running sshd on
my laptop, I just set my host to localhost and everything just works.


