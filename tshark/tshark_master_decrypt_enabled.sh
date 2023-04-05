#!/bin/bash
# T-Shark Master
# Author: bmshema
# v1.6
#
#  ¯\_(ツ)_/¯
#
# Will programmatically apply several tshark queries while enabling decryption to multiple
# packet captures located in a directory in any packet capture format; .pcap, .cap, .pcapng, .pcapppi
# Outputs to csv file with column headers
#
# Dependencies: TShark
# Usage: Run in a directory containing packet captures and answer the two prompts regarding SSID and passphrase
# of the subject network.
#
# Resulting csv files can be imported to network mapping software
#
shark () {
    for f in *.*cap*; do
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "wlan.bssid && !(wlan.fc.type_subtype==4 || wlan.fc.type_subtype==5 || wlan.fc.type_subtype==8) && !(wlan.bssid==wlan.sa)" -T fields -e wlan.bssid -e wlan.sa -E separator=, -E header=y >> clients.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "dhcp.option.dhcp==5" -T fields -e wlan.bssid -e wlan.sa -e dhcp.option.dhcp_server_id -e dhcp.option.ip_address_lease_time -e dhcp.option.subnet_mask -e dhcp.option.router -e dhcp.option.domain_name_server -E separator=, -E header=y >> dhcpserver.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "dhcp.option.dhcp==3" -T fields -e dhcp.hw.mac_addr -e dhcp.option.requested_ip_address -e dhcp.option.hostname -E separator=, -E header=y >> dhcpclients.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "arp.opcode==2" -T fields -e arp.src.hw_mac -e arp.src.proto_ipv4 -E separator=, -E header=y >> arpreply.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "dns.flags.opcode==0" -T fields -e wlan.sa -e dns.qry.name -E separator=, -E header=y >> dnsclients.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "http.request.method" -T fields -e wlan.sa -e http.request.method -e http.request.full_uri -e http.host -e http.user_agent -E separator=, -E header=y >> httpclients.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "browser.command==0x00000001" -T fields -e wlan.sa -e browser.server -e browser.windows_version -e browser.os_major -e browser.os_minor -e browser.comment -E separator=, -E header=y >> browser.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "dns.flags.response==1 && mdns" -T fields -e wlan.sa -e dns.ptr.domain_name -E separator=, -E header=y >> mdns.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "wlan.fc.type_subtype==4" -T fields -e wlan.sa -e wlan.ssid -E separator=, -E header=y >> probes.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "wlan.fc.type_subtype==5 || wlan.fc.type_subtype==8" -T fields -e wlan.bssid -e wlan.ssid -e wlan.ds.current_channel -e wps.wifi_protected_setup_state -e wps.manufacturer -e wps.model_name -e wps.model_number -e wps.serial_number -e wps.device_name -e wlan.fixed.capabilities.privacy -e wlan.rsn.gcs.type -e wlan.rsn.pcs.type -e wlan.rsn.akms.type -E separator=, -E header=y >> accesspoints.csv
        tshark -r $f -o wlan.enable_decryption:TRUE -o "uat:80211_keys:\"wpa-pwd\",\"$PW:$SSID\"" -Y "icmp" -T fields -e wlan.sa -e ip.src -e ip.dst -e icmp.type -E separator=, -E header=y >> icmp.csv
    done
}

cleanup () {
    cat clients.csv | sort | uniq >> clients2.csv
    cat dhcpserver.csv | sort | uniq >> dhcpserver2.csv
    cat dhcpclients.csv | sort | uniq >> dhcpclients2.csv
    cat arpreply.csv | sort | uniq >> arpreply2.csv
    cat dnsclients.csv | sort | uniq >> dnsclients2.csv
    cat httpclients.csv | sort | uniq >> httpclients2.csv
    cat browser.csv | sort | uniq >> browser2.csv
    cat mdns.csv | sort | uniq >> mdns2.csv
    cat probes.csv | sort | uniq >> probes2.csv
    cat accesspoints.csv | sort | uniq >> accesspoints2.csv
    cat imcp.csv | sort | uniq >> icmp2.csv

    rm -rf clients.csv dhcpserver.csv dhcpclients.csv arpreply.csv dnsclients.csv httpclients.csv browser.csv mdns.csv probes.csv accesspoints.csv icmp.csv
}

echo "$(tput setaf 3)What is the SSID of the target network?"
read SSID
echo "$(tput setaf 3)What is the passphrase?"
read PW

shark
cleanup

