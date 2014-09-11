#!/bin/bash

. ./vars.sh

function setupWiFiAP {
    echo "$(tput setaf 6)[+] Setup Access Point... $(tput sgr 0)"

    ##-------------------------------------
    echo "$(tput setaf 7)[+] Installing AP software... $(tput sgr 0)"
    apt-get install -y hostapd isc-dhcp-server

    echo "$(tput setaf 7)[+] Configure dhcp -> /etc/dhcp/dhcpd.conf... $(tput sgr 0)"
    ## comment domain names
    sed -i 's/option domain-name/#option domain-name/' /etc/dhcp/dhcpd.conf
    sed -i 's/option domain-name-servers/#option domain-name-servers/' /etc/dhcp/dhcpd.conf
    ## uncomment autority option
    sed -i 's/#authoritative/authoritative/' /etc/dhcp/dhcpd.conf


    echo "Input AP name:"
    read AP_NAME
    echo "$(tput setaf 3)[+] Default connects num is 10 $(tput sgr 0)"

    echo "$(tput setaf 7)[+] add our AP settings -> /etc/dhcp/dhcpd.conf $(tput sgr 0)"
    echo "
    /etc/dhcp/dhcpd.conf ## add subnet settings after last line
    subnet 192.168.10.0 netmask 255.255.255.0 {
     range 192.168.10.10 192.168.10.20;
     option broadcast-address 192.168.10.255;
     option routers 192.168.10.1;
     default-lease-time 600;
     max-lease-time 7200;
     option domain-name "$AP_NAME";
     option domain-name-servers 8.8.8.8, 8.8.4.4;
    }" >> /etc/dhcp/dhcpd.conf


    echo "$(tput setaf 7)[+] set AP interface -> /etc/default/isc-dhcp-server $(tput sgr 0)"
    sed -i 's/#INTERFACES=""/INTERFACES="wlan0"/' /etc/default/isc-dhcp-server

    echo "$(tput setaf 7)[+] set path to default config -> /etc/default/hostapd $(tput sgr 0)"
    sed -i 's/#DAEMON_CONF=""/DAEMON_CONF="/etc/hostapd/hostapd.conf"/' /etc/default/hostapd


    echo "$(tput setaf 7)[+] Down wlan0 before configure card settings... $(tput sgr 0)"
    ifdown wlan0


    #/etc/network/interfaces ## modify
    #auto wlan0
    #allow-hotplug wlan0
    #iface wlan0 inet static
    # address 192.168.10.1
    # netmask 255.255.255.0
    echo "$(tput setaf 7)[+] Setting up your lan cards -> /etc/network/interfaces ... $(tput sgr 0)"
    echo "$(tput setaf 1)[+] Replacing config by version from repo!!! $(tput sgr 0)"
    cat ./etc/network/interfaces.ap > /etc/network/interfaces

    ##-------------------------------------
    ## Configuring HostAPD
    ## get from this repo kuz don't have default
    echo "$(tput setaf 7)[+] Configuring HostAPD -> /etc/hostapd/hostapd.conf ... $(tput sgr 0)"
    echo "$(tput setaf 1)[+] Replacing config by version from repo!!! $(tput sgr 0)"
    cat ./etc/hostapd/hostapd.conf > /etc/hostapd/hostapd.conf


    ##-------------------------------------
    echo "$(tput setaf 7)[+] Enable NAT... $(tput sgr 0)"

    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    echo 1 > /proc/sys/net/ipv4/ip_forward

    echo "$(tput setaf 7)[+] All done up wlan0... $(tput sgr 0)"
    ifup wlan0


    echo "$(tput setaf 7)[+] setting up the forwarding between eth0 and wlan0... $(tput sgr 0)"
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT


    ##-------------------------------------
    echo "$(tput setaf 7)[+] Starting your wireless router... $(tput sgr 0)"
    service isc-dhcp-server start
    service hostapd start

    ##-------------------------------------
    echo "$(tput setaf 7)[+] Finishing up... $(tput sgr 0)"
    echo "$(tput setaf 7)[+] add to startup... $(tput sgr 0)"
    update-rc.d hostapd enable
    update-rc.d isc-dhcp-server enable

    echo "$(tput setaf 7)[+] save NAT settings to file... $(tput sgr 0)"
    iptables-save > /etc/iptables.ipv4.nat

    echo "$(tput setaf 7)[+] restore NAT settings on reboot... $(tput sgr 0)"
    echo "up iptables-restore < /etc/iptables.ipv4.nat" >> /etc/network/interfaces

    return ${RETOK}
}