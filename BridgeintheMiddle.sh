#!/bin/bash

# BridgeintheMiddle
# Version 0.1
# Author: bmshema

## Bridging Device Variables (CHANGE THESE) ##
UN = pi
PW = raspberry
IP = '10.0.0.12'

## Parameters of your evil twin on your bridging device (CHANGE THESE) ##
WPA = 2 # Use 1 for WPA, use 2 for WPA2, use 1+2 for both
CH = 11
MAC = "11:22:33:44:55:66" # BSSID of your AP
FREQ = '2.4' # 2.4 or 5
INT = wlan0 # Interface to serve AP
NET = ppp0 # Interface with internet access
SSID = TestSSID 
PSK = testtestpsk


## Makes a named pipe for Wireshark to listen to ##
if [ ! -e /tmp/loot ]; then
    mkfifo /tmp/loot
fi

