#!/bin/bash


#$(tput setaf 1) - Red - Warning
#$(tput setaf 2) - Green - ??
#$(tput setaf 3) - Yellow - Important info
#$(tput setaf 4) - Blue - ??
#$(tput setaf 5) - Magenta - ??
#$(tput setaf 6) - Cyan - Header
#$(tput setaf 7) - White - Info



echo "$(tput setaf 6)[+] Setup Access Point... $(tput sgr 0)"
./lan.sh

echo "$(tput setaf 6)[+] Setup mediaserver... $(tput sgr 0)"
./mediaserver.sh

echo "$(tput setaf 6)[+] Setup mediaplayer... $(tput sgr 0)"
./mediaplayer.sh

## reboot after all
sudo reboot