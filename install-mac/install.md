
The goal of this project is to document what is installed on my mac, so setting
up a new mac is consistent, repeatable, and easier.

## Automated installation

There are a (growing) number of resources for automating the setup of a Mac OS X developer machine.

- "Automating the Setup of My Perfect Developer Environment on OSX 10.8 Mountain Lion" http://vanderveer.be/blog/2013/01/02/automating-the-setup-of-my-perfect-developer-environment-on-osx-10-dot-8-mountain-lion/
- Mac Development Ansible Playbook: https://github.com/geerlingguy/mac-dev-playbook
- Battleschool: http://spencer.gibb.us/blog/2014/02/03/introducing-battleschool/
- Boxen, how github maintains their laptops.
- http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac?utm_source=hackernewsletter&utm_medium=email&utm_term=fav

## Install Seil (formerly PCKeyboardHack)

This allows me to map the caps lock key to <esc> on Mac OS X.  For using vim,
doing so is an ergonomic blessing.

Download and  and install Seil (formerly PCKeyboardHack).
https://pqrs.org/osx/karabiner/seil.html
Open the .dmg file and run the installer.

Map the Caps Lock key to Escape:

    Go to System Preferences > Keyboard > Modifier Keys and change Caps Lock to 'No Action'
    Open Seil
    Choose "Change Caps Key" to Keycode 53 (Esc key)


## Install Dropbox and Google Drive

It can take a while for Dropbox to sync completely, so start this step early.

Dropbox gives access to my notes, including this file, and secrets.

Maybe I'll use Google Drive someday.

Link proj and work dirs into home:

    ln -s ~/Dropbox/work ~
    ln -s ~/Dropbox/proj ~
    ln -s ~/Dropbox/technotes ~


## Install Xcode or Command Line Developer Tools

The command line tools are needed to install homebrew, compile code, and I'm not sure what else.

Xcode is required to install macvim with brew.

Install "Xcode" and "Command Line Tools" from the App Store.


## Create Dirs in Home Dir

Create dirs for installing local frameworks and applications.  Homebrew
sometimes links installed apps and frameworks into these dirs.

    mkdir -p ~/Applications ~/Frameworks ~/bin

Some other dirs used by scripts like `~/bin/backup`, etc:

    mkdir -p ~/tmp ~/data ~/deploy


## Install and Update Homebrew and Cask

Homebrew is used to install and update many applications/programs on the mac,
particularly command line ones and developer ones.

Cask is an extension of homebrew for installing binary packages.

Install homebrew if it is not yet installed.  See https://brew.sh/

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


Run the brew doctor to see what is broken with your system and installation.

    brew doctor

Before running `brew install <formula>`, you should update homebrew to get the
latest formulas from the homebrew library:

    brew update

Tap some kegs we use to get various homebrew formulae.

    # For gcc-4.2, needed to install ruby versions < 1.9.3
    brew tap homebrew/dupes
    # For older versions of grails and scala 2.10
    brew tap homebrew/versions
    # For R, kalign, blast, paml
    brew tap homebrew/science

Install Cask:

    brew install caskroom/cask/brew-cask


## Homebrew Installs

Some recommendations come from https://github.com/skwp/dotfiles.

    brew update

    # install Google Chrome
    brew cask install google-chrome

    # ctags is a program that generates an index (or tag) file of names found in source and header files of various programming languages
    brew install ctags

    # install python (and pip and distribute):
    brew install python
    brew install python3

    # install a recent ruby version
    brew install ruby
    # From the ruby install caveats, add the default gem bin dir to .bashrc
    # PATH="$PATH:/usr/local/Cellar/ruby/1.9.3-p362/bin"

    # Install MacVim after ruby and python so it uses the brew installs for them.
    # also overriding the existing (older) system vim.
    brew install cscope # recommended by `brew info macvim`
    brew install macvim --override-system-vim

    # get a recent version of git
    brew install git
    # make less friendlier for non-text input files
    brew install lesspipe
    # XZ Utils is free general-purpose data compression software.
    # XZ Utils are the successor to LZMA Utils.
    brew install xz
    # Graphviz is open source graph visualization software.  Used by my gpdm workflow visualization project.
    # As of 2013/07/28 the brew install failed on my 2013 Macbook Air 10.8.4
    brew install graphviz

    # install zeromq, which IPython Notebook uses.
    brew install zeromq

    # install node.js and grunt for reveal.js markdown slideshow app
    brew install node

    # install maven and gradle for java development and deployment
    brew install gradle
    brew install maven

    # install some languages used at DDC
    brew install scala210
    brew install groovy

    # install local instance of hadoop for testing cascading workflows
    brew install hadoop
    # install apache spark for running and testing spark jobs on localhost
    brew install apache-spark

    brew install jq # Like awk/sed/grep for json.
    brew install jsawk # awk for json.  Use by some ddc scripts.

    # Virtual box used for vagrant and boot2docker
    brew cask install virtualbox
    # vagrant used for python-vagrant testing
    brew cask install vagrant
    # docker and boot2docker
    brew install docker
    brew install boot2docker

    # Install SourceTree, a nice git repository browser
    brew cask install sourcetree

    # Install X11/XQuartz
    # R, Python, IPython, among other programs, depends on X11, but it does not ship with OS X 10.8 Mountain Lion.
    brew cask info xquartz
    # Install R (requires XQuartz)
    brew install r
    # Install RStudio:
    brew cask install rstudio

    brew linkapps


### Brew installs to add as needed

    # ack is a tool like grep, optimized for programmers
    brew install ack
    # interact with github from the command line.
    brew install hub
    # use imagemagick to create, edit, compose, or convert bitmap images
    brew install imagemagick

    # install rbenv and ruby-build
    brew install rbenv
    brew install ruby-build

    # Mercurial (distributed version control) is useful for contributing to python, etc.  Depends on docutils.
    pip-2.7 install docutils
    brew install hg

    # Postgres database.  Used by autworks.
    brew install postgresql

    # install NCBI BLAST, PAML and Kalign, which are used by RSD
    # requires the tapping homebrew/science
    brew install blast
    brew install paml
    brew install kalign

    brew install scala
    brew install mysql

Install gcc-4.2 in case you need to install an older (`< 1.9.3`) version of
ruby.  As of Mountain Lion, OS X does not ship with gcc-4.2.  This requires
tapping the dupes homebrew formula repository:

    brew install apple-gcc42
    # Get gcc and gfortran (for scientific computing)
    # fortran is useful for scientific computing.
    brew install gcc


## Install Go Lang

    brew install go
    mkdir $HOME/go

## Node NPM Installs

    # Reveal.js markdown slideshow app depends on Grunt CLI (and node.js)
    npm install -g grunt-cli
    npm install git+https://github.com/parmentf/xml2json.git
    npm install --global xml2json  // converts xml to json.  Great with jq.

## Install Dotfiles

This depends on python3, which is installed by homebrew.  The ~/.vim/install.py
script requires python3.  It also depends on Dropbox being synchronized,
especially the ~/Dropbox/proj/dotfiles and ~/Dropbox/secrets.dmg.

Install dotfiles, bin dir, vim bundles, and secrets:

    cd ~/Dropbox/proj/dotfiles
    ./install.sh copy
    ./install.sh secrets
    source ~/.bash_profile


## Install Postman Chrome App

It can be used to interact with REST APIs more easily.

In Chrome, go to chrome://apps/, choose "Store", search for "Postman" and install the Postman - Rest Client by rickreation.


## Install Adobe Reader

This is so I can read and sign adobe forms.


## Install Julia

Download and install it from http://julialang.org/downloads/.


## Configure OS X

### System Preferences

Allow clicking to a specific place in the scrollbar instead of having to drag the scrollbar there:

    General > "Click in the scrollbar to:", select "Jump to the spot that's clicked".

Enable more keyboard accessability to UI controls:

    Go to System Preferences > Keyboard > Shortcuts
    Under 'Full Keyboard Access' choose 'All controls'.

Configure Dock:

    System Preferences > Dock.
    Make the Size small.
    Position on screen: Left.
    Select "Automatically hide and show Dock".

Configure clock:

    System Preferences > Date & Time > Clock.  Check Use a 24-hour clock.

Use a picture folder for the desktop background and screen saver:

    Go to System Preferences > Desktop & Screen Saver > Desktop
    Click '+' to add a new folder.
    Choose ~/Pictures/John_Joseph_DeLuca
    Select "Change picture" "Every 5 minutes"
    Go to ... > Screen Saver
    Choose 'Shifting Tiles' and Source, choose ~/Pictures/John_Joseph_DeLuca

Enable Text-to-Speech for reading articles, etc.:

    Go to System Preferences > Dictation & Speech > Text to Speech
    Click "Speak selected text when the key is pressed".
    Now when you press "Option+Esc" the selected text will be spoken

The default computer name was something like 'HMS MacBook Laptop'.  I prefer something with my name in it and without spaces.
Change the Computer Name:

    System Preferences > Sharing > Computer Name.  Enter whatever name you want.

For my work laptop I used 'ToddWorkMac'.

Change Application Installation Security Setting to allow applications downloaded from anywhere, not just Apple-blessed apps:

    System Preferences > Security & Privacy > General > Allow applications downloaded from: Anywhere.

Arrange the relationship between the external display and the laptop screen:

    System Preferences > Displays > Arrangement.  
    Place laptop screen below the external monitor.  
    Move the menu bar the the external display.

Start SSH daemon on localhost so Fabric can deploy as if to a remote host.

Start SSH on Mac OS X by enabling 'Remote Login'.

    System Preferences > Sharing > Remote Login

I hit a few stumbling blocks trying to ssh/sftp into localhost when I first did
this.  

- Authentication with a keypair was failing because my permissions were too
  permissive in my home directory.  ~/ perms should be set to 755 or less.
  ~/.ssh perms should be set to 700.  I found out about this by looking at
  /var/log/secure.log.  The following restricted permissions seem to work for
  me:

        chmod 755 ~
        chmod 700 ~/.ssh
        chmod 600 ~/.ssh/id_dsa
        chmod 644 ~/.ssh/id_dsa.pub
        chmod 600 ~/.ssh/authorized_keys

- In my ~/.bashrc I was running some commands  that I only should have been
  running in an interactive shell, like `ssh-add` b/c they were failing when
  executing in a non-interactive shell.  This happened when opening a
  connection for sftp.

Add Printers

Work printers:

    Go to System Preferences > Print and Scan > + > Add Printer or Scanner... > IP
    Add CBMI Admin Color HP Color LaserJet 3800n 134.174.151.228
    Add CBMI Admin B&W HP Color LaserJet 4240n 134.174.151.242 duplex.
    Add Doug Color HP Color LaserJet 4700 134.174.151.56 duplex.


### Finder Preferences

Configure Finder Sidebar:

    Finder > Preferences > Sidebar
    Add home dir (td23) to Favorites
    Add hard disks to Devices
    Drag ~/Dropbox/papers to the Finder Favorites sidebar.


### Terminal Settings

Fix paging in Terminal, s.t. page up and page down work in `less`, etc.

    Go to Terminal > Preferences > Basic Profile > Keyboard
    Edit key 'page up' to action 'send string to shell' with '\033[5~' which is <esc>[5~.
    Edit key 'shift page up' to 'Scroll Page Up'
    Edit key 'page down' to action 'send string to shell' with '\033[6~'
    Edit key 'shift page down' to 'Scroll Page Down'

My eyes are getting old.

    Go to Terminal > Preferences > Basic Profile > Text > Size
    Choose 14 point.


### Start Locate Indexing

This allows one to run the `locate` command by setting up the index.  It can take a while to run the first time:

    # sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist


### Configure /etc/hosts File

Download a hosts file from a site like mvps.org, someonewhocares.org, and
malwaredomainlist.com:

    sudo curl -o /etc/hosts http://someonewhocares.org/hosts/hosts

Then comment out 'ad-g.doubleclick.net' so Google Chrome does not complain when using YouTube.

Or use/make a program to combine multiple hosts files, like:

    https://github.com/StevenBlack/hosts


## Install Skype

Used for chatting with colleagues around the world.

http://www.skype.com/en/download-skype/skype-for-computer/


## Install Android FileTransfer

Until Macs start supporting MTP protocol, this app can be used to download and
upload files to an android device.  Download and install from:

http://www.android.com/filetransfer/



## Install Markdown renderer from github into the system ruby.

This markdown renderer has some nice extras like fenced code blocks and
autolinks.  It is used by ~/bin/markdown to render my markdown file, e.g via
`<leader>mdp` in vim.

    gem install redcarpet


## Install Microsoft Office 2011 for Mac OS X

Mount and run the installer from:

    open ~/data/2011_microsoft_office/SW_DVD5_Office_Mac_Standard_2011_English_MLF_X16-99088.ISO

From the install, the id for customer service is 03334-010-0110005-02060.

Or just install OpenOffice.


## Sync Data from Hard Drive to Laptop

Be careful in choosing exactly what data to get, since it will not all fit.

~/data, ~/Pictures, ~/Music, ~/Movies

Get all my data from orchestra:

    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/data ~/

Get my deployed "vanvactor_mirna" project from Orchestra:

    mkdir -p ~/deploy ~/data
    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/backup/deploy/vanvactor_mirna ~/deploy/
    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/backup/data/work ~/data/
    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/backup/data/stardog ~/data/


## Pip Installs

Install packages for python2:

    # virtualenv is a tool to create isolated Python environments.  
    pip install virtualenv
    # Fabric for deploying to remote hosts
    pip install fabric
    # My own fabric tweaks
    pip install diabric
    # Install boto for working with EC2
    pip install boto
    # Install nose for testing
    pip install nose
    # Pyflakes is a simple program which checks Python source files for errors.
    pip install pyflakes

    pip install pandas
    pip install numpy
    pip install scipy
    pip install matplotlib
    pip install statsmodels

Install packages for python3:

    # used in ~/bin/new_oist_careers
    pip3 install requests
    # used in ~/bin/new_oist_careers
    pip3 install beautifulsoup4
    # A lovely command line interface package
    pip3 install click
    # Python Subprocesses for Humans
    pip3 install envoy


## Install local (non-pypi/github) python packages

Install `mailutil.py`, so `~/bin/new_oist_careers` will work:

    # mailutil.py used in ~/bin/new_oist_careers
    cd ~/proj/python-utils
    python3 setup.py install


## Configure cron

    crontab ~/.crontab

## Configure postfix mail client

Configuring to use Gmail as a mail relay and then starting postfix allows
programs to use `mail` and the cron daemon to send email.

For more information, google "Postfix SMTP client mac os x" or check out these links:

- http://benjaminrojas.net/configuring-postfix-to-send-mail-from-mac-os-x-mountain-lion/
- http://www.zenddeveloper.com/how-to-send-smtp-mails-with-postfix-mac-os-x-10-8/
- http://slashusr.wordpress.com/2012/02/14/enabling-postfix-for-outbound-relay-via-gmail-on-os-x-lion-11/

Before running the script below, I created a application-specific password for
my Google account, 'mac_postfix', because I use two-factor authentication.  I
added the email environment variables to the secrets/dotfiles/copy/.bash_email
file that my 'dotfiles' project uses and made ~/.bashrc source .bash_email.

Following the directions in the links above, this script configures
`/etc/postfix/sasl_passwd`, `/etc/postfix/generic`, `/etc/postfix/main.cf`, and
`/System/Library/LaunchDaemons/org.postfix.master.plist`.  I needed to setup
the `generic` file to get `mail` to finally work, I think.  
The script creates backups of the original files (if they do not already
exist), and runs commands to modify the files (using `sudo`) and
load/reload/start/etc., the modified files.  It depends on some environment
variables being set, to avoid hard-coding sensitive data (email address,
password) in the script.  

```
    python3 -c "
    import os, subprocess
    #
    # Script Configuration
    #
    host = os.environ['GMAIL_SMTP_HOST']
    port = os.environ['GMAIL_SMTP_PORT']
    username = os.environ['GMAIL_SMTP_USERNAME']
    password = os.environ['GMAIL_SMTP_PASSWORD']
    email = os.environ['EMAIL'] # my email address
    local_hostname = subprocess.check_output('hostname').decode('utf-8').strip()
    local_username = subprocess.check_output('whoami').decode('utf-8').strip()
    #
    # Helper Functions
    #
    def initial_backup(fn):
        orig = fn + '.orig'
        if not os.path.exists(orig):
            subprocess.check_call('sudo cp -p {} {}'.format(fn, orig), shell=True)
        return orig
    def file_lines(fn):
        filebytes = subprocess.check_output('sudo cat {}'.format(fn), shell=True)
        return filebytes.decode('utf-8').splitlines()
    def file_write(text, fn):
        p = subprocess.Popen('sudo tee {}'.format(fn), stdin=subprocess.PIPE, shell=True)
        out, err = p.communicate(text.encode('utf-8'))
        if p.returncode:
            raise Exception('command failed.', p.returncode, out, err)
    #
    # Create SASL Password
    #
    sasl = '/etc/postfix/sasl_passwd'
    msg = '[{}]:{} {}:{}'.format(host, port, username, password)
    file_write(msg, sasl)
    subprocess.check_call('sudo postmap {}'.format(sasl), shell=True)
    #
    # Configure Launchd To Run Postfix At Startup
    #
    plist = '/System/Library/LaunchDaemons/org.postfix.master.plist'
    # make initial backup
    plist_orig = initial_backup(plist)
    # note: subprocess.check_output returns byte array, not unicode string.
    plist_lines = file_lines(plist_orig)
    msg = ''
    for line in plist_lines:
        if line == '</dict>':
            msg += '\t<key>OnDemand</key>\n'
            msg += '\t<true/>\n'
        msg += line + '\n'
    file_write(msg, plist)
    #
    # Configure Postfix Main.cf
    #
    maincf = '/etc/postfix/main.cf'
    maincf_orig = initial_backup(maincf)
    maincf_lines = file_lines(maincf_orig)
    # confirm that these lines are already set
    initial_lines = ['mydomain_fallback = localhost', 'mail_owner = _postfix',
                    'setgid_group = _postdrop',
                    'tls_random_source = dev:/dev/urandom']
    for line in initial_lines:
        assert line in maincf_lines
    # append config lines
    msg = '\n'.join(maincf_lines) + '\n'
    msg += '''
    # SMTP server used to relay email
    relayhost=[{host}]:{port}
    # Postfix 2.2 uses the generic(5) address mapping to replace local fantasy email
    # addresses by valid Internet addresses. This mapping happens ONLY when mail
    # leaves the machine; not when you send mail between users on the same machine.
    # Enable SASL authentication in the Postfix SMTP client.
    smtp_generic_maps = hash:/etc/postfix/generic
    # These settings (along with the relayhost setting above) will make
    # postfix relay all outbound non-local email via Gmail using an
    # authenticated TLS/SASL session.
    # SASL
    smtp_sasl_auth_enable=yes
    smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd
    smtp_sasl_security_options=noanonymous
    # Enable Transport Layer Security (TLS), i.e. SSL.
    smtp_use_tls=yes
    smtp_tls_security_level=encrypt
    '''.format(host=host, port=port)
    file_write(msg, maincf)
    #
    # Configure Postfix Generic
    #
    generic = '/etc/postfix/generic'
    generic_orig = initial_backup(generic)
    generic_lines = file_lines(generic_orig)
    msg = '\n'.join(generic_lines) + '\n'
    msg += '''
    # Translate my primary email address to the an external address
    # This is ONLY for the outbound email, and does not apply to local email.
    {luser}@{lhost} {email}
    @{lhost} {email}
    '''.format(luser=local_username, lhost=local_hostname, email=email)
    file_write(msg, generic)
    subprocess.check_call('sudo postmap {}'.format(generic), shell=True)
    #
    # Restart And Test Postfix
    #
    # subprocess.check_call('sudo postfix reload', shell=True)
    subprocess.check_call('sudo launchctl load -w {}'.format(plist), shell=True)
    # Test
    subprocess.check_call('date | mail -s test {}'.format(email), shell=True)
    "
```

## Install Stardog RDF server

This is used for development of the miRNA + orthology + functional annotation
mashup using Microcosm, TargetScan, Roundup, and GO.

Signed up for a stardog community edition.  Got email on 5/22 from stardog with
download links.  Downloaded zip file and key from 2013/05/22 gmail email.  Opened zip file.
Copied the binaries, etc., to ~/data/installs.

    cp -pr ~/Downloads/stardog-1.2.2 ~/data/installs/.

Following the the quickstart directions
(http://www.stardog.com/docs/quick-start/), I created a data dir,
~/data/stardog, copied the license key there, and added some env vars:

    mkdir ~/data/stardog
    export STARDOG_HOME=~/data/stardog
    cp -pr ~/Downloads/stardog-license-key.bin $STARDOG_HOME
    export PATH=$PATH:~/data/installs/stardog-1.2.2

Start the server, create and load an example database, and query the database:

    cd ~/data/installs/stardog-1.2.2
    ./stardog-admin server start
    ./stardog-admin db create -n myDB -t D -u admin -p admin examples/data/University0_0.owl
    ./stardog query myDB "SELECT DISTINCT ?s WHERE { ?s ?p ?o } LIMIT 10"


## Install chef on Mac OS X laptop

Since RubyGems is installed already (on the Ruby 1.9.3), just install the Chef
gem:

    gem install chef --no-ri --no-rdoc

There are alternate instructions for installing rubygems (for Ruby 1.8) found
on the Chef site:
http://wiki.opscode.com/display/chef/Installing+Chef+Client+on+OS+X

Make sure the executables are on the path:

    which knife chef-solo



## Install IPython and some of its dependencies, Tornado, Pygments, pyzmq

You should have already installed XQuartz and zmq.

Install IPython and its dependencies.  IPython Notebook requires the tornado
webserver, and zeromq, and requests pygments:

    # An asynchronous webserver
    pip install tornado
    # a python interface for zeromq, a lightweight message broker.
    pip install pyzmq
    # pygments is a syntax highlighter used by ipython
    pip install pygments
    # Interactive Computing for Python
    pip install ipython

Create the default config files / dirs in ~/.config/ipython/:

    ipython profile create

Learn more about configuration:

    ipython config -h

## Install IScala

Install the latest code from github into /usr/local:

    cd /usr/local
    git clone https://github.com/mattpap/IScala
    cd IScala
    sbt compile
    sbt assembly

Test run the notebook:

    /usr/local/IScala/target/scala-2.11/bin/notebook

## Install rpy2, python bindings for using R from python code.

    pip install rpy2


## Install psycopg2

Psycopg2 is a bridge between Python and Postgres.  Website:
http://initd.org/psycopg/

Install psycopg2:

    pip install psycopg2


## Install Sphinx

Read more: http://sphinx.pocoo.org/

Sphinx converts reStructuredText content into source code documentation, html
files, pdfs, latex.  It is used to generate the python documentation.

Install via pip:

    pip install Sphinx


## Install Spark or Quicksilver

I use Spark to map keystrokes to actions, particularly to map <ctrl><option>z
to my window zooming script, `~/bin/Zoom_Frontmost_Windows_Fullscreen.scpt`

Install spark (http://www.shadowlab.org/softwares/spark.php):

    brew cask install spark

Now Ctrl-Option-z to zoom windows.

    open /Users/ddctoddd/Applications/Spark.app

In Spark:

    File > New HotKey > AppleScript.  
    Shortcut > <ctrl><option>z.  
    Name > ZoomFrontmostWindows.  
    File > Choose ... > ~/bin/Zoom_Frontmost_Windows_Fullscreen.scpt.


Download Quicksilver at:
http://qsapp.com/download.php

Configure Quicksilver Preferences:

Catalog > Scripts > Select "Scripts (All Users)"
Catalog > Custom > Add ("+"), then choose ~/bin dir and set "Include Contents" to "Folder Contents"
Triggers > Custom Triggers
  - Add ("+") HotKey
  - Choose Zoom_Frontmost_Windows_Fullscreen.scpt and the (default) Run action.
  - Click the Trigger column of the new trigger and set the hotkey to ctrl-option-z
