#!/bin/bash

#$(tput setaf 1) - Red - Warning
#$(tput setaf 2) - Green - Prompt
#$(tput setaf 3) - Yellow - Important info
#$(tput setaf 4) - Blue - ??
#$(tput setaf 5) - Magenta - Header
#$(tput setaf 6) - Cyan - Info
#$(tput setaf 7) - White - ??


SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
cd ${DIR}
echo ${DIR}
echo "$(pwd)"

. ./include/vars.sh
. ./mediaserver.sh
. ./mediaplayer.sh

#TODO check module wlan0 is present. Skip lan settings if not.
. ./lan.sh
while true; do
    read -p "$(tput setaf 2)Are you want to configure wifi as AP?(yes/no): $(tput sgr 0)" WIFI_TYPE
    case ${WIFI_TYPE} in
        [Yy]* )
            echo "$(tput setaf 6)Setting up as AP $(tput sgr 0)";
            WIFI_TYPE="1"
            break;;
        [Nn]* )
            echo "$(tput setaf 6)Setting up as client $(tput sgr 0)";
            WIFI_TYPE=2
            break;;
        * )
            echo "$(tput setaf 1)You are should input y/n, yes/no $(tput sgr 0)";
            break;;
    esac
done

setupWiFi ${WIFI_TYPE}
echo "$(tput setaf 6)setupWiFi result is: $(tput sgr 0)" $?

setupMediaServer
echo "$(tput setaf 6)setupMediaServer result is: $(tput sgr 0)" $?

setupMediaPlayer
echo "$(tput setaf 6)setupMediaPlayer result is: $(tput sgr 0)" $?

echo "$(tput setaf 5)[+] Reboot system... $(tput sgr 0)"
#sudo reboot
