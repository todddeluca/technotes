## USEFUL APACHE COMMANDS

start apache and see if it is working:

    sudo find / -type f -name apachectl
    sudo /usr/sbin/apachectl start
    curl http://localhost
    sudo /usr/sbin/apachectl stop

apache docroot: /var/www/html

what apache2 modules are installed?

    sudo /usr/sbin/apachectl -M

what version of apache is installed?

    sudo /usr/sbin/apachectl -v

Output:

    Server version: Apache/2.2.16 (Unix)
    Server built:   Jan 16 2011 12:22:02

Restart server so httpd.conf changes take effect

    sudo service httpd restart

Test that it works:

    curl http://ec2-23-21-160-23.compute-1.amazonaws.com/index.py

Change logging level in /etc/httpd/conf/httpd.conf by using this line:

    LogLevel info


## CONFIGURE APACHE FOR MULTIPLE VIRTUAL HOSTS

Backup httpd.conf

    cd ~/proj/ec2config && rsync -avz ec2-user@ec2-23-21-160-23.compute-1.amazonaws.com:/etc/httpd/conf/httpd.conf httpd.conf

Send a fresh copy up to the instance

    cd ~/proj/ec2config && time scp -vp httpd.conf ec2-user@ec2-23-21-160-23.compute-1.amazonaws.com:.

Now log in to the instance:

    sshe 

Copy config file to the right location

    sudo cp httpd.conf /etc/httpd/conf/httpd.conf


## PHUSION PASSENGER CONFIGURATION

    echo '
    # Phusion Passenger Configuration
    LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-3.0.11/ext/apache2/mod_passenger.so
    PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-3.0.11
    PassengerRuby /usr/bin/ruby
    ' | sudo tee --append /etc/httpd/conf/httpd.conf


## ALLOW MULTIPLE VIRTUAL HOSTS ON THE SAME IP ADDRESS.  

See http://httpd.apache.org/docs/2.0/vhosts/examples.html#purename

    echo '
    # ALLOW MULTIPLE VIRTUAL HOSTS ON THE SAME IP ADDRESS
    NameVirtualHost *:80
    ' | sudo tee --append /etc/httpd/conf/httpd.conf


## CONFIGURE VIRTUAL HOSTS 

Configure the hosts to redirect domain.com to www.domain.com and to tell
passenger where its files are.

    echo '
    # heyluca.com configuration
    <VirtualHost *:80>
        ServerName www.heyluca.com
        ServerAdmin webmaster@heyluca.com
        # redirect domain.com to www.domain.com
        ServerAlias heyluca.com
        RewriteEngine On
        RewriteCond %{HTTP_HOST} ^heyluca\.com
        RewriteCond %{REQUEST_URI} -d
        RewriteRule .* http://www.heyluca.com%{REQUEST_URI} [L,R=301]
        # passenger config
        # be sure to point to public dir!
        DocumentRoot /www/heyluca.com/webapp/public
        <Directory /www/heyluca.com/webapp/public>
            # relax Apache security settings
            AllowOverride all
            # MultiViews must be turned off
            Options -MultiViews            
        </Directory>
    </VirtualHost>

    # todddeluca.com configuration
    <VirtualHost *:80>
        ServerName www.todddeluca.com
        ServerAdmin webmaster@todddeluca.com
        # redirect domain.com to www.domain.com
        ServerAlias todddeluca.com
        RewriteEngine On
        RewriteCond %{HTTP_HOST} ^todddeluca\.com
        RewriteCond %{REQUEST_URI} -d
        RewriteRule .* http://www.todddeluca.com%{REQUEST_URI} [L,R=301]
        # passenger config
        # be sure to point to public dir!
        DocumentRoot /www/todddeluca.com/webapp/public
        <Directory /www/todddeluca.com/webapp/public>
            # relax Apache security settings
            AllowOverride all
            # MultiViews must be turned off
            Options -MultiViews            
        </Directory>
    </VirtualHost>
    ' | sudo tee --append /etc/httpd/conf/httpd.conf

Restart server so httpd.conf changes take effect

    sudo service httpd restart



