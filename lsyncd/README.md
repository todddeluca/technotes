http://code.google.com/p/lsyncd/


Lsyncd - Live Syncing (Mirror) Daemon

# Description

Lsyncd watches a local directory trees event monitor interface (inotify or
fsevents). It aggregates and combines events for a few seconds and then spawns
one (or more) process(es) to synchronize the changes. By default this is rsync.
Lsyncd is thus a light-weight live mirror solution that is comparatively easy
to install not requiring new filesystems or blockdevices and does not hamper
local filesystem performance.

Rsync+ssh is an advanced action configuration that uses a SSH to act file and
directory moves directly on the target instead of retransmitting the move
destination over the wire.


