#!/bin/bash

#
# Install  VirtualBox Guest Additions pre-reqs.
sudo yum -y install gcc make kernel-devel-`uname -r` perl
#
# Ruby infrastructure taken care of by rvm.
#
# Install additional, helpful packages
sudo yum -y install unzip wget

#
# Install Vagrant provisioners
#
# Installing ruby with RVM
curl -L https://get.rvm.io | sudo bash -s stable --ruby=1.9.3 --gems=chef,puppet

#
# Installing vagrant ssh keys
#
mkdir -pm 700 /home/vagrant/.ssh
curl --insecure --output /home/vagrant/.ssh/authorized_keys 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

#
# Install VirtualBox Guest Additions
#
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
sudo mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run --nox11
sudo umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso

#
#	Reboot to ensure all changes take effect (particularly vbox kernel updates)
#
sudo shutdown -r now
