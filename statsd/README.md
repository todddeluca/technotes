


## Telnet Admin Interface

Documentation at 
https://github.com/etsy/statsd/blob/master/docs/admin_interface.md

Default port: 8126

Connect to the admin interface and play around:

    $ telnet vtdevana-sandbox01 8126
    Trying 10.12.17.235...
    Connected to vtdevana-sandbox01.srvr.office.vt.dealer.ddc.
    Escape character is '^]'.
    stats
    uptime: 22276
    messages.last_msg_seen: 3
    messages.bad_lines_seen: 0
    graphite.last_flush: 1
    graphite.last_exception: 22276
    graphite.flush_time: 2
    graphite.flush_length: 159402
    END
    quit
    Connection closed by foreign host.

