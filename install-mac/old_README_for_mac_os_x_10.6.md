
The goal of this project is to document what is installed on my mac, so setting
up a new mac is consistent, repeatable, and easier.

# install mac developer tools

xcode 4.3.2 for lion
download and run Xcode app at http://connect.apple.com
took FOREVER to download, b/c 1.8GB
after installing, brew install git still failed.
try installing just the command line tools.

install command line tools for Xcode - late March 2012
downloaded and ran installer located at
https://developer.apple.com/downloads/index.action
describe somewhat at this page:
http://kennethreitz.com/xcode-gcc-and-homebrew.html

# Configure dirs and PATH vars I commonly use.
Create dirs for installing local frameworks and applications.  Homebrew
sometimes likes to link installed apps and frameworks into these dirs.

    mkdir ~/Applications
    mkdir ~/Frameworks
    mkdir ~/bin 

Add to PATH places that homebrew or other installers put things

    # installer for pip puts executables in share/python
    echo 'export PATH="/usr/local/share/python:$PATH"'
    # location where homebrew links python
    echo 'export PATH="/usr/local/bin:$PATH"'
    # location where pip installer places pip (based on the homebrew python
    # install)
    echo 'export PATH="~/bin:$PATH"'



# install homebrew


https://github.com/mxcl/homebrew/wiki/installation

    /usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
    brew doctor

    # brew doctor tells me to fix my Xcode path.
    # macvim install fails without this.

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

# update homebrew

Do this to get the latest formulas from the homebrew library.

    brew update


# install git
http://git-scm.com/download

    brew install git

# install python

    brew install xz # lmza
    brew install python --framework
    brew link python
    ln -s "/usr/local/Cellar/python/2.7.3/Frameworks/Python.framework" ~/Frameworks


# install macvim and some other bits recommended by https://github.com/skwp/dotfiles

    brew install ack ctags git hub imagemagick macvim
    brew linkapps # link macvim to /Applications/MacVim.app


# install distribute, pip, virtualenv

Install distribute (which pip requires) if you have not already.

    curl http://python-distribute.org/distribute_setup.py | python

Install pip.

    curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python

Install packages

    pip install virtualenv


Install Fabric for deploying to remote hosts

    pip install fabric

Install boto for working with EC2

    pip install boto

Install nose for testing

    pip install nose

# install Spark

I use Spark to map keystrokes to actions.  Specifically to map <ctrl><option>z to my window zooming script, ~/bin/Zoom_Frontmost_Windows_Fullscreen.scpt

http://www.shadowlab.org/softwares/spark.php


# install PCKeyboardHack

This allows me to map the caps lock key to <esc> on Mac OS X.
How to:
http://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x

Download and install PCKeyboardHack
http://pqrs.org/macosx/keyremap4macbook/extra.html
Restart computer.
Go to System Preferences > Keyboard > Modifier Keys and change Caps Lock to 'No Action'
Go to System Preferences > PCKeyboardHack and change Caps Lock to Esc (53)


# start SSH daemon on localhost so Fabric can deploy as if to a remote host.

Start SSH on Mac OS X by enabling 'Remote login'.

    System Preferences > Sharing > Remote login

I hit a few stumbling blocks trying to ssh/sftp into localhost when I first did this.  

- Authentication with a keypair was failing because my permissions were too
  permissive in my home directory.  ~/ perms should be set to 755 or less.
  ~/.ssh perms should be set to 700.  I found out about this by looking at
  /var/log/secure.log.
    
        chmod 755 ~
        chmod 700 ~/.ssh
    
- In my ~/.bashrc I was running some commands  that I only should have been
  running in an interactive shell, like `ssh-add` and `rvm`, b/c they were
  failing when executing in a non-interactive shell.  This happened when
  opening a connection for sftp.


# install a ruby version manager, rbenv.


install rbenv and ruby-build

    brew update
    brew install rbenv
    brew install ruby-build

Change .bashrc to use rbenv.

    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

install ruby into .rbenv/versions, using ruby-build via rbenv.  Cool.

    rbenv install 1.9.3-p194


# DEPRECATED.  Use rbenv. 
install Ruby Version Manager (RVM)

See https://rvm.io for more info.

Install rvm and load it.

    curl -L get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm

Find any requirements and follow the instructions

    rvm requirements

Upgrade rvm if it is already installed.

    rvm get stable
    rvm reload

Install the latest ruby

    rvm install ruby

Set the default rvm to the latest 1.9.3 and use it.

    # e.g. YOUR_RUBY=ruby-1.9.3
    # rvm alias create default YOUR_RUBY
    # rvm use default
    rvm use 1.9.3 --default

Add rvm activation to .bashrc if not already there.

    echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session' >> ~/.bashrc..


# install Markdown renderer from github into the system ruby.

This markdown renderer has some nice extras like fenced code blocks and
autolinks.  It is used by ~/bin/markdown.pl to render my markdown file, e.g via
`<leader>mdp` in vim.

    /usr/bin/gem install redcarpet

# Install mercurial

    brew install hg
    brew install xz


# Install chef on Mac OS X laptop

This installs Chef for Ruby 1.8.7 (on Mac OS X 10.6 on 2012/06/01). Instructions here: http://wiki.opscode.com/display/chef/Installing+Chef+Client+on+OS+X

Dowload and install Chef rubygem:

    cd /tmp
    curl -O http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz
    tar zxf rubygems-1.8.10.tgz
    cd rubygems-1.8.10
    sudo ruby setup.rb --no-format-executable
    sudo gem install chef --no-ri --no-rdoc

Install locations:

    /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/gem
    ...
    Successfully installed chef-0.10.10
    22 gems installed
    $ which knife chef-solo
    /usr/bin/knife
    /usr/bin/chef-solo


# Install GraphViz

Install from source using homebrew:

    brew update
    brew install graphviz

    
# Install IPython and some of its dependencies, Tornado, Pygments, ZeroMQ, pyzmq


Install IPython

    pip install ipython

Create the default config files / dirs in ~/.config/ipython/:

    ipython profile create

Learn more about configuration:

    ipython config -h

IPython Notebook requires the tornado webserver, and zeromq.  Install tornado:

    pip install tornado

Install zeromq:

    brew update
    brew install zeromq
    brew link zeromq # see script to remove existing files below
    pip install pyzmq

Getting these errors trying to `brew link zeromq`.  This happened to me once
trying to install something else and brew dribbles out the files that need
to be removed one at a time.  The errors:

    td23@todd-mac:~$ brew link zeromq
    Linking /usr/local/Cellar/zeromq/2.2.0... 
    Error: Could not symlink file: /usr/local/Cellar/zeromq/2.2.0/include/zmq_utils.h
    Target /usr/local/include/zmq_utils.h already exists. You may need to delete it.

An interactive script to fix the errors.  If `brew link` fails, it gets the
offending file from the output, asks you if you want to delete it and if
you say 'y', it deletes the file and tries `brew link` again.

    python -c "import subprocess, os, re;
    cmd = 'brew link zeromq'.split()
    delete_log = open('delete.log', 'a')
    while True:
        try:
            print 'Running', cmd
            subprocess.check_output(cmd) #, stderr=subprocess.STDOUT)
        except subprocess.CalledProcessError as e:
            print 'Handling exception' 
            print e
            print e.output
            badfile = re.search('Target ([^\s]+) already exists\. You may need to delete it\.', e.output).group(1)
            print badfile
            yn = raw_input('Delete {}? [y/n](default: y):'.format(badfile))
            if not yn or yn == 'y':
                print 'Removing {}'.format(badfile)
                delete_log.write('removing {}\n'.format(badfile))
                os.remove(badfile)
                continue
            else:
                break
        break
    "

These are some of the deleted files. I deleted a lot more than just these
files, but I only started logging them halfway through:

    $ cat delete.log
    removing /usr/local/share/man/man3/zmq_socket.3
    removing /usr/local/share/man/man3/zmq_setsockopt.3
    removing /usr/local/share/man/man3/zmq_send.3
    removing /usr/local/share/man/man3/zmq_recv.3
    removing /usr/local/share/man/man3/zmq_poll.3
    removing /usr/local/share/man/man3/zmq_msg_size.3
    removing /usr/local/share/man/man3/zmq_msg_move.3
    removing /usr/local/share/man/man3/zmq_msg_init_size.3
    removing /usr/local/share/man/man3/zmq_msg_init_data.3
    removing /usr/local/share/man/man3/zmq_msg_init.3
    removing /usr/local/share/man/man3/zmq_msg_data.3
    removing /usr/local/share/man/man3/zmq_msg_copy.3
    removing /usr/local/share/man/man3/zmq_msg_close.3
    removing /usr/local/share/man/man3/zmq_init.3
    removing /usr/local/share/man/man3/zmq_getsockopt.3
    removing /usr/local/share/man/man3/zmq_errno.3
    removing /usr/local/share/man/man3/zmq_device.3
    removing /usr/local/share/man/man3/zmq_connect.3
    removing /usr/local/share/man/man3/zmq_close.3
    removing /usr/local/share/man/man3/zmq_bind.3
    removing /usr/local/lib/pkgconfig/libzmq.pc
    removing /usr/local/lib/libzmq.a
    removing /usr/local/lib/libzmq.1.dylib


Install pygments too, a syntax highlighter used by ipython

    pip install pygments


# Install R, latest version 2.15.0

Download R installer from http://cran.r-project.org/bin/macosx/
Run the installer.



# Install rpy2, python bindings for using R from python code.

    pip install rpy2



# Install numpy, scipy, matplotlib

Instructions from the numpy/scipy website:
http://www.scipy.org/Installing_SciPy/Mac_OS_X

Instructions from someone on the internet who also uses homebrew:
http://www.thisisthegreenroom.com/2011/installing-python-numpy-scipy-matplotlib-and-ipython-on-lion/#numpy

What version of gcc and g++ did I use to compile python2.7 when installed with
homebrew?  4.2?  I think this means I can install numpy using the default
compilers of Mac OS X 10.6, which are gcc 4.2

    grep -e '^CC=\|^CXX=' /usr/local/Cellar/python/2.7.3/Frameworks/Python.framework/Versions/2.7/lib/python2.7/config/Makefile 
    CC=		/usr/bin/gcc-4.2
    CXX=		/usr/bin/g++-4.2

Install numpy:

    pip install numpy

Skipping homebrew installation of gfortran compiler needed by scipy, since
it is already installed.

Install scipy:

    # the pip way does a "develop" install, which is not what I want, I think.
    # The src is downloaded and the then symlinked instead of installed into
    # the python site-packages, I think.
    # pip install -e git+https://github.com/scipy/scipy#egg=scipy-dev

    git clone https://github.com/scipy/scipy.git
    cd scipy
    python setup.py build install

Install matplotlib

    # the pip way does a "develop" install, which is not what I want, I think.
    # The src is downloaded and the then symlinked instead of installed into
    # the python site-packages, I think.
    # pip install -e git+https://github.com/matplotlib/matplotlib#egg=matplotlib-dev

    git clone https://github.com/matplotlib/matplotlib.git
    cd matplotlib
    python setup.py build install


# Install Postgres

    brew install postgresql


# Install Pandas (and Cython dependency)

Pandas is a python project that provides a powerful "dataframe" for numerical
and scientific computing.  For more information see http://pandas.pydata.org/.

Pandas requires cython.  Install cython:

    pip install cython

Install pandas:

    cd
    git clone git://github.com/pydata/pandas.git
    cd pandas
    python setup.py install


# Install psycopg2

Psycopg2 is a bridge between Python and Postgres.  Website:
http://initd.org/psycopg/

Install psycopg2:

    pip install psycopg2


# Install Emacs

Download and install a dmg file from http://emacsformacosx.com/builds.

Add the following to `~/.bashrc`:

    alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'

Consider starting the Emacs Server Daemon when running emacs, by adding to your `~/.emacs` file:

    ;;========================================
    ;; start the emacsserver that listens to emacsclient
    (server-start)

Consider using `emacsclient` as your EDITOR by adding to `~/.bashrc`:

    export EDITOR=ec


# Install Locate

This allows one to run the `locate` command by setting up the index.  It can take a while to run the first time:

    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist



