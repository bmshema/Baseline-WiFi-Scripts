#!/bin/bash

# BridgeintheMiddle
# Version 0.1
# Author: bmshema

## Bridging Device Variables (Change These) ##
UN = pi
PW = raspberry
IP = '10.0.0.12'

## Makes a named pipe for Wireshark to listen to ##
if [ ! -e /tmp/loot ]; then
    mkfifo /tmp/loot
fi

