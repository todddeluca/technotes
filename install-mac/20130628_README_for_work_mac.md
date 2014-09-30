
The goal of this project is to document what is installed on my mac, so setting
up a new mac is consistent, repeatable, and easier.

# Automated installation

Here is an article about using chef to automate the setup of a Mac:

"Automating the Setup of My Perfect Developer Environment on OSX 10.8 Mountain Lion"
http://vanderveer.be/blog/2013/01/02/automating-the-setup-of-my-perfect-developer-environment-on-osx-10-dot-8-mountain-lion/


# Install PCKeyboardHack

This allows me to map the caps lock key to <esc> on Mac OS X.  For using vim,
doing so is an ergonomic blessing.

How to:
http://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x

Download and install PCKeyboardHack
http://pqrs.org/macosx/keyremap4macbook/extra.html

Downloaded PCKeyboardHack-9.0.0, open PCKeyboardHack-9.0.0.dmg, right click
PCKeyboardHac.pkg and choose Open.  Then choose open despite the scary warning
from the apple gatekeeper.  Install the program and restart the computer.

*Warning!* The installer restarts the computer rather abruptly, so make sure to
save your work before restarting.

Map the Caps Lock key to Escape:

    Go to System Preferences > Keyboard > Modifier Keys and change Caps Lock to 'No Action'
    Open PCKeyboardHack
    Choose "Change Caps Key" to Keycode 53 (Esc key)


# Install Dropbox and Google Drive

It can take a while for Dropbox to sync completely, so start this step early.

Dropbox gives access to my notes, including this file, and secrets.

Maybe I'll use Google Drive someday.

Link proj and work dirs into home:

    ln -s ~/Dropbox/work ~
    ln -s ~/Dropbox/proj ~
    ln -s ~/Dropbox/technotes ~


## Install Xcode And Command Line Tools For Mountain Lion via the App Store

This is a big install and could take a long time to download on a slow
connection.  

- Go to App Store.
- Search for Xcode.
- Install it.

After installing Xcode, you still need to install the command line
tools as follows: 

- Go to Preferences > Downloads.
- Choose to install the command line tools.  (Since XCode 4.5 or so).


# Install Google Chrome

I like chrome.

https://www.google.com/intl/en/chrome/browser/


# Configure OS X

Enable more keyboard accessability to UI controls:

    Go to System Preferences > Keyboard > Keyboard Shortcuts
    Choose 'All controls' for 'Full Keyboard Acess'

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
      Change iTunes Media folder location to "~/Music/lossless_20130101
      Deselect "Copy files to iTunes Media folder when adding to library".

Do not open DVDs with DVD Player

    System Preferences > CDs and DVDs > When you insert a video DVD > Select "Ignore".

Fix paging in Terminal, s.t. page up and page down work in `less`, etc.

    Go to Terminal > Preferences > Basic Profile > Keyboard
    Edit key 'page up' to action 'send string to shell' with '\033[5~' which is <esc>[6~.
    Edit key 'shift page up' to 'scroll to next page in buffer'
    Edit key 'page down' to action 'send string to shell' with '\033[6~'
    Edit key 'shift page down' to 'scroll to previous page in buffer'

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
    Add CBMI Admin B&W HP Color LaserJet 4240n 134.174.151.228 duplex.
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


# Install Sublime Text 2

Not done.

Download it from http://www.sublimetext.com/.

Link the command line script into my home bin:

    ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl ~/bin/subl

## Install Package Control (the ST package manager).  See instructions at http://wbond.net/sublime_packages/package_control/installation#ST3.

Open Sublime Text 2.  Type "ctrl-`" and paste in the following

    import urllib2,os; pf='Package Control.sublime-package'; ipp=sublime.installed_packages_path(); os.makedirs(ipp) if not os.path.exists(ipp) else None; urllib2.install_opener(urllib2.build_opener(urllib2.ProxyHandler())); open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read()); print('Please restart Sublime Text to finish installation')

## Install and Configure Markdown Packages

See instructions and suggestions 

- http://www.macstories.net/roundups/sublime-text-2-and-markdown-tips-tricks-and-links/.
- http://blog.boyet.com/blog/blog/using-markdown-in-sublime-text-2-on-windows/
- http://www.bram.us/2013/02/08/sublime-text-markdown-syntax-highlighting/
- http://hiltmon.com/blog/2012/11/07/multiple-themes-in-sublime-text-2/

Install MarkdownEditing via PackageManager:InstallPackage in ST2.

Create a new Monokai Markdown Theme as a derivative of Monokai.

    cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages
    cp Color\ Scheme\ -\ Default/Monokai.tmTheme User/MonokaiMarkdown.tmTheme
    subl User/MonokaiMarkdown.tmTheme

Add the following, from http://www.bram.us/2013/02/08/sublime-text-markdown-syntax-highlighting/, to the MonokaiMarkdown Theme:

    <dict>
        <key>name</key>
        <string>Markdown: Linebreak</string>
        <key>scope</key>
        <string>text.html.markdown meta.dummy.line-break</string>
        <key>settings</key>
        <dict>
            <key>background</key>
            <string>#A57706</string>
            <key>foreground</key>
            <string>#E0EDDD</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markdown: Raw</string>
        <key>scope</key>
        <string>text.html.markdown markup.raw.inline</string>
        <key>settings</key>
        <dict>
            <key>foreground</key>
            <string>#269186</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markdown: Punctuation for Inline Block</string>
        <key>scope</key>
        <string>punctuation.definition.raw.markdown</string>
        <key>settings</key>
        <dict>
            <key>foreground</key>
            <string>#269186</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markup: Heading</string>
        <key>scope</key>
        <string>markup.heading</string>
        <key>settings</key>
        <dict>
            <key>fontStyle</key>
            <string>bold</string>
            <key>foreground</key>
            <string>#cb4b16</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markup: Italic</string>
        <key>scope</key>
        <string>markup.italic</string>
        <key>settings</key>
        <dict>
            <key>fontStyle</key>
            <string>italic</string>
            <key>foreground</key>
            <string>#839496</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markup: Bold</string>
        <key>scope</key>
        <string>markup.bold</string>
        <key>settings</key>
        <dict>
            <key>fontStyle</key>
            <string>bold</string>
            <key>foreground</key>
            <string>#586e75</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markdown: Punctuation for Bold, Italic</string>
        <key>scope</key>
        <string>punctuation.definition.bold.markdown, punctuation.definition.italic.markdown</string>
        <key>settings</key>
        <dict>
            <key>foreground</key>
            <string>#586e75</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markup: Underline</string>
        <key>scope</key>
        <string>markup.underline</string>
        <key>settings</key>
        <dict>
            <key>fontStyle</key>
            <string>underline</string>
            <key>foreground</key>
            <string>#839496</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markup: Quote</string>
        <key>scope</key>
        <string>markup.quote</string>
        <key>settings</key>
        <dict>
            <key>fontStyle</key>
            <string>italic</string>
            <key>foreground</key>
            <string>#268bd2</string>
        </dict>
    </dict>
    <dict>
        <key>name</key>
        <string>Markup: Separator</string>
        <key>scope</key>
        <string>meta.separator</string>
        <key>settings</key>
        <dict>
            <key>background</key>
            <string>#eee8d5</string>
            <key>fontStyle</key>
            <string>bold</string>
            <key>foreground</key>
            <string>#268bd2</string>
        </dict>
    </dict>

And Change `Monokai` to `MonokaiMarkdown` in the file:

    # change this
    <string>Monokai</string>
    # to this
    <string>MonokaiMarkdown</string>


# Install VLC and Handbrake

Download and install from:

- http://www.videolan.org/vlc/index.html
- http://handbrake.fr/downloads.php

When using Handbrake for the first time it explains that for 64-bit Handbrake
you also need to download a 64-bit version of libdvdcss and directs you to:

    http://download.videolan.org/libdvdcss/last/macosx/


# Install Spark

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


# Install X11/XQuartz

Python, IPython, among other programs, depends on X11, but it does not ship
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

Download R installer from
http://cran.r-project.org/bin/macosx/
Run the installer.

Downloaded and installed R-2.15.2.

Download RStudio Desktop installer from
http://www.rstudio.com/ide/download/desktop

Installed RStudio 0.97.248 - Mac OS X 10.6+ (64-bit).


# Install Mac Developer Tools

Needed to install homebrew, compile code, and I'm not sure what else.


## Or Only Install Command Line Tools (OS X Mountain Lion) for Xcode - August 2012

Go to http://connect.apple.com, log in with your apple credentials, and you
should be at https://developer.apple.com/downloads/index.action#.  Navigate to
the section labeled "e - August 2012" and click the download link.  This
download is ~100 MB, much lighter than ~2 GB of Xcode.

After downloading the dmg file, open it and run the installer.

This download is described somewhat at this page: 
http://kennethreitz.com/xcode-gcc-and-homebrew.html

Many tips for upgrading to Mountain Lion are described here:
http://robots.thoughtbot.com/post/27985816073/the-hitchhikers-guide-to-riding-a-mountain-lion.
Fix the permissions the installer tweeks on `/usr/local` by changing the owner from root to you:

    sudo chown -R `whoami` /usr/local


# Install and Update Homebrew


Install homebrew if it is not yet installed.  See https://github.com/mxcl/homebrew/wiki/installation:

    ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

Run the brew doctor to see what is broken with your system and installation.

    brew doctor

Before running `brew install <formula>`, you should update homebrew to get the
latest formulas from the homebrew library:

    brew update

Install gcc-4.2 in case you need to install an older (`< 1.9.3`) version of
ruby.  As of Mountain Lion, OS X does not ship with gcc-4.2.  This requires
tapping the dupes homebrew formula repository:

    brew tap homebrew/dupes
    brew install apple-gcc42

Create dirs for installing local frameworks and applications.  Homebrew
sometimes links installed apps and frameworks into these dirs.

    mkdir -p ~/Applications ~/Frameworks ~/bin 


# Install Dotfiles

The ~/.vim/install.py script requires python3, so this might need to be done
after python3 is installed.

    cd ~/Dropbox/proj/dotfiles
    ./install.sh copy
    ./install.sh secrets
    source ~/.bash_profile

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
    # Mercurial (distributed version control) is useful for contributing to python, etc.  
    brew install hg
    # Graphviz is open source graph visualization software.  Used by my gpdm workflow visualization project.
    brew install graphviz
    # install rbenv and ruby-build
    brew install rbenv
    brew install ruby-build

    # install python (and pip and distribute):
    brew install python
    brew install python3

    # install a recent ruby version
    brew install ruby
    # From the ruby install caveats, add the default gem bin dir to .bashrc
    # PATH="$PATH:/usr/local/Cellar/ruby/1.9.3-p362/bin"

    # install zeromq, which IPython Notebook uses.
    brew install zeromq
    # Postgres database.  Used by autworks.
    brew install postgresql
    # Install MacVim after ruby and python so it uses the brew installs for them.
    # also overriding the existing (older) system vim.
    # http://apple.stackexchange.com/questions/59375/how-do-i-install-macvim
    brew install macvim --override-system-vim
    # fortran is useful for scientific computing.
    brew install gfortran

    brew linkapps

    # install NCBI BLAST, PAML and Kalign, which are used by RSD
    brew tap homebrew/science
    brew install blast
    brew install paml
    brew install https://raw.github.com/todddeluca/homebrew-science/add_kalign_formula/kalign.rb
    # if my pull request gets accepted, kalign can be installed like so:
    # brew install kalign

## Install MySQL

Instructions: 

- http://www.andrewsavory.com/blog/2011/2144
- http://madebyhoundstooth.com/blog/install-mysql-on-mountain-lion-with-homebrew/

Install and configure:

    brew install mysql

Caveats from `brew info mysql`:

Set up databases to run AS YOUR USER ACCOUNT with:

    unset TMPDIR
    mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

Load and Run mysql at startup and now:

    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

Run the secure installation script.  This will allow you to change the root
password, remove the anonymous user and test database, and only allow root to
log in from localhost:

    mysql_secure_installation

Create a user for myself with full privileges.  To avoid putting the password
in the command, create a function to read it in from the command line and then
echo the `CREATE USER` and `GRANT` statements to mysql.  This at least should
keep the password out of ~/.bash_history:
    
    createandgrantall() {
      echo 'You will be prompted first for the new user password and then the root password.'
      read -s -p 'Enter password: ' MPASSWORD
      echo 
      MUSER=$1
      echo "CREATE USER '$MUSER'@'localhost' IDENTIFIED BY '$MPASSWORD';
      GRANT ALL ON *.* TO '$MUSER'@'localhost';
      GRANT GRANT OPTION ON *.* TO '$MUSER'@'localhost';" | mysql -u root -p mysql
    }

    createandgrantall td23


## Install Vagrant and Virtualbox

Download and install the latest version (4.2.10) of VirtualBox from
https://www.virtualbox.org/wiki/Downloads


Download and install the latest version of Vagrant from
http://www.vagrantup.com/
As of this writing that is version 1.1.1.

Create a Vagrantfile, download a "box", and bring it up to make sure it works:

    cd ~/tmp
    vagrant box add base http://files.vagrantup.com/precise64.box
    rm -f Vagrantfile
    vagrant init
    vagrant up
    vagrant destroy

In typical Vagrant style, this fails with an inscrutable error and no obvious
help on the internet.  The error:

    /Applications/Vagrant/embedded/gems/gems/vagrant-1.1.1/plugins/providers/virtualbox/action/prepare_nfs_settings.rb:16:in
    `call': uninitialized constant
    VagrantPlugins::ProviderVirtualBox::Action::PrepareNFSSettings::Errors
    (NameError)




## Some notes on Python installation:

This page has instructions for how to install python using homebrew:
https://python-guide.readthedocs.org/en/latest/starting/install/osx/
It suggests building using `brew install python --framework`.  However
`--framework` is no longer an option, since python is built as a framework by
default, at least since around Aug 2012, according to
https://github.com/mxcl/homebrew/commit/a97c8174e241bce9a4ec59e3c3c0843ec06378d1#Library/Formula/python.rb.

## Some notes on ZeroMQ installation from my 10.6 days

There were no errors when installing on a fresh OS X 10.8 install from a
MacBook Pro 13" Mid 2010.

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


# Sync Work Data from Orchestra to ~/data

Get all my data from orchestra:

    rsync -avzhP --stats td23@orchestra.med.harvard.edu:/groups/cbi/td23/data ~/


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
autolinks.  It is used by ~/bin/markdown.pl to render my markdown file, e.g via
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




