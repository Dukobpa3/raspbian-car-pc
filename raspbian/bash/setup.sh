#!/bin/bash

##-------------------------------------
## automount usb sticks
apt-get install ntfs-3g
apt-get install usbmount

##-------------------------------------
## UPnP server
apt-get instal minidlna

##-------------------------------------
## Link usb automounts to minidlna default folders
ln -s /media /var/lib/minidlna/media


##-------------------------------------
##-------------------------------------
##-------------------------------------
## Install the router software

# WiFi access point
apt-get install hostapd
apt-get install isc-dhcp-server

##-------------------------------------
## Configure the ISC-DHCP-Server

/etc/dhcp/dhcpd.conf ## comment
option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;

/etc/dhcp/dhcpd.conf ## uncomment
authoritative;

/etc/dhcp/dhcpd.conf ## add subnet settings after last line
subnet 192.168.10.0 netmask 255.255.255.0 {
 range 192.168.10.10 192.168.10.20;
 option broadcast-address 192.168.10.255;
 option routers 192.168.10.1;
 default-lease-time 600;
 max-lease-time 7200;
 option domain-name "local-network";
 option domain-name-servers 8.8.8.8, 8.8.4.4;
}


/etc/default/isc-dhcp-server ## set AP interface
INTERFACES="wlan0"


/etc/default/hostapd ## set set path to default config
DAEMON_CONF="/etc/hostapd/hostapd.conf"


sudo ifdown wlan0 ## down wlan0


/etc/network/interfaces ## modify
auto wlan0
allow-hotplug wlan0
iface wlan0 inet static
 address 192.168.10.1
 netmask 255.255.255.0


##-------------------------------------
## Configuring HostAPD
/etc/hostapd/hostapd.conf ## get from this repo kuz don't have default

##-------------------------------------
## Enable NAT

/etc/sysctl.conf ## add last line
net.ipv4.ip_forward=1


sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo ifup wlan0


## setting up the actual translation between the ethernet port called eth0 and the wireless card called wlan0.
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT


##-------------------------------------
## Starting your wireless router
sudo service isc-dhcp-server start
sudo service hostapd start

##-------------------------------------
## Finishing up …

## add to startup
sudo update-rc.d hostapd enable
sudo update-rc.d isc-dhcp-server enable

## save NAT settings to file
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

## restore NAT settings on reboot
/etc/network/interfaces
up iptables-restore < /etc/iptables.ipv4.nat

## reboot after all
sudo reboot