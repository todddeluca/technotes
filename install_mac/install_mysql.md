
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

