#!/bin/bash

. ./vars.sh

setupMediaPlayer() {
    echo "$(tput setaf 6)[+] Setup mediaplayer... $(tput sgr 0)"
    apt-get install -y mpd

    # clone

    return ${RETOK}

}