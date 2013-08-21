

## CONFIGURE CRON TO MONITOR HEYLUCA.COM

On instance, setup cron to run a curl job that will send me an email if the
website goes down.

    echo '
    # configure where cron sends mail
    MAILTO=todddeluca@gmail.com
    # make sure the ec2 instance is serving todddeluca.com
    * * * * * curl -s -S http://www.todddeluca.com > /dev/null
    ' >> ~/.crontab
    crontab ~/.crontab

Test that the cronjob will notice a down website

    sudo service httpd stop
    # wait for an minute
    sleep 60
    sudo service httpd start
    


