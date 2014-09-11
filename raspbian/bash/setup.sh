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

function checkVariables {

    echo "Check WiFi settings"
    if [ ${WLAN_DEVICE} != "" ]; then
        echo "configure WiFi"
        #TODO check all filled
        #TODO check wifi dongle name
        #TODO check currently installed versions of soft and settings
    else
        echo "don't configure WiFi"
    fi


    echo "Check UPnP server settings"
    if [ ${UPNP_SERVER} > 0 ]; then
        echo "configure UPnP server"
        #TODO check all filled
        #TODO check currently installed versions of soft and settings
    else
        echo "don't configure UPnP server"
    fi

    echo "Check UPnP player settings"
    if [ ${UPNP_PLAYER} > 0 ]; then
        echo "configure UPnP player"
        #TODO check all filled
        #TODO check currently installed versions of soft and settings
    else
        echo "don't configure UPnP player"
    fi

    return 0
}

function checkCurrentState {

    return 0
}

checkVariables
if [ $? == 1 ]; then
    echo "$(tput setaf 1)Error in your config file $(tput sgr 0)"
    exit 1
fi

checkCurrentState
if [ $? == 1 ]; then
    echo "$(tput setaf 1)Error in your current pc state $(tput sgr 0)"
    exit 1
fi


## All is ok. Start setup
if [ ${WLAN_DEVICE} != "" ]; then
    echo "$(tput setaf 6)Import lan config... $(tput sgr 0)"
    . ./lan.sh
    setupWiFi ${WIFI_TYPE} ${WLAN_DEVICE} ${AP_NAME}
    echo "$(tput setaf 6)setupWiFi result is: $(tput sgr 0)" $?
fi


if [ ${UPNP_SERVER} > 0 ]; then
    echo "$(tput setaf 6)Import mediaserver config... $(pwd) $(tput sgr 0)"
    . ./mediaserver.sh
    setupMediaServer
    echo "$(tput setaf 6)setupMediaServer result is: $(tput sgr 0)" $?
fi


if [ ${UPNP_PLAYER} > 0 ]; then
    echo "$(tput setaf 6)Import mediaplayer config... $(pwd) $(tput sgr 0)"
    . ./mediaplayer.sh
    setupMediaPlayer
    echo "$(tput setaf 6)setupMediaPlayer result is: $(tput sgr 0)" $?
fi

# TODO prompt rebooting if no - just exit
echo "$(tput setaf 5)[+] Reboot system... $(tput sgr 0)"
#sudo reboot

exit 0