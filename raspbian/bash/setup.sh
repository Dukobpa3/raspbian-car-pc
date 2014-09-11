#!/bin/bash

# version 1.0.0

#$(tput setaf 1) - Red - Warning
#$(tput setaf 2) - Green - Prompt
#$(tput setaf 3) - Yellow - Important info
#$(tput setaf 4) - Blue - ??
#$(tput setaf 5) - Magenta - Header
#$(tput setaf 6) - Cyan - Info
#$(tput setaf 7) - White - ??

## Start
SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
cd ${DIR}
echo "$(tput setaf 6)Currently run in: $(pwd) $(tput sgr 0)"

## Set configuration
echo "$(tput setaf 6)Import config settings... $(tput sgr 0)"
. ./VARIABLES.sh


echo "$(tput setaf 5)Check WiFi settings $(tput sgr 0)"
if [ -z ${WLAN_DEVICE} ]; then
    echo "$(tput setaf 6)don't configure WiFi$(tput sgr 0)"
else
    echo "$(tput setaf 6)configure WiFi$(tput sgr 0)"
    #TODO check all filled
    #TODO check wifi dongle name
    #TODO check currently installed versions of soft and settings
    echo "$(tput setaf 6)Import lan config... $(tput sgr 0)"
    . ./lan.sh
    setupWiFi ${WIFI_TYPE} ${WLAN_DEVICE} ${AP_NAME}
    echo "$(tput setaf 6)setupWiFi result is: $(tput sgr 0)" $?
fi


echo "$(tput setaf 5)Check UPnP server settings$(tput sgr 0)"
if [ ${UPNP_SERVER} -gt 0 ]; then
    echo "$(tput setaf 6)configure UPnP server$(tput sgr 0)"
    #TODO check all filled
    #TODO check currently installed versions of soft and settings
    echo "$(tput setaf 6)Import mediaplayer config... $(pwd) $(tput sgr 0)"
    . ./mediaplayer.sh
    setupMediaPlayer
    echo "$(tput setaf 6)setupMediaPlayer result is: $(tput sgr 0)" $?
else
    echo "$(tput setaf 6)don't configure UPnP server$(tput sgr 0)"
fi

echo "$(tput setaf 5)Check UPnP player settings$(tput sgr 0)"
if [ ${UPNP_PLAYER} -gt 0 ]; then
    echo "$(tput setaf 6)configure UPnP player$(tput sgr 0)"
    #TODO check all filled
    #TODO check currently installed versions of soft and settings
    echo "$(tput setaf 6)Import mediaplayer config... $(pwd) $(tput sgr 0)"
    . ./mediaplayer.sh
    setupMediaPlayer
    echo "$(tput setaf 6)setupMediaPlayer result is: $(tput sgr 0)" $?
else
    echo "$(tput setaf 6)don't configure UPnP player$(tput sgr 0)"
fi


# TODO prompt rebooting if no - just exit
echo "$(tput setaf 5)[+] Reboot system... $(tput sgr 0)"
#sudo reboot

exit 0