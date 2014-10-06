yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
rm -rf /etc/yum.repos.d/{puppetlabs,epel}.repo
rm -rf VBoxGuestAdditions_*.iso

# Networking cleanup.
# ln -sf /dev/null /lib/udev/rules.d/75-persistent-net-generator.rules
# rm -f /etc/udev/rules.d/70-persistent-net.rules

# On startup, remove HWADDR from the eth0 interface.
# cp -f /etc/sysconfig/network-scripts/ifcfg-eth0 /tmp/eth0
# sed "/^HWADDR/d" /tmp/eth0 > /etc/sysconfig/network-scripts/ifcfg-eth0
# sed -e "s/dhcp/none/;s/eth0/eth1/" /etc/sysconfig/network-scripts/ifcfg-eth0 > /etc/sysconfig/network-scripts/ifcfg-eth1

# Prevent way too much CPU usage in VirtualBox by disabling APIC.
# sed -e 's/\tkernel.*/& noapic/' /boot/grub/grub.conf > /tmp/new_grub.conf
# mv /boot/grub/grub.conf /boot/grub/grub.conf.bak
# mv /tmp/new_grub.conf /boot/grub/grub.conf

# Get rid of veewee artifacts.
umount veewee-validation

# Remove the humongous, memory-mapped locale-archive, leaving only en_US
localedef --list-archive | grep -v -e "en_US" | xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive
