#!/bin/bash
# Name: twoPlaces
# Author: bmshema
# Takes input from packet captures collected from two separate locations
# and identifies MAC addresses present at both locations
#
# Resulting output is in bothplaces.txt.

echo "PCAP filename from location 1: "
read LOC1
echo "PCAP filename from location 2: "
read LOC2

tshark -r $LOC1 -Y wlan.addr -T fields -e wlan.sa > location1.txt
tshark -r $LOC1 -Y wlan.addr -T fields -e wlan.ta >> location1.txt
tshark -r $LOC1 -Y wlan.addr -T fields -e wlan.ra >> location1.txt
tshark -r $LOC1 -Y wlan.addr -T fields -e wlan.da >> location1.txt

tshark -r $LOC2 -Y wlan.addr -T fields -e wlan.sa > location2.txt
tshark -r $LOC2 -Y wlan.addr -T fields -e wlan.ta >> location2.txt
tshark -r $LOC2 -Y wlan.addr -T fields -e wlan.ra >> location2.txt
tshark -r $LOC2 -Y wlan.addr -T fields -e wlan.da >> location2.txt

cat location1.txt | sort | uniq > location1_uniq.txt
cat location2.txt | sort | uniq > location2_uniq.txt

cat location1_uniq.txt > everybody.txt
cat location2_uniq.txt >> everybody.txt

cat everybody.txt | sort | uniq -c | sort -nr | grep "2 "> bothplaces.txt
cat bothplaces.txt | grep "2 " > bothplaces2.txt
rm bothplaces.txt
cat bothplaces2.txt | sed 's/2 //g' | sed 's/      //g' > bothplaces.txt

rm location1.txt location2.txt everybody.txt location1_uniq.txt location2_uniq.txt bothplaces2.txt
