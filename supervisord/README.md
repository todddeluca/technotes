

## Supervisord features:

- Command is a foreground process
- Start, stop, restart, and get status of cmd
- Handles logging cmd output and log file rotation
- Event handlers for logging, sending email on events.
- Events include starting, stopping, but not cpu, memory, I think.
- Specify uid and gid with which to run cmd
- Specify working dir in which to run cmd


## Installing supervisord

http://supervisord.org/installing.html

    # Install distribute, a pip dependency
    curl http://python-distribute.org/distribute_setup.py | python2.7
    # install pip in system python
    curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python2.7
    # install supervisord to supervise nginx, gunicorn.
    pip-2.7 install supervisor
    # Create configuration file.  Then edit it.
    echo_supervisord_conf > /etc/supervisord.conf


## Using supervisord with upstart

http://cuppster.com/2011/05/18/using-supervisor-with-upstart/

Upstart is used by Ubuntu, Amazon Linux AMI, Fedora.  See all at
http://upstart.ubuntu.com/.

This page on how to debug upstart scripts might be helpful:
http://askubuntu.com/questions/36200/how-to-debug-upstart-scripts


# Configuring Supervisor

Use `[include]` section to include modular conf files, one per PROGRAM.  Add
this to supervisord.conf:

    [include]
    files = supervisor.d/*.conf

Then create the directory:

    mkdir -p /etc/supervisor.d


# Restarting and reloading supervisor when things change

http://lists.supervisord.org/pipermail/supervisor-users/2010-August/000667.html

The not-so-helpful help from supervisorctl

    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help reread
    reread 			Reload the daemon's configuration files
    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help update
    update		Reload config and add/remove as necessary
    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help restart
    restart <name>		Restart a process
    restart <gname>:*	Restart all processes in a group
    restart <name> <name>	Restart multiple processes or groups
    restart all		Restart all processes
    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help stop
    stop <name>		Stop a process
    stop <gname>:*		Stop all processes in a group
    stop <name> <name>	Stop multiple processes or groups
    stop all		Stop all processes
    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help start
    start <name>		Start a process
    start <gname>:*		Start all processes in a group
    start <name> <name>	Start multiple processes or groups
    start all		Start all processes
    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help reload
    reload 		Restart the remote supervisord.
    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help remove
    remove <name> [...]	Removes process/group from active config
    [ec2-user@ip-10-195-187-248 ~]$ supervisorctl help add
    add <name> [...]	Activates any updates in config for process/group

A helpful mailing list thread I found:
http://comments.gmane.org/gmane.comp.sysutils.supervisor.general/858

> as mentioned, 'update' will only affect programs with an updated config.
> if you needed something more granular to update a single program by name, do:

    supervisorctl reread
    supervisorctl stop <program>
    supervisorctl remove <program>
    supervisorctl add <program>
    supervisorctl start <program> # optional step if autostart=True

What is the code actually doing?  Grep for 'do_reread', etc., in on github.
https://github.com/Supervisor/supervisor/blob/master/supervisor/supervisorctl.py

- 'reread' reloadConfig, i.e. tell supervisord to read the configuration files.
- 'reload': restart supervisord, which I think stops all processes being
  supervised, reloads (rereads?) the configuration file, and restarts the
  processes, but I could not easily tell from the code on github.
- 'update': reloadConfig, stop removed and changed processes, remove removed and changed
  configs, add new and changed configs.
- 'restart <program>': stop program, and start program.  Does not read config files.
- 'shutdown': shutdown the main supervisord process.  I would guess this stops
  all supervised processes.


# Random bits

http://news.ycombinator.com/item?id=1368855
Services are born into a life of sweat and suffering, but some can't stand the beating or the garbage being thrown at them, and they die on you. Hence the question:
What are you using to keep them always up and running?

I've used djb's daemontools some 6 years ago, and it was okay back then, but I wonder what is being used by those setting up their gear now. I've also compiled this quick list of players in this space after some googling and asking around:

- monit http://mmonit.com/monit/
- supervisord http://supervisord.org/
- daemonize http://bmc.github.com/daemonize/
- runit http://smarden.sunsite.dk/runit/
- perp http://b0llix.net/perp/
- launchd http://launchd.macosforge.org/
- DJB's daemontools http://cr.yp.to/daemontools.html

http://dustin.github.com/2010/02/28/running-processes.html
http://www.kalzumeus.com/2010/04/20/building-highly-reliable-websites-for-small-companies/


