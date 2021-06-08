

# Install DDC

Dealer.com specific installation notes.

The purpose of this file is to track ongoing changes to my DDC laptop s.t.
I can get up and running on a new laptop quickly, without forgetting any
necessary software or changes to the filesystem, System Preferences, etc.

Changes in .bashrc (and the like)

## Bash configuration


Link ddc bash secrets into the bash secrets directory:

    ln -s ~/Dropbox/work/ddc/secrets/.bash_secrets.d/.bash_ddc_secrets ~/.bash_secrets.d/


## /etc/hosts configuration

Disable Hacker News:

```
echo '
# Hacker News.  I love you too much
127.0.0.1 news.ycombinator.com
' | sudo tee -a /etc/hosts
```

Configure DDC localhost redirects:

```
echo '
# Nexus and other DB entries (dev environment)
10.12.10.60 nexus-db.earthcars.net
10.12.10.60 nexus-db1.earthcars.net
10.12.10.60 nexus-db2.earthcars.net
10.12.10.60 nexus-db3.earthcars.net
10.12.10.60 postfix-db.earthcars.net
10.12.10.60 reports-db1.earthcars.net
10.12.10.60 reports-db2.earthcars.net
10.12.10.60 video-db.earthcars.net
# CC local environment
127.0.0.1 apps.local.dealer.ddc
127.0.0.1 static.cc7.local.dealer.ddc
' | sudo tee -a /etc/hosts
```

Flush your local DNS cache to force a re-load of the /etc/hosts file:

    dscacheutil -flushcache



## /etc configuration


## System Preferences


## Homebrew and Cask Install

Install maven

```
brew install maven
brew install gradle
# hadoop: for the cascading tutorial
brew install hadoop

```



## Install Java

We're still on Java 7 at Dealer.

Install Java EE 7
Installed Java Platform, Enterprise Edition 7 SDK (with JDK 7u45)




## Install SequelPro

Sequel Pro is a useful GUI for interacting with MySQL (and other?) databases.

Download the latest .dmg at:

http://www.sequelpro.com/download

Move the app to the applications dir.

## Install IntelliJ IDEA

Download and install JetBrains IntelliJ IDEA Ultimate Edition
https://docs.dealer.com/pages/viewpage.action?pageId=100541447

Use this license server URL:
http://jetbrains.dealerdotcom.corp:8080/licenseServer




## Create a ssh key pair for DDC

ssh-keygen -t rsa -C "todd.deluca@dealer.com"

Created ~/.ssh/id_rsa_ddc{,.pub}

Copy key to a dev box:

cat ~/.ssh/id_rsa_ddc.pub | ssh vtqaservices1 "mkdir ~/.ssh 2>/dev/null; chmod 700 ~/.ssh &>/dev/null; cat >> ~/.ssh/authorized_keys"

Add the key to the ssh agent:

ssh-add -K ~/.ssh/id_rsa_ddc

Confirm that logging in with the key pair works

ssh vtqaservices1 "exit"

Mailed Zach Morton, requesting that my public key (which he'll get from my ~/.ssh/authorized_keys file on vtqaservices1) be added to gitolite.


## Set up github key pair access

created ~/.ssh/id_rsa_ddc_laptop_github key pair

Create new key pair for github:

ssh-keygen -t rsa -C "dealer.com"

Uploaded public key to todddeluca github account

Add private key to ssh-agent and mac keychain

ssh-add -K /Users/ddctoddd/.ssh/id_rsa_ddc_laptop_github


## Add dotfiles and technotes home projects

Clone the dotfiles repository:

    cd ~/home/proj
    git clone git@github.com:todddeluca/dotfiles.git

Install the dotfiles:

    cd ~/home/proj/dotfiles
    ./dotf bin
    ./dotf copy
    ./dotf link
    ./dotf vim
    source ~/.bashrc

Add technotes to computer:

    ddctoddd@Maverick-Image:~$ cd ~/home/proj/
    ddctoddd@Maverick-Image:~/home/proj$ git clone git@github.com:todddeluca/technotes.git

## Add scripts-analytics build scripts to path

See the README in build-analytics for more details.

```
cd ~/git/scripts-analytics/build-analytics
pip install -e .
```

## Install vsql command line

[todo] install vsql, the vertica command line utility
[done] Downloaded, moved dir under /usr/local/opt, and added the bin dir to my path

[9:21 AM] Matt Bologna: You're gonna want to install vsql (vertica command line utility):  http://myverticablog.com/post/39762912038/how-to-install-vsql-on-mac-os-x

Download client tarball from https://s3.amazonaws.com/myverticablog/vertica-client-6.1.0-0.mac.tar.gz

```
cd ~/tmp
rm -rf opt # tarball upacks here.
curl https://s3.amazonaws.com/myverticablog/vertica-client-6.1.0-0.mac.tar.gz | tar xvz
```

Move vertica files to /usr/local/opt:

    mv ~/tmp/opt/vertica /usr/local/opt/.

## Other



[todo] Install grails version 2.0.3
[done]
Matt Bologna: You probably won't have an immediate use for Grails (we don't do a ton of work in that space), but I would go ahead and install Grails version 2.0.3.  Instructions for doing so via homebrew are here:
http://blog.jdriven.com/2012/09/quick-tip-installing-a-specific-grails-version-on-os-x-using-homebrew/

See/get the version of the homebrew repo containing the version of grails I want:

    $ brew versions grails
    2.1.0    git checkout 0dcf6e7 /usr/local/Library/Formula/grails.rb
    2.0.4    git checkout 624e065 /usr/local/Library/Formula/grails.rb
    2.0.3    git checkout af73ab0 /usr/local/Library/Formula/grails.rb
    2.0.2    git checkout 1015eda /usr/local/Library/Formula/grails.rb
    2.0.1    git checkout 97e8e5a /usr/local/Library/Formula/grails.rb

Install grails version 2.0.3:

    cd `brew --prefix` # go to the homebrew repository
    git checkout af73ab0 /usr/local/Library/Formula/grails.rb
    brew install grails  # installs the old formula we just checked out
    git checkout -- Library/Formula/grails.rb  # revert the formula to the latest

Add GRAILS_HOME to my environment:

    echo 'export GRAILS_HOME=/usr/local/Cellar/grails/2.0.3/libexec' >> ~/.bashrc


In the future, Homebrew says to tap the versions repo to get older versions,
since the `brew versions` command is going away.  However, the grails20 version
is actually 2.0.4.  So the future way to install an older grails version will
look like:

    $ brew tap homebrew/versions
    $ brew search grails
    grails	  grails13  grails20  grails21	grails22
    $ brew install grails20


[todo] install Groovy version 2.3.x
[done] via homebrew
Matt Bologna: Also, install the latest 2.3.x release of Groovy

Confirm that 2.3.x is the latest version:
    brew info groovy

Install Groovy:

    brew install groovy

Add GROOVY_HOME to the environment:

    echo 'export GROOVY_HOME=/usr/local/opt/groovy/libexec' >> ~/.bashrc


[todo] install scala version 2.10.4
[done]
Matt Bologna: For scala, install version 2.10.4 (you can do this via homebrew as well)

Find formula for version 2.10.4, using info to confirm that scala210 is 2.10.4

    brew search scala
    brew info scala210

Install scala

    brew install scala210

Following the homebrew caveats, set SCALA_HOME for IntelliJ:

    echo 'export SCALA_HOME=/usr/local/opt/scala210/idea' >> ~/.bashrc

Do I need to set the SBT_OPTS env var, as described here:
http://catchthrowable.blogspot.com/2013/01/scala-on-osx-mountain-lion-and-intellij.html


[todo] Clone build scripts
[done]

# Clone the build module
mkdir ~/git
cd ~/git
git clone gitolite@git.dealer.ddc:build.git

# Add it to the path
echo "# Adding build module to the path (first)" >> ~/.bashrc
echo 'export PATH=$HOME/git/build/bin:$PATH' >> ~/.bashrc


[todo] install and configure maven
[done]

To install Maven using Homebrew, follow these steps:

Open up a new terminal window and enter:

    brew install maven

Run Maven to create the local Maven cache (~/.m2):

    mvn    # Note that it is okay to see Maven report an error.

If you have not already done so, check out the build project from Git.

Create a symbolic link to the settings.xml file in the build project:

    cd ~/.m2
    ln -s ~/git/build/settings-artifactory.xml settings.xml

It is also recommended that you set a MAVEN_OPTS and JAVA_HOME environment variable:

Export default maven opts

    echo 'export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=768m"' >> ~/.bashrc

  Export java 7 as the default JAVA_HOME:

echo "export JAVA_HOME=`/usr/libexec/java_home --version 1.7`" >> ~/.bashrc

    source ~/.bashrc

[todo][tech] Download and install sourcetree for visualizing git trees, commit messages, changes, etc.
[done]

http://sourcetreeapp.com/


Install Grails 2.0.3:

From https://grails.org/download, download http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-2.0.3.zip
Extract to /opt/grails-2.0.3:

    curl -O http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-2.0.3.zip
    unzip -d /opt grails-2.0.3.zip
    rm -f grails-2.0.3.zip

Set your `GRAILS_HOME` environment variable to point at `/opt/grails-2.0.3`.
Add `$GRAILS_HOME/bin` to your `PATH` environment variable.

    echo 'export GRAILS_HOME=/opt/grails-2.0.3' >> ~/.bashrc
    echo 'export PATH="$PATH:$GRAILS_HOME/bin"' >> ~/.bashrc



Create a symbolic link from the Apache2 configuration folder to the local CC7 Apache configuration found in the build project:

sudo ln -s $HOME/git/build/cc7-local-httpd.conf /etc/apache2/other/cc7-local-httpd.conf

Restart the Apache2 server:

sudo /usr/sbin/apachectl restart


Create a symbol link from the Grails metadata folder to the default `settings.groovy` file found in the `build` project:

mkdir -p ~/.grails
ln -s $HOME/git/build/settings.groovy ~/.grails/settings.groovy


[tech] Install Postman app in Chrome
It can be used to interact with REST APIs more easily.
In Chrome, go to chrome://apps/, choose "Store", search for "Postman" and install the Postman - Rest Client by rickreation.


[tech] install tomcat to get adw-reporting-services running in IntelliJ.

brew update
brew install tomcat6
In IntelliJ, edit application configuration for a tomcat server.
TOMCAT_HOME is /usr/local/Cellar/tomcat6/6.0.41/libexec


Install siege for load testing

brew install siege
# decrease the port wait time for siege
sysctl net.inet.tcp.msl
# net.inet.tcp.msl: 15000
sudo sysctl -w net.inet.tcp.msl=1000


Install SASS:

    gem install sass

Install Compass for sass compilation in cc-analytics:

    gem install compass


Remoteconfig, remote_config, remote config Configuration:

Install java cryptography extension package to Java 7 runtime:

cd ~/git/build/bin
install-jce

Copy dev /etc/remote_config to localhost, as /etc/remote_config_dev:

```
ssh vtdevana-pixall01
cd /etc
sudo rm -f remote_config_dev.tar.gz
sudo tar cvfz remote_config_dev.tar.gz remote_config
sudo mv remote_config_dev.tar.gz ~
exit
# on laptop
cd ~/tmp
sudo rm -rf remote_config*
scp vtdevana-pixall01:remote_config_dev.tar.gz .
tar xvzf remote_config_dev.tar.gz
# move to /etc and fix permissions
sudo mv remote_config /etc/remote_config_dev
sudo chown -R root:wheel /etc/remote_config_dev
sudo chmod 755 /etc/remote_config_dev
sudo chmod 644 /etc/remote_config_dev/*
```

Add "live" remote config credentials to my local box (after archiving them on wcana-pixall01)

```
ssh la1ana-pixall01
cd /etc
sudo rm -f remote_config_live.tar.gz
sudo tar cvfz remote_config_live.tar.gz remote_config
sudo mv remote_config_live.tar.gz ~
exit
# on laptop
cd ~/tmp
sudo rm -rf remote_config*
scp la1ana-pixall01:remote_config_live.tar.gz .
tar xvzf remote_config_live.tar.gz
# move to /etc and fix permissions
sudo mv remote_config /etc/remote_config_live
sudo chown -R root:wheel /etc/remote_config_live
sudo chmod 755 /etc/remote_config_live
sudo chmod 644 /etc/remote_config_live/*
```

Copy QA /etc/remote_config to localhost, as /etc/remote_config_qa:

```
ssh vtqaana-pixall01
cd /etc
sudo rm -f remote_config_qa.tar.gz
sudo tar cvfz remote_config_qa.tar.gz remote_config
sudo mv remote_config_qa.tar.gz ~
exit
# on laptop
cd ~/tmp
sudo rm -rf remote_config*
scp vtqaana-pixall01:remote_config_qa.tar.gz .
tar xvzf remote_config_qa.tar.gz
# move to /etc and fix permissions
sudo mv remote_config /etc/remote_config_qa
sudo chown -R root:wheel /etc/remote_config_qa
sudo chmod 755 /etc/remote_config_qa
sudo chmod 644 /etc/remote_config_qa/*
```

Select 'dev' remote config as the default:

```
cd /etc
sudo rm -rf remote_config
sudo cp -pr remote_config_dev remote_config
```
