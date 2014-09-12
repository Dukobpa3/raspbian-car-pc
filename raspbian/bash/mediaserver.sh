#!/bin/bash

function setupMediaServer {
    USB_NUM=$1
    echo "$(tput setaf 5)[+] Setup mediaserver... $(tput sgr 0)"

    ##-------------------------------------
    echo "$(tput setaf 6)[+] Configure automount usb sticks... $(tput sgr 0)"
    echo "$(tput setaf 6)[+] Install soft... $(tput sgr 0)"
    apt-get install -y ntfs-3g usbmount

    #TODO do backup /etc/usbmount/usbmount.conf
    echo "$(tput setaf 6)[+] Set usb mount points num... $(tput sgr 0)"

    #TODO stop usbmount
    rm -rf /media/usb*
    USB_LIST=$(seq -f "/media/usb%g" -s " " 0 $(echo ${USB_NUM}-1 | bc))
    sed -i "/MOUNTPOINTS=\".*/{N;s|MOUNTPOINTS=\".*\"|MOUNTPOINTS=\"$USB_LIST\"|g}" /etc/usbmount/usbmount.conf

    echo "$(tput setaf 6)[+] Add utf-8... $(tput sgr 0)"
    echo "$(tput setaf 1)[+] Replacing config by version from repo!!! $(tput sgr 0)"
    sed -i 's|#FS_MOUNTOPTIONS="|FS_MOUNTOPTIONS="|' /etc/usbmount/usbmount.conf
    #TODO do replace string instead config
    cat ./etc/usbmount/usbmount.conf > /etc/usbmount/usbmount.conf

    #TODO start usbmount

    ##-------------------------------------
    echo "$(tput setaf 6)[+] Install UPnP server... $(tput sgr 0)"
    apt-get instal -y minidlna

    #TODO add minidlna config editing, or copy current

    ##-------------------------------------
    echo "$(tput setaf 6)[+] Link usb automounts to minidlna default folders... $(tput sgr 0)"
    ln -s /media /var/lib/minidlna/media

    return 0
}