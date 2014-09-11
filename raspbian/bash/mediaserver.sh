#!/bin/bash

function setupMediaServer {
    echo "$(tput setaf 5)[+] Setup mediaserver... $(tput sgr 0)"

    ##-------------------------------------
    echo "$(tput setaf 6)[+] Configure automount usb sticks... $(tput sgr 0)"
    echo "$(tput setaf 6)[+] Install soft... $(tput sgr 0)"
    apt-get install -y ntfs-3g usbmount

    #TODO do backup /etc/usbmount/usbmount.conf
    #TODO prompt usb_sticks num
    echo "$(tput setaf 6)[+] Add utf-8... $(tput sgr 0)"
    echo "$(tput setaf 1)[+] Replacing config by version from repo!!! $(tput sgr 0)"
    cat ./etc/usbmount/usbmount.conf > /etc/usbmount/usbmount.conf

    ##-------------------------------------
    echo "$(tput setaf 6)[+] Install UPnP server... $(tput sgr 0)"
    apt-get instal -y minidlna

    #TODO add config editing, or copy current

    ##-------------------------------------
    echo "$(tput setaf 6)[+] Link usb automounts to minidlna default folders... $(tput sgr 0)"
    ln -s /media /var/lib/minidlna/media

    return 0
}