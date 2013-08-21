

# CONFIGURE MONIT TO MONITOR APACHE

http://www.cyberciti.biz/tips/howto-monitor-and-restart-linux-unix-service.html

http://mmonit.com/monit/documentation/monit.html#monit_httpd
Note: you must start a Monit daemon with http support if you want to be able to
use most of the available console commands. I.e. 'Monit stop all', 'Monit start
all' etc.

On ec2 server, default monit config file is /etc/monit.conf and /etc/monit.d/logging
and by default it monitors every 60 seconds and loads extra config in 
/etc/monit.d/* and logs to /var/log/monit.

/etc/monit.d/general.conf
Configure monit daemon to use http server and accept connections only from
local host.  This enables monit cli functionality.

    set httpd port 2812
      allow localhost

Contents of monit.d/emailing.conf which configures how monit emails

    set mailserver localhost
    set alert todddeluca@gmail.com

Contents of monit.d/apache, which configures monitoring apache httpd

    check process httpd with pidfile /var/run/httpd/httpd.pid
      group apache
      start program = "/etc/init.d/httpd start"
      stop program = "/etc/init.d/httpd stop"
      if failed host 127.0.0.1 port 80
        protocol http then restart
      if 5 restarts within 5 cycles then timeout

Make a place to copy the configuration files on instance

    mkdir ~/tmp

Copy monit config to ec2

    rsync -avz ~/proj/ec2webserver/monit.d ec2-user@ec2-23-21-160-23.compute-1.amazonaws.com:tmp/.

On instance, copy config to right location

    sudo cp ~/tmp/monit.d/* /etc/monit.d/

Restart monit

    sudo service monit restart

Bring down apache to test if monit will restart it.

    sudo service httpd stop

Monitor the monit log

    sudo tail -f /var/log/monit

It works!  At least in this case.  It restarted apache and emailed me about the failure and restart.

    [UTC Feb 27 18:14:56] info     : monit: generated unique Monit id e69755e20e67e9610dddd0da6a891a1c and stored to '/root/.monit.id'
    [UTC Feb 27 18:14:56] info     : 'system_ip-10-212-130-122.ec2.internal' Monit started
    [UTC Feb 27 18:18:57] error    : 'httpd' process is not running
    [UTC Feb 27 18:18:57] info     : 'httpd' trying to restart
    [UTC Feb 27 18:18:57] info     : 'httpd' start: /etc/init.d/httpd


