#!/bin/bash
# v1
# This script is intended to run post an IKEv2 VPN tunnel connection
# If you are not using Apple profiles to set split dns tunnel information this script can be run to inject
# the supplemnentalMatchDomains setting required to make the VPN resolution function.
# The script will grab the last DNS entry from the scutil data which *should* be the VPN DNS
# and adds the specified key and domains to the key 
DNS=`sudo scutil << EOF
list ".*DNS"
EOF`
VPNServer="${DNS##*$'\n'}"
KEY=`echo $VPNServer | cut -f2 -d=`
sudo scutil << EOF
d.init
get $KEY
d.add SupplementalMatchDomains * example.com anotherexample.com
set $KEY
EOF
