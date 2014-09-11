#!/bin/bash
##-------------------------------------

function setupWiFiClient {
    echo "$(tput setaf 5)[+] Setup WiFi lan client... $(tput sgr 0)"
    echo "$(tput setaf 6)[+] Down wlan0 before configure card settings... $(tput sgr 0)"
    ifdown wlan0

    echo "$(tput setaf 6)[+] Setting up your lan cards -> /etc/network/interfaces ... $(tput sgr 0)"
    echo "$(tput setaf 1)[+] Replacing config by version from repo!!! $(tput sgr 0)"
    cat ./etc/network/interfaces.ap > /etc/network/interfaces

    echo "$(tput setaf 6)[+] All done up wlan0... $(tput sgr 0)"
    ifup wlan0
    return "0"
}
