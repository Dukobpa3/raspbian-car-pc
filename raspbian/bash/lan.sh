#!/bin/bash

. ./include/vars.sh
. ./include/lan_ap.sh
. ./include/lan_cl.sh

function setupWiFi {
    case $1 in
        1)
        #setupWiFiAP
        return $?
        ;;
        2)
        #setupWiFiClient
        return $?
        ;;
        *)
        return ${RETERR}
    esac

    return ${RETERR}
}