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

tshark -r $LOC1 -Y wlan.addr -T fields -e wlan.ta >> location1.txt
tshark -r $LOC2 -Y wlan.addr -T fields -e wlan.ta >> location2.txt

cat location1.txt | sort | uniq > location1_uniq.txt
cat location2.txt | sort | uniq > location2_uniq.txt

cat location1_uniq.txt > everybody.txt
cat location2_uniq.txt >> everybody.txt

