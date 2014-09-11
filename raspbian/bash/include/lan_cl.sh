#!/bin/bash
##-------------------------------------

. ./vars.sh

function setupWiFiClient {
    echo "$(tput setaf 6)[+] Setup WiFi lan client... $(tput sgr 0)"
    echo "$(tput setaf 7)[+] Down wlan0 before configure card settings... $(tput sgr 0)"
    ifdown wlan0

    echo "$(tput setaf 7)[+] Setting up your lan cards -> /etc/network/interfaces ... $(tput sgr 0)"
    echo "$(tput setaf 1)[+] Replacing config by version from repo!!! $(tput sgr 0)"
    cat ./etc/network/interfaces.ap > /etc/network/interfaces

    echo "$(tput setaf 7)[+] All done up wlan0... $(tput sgr 0)"
    ifup wlan0
    return ${RETOK}
}
