#!/bin/bash


#$(tput setaf 1) - Red - Warning
#$(tput setaf 2) - Green - ??
#$(tput setaf 3) - Yellow - Important info
#$(tput setaf 4) - Blue - ??
#$(tput setaf 5) - Magenta - ??
#$(tput setaf 6) - Cyan - Header
#$(tput setaf 7) - White - Info

RETVAL = 0

setupWiFiAP() {
    echo "$(tput setaf 6)[+] Setup Access Point... $(tput sgr 0)"
    . ./lan_ap.sh
    return $RETVAL
}

setupWiFiClient() {
    echo "$(tput setaf 6)[+] Setup WiFi lan client... $(tput sgr 0)"
    . ./lan_cl.sh
    return $RETVAL
}

setupWiFi() {
    echo "Are you want to configure wifi as AP - 1; as client - 2: "
    input WIFI_TYPE
    case $WIFI_TYPE in
        1)
        return setupWiFiAP
        ;;
        2)
        return setupWiFiClient
        ;;
        *)
        echo "You should enter 1 or 2"
        return setupWiFi
    esac
    return 1;
}

setupMediaServer() {
    echo "$(tput setaf 6)[+] Setup mediaserver... $(tput sgr 0)"
    . ./mediaserver.sh
}


setupMediaPlayer() {
    echo "$(tput setaf 6)[+] Setup mediaplayer... $(tput sgr 0)"
    . ./mediaplayer.sh
}

setupWiFi
setupMediaServer
setupMediaPlayer


echo "$(tput setaf 6)[+] Reboot system... $(tput sgr 0)"
sudo reboot