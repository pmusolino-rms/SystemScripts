#!/bin/bash
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
