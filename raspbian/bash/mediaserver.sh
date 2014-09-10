#!/bin/bash

##-------------------------------------
echo "$(tput setaf 7)[+] Configure automount usb sticks... $(tput sgr 0)"
echo "$(tput setaf 7)[+] Install soft... $(tput sgr 0)"
apt-get install -y ntfs-3g usbmount

echo "$(tput setaf 7)[+] Add utf-8... $(tput sgr 0)"
echo "$(tput setaf 1)[+] Replacing config by version from repo!!! $(tput sgr 0)"
cat ./etc/usbmount/usbmount.conf > /etc/usbmount/usbmount.conf

##-------------------------------------
echo "$(tput setaf 7)[+] Install UPnP server... $(tput sgr 0)"
apt-get instal minidlna

#TODO add config editing, or copy current

##-------------------------------------
echo "$(tput setaf 7)[+] Link usb automounts to minidlna default folders... $(tput sgr 0)"
ln -s /media /var/lib/minidlna/media