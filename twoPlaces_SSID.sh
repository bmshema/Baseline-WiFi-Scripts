#!/bin/bash
# Name: twoPlaces_SSID
# Author: bmshema
# Takes input from packet captures collected from two separate locations
# and identifies SSIDs that were probe requested for at both locations.
#
# Resulting output is in bothplaces_ssid.txt.

echo "PCAP filename from location 1: "
read LOC1
echo "PCAP filename from location 2: "
read LOC2