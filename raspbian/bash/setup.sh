#!/bin/bash

#$(tput setaf 1) - Red - Warning
#$(tput setaf 2) - Green - ??
#$(tput setaf 3) - Yellow - Important info
#$(tput setaf 4) - Blue - ??
#$(tput setaf 5) - Magenta - ??
#$(tput setaf 6) - Cyan - Header
#$(tput setaf 7) - White - Info


# Absolute path to this script
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in
SCRIPTPATH=$(dirname "$SCRIPT")

DIRNAME="$( dirname "$0" )"
cd "${DIRNAME}"

declare RETOK = 0
declare RETERR = 1
declare WIFI_TYPE

setupWiFiAP() {
    echo "$(tput setaf 6)[+] Setup Access Point... $(tput sgr 0)"
    source ${DIRNAME}/lan_ap.sh
    return ${RETOK}
}

setupWiFiClient() {
    echo "$(tput setaf 6)[+] Setup WiFi lan client... $(tput sgr 0)"
    source ${DIRNAME}/lan_cl.sh
    return ${RETOK}
}

setupWiFi() {
    echo "Are you want to configure wifi as AP - 1; as client - 2: "
    input WIFI_TYPE
    case ${WIFI_TYPE} in
        1)
        setupWiFiAP
        return $?
        ;;
        2)
        setupWiFiClient
        return $?
        ;;
        *)
        echo "You should enter 1 or 2"
        setupWiFi
        return $?
    esac
    return ${RETERR};
}

setupMediaServer() {
    echo "$(tput setaf 6)[+] Setup mediaserver... $(tput sgr 0)"
    source ${DIRNAME}/mediaserver.sh
}


setupMediaPlayer() {
    echo "$(tput setaf 6)[+] Setup mediaplayer... $(tput sgr 0)"
    source ${DIRNAME}/mediaplayer.sh
}

setupWiFi
setupMediaServer
setupMediaPlayer


echo "$(tput setaf 6)[+] Reboot system... $(tput sgr 0)"
sudo reboot