# Vagrant specific
date > /etc/vagrant_box_build_time

# Add vagrant user
/usr/sbin/groupadd vagrant
/usr/sbin/useradd vagrant -g vagrant -G wheel
echo "vagrant"|passwd --stdin vagrant
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
echo 'Defaults !secure_path' >> /etc/sudoers.d/vagrant
echo 'Defaults    env_keep += "SSH_AUTH_SOCK"' >> /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Installing vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Customize the message of the day
echo 'Built by Vagrant (see vagrantup.com)' > /etc/motd

# Putting /usr/local/bin on the path for everyone so that the vagrant provisioning
# can find all tools we install.
echo "pathmunge /usr/local/bin" >> /etc/profile.d/path.sh

# Put the zerodisk.sh script on disk for root so future boxes can trim the VM snapshot size as well.
sudo cp /home/veewee/zerodisk.sh  /usr/local/bin
