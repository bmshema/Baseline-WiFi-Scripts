# Random-WiFi-Scripts
A bunch of random scripts for WiFi analysis.

### tshark-master*.sh: 
Executes 10 tshark commands to aid in wireless network mapping and exports to a csv format suitable for most network diagram applications.
  - Connected Clients
  - Probe Requests
  - Access Point information
  - DHCP Server
  - DHCP Clients
  - ARP
  - DNS Client
  - HTTP Client
  - Browser
  - MDNS

### twoPlaces.sh: 
Takes input from packet captures collected from two separate locations and identifies MAC addresses present at both locations. Resulting output is in bothplaces.txt numbered by how many locations a MAC address was present in

### regretfulRaven.sh:
Takes input for network SSID and hashcat mode 22000 file and executes a mask attack with Hashcat to exploit Netgear AT&T hotspot default credentials.

