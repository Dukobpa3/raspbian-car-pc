#!/bin/bash

#$(tput setaf 1) - Red - Warning
#$(tput setaf 2) - Green - ??
#$(tput setaf 3) - Yellow - Important info
#$(tput setaf 4) - Blue - ??
#$(tput setaf 5) - Magenta - ??
#$(tput setaf 6) - Cyan - Header
#$(tput setaf 7) - White - Info


SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
cd ${DIR}
echo ${DIR}
echo "$(pwd)"

. ./include/vars.sh
. ./lan.sh
. ./mediaserver.sh
. ./mediaplayer.sh

## WiFi type settings

while true; do
    read -p "Are you want to configure wifi as AP?(yes/no) " WIFI_TYPE
    case ${WIFI_TYPE} in
        [Yy]* )
            echo "Setting up as AP";
            WIFI_TYPE="1"
            break;;
        [Nn]* )
            echo "Setting up as client";
            WIFI_TYPE=2
            break;;
        * )
            echo "You are should input y/n, yes/no";
            break;;
    esac
done

setupWiFi ${WIFI_TYPE}
echo "setupWiFi result is: " $?

#setupMediaServer
#setupMediaPlayer

echo "$(tput setaf 6)[+] Reboot system... $(tput sgr 0)"
sudo reboot