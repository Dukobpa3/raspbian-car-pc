#!/bin/bash

PC_NAME="MediaAP"

# WiFi dongle ID.
# if not setted up - WiFi settings will be ignored
WLAN_DEVICE="wlan0"

# Access point or Client settings for WiFi adapter
# If selected 1 - you'll get an new WiFi network.
# It will route inet access from ppp0 or eth0 to WiFi clients.
# Another way is setting WiFi dongle as default client for avaliable networks.
# With set as Client you can add new credentials by a command:
# sudo wpa_passphrase "your ssid" "your pass to ssid" >> /etc/wpa_supplicant/wpa_supplicant.conf
# 1 - AP; 2 - Client;
WIFI_TYPE=1

# Should be setted up if WIFI_TYPE=1
AP_NAME="${PC_NAME}-network"

# minidlna
UPNP_SERVER_NAME="${PC_NAME}-library"

# number of setted up usb sticks. Will be mounted in /media/[usb1|usb2|usbN]
USB_AUTOMOUNT_STICKS_NUM=2

# UPnP player.
# 0 - nothing; 1 - upmpdcli; 2 - MediaPlayer; 3 - gmediarender-resurrect.
UPNP_PLAYER=1
UPNP_PLAYER_NAME="${PC_NAME}-player"