#!/bin/bash

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
    #TODO check all filled
    #TODO check wifi dongle name
    #TODO check currently installed versions of soft and settings
    return 0
}

#TODO if [ checkVariables != 0 ] return
checkVariables


## All is ok. Start setup
echo "$(tput setaf 6)Import lan config... $(tput sgr 0)"
. ./lan.sh
echo "$(tput setaf 6)Import mediaserver config... $(pwd) $(tput sgr 0)"
. ./mediaserver.sh
echo "$(tput setaf 6)Import mediaplayer config... $(pwd) $(tput sgr 0)"
. ./mediaplayer.sh


#TODO read checker by modules setup
setupWiFi ${WIFI_TYPE}
echo "$(tput setaf 6)setupWiFi result is: $(tput sgr 0)" $?

setupMediaServer
echo "$(tput setaf 6)setupMediaServer result is: $(tput sgr 0)" $?

setupMediaPlayer
echo "$(tput setaf 6)setupMediaPlayer result is: $(tput sgr 0)" $?

# TODO prompt rebooting if no - just exit
echo "$(tput setaf 5)[+] Reboot system... $(tput sgr 0)"
#sudo reboot