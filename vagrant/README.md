## Install Vagrant

Instructions and Tutorials:

- http://unfoldthat.com/2011/05/06/using-vagrant-for-your-django-development.html
- http://vagrantup.com/v1/docs/getting-started/index.html

### Step 1: Install Oracle VM VirtualBox

Go to https://www.virtualbox.org/wiki/Downloads and download and install VirtualBox for Mac OS X.  Done.  Sort of...

### Step 2: Download and install Vagrant

Go to http://www.vagrantup.com/downloads and download and install Vagrant for Mac OS X.  Done.

### Step 3: Follow the Getting Started Instructions

http://docs.vagrantup.com/v2/getting-started/index.html

Create a directory, download a box, start a Vagrantfile:

    mkdir -p ~/tmp/vagrant
    cd !$
    vagrant box add trusty64 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
    vagrant init trusty64
    vagrant up
    vagrant destroy

Run the box a watch the fail!

    td23@todd-mac:~/tech/vagrant/vagrant_guide$ vagrant up
    [default] Importing base box 'lucid64'...
    [default] The guest additions on this VM do not match the install version of
    VirtualBox! This may cause things such as forwarded ports, shared
    folders, and more to not work properly. If any of those things fail on
    this machine, please update the guest additions and repackage the
    box.

    Guest Additions Version: 4.1.14
    VirtualBox Version: 4.1.16
    [default] Matching MAC address for NAT networking...
    [default] Clearing any previously set forwarded ports...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] Creating shared folders metadata...
    [default] Clearing any previously set network interfaces...
    [default] Booting VM...
    [default] Waiting for VM to boot. This can take a few minutes.
    The VM failed to remain in the "running" state while attempting to boot.
    This is normally caused by a misconfiguration or host system incompatibilities.
    Please open the VirtualBox GUI and attempt to boot the virtual machine
    manually to get a more informative error message.

#### Follow a deadend to fix the problem.  Hint: it is not the VirtualBox version.

Uninstall VirtualBox 4.1.16.  Open VirtualBox-4.1.16-78094-OSX.dmg and ran the uninstall tool.
Install VirtualBox 4.1.14.  Go to https://www.virtualbox.org/wiki/Download_Old_Builds_4_1 and run the installer for 4.1.14.
This fixes the 'guest additions' warning above, but `vagrant up` still fails.

Still getting the error.  Vagrant tells me to start the vm from the virtualbox
GUI.  VirtualBox gives me this error:

    Failed to load VMMR0.r0 (VERR_SUPLIB_OWNER_NOT_ROOT).

Googling for "virtualbox error verr_suplib_owner_not_root", I find https://www.virtualbox.org/ticket/7889 with this comment:

> Finally after examining Virtual Box log files i saw that it complains that
> /Applications folder is not owned by root... a "sudo chown root
> /Applications" fixes the problem

After googling for the location of virtualbox log files, I take a look at the logs:

    cat ~/VirtualBox\ VMs/vagrant_guide_1338561830/Logs/VBox.log
    VirtualBox 4.1.14 r77440 darwin.x86 (Apr 12 2012 18:38:55) release log
    00:00:02.864 Log opened 2012-06-01T14:44:34.692265000Z
    00:00:02.864 OS Product: Darwin
    00:00:02.864 OS Release: 10.8.0
    00:00:02.864 OS Version: Darwin Kernel Version 10.8.0: Tue Jun  7 16:33:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386
    00:00:02.867 DMI Product Name: MacBookPro7,1
    00:00:02.869 DMI Product Version: 1.0
    00:00:02.870 Host RAM: 8192MB RAM, available: 1781MB
    00:00:02.870 Executable: /Applications/VirtualBox.app/Contents/MacOS/../Resources/VirtualBoxVM.app/Contents/MacOS/VirtualBoxVM
    00:00:02.870 Process ID: 22071
    00:00:02.870 Package type: DARWIN_32BITS_GENERIC
    00:00:02.870 Installed Extension Packs:
    00:00:02.870   None installed!
    00:00:02.880 pdmR3LoadR0U: pszName="VMMR0.r0" rc=VERR_SUPLIB_OWNER_NOT_ROOT szErr="The owner is not root: '/Applications'"
    00:00:02.880 VMSetError: /Users/vbox/tinderbox/4.1-mac-rel/src/VBox/VMM/VMMR3/VM.cpp(591) int vmR3CreateU(UVM*, uint32_t, int (*)(VM*, void*), void*); rc=VERR_SUPLIB_OWNER_NOT_ROOT
    00:00:02.880 VMSetError: Failed to load VMMR0.r0
    00:00:02.881 ERROR [COM]: aRC=NS_ERROR_FAILURE (0x80004005) aIID={1968b7d3-e3bf-4ceb-99e0-cb7c913317bb} aComponent={Console} aText={Failed to load VMMR0.r0 (VERR_SUPLIB_OWNER_NOT_ROOT)}, preserve=false
    00:00:02.885 Power up failed (vrc=VERR_SUPLIB_OWNER_NOT_ROOT, rc=NS_ERROR_FAILURE (0X80004005))

VirtualBox is indeed complaining about the owner of /Applications.  Who owns it?

    ls -ld /Applications
    drwxrwxr-x  79 td23  staff  2686 Jun  1 10:42 /Applications/

Change it to root and try to start the vm again:

    sudo chown root /Applications
    vagrant up

Another error.  Check the log files again and goole for the next error,
"virtualbox error VERR_SUPLIB_WRITE_NON_SYS_GROUP".  Check out this solution at http://www.westwideweb.com/wp/2011/08/31/virtualbox-4-1-2-os/

    sudo chmod g-w /Applications

Continue to follow instructions at
http://vagrantup.com/v1/docs/getting-started/index.html.  Everything works
fine.  Yay!
