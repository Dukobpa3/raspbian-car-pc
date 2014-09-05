#!/bin/bash

sudo su
apt-get instal minidlna
apt-get install ntfs-3g
apt-get install usbmount

ln -s /media /var/lib/minidlna/media