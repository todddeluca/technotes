
## Install Vagrant and Virtualbox

Download and install the latest version (4.2.10) of VirtualBox from
https://www.virtualbox.org/wiki/Downloads


Download and install the latest version of Vagrant from
http://www.vagrantup.com/
As of this writing that is version 1.1.1.

Create a Vagrantfile, download a "box", and bring it up to make sure it works:

    cd ~/tmp
    vagrant box add base http://files.vagrantup.com/precise64.box
    rm -f Vagrantfile
    vagrant init
    vagrant up
    vagrant destroy

In typical Vagrant style, this fails with an inscrutable error and no obvious
help on the internet.  The error:

    /Applications/Vagrant/embedded/gems/gems/vagrant-1.1.1/plugins/providers/virtualbox/action/prepare_nfs_settings.rb:16:in
    `call': uninitialized constant
    VagrantPlugins::ProviderVirtualBox::Action::PrepareNFSSettings::Errors
    (NameError)


