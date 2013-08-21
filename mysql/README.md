

# Links, Tutorials, Howtos, Etc.

http://theos.in/desktop-linux/tip-that-matters/how-do-i-restart-mysql-server/


# Installing and configuring mysql

Install on a yum based system, like Redhat or Amazon Linux AMI:

    sudo yum -y install mysql
    sudo yum -y install mysql-server
    sudo yum -y install mysql-devel

start mysqld and secure it:

    sudo service mysqld start
    sudo mysql_secure_installation


# Using Homebrew to install mysql

Install on Mac OS X 10.8 Mountain Lion:

    brew install mysql

# Create user with full privileges:

To avoid putting the password in the command, create a function to read it
in from the command line and then echo the `CREATE USER` and `GRANT` statements
to mysql.  This at least should keep the password out of the ~/.bash_history:
    
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


# Configuration 

## apache config on orchestra for apache virtualhost configuration to add mysql creds to environment.

    less /opt/apache/conf/auth/genotator.hms.harvard.edu


## How to create ~/.my.cnf file, so user can log in to mysql easily.

    echo '[client]
    host = localhost
    password = insecurepassword
    ' > ~/.my.cnf
    chmod 600 ~/.my.cnf

# create a database

From the command line:

    mysqladmin create ec2devgenotator

From mysql, create a test database:

    CREATE DATABASE test;


# create a user

Create ec2devgenoweb user (the user apache puts in the environment, configured later in the httpd.conf file.):

    echo 'CREATE USER "ec2devgenoweb"@"localhost" IDENTIFIED BY "insecurepassword";
    GRANT ALL ON ec2devgenotator.* TO "ec2devgenoweb"@"localhost";
    ' | mysql

Create a test user that has CRUD permissions for the test database, from localhost only:

    echo 'CREATE USER "testuser"@"localhost" IDENTIFIED BY "testpassword";
    GRANT ALL ON test.* TO "testuser"@"localhost";
    ' | mysql


# Log queries to a table

http://stackoverflow.com/questions/650238/how-to-show-the-last-queries-executed-on-mysql

This might be specific to MySQL >= 5.1.12:

Log queries to a table:

    SET GLOBAL log_output = 'TABLE';
    SET GLOBAL general_log = 'ON';

Take a look at the table mysql.general_log:

    SELECT * FROM mysql.general_log;


# Dumping and Loading a MySQL Database

On laptop, dump the localgenotator database

    mysqldump --host localhost localgenotator > ~/dev.mysql.cl_devgenotator_db_dump_current.sql

Copy to instance

    scp ~/dev.mysql.cl_devgenotator_db_dump_current.sql ec2-user@ec2.dev.genotator.hms.harvard.edu:.

On instance, load into mysql

    cat dev.mysql.cl_devgenotator_db_dump_current.sql | mysql ec2devgenotator



