#!/bin/bash
set -e

# Bail if we are not running inside VirtualBox.
if [[ `facter virtual` != "virtualbox" && `facter boardproductname` != "VirtualBox" ]]; then
    echo "not running under virtualbox (`facter virtual` / `facter boardproductname`)"
    exit 0
fi

mkdir -p /mnt/virtualbox
mount -o loop /home/vagrant/VBoxGuest*.iso /mnt/virtualbox
/mnt/virtualbox/VBoxLinuxAdditions.run || true
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
umount /mnt/virtualbox
rm -rf /home/vagrant/VBoxGuest*.iso
