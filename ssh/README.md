

## Using SSH to log in to localhost

### Enable the ssh daemon, sshd, on Mac OS X

How to:
http://osxdaily.com/2011/09/30/remote-login-ssh-server-mac-os-x/

On my mac laptop, here is how I enabled remote logins via ssh:

1. Go to System Preferences
2. Choose Sharing
3. Select Remote login, and optionally specify all users or specific users.


### Use a key-pair to avoid typing your password over and over again.

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


## Using SSH Key Pairs for Passwordless Login


## Using SSH Agent to Manage Keys

### Remove host from known hosts in case the host ip has changed.  

Removing a host from known_hosts can be useful when working with VMs and cloud
hosts.  When one recreates a vm, s.t. it has a new IP or is a new computer on
the same IP, ssh balks.  After removing the host, ssh will ask to add it to the
known hosts file instead of failing.

Use `ssk-keygen` to remove a host from known_hosts:

    ssh-keygen -R <hostname>

### Add keys to ssh-agent and mac os x keychain

The `-K` option stores a passphrase in the Mac OS X keychain.  This avoids retyping it everytime the key is added.

    ssh-add -K ~/.ssh/my_own_id_rsa
    passphrase: <hidden> 


### Remove keys from ssh-agent to avoid errors

I had a problem pushing to github, because ssh or git was trying to use the wrong key.  The error message:

> ERROR: Permission to todddeluca/reciprocal_smallest_distance.git denied to LPM.
> fatal: The remote end hung up unexpectedly

The solution was to remove all identities from ssh-agent. Then github got the right keypair (id_dsa):

    $ ssh-add -D
    All identities removed.


## SSH Tunneling

- http://www.popcornfarmer.com/2009/01/ssh-tunneling-tutorial/
- https://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/


## The SSH Config File

The ssh configuration file lives at ~/.ssh/config.  This amazing file is used
to configure ssh on a per-host basis.  Each block of the file specifies a host
and then the ssh options associated with that host.  This way you can configure
which identity file to use with which host and which port to use.  You can skip
using known_hosts to avoid man-in-the-middle attacks, which can be useful when
using hosts that change a lot, like EC2 or Vagrant VMs.   And you can alias a
long hostname to a short one.

Alias a hostname:

    Host o
    Hostname orchestra.med.harvard.edu

Now you can log in to orchestra by typing `ssh o`.

Avoid keys in the ssh-agent or home .ssh directory and use a specific identity
file.  This can be useful if ssh is using the agent to pass an incorrect key
before the correct one.

    Host github.com
    IdentityFile ~/.ssh/id_dsa
    IdentitiesOnly yes

The page
http://nerderati.com/2011/03/simplify-your-life-with-an-ssh-config-file/ has an
example of using ssh to tunnel a local port to a remote one via ssh.  When
would this come in handy?  Imagine you had a client running on localhost that 
wanted to connect to a server on port 6000, but the remote host running the
server did not have that port open for security reasons.  You could use ssh
port forwarding to tunnel the local port 6000 to the remote port 6000.  Then pointing the client to localhost:6000 would make it connect
to remotehost:6000.  Use this config file:

    Host tunnel
    HostName remote.example.com
    IdentityFile ~/.ssh/remote.example.key
    LocalForward 9906 127.0.0.1:3306
    User remoteuser

Then create the tunnel:

    ssh -f -N tunnel


### Syntax

> The configuration file has the following format:
> 
> Empty lines and lines starting with '#' are comments. Otherwise a line is of
> the format ''keyword arguments''. Configuration options may be separated by
> whitespace or optional whitespace and exactly one '='; the latter format is
> useful to avoid the need to quote whitespace when specifying configuration
> options using the ssh, scp, and sftp -o option. Arguments may optionally be
> enclosed in double quotes (") in order to represent arguments containing
> spaces.


### Learn more about ssh config files:

- The Man Pages: http://linux.die.net/man/5/ssh_config
- A good article: http://nerderati.com/2011/03/simplify-your-life-with-an-ssh-config-file/



