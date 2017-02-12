#!/bin/bash
set -e

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm -f /var/lib/dhcp/*

# Make sure Udev doesn't block our network
echo "cleaning up udev rules"
rm -f /etc/udev/rules.d/70-persistent-net.rules
mkdir -p /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces
