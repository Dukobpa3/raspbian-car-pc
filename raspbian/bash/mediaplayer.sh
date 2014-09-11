#!/bin/bash

function setupMediaPlayer {
    echo "$(tput setaf 5)[+] Setup mediaplayer... $(tput sgr 0)"
    apt-get install -y mpd

    # clone

    return 0

}