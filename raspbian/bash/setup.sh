#!/bin/bash

# version 1.0.0

#$(tput setaf 1) - Red - Warning
#$(tput setaf 2) - Green - Prompt
#$(tput setaf 3) - Yellow - Important info
#$(tput setaf 4) - Blue - ??
#$(tput setaf 5) - Magenta - Header
#$(tput setaf 6) - Cyan - Info
#$(tput setaf 7) - White - ??
#$(tput sgr 0) - clean format

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

    if [ $(ifconfig 2>/dev/null | grep -c wlan0) -eq 0 ]; then
        echo "$(tput setaf 1) Check your Wlan device name! $(tput sgr 0)"
        echo -n "$(tput setaf 3) Your lan devices: $(ifconfig | cut -c1-10 | sort -u) $(tput sgr 0)"
        exit 1
    fi

    echo "$(tput setaf 6)Import lan config... $(tput sgr 0)"
    . ./lan.sh
    setupWiFi ${WIFI_TYPE} ${WLAN_DEVICE} ${AP_NAME}
    echo "$(tput setaf 6)setupWiFi result is: $(tput sgr 0)" $?
fi


echo "$(tput setaf 5)Check UPnP server settings$(tput sgr 0)"
if [ -z ${UPNP_SERVER} ]; then
    echo "$(tput setaf 6)don't configure UPnP server$(tput sgr 0)"
else
    echo "$(tput setaf 6)configure UPnP server$(tput sgr 0)"
    #TODO check all filled
    #TODO check currently installed versions of soft and settings
    echo "$(tput setaf 6)Import mediaplayer config... $(pwd) $(tput sgr 0)"
    . ./mediaserver.sh
    setupMediaServer
    echo "$(tput setaf 6)setupMediaPlayer result is: $(tput sgr 0)" $?
fi

echo "$(tput setaf 5)Check UPnP player settings$(tput sgr 0)"
if [ -z ${UPNP_PLAYER} ]; then
    echo "$(tput setaf 6)don't configure UPnP player$(tput sgr 0)"
else
    echo "$(tput setaf 6)configure UPnP player$(tput sgr 0)"
    #TODO check all filled
    #TODO check currently installed versions of soft and settings
    echo "$(tput setaf 6)Import mediaplayer config... $(pwd) $(tput sgr 0)"
    . ./mediaplayer.sh
    setupMediaPlayer
    echo "$(tput setaf 6)setupMediaPlayer result is: $(tput sgr 0)" $?
fi

asksure() {
    echo "$(tput setaf 5)[+] Reboot system... (Y/N)? $(tput sgr 0)"
    while read -r -n 1 -s answer; do
        if [[ ${answer} = [YyNn] ]]; then
            [[ ${answer} = [Yy] ]] && retval=0
            [[ ${answer} = [Nn] ]] && retval=1
            break
        fi
    done

    return ${retval}
}

if asksure; then
    echo "$(tput setaf 5)[+] Rebooting... $(tput sgr 0)"
    reboot
fi

echo "$(tput setaf 5)[+] Have a nice day! :) $(tput sgr 0)"
exit 0