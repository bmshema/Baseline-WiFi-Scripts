# WiFi-Scripts
Some baseline scripts for Wi-Fi Analysis, network mapping, and enrichment.

### tshark_baseline*.sh: 
Executes 12 tshark commands to aid in wireless network mapping, resulting in csv format files suitable for import into most network diagram applications.
  - Access Point Information
  - Connected Clients
  - Probe Requests
  - DHCP Server
  - DHCP Clients
  - ARP
  - DNS Client
  - HTTP Client
  - Browser
  - MDNS
  - ICMP
  - TCP

### twoPlaces.sh: 
Takes input from packet captures collected from two separate locations and identifies MAC addresses present at both locations. Resulting output is in bothplaces.txt numbered by how many locations a MAC address was present in.

