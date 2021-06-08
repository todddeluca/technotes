
The goal of this project is to document what is installed on my mac, so setting
up a new mac is consistent, repeatable, and easier.

# Automated installation

There are a (growing) number of resources for automating the setup of a Mac OS X developer machine.

- "Automating the Setup of My Perfect Developer Environment on OSX 10.8 Mountain Lion" http://vanderveer.be/blog/2013/01/02/automating-the-setup-of-my-perfect-developer-environment-on-osx-10-dot-8-mountain-lion/
- Mac Development Ansible Playbook: https://github.com/geerlingguy/mac-dev-playbook
- Battleschool: http://spencer.gibb.us/blog/2014/02/03/introducing-battleschool/
- Boxen, how github maintains their laptops.
- http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac?utm_source=hackernewsletter&utm_medium=email&utm_term=fav

# Install Seil (formerly PCKeyboardHack)

This allows me to map the caps lock key to <esc> on Mac OS X.  For using vim,
doing so is an ergonomic blessing.

Download and  and install Seil (formerly PCKeyboardHack).
https://pqrs.org/osx/karabiner/seil.html
Open the .dmg file and run the installer.

Map the Caps Lock key to Escape:

    Go to System Preferences > Keyboard > Modifier Keys and change Caps Lock to 'No Action'
    Open Seil
    Choose "Change Caps Key" to Keycode 53 (Esc key)


# Install Dropbox and Google Drive

It can take a while for Dropbox to sync completely, so start this step early.

Dropbox gives access to my notes, including this file, and secrets.

Maybe I'll use Google Drive someday.

Link proj and work dirs into home:

    ln -s ~/Dropbox/work ~
    ln -s ~/Dropbox/proj ~
    ln -s ~/Dropbox/technotes ~


## Install Xcode or Command Line Developer Tools

The command line tools are needed to install homebrew, compile code, and I'm not sure what else.

Installation instructions can be found at
http://www.cnet.com/how-to/install-command-line-developer-tools-in-os-x/

> To install these tools, simply open the Terminal, type "make" or any desired
> common developer command, and press Enter, and then when prompted you can
> install the developer tools (an approximate 100MB download from Apple), and
> be up and running.


# Create Dirs in Home Dir

Create dirs for installing local frameworks and applications.  Homebrew
sometimes links installed apps and frameworks into these dirs.

    mkdir -p ~/Applications ~/Frameworks ~/bin

Some other dirs used by scripts like `~/bin/backup`, etc:

    mkdir -p ~/tmp ~/data ~/deploy


# Install and Update Homebrew

Homebrew is used to install and update many applications/programs on the mac,
particularly command line ones and developer ones.

Install homebrew if it is not yet installed.  See https://brew.sh/

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

Run the brew doctor to see what is broken with your system and installation.

    brew doctor

Before running `brew install <formula>`, you should update homebrew to get the
latest formulas from the homebrew library:

    brew update

Tap some kegs we use to get various homebrew formulae.

    # For gcc-4.2, needed to install ruby versions < 1.9.3
    brew tap homebrew/dupes
    # For older versions of grails
    brew tap homebrew/versions
    # For kalign, blast, paml
    brew tap homebrew/science
    

Install gcc-4.2 in case you need to install an older (`< 1.9.3`) version of
ruby.  As of Mountain Lion, OS X does not ship with gcc-4.2.  This requires
tapping the dupes homebrew formula repository:

    brew install apple-gcc42
    # Get gcc and gfortran (for scientific computing)
    # fortran is useful for scientific computing.
    brew install gcc 

# Homebrew Installs

Some recommendations come from https://github.com/skwp/dotfiles.

    brew update

    # ack is a tool like grep, optimized for programmers
    brew install ack
    # ctags is a program that generates an index (or tag) file of names found in source and header files of various programming languages
    brew install ctags
    # get a recent version of git
    brew install git
    # interact with github from the command line.
    brew install hub
    # use imagemagick to create, edit, compose, or convert bitmap images
    brew install imagemagick
    # make less friendlier for non-text input files
    brew install lesspipe
    # XZ Utils is free general-purpose data compression software.
    # XZ Utils are the successor to LZMA Utils.
    brew install xz
    # Graphviz is open source graph visualization software.  Used by my gpdm workflow visualization project.
    # As of 2013/07/28 the brew install failed on my 2013 Macbook Air 10.8.4
    brew install graphviz
    # install rbenv and ruby-build
    brew install rbenv
    brew install ruby-build

    # install python (and pip and distribute):
    brew install python@2 --with-tcl-tk
    brew install python3
    # Mercurial (distributed version control) is useful for contributing to python, etc.  Depends on docutils.
    pip-2.7 install docutils
    brew install hg

    # install a recent ruby version
    brew install ruby
    # From the ruby install caveats, add the default gem bin dir to .bashrc
    # PATH="$PATH:/usr/local/Cellar/ruby/1.9.3-p362/bin"

    # install zeromq, which IPython Notebook uses.
    brew install zeromq
    # Postgres database.  Used by autworks.
    # brew install postgresql
    # Install MacVim after ruby and python so it uses the brew installs for them.
    # also overriding the existing (older) system vim.
    # http://apple.stackexchange.com/questions/59375/how-do-i-install-macvim
    # Requires Xcode (as of 2014/07)
    brew install macvim --override-system-vim

    # install NCBI BLAST, PAML and Kalign, which are used by RSD
    brew install blast
    brew install paml
    brew install kalign

    # install node.js and grunt for reveal.js markdown slideshow app
    brew install node

    # install maven and gradle for java development and deployment
    brew install gradle
    brew install maven

    # install some languages used at DDC
    brew install scala210
    brew install groovy
    brew install scala

    # install local instance of hadoop for testing cascading workflows
    brew install hadoop

    brew install jq # Like awk/sed/grep for json.
    brew install jsawk # awk for json.  Use by some ddc scripts.

    brew linkapps


# Install Docker

Use homebrew:

    brew install docker
    brew install boot2docker

To have launchd start boot2docker at login:

    ln -sfv /usr/local/opt/boot2docker/*.plist ~/Library/LaunchAgents

Then to load boot2docker now:

    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.boot2docker.plist


# Install Go Lang

    brew install go
    mkdir $HOME/go

# Node NPM Installs

    # Reveal.js markdown slideshow app depends on Grunt CLI (and node.js)
    npm install -g grunt-cli
    npm install git+https://github.com/parmentf/xml2json.git
    npm install --global xml2json  // converts xml to json.  Great with jq.

# Vagrant and Virtualbox

I need vagrant and virtual box to test the python-vagrant package.

Go to http://downloads.vagrantup.com/
Download the latest Mac installer, 1.2.7 on 2013/07/30 and install it.

Go to https://www.virtualbox.org/wiki/Downloads
Download the latest Mac installer, 4.2.16 on 2013/07/30, an install it.

# Install Dotfiles

This depends on python3, which is installed by homebrew.  The ~/.vim/install.py
script requires python3.  It also depends on Dropbox being synchronized,
especially the ~/Dropbox/proj/dotfiles and ~/Dropbox/secrets.dmg.

Install dotfiles, bin dir, vim bundles, and secrets:

    cd ~/Dropbox/proj/dotfiles
    ./install.sh copy
    ./install.sh secrets
    source ~/.bash_profile


## Install Spark

For local development, download spark 1.3.1 with hadoop 2.6 support, since that is what CDH 5.4 is using, not that it matters.

Unpack and install:

    cd ~/Downloads
    tar xvzf spark-1.3.1-bin-hadoop2.6.tgz
    cp -pr spark-1.3.1-bin-hadoop2.6 /usr/local/

Add to path:

    echo '# Add Spark to Path
    export PATH="$PATH:/usr/local/spark-1.3.1-bin-hadoop2.6/bin"
    ' >> ~/.bashrc


# Install Google Chrome

I like chrome.

See https://github.com/caskroom/homebrew-cask for a way to install Chrome from the command line.

    brew install caskroom/cask/brew-cask
    brew cask install google-chrome
    open ~/Applications/"Google Chrome.app"

https://www.google.com/intl/en/chrome/browser/

Deprecated?  Install "GoogleVoiceAndVideoSetup.dmg", the Hangouts video and voice
chatting plugin, needed for chatting and using Google Voice to make calls.

## Install Postman Chrome App

It can be used to interact with REST APIs more easily.

In Chrome, go to chrome://apps/, choose "Store", search for "Postman" and install the Postman - Rest Client by rickreation.


# Install Adobe Reader

This is so I can read and sign adobe forms.


# Install iTerm2

Download it from http://www.iterm2.com/ and put it in /Applications.

Configure iTerm2 so that one can scrollback when using tmux or screen.
(Solution found at https://code.google.com/p/iterm2/issues/detail?id=980):

    Preferences > Profiles > Terminal
    Save lines to scrollback when an app status bar is present.

# Install Julia

Download and install it from http://julialang.org/downloads/.


# Configure OS X

## System Preferences

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

Configure Finder Sidebar:

    Finder > Preferences > Sidebar
    Add home dir (td23) to Favorites
    Add hard disks to Devices
    Drag ~/Dropbox/papers to the Finder Favorites sidebar.

Configure clock:

    System Preferences > Date & Time > Clock.  Check Use a 24-hour clock.

Configure iTunes:

    iTunes > Preferences > General.  
      When you insert a CD: Select "Import CD and Eject"
      Import Settings ...
        Import Using: Select "AAC iTunes Plus" (256kbps stereo, VBR encoding)
        Check "Use error correction when reading Audio CDs"
    iTunes > Preferences > Advanced
      Change iTunes Media folder location to something like "~/Music/lossless_20130101"
      Deselect "Copy files to iTunes Media folder when adding to library".

Do not open DVDs with DVD Player

    System Preferences > CDs and DVDs > When you insert a video DVD > Select "Ignore".

## Terminal Settings

Fix paging in Terminal, s.t. page up and page down work in `less`, etc.

    Go to Terminal > Preferences > Basic Profile > Keyboard
    Edit key 'page up' to action 'send string to shell' with '\033[5~' which is <esc>[5~.
    Edit key 'shift page up' to 'Scroll Page Up'
    Edit key 'page down' to action 'send string to shell' with '\033[6~'
    Edit key 'shift page down' to 'Scroll Page Down'

My eyes are getting old.

    Go to Terminal > Preferences > Basic Profile > Text > Size
    Choose 14 point.

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


## Start Locate Indexing

This allows one to run the `locate` command by setting up the index.  It can take a while to run the first time:

    # sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

## Change the Computer Name

The default name was something like 'HMS MacBook Laptop'.  I prefer something with my name in it and without spaces.

    System Preferences > Sharing > Computer Name.  Enter whatever name you want.

For my work laptop I used 'ToddWorkMac'.

## Change Application Installation Security Setting

This is used to install Spark, and perhaps other things.

    System Preferences > Security & Privacy > General > Allow applications downloaded from: Anywhere.

## Arrange the relationship between the external display and the laptop screen

    System Preferences > Displays > Arrangement.  
    Place laptop screen below the external monitor.  
    Move the menu bar the the external display.

## Start SSH daemon on localhost so Fabric can deploy as if to a remote host.

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

## Add Printers

Work printers:

    Go to System Preferences > Print and Scan > + > Add Printer or Scanner... > IP
    Add CBMI Admin Color HP Color LaserJet 3800n 134.174.151.228
    Add CBMI Admin B&W HP Color LaserJet 4240n 134.174.151.242 duplex.
    Add Doug Color HP Color LaserJet 4700 134.174.151.56 duplex.


## Configure /etc/hosts File

Download a hosts file from a site like mvps.org, someonewhocares.org, and
malwaredomainlist.com:

    sudo curl -o /etc/hosts http://someonewhocares.org/hosts/hosts

Then comment out 'ad-g.doubleclick.net' so Google Chrome does not complain when using YouTube.

Or use/make a program to combine multiple hosts files, like:

    https://github.com/StevenBlack/hosts


# Install Skype

Used for chatting with colleagues around the world.

http://www.skype.com/en/download-skype/skype-for-computer/


# Install Android FileTransfer

Until Macs start supporting MTP protocol, this app can be used to download and
upload files to an android device.  Download and install from:

http://www.android.com/filetransfer/


# Install VLC and Handbrake

Download and install from:

- http://www.videolan.org/vlc/index.html
- http://handbrake.fr/downloads.php

When using Handbrake for the first time it explains that for 64-bit Handbrake
you also need to download a 64-bit version of libdvdcss and directs you to:

    http://download.videolan.org/libdvdcss/last/macosx/

# Install MySQL

brew install mysql

# Install SequelPro

SequelPro is a useful GUI for interacting with MySQL (and other?) databases.

Download the latest .dmg at:

http://www.sequelpro.com/download

Move the app to the applications dir.



# Install Spark or Quicksilver

I use Spark to map keystrokes to actions, particularly to map <ctrl><option>z
to my window zooming script, `~/bin/Zoom_Frontmost_Windows_Fullscreen.scpt`

Download Spark from:
http://www.shadowlab.org/softwares/spark.php

Installed version 3.0b9.

Now C-O-z to zoom windows.  In Spark:

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


# Install X11/XQuartz

R, Python, IPython, among other programs, depends on X11, but it does not ship
with OS X 10.8 Mountain Lion.  Install it by going to:
http://xquartz.macosforge.org/landing/
and clicking the download link for
XQuartz-2.7.4.dmg
and opening the dmg and running
the installer.
Log out and back in again to update the `DISPLAY` variable to point to XQuartz
instead of X11.  The installer suggested doing this.


# Install Microsoft Office 2011 for Mac OS X

Mount and run the installer from:

    open ~/data/2011_microsoft_office/SW_DVD5_Office_Mac_Standard_2011_English_MLF_X16-99088.ISO

From the install, the id for customer service is 03334-010-0110005-02060.


# Install R and R Studio

Install R:

    brew install r

Download RStudio Desktop installer from
http://www.rstudio.com/ide/download/desktop

Installed RStudio 0.97.248 - Mac OS X 10.6+ (64-bit).


# Sync Data from Hard Drive to Laptop

Be careful in choosing exactly what data to get, since it will not all fit.

~/data, ~/Pictures, ~/Music, ~/Movies

Get all my data from orchestra:

    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/data ~/

Get my deployed "vanvactor_mirna" project from Orchestra:

    mkdir -p ~/deploy ~/data
    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/backup/deploy/vanvactor_mirna ~/deploy/
    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/backup/data/work ~/data/
    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/backup/data/stardog ~/data/


# Pip Installs

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

Install packages for python3:

    # used in ~/bin/new_oist_careers
    pip3 install requests
    # used in ~/bin/new_oist_careers
    pip3 install beautifulsoup4
    # A lovely command line interface package
    pip3 install click
    # Python Subprocesses for Humans
    pip3 install envoy

# Install local (non-pypi/github) python packages

Install `mailutil.py`, so `~/bin/new_oist_careers` will work:

    # mailutil.py used in ~/bin/new_oist_careers
    cd ~/proj/python-utils
    python3 setup.py install


# Configure cron

    crontab ~/.crontab

# Configure postfix mail client

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



# Install Markdown renderer from github into the system ruby.

This markdown renderer has some nice extras like fenced code blocks and
autolinks.  It is used by ~/bin/markdown to render my markdown file, e.g via
`<leader>mdp` in vim.

    gem install redcarpet

# Install Stardog RDF server

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


# Install chef on Mac OS X laptop

Since RubyGems is installed already (on the Ruby 1.9.3), just install the Chef
gem:

    gem install chef --no-ri --no-rdoc

There are alternate instructions for installing rubygems (for Ruby 1.8) found
on the Chef site:
http://wiki.opscode.com/display/chef/Installing+Chef+Client+on+OS+X

Make sure the executables are on the path:

    which knife chef-solo


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

Install numpy and scipy and matplotlib:

    # the pip way does a "develop" install, which is not what I want, I think.
    # The src is downloaded and the then symlinked instead of installed into
    # the python site-packages, I think.
    # e.g. pip install -e git+https://github.com/matplotlib/matplotlib#egg=matplotlib-dev
    mkdir -p ~/tmp
    cd ~/tmp
    git clone https://github.com/numpy/numpy.git
    cd numpy
    python setup.py build install

    cd ~/tmp
    git clone https://github.com/scipy/scipy.git
    cd scipy
    python setup.py build install

    cd ~/tmp
    git clone https://github.com/matplotlib/matplotlib.git
    cd matplotlib
    python setup.py build install


# Install Pandas (and Cython dependency)

Pandas is a python project that provides a powerful "dataframe" for numerical
and scientific computing.  For more information see http://pandas.pydata.org/.

Pandas requires cython.  Install cython:

    pip install cython
    pip install openpyxl xlrd xlwt


Install pandas:

    pip install pandas


Pandas suggests installing:

    pip install statsmodels


# Install IPython and some of its dependencies, Tornado, Pygments, pyzmq

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

# Install IScala

Install the latest code from github into /usr/local:

    cd /usr/local
    git clone https://github.com/mattpap/IScala
    cd IScala
    sbt compile
    sbt assembly

Test run the notebook:

    /usr/local/IScala/target/scala-2.11/bin/notebook

# Install rpy2, python bindings for using R from python code.

    pip install rpy2


# Install psycopg2

Psycopg2 is a bridge between Python and Postgres.  Website:
http://initd.org/psycopg/

Install psycopg2:

    pip install psycopg2


# Install Sphinx

Read more: http://sphinx.pocoo.org/

Sphinx converts reStructuredText content into source code documentation, html
files, pdfs, latex.  It is used to generate the python documentation.

Install via pip:

    pip install Sphinx


# Install Theano

I plan to use Theano for training deep neural network models.

Instructions for installing Theano:
http://deeplearning.net/software/theano/install.html#install

Theano needs:

- Python
- g++, python-dev
- numpy
- scipy
- BLAS

And it wants:

- nose
- Sphinx, pygments
- git
- pydot
- nvidia cuda drivers and sdk

## Python

I used homebrew to install python 2.7.3.

## g++

This comes with Xcode or the command-line utilities which can be downloaded separately.  They are a prerequisite of homebew, so I already have them installed.

## python-dev

The development headers should be already installed on Mac OS X.
http://code.mixpanel.com/2010/09/30/building-c-extensions-in-python/ suggests
looking in `/System/Library/Frameworks/Python.framework/Versions/2.6/` for
them.  Since I have a homebrew install of python, I looked in
`/usr/local/Cellar/python/2.7.3/Frameworks/Python.framework/Versions/Current/include/python2.7/`
to find them.  They seem to be there.  Fingers crossed.

## numpy

Already installed.


## scipy

Already installed.


## BLAS

I think this is already installed as part of Accelerate.framework, at least on OS X Mountain Lion.  I think it comes with Xcode, based on the output of this `locate` command:

    locate BLAS
    # ...
    # /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/Headers/vBLAS.h
    # ...

## nose

Upgraded nose:

    pip install --upgrade nose

## Sphinx and Pygments

Up-to-date:

    pip install --upgrade sphinx Pygments

## git

Already installed.

## pydot

Installed version 1.0.28:

    pip install pydot

## Install CUDA dependency, open-mpi

    brew install open-mpi

## nvidia cuda drivers and sdk

Requirements and Instructions:
http://docs.nvidia.com/cuda/cuda-getting-started-guide-for-mac-os-x/index.html

Is my GPU CUDA-capable?  Find out in 'About This Mac > More Info':

    NVIDIA GeForce 320M 256 MB

Then look it up here: https://developer.nvidia.com/cuda-gpus.  The 320M is not
in the list.  This page
(http://appleinsider.com/articles/10/04/13/nvidia_320m_gpu_made_especially_for_apples_new_13_inch_macbook_pro.html)
suggests it might be comparable to a GeForce 216 or GeForce 310M.  The 320M
does not have dedicated graphics memory.  Instead it shares main memory.  Hmmm.
Anyway, it *might* be CUDA-compatible.

Download and install the Mac OS X drivers from
https://developer.nvidia.com/cuda-downloads

Installed cuda-5.0.36.

Add the cuda drivers to PATH and DYLD_LIBRARY_PATH:

    export PATH="/Developer/NVIDIA/CUDA-5.0/bin:$PATH"
    export DYLD_LIBRARY_PATH="/Developer/NVIDIA/CUDA-5.0/lib:${DYLD_LIBRARY_PATH}"

Verify driver installation:

    kextstat | grep -i cuda

Compile example programs:

    cd /Developer/NVIDIA/CUDA-5.0/samples && make

Test that CUDA is working:

    cd /Developer/NVIDIA/CUDA-5.0/samples/bin/darwin/release
    ./deviceQuery
    # ...
    # Detected 1 CUDA Capable device(s)
    # ...
    ./bandwidthTest


## Finally, Install Theano

    pip install theano


# (Optional) Install Ruby Using rbenv

Install ruby into .rbenv/versions, using ruby-build via rbenv. This might be
needed to run Autworks locally:

    rbenv install 1.9.3-p194
    rbenv rehash


# (Optional) Install Emacs

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


# (Optional) Install MacTeX

MacTeX is a large install (2 GB download) which installs lots of binaries,
fonts, etc., for using TeX on a Mac.  If I want to use LaTeX to write papers,
this could be the way to go.

Downloaded and ran installer for MacTeX-2012 from http://www.tug.org/mactex/


# (Deprecated) Install gcc-4.0, needed to compile pycrypto

This was needed on my OS X 10.8 Mountain Lion White MacBook from Jan 2009.  Not needed on my Spring 2010 MacBook Pro with a fresh OS X 10.8 Installation.

http://apple.stackexchange.com/questions/70464/how-to-compile-gcc-4-0-on-mountain-lion
http://www.opensource.apple.com/release/developer-tools-314/

Download and unpack:

    mkdir -p ~/tmp
    cd ~/tmp
    curl http://www.opensource.apple.com/tarballs/gcc/gcc-5493.tar.gz | tar xvz
    cd gcc-5493/

Compile and install:

    mkdir darwin
    cd darwin
    ../configure --prefix=/tmp/testplace --enable-languages=objc,c++
    make bootstrap
    make install

Link /usr/bin/gcc-4.0 to the binary in the temp dir, so it can be found (with the right name) when pycrypto is compiling:

    sudo ln -s /tmp/testplace/bin/gcc /usr/bin/gcc-4.0
    pip install pycrypto
