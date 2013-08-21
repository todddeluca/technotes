

## PHUSION PASSENGER INSTALLATION AND APACHE CONFIGURATION

http://www.modrails.com/install.html

Install passenger dependencies:

    # install gnu c++
    sudo yum -y install gcc-c++
    # install Curl development headers with SSL support
    sudo yum -y install libcurl-devel
    # install Zlib development headers
    sudo yum -y install zlib-static
    # install Ruby development headers
    sudo yum -y install ruby-devel
    # install RubyGems
    sudo yum -y install rubygems
    # install Rake
    sudo gem install rake
    # install rack
    sudo gem install rack

Install passenger:

    sudo gem install passenger
    # interactive installer of apache2 passenger module
    sudo passenger-install-apache2-module

The interactive installer says the following:

    Please edit your Apache configuration file, and add these lines:
      LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-3.0.11/ext/apache2/mod_passenger.so
      PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-3.0.11
      PassengerRuby /usr/bin/ruby

It also says:

    Suppose you have a Rails application in /somewhere. Add a virtual host to your
    Apache configuration file and set its DocumentRoot to /somewhere/public:
      <VirtualHost *:80>
          ServerName www.yourhost.com
          DocumentRoot /somewhere/public    # <-- be sure to point to 'public'!
          <Directory /somewhere/public>
            AllowOverride all              # <-- relax Apache security settings
            Options -MultiViews            # <-- MultiViews must be turned off
          </Directory>
      </VirtualHost>



