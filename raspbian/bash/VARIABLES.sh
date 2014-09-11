#!/bin/bash

# setup modules checker
SETUP_WIFI=yes
SETUP_DLNA_SERVER=yes
SETUP_DLNA_PLAYER=yes

# WiFi dongle ID. If empty - lan settings will be ignored
WLAN_DEVICE="wlan0"
PC_NAME="MediaAP"

# Access point or Client settings for WiFi adapter
# If selected 1 - you'll get an new WiFi network.
# It will route inet access from ppp0 or eth0 to WiFi clients.
# Another way is setting WiFi dongle as default client for avaliable networks.
# With set as Client you can add new credentials by a command:
# sudo wpa_passphrase "your ssid" "your pass to ssid" >> /etc/wpa_supplicant/wpa_supplicant.conf
# 1 - AP; 2 - Client;
WIFI_TYPE=1

AP_NAME="${PC_NAME}-network"
UPNP_SERVER_NAME="${PC_NAME}-library"

USB_AUTOMOUNT_STICKS_NUM=2

# Sound config
# 1 - alsa; 2 - pulseaudio
SOUND_CONFIG=1

# UPnP player.
# 1 - upmpdcli; 2 - MediaPlayer; 3 - gmediarender-resurrect.
UPNP_PLAYER=1
UPNP_PLAYER_NAME="${PC_NAME}-player"