#!/bin/bash -e
die() { echo "$@"; exit 1; }

[ "x$1" == "x" ] && die "$0 <hostname>"

minion=$1

#cd /etc/openvpn/easy-rsa
cd /srv/CA

if [ ! -f keys/$minion.key ]; then
#echo "TEST DUMMY key for $minion \n" > keys/$minion.key
#echo "TEST DUMMY certifikat for $minion \n" > keys/$minion.crt
#  . vars > /dev/null 2>&1
#  ./pkitool $1 > /dev/null 2>&1
cp keys/ojlap.key keys/$minion.key
cp keys/ojlap.crt keys/$minion.crt

fi
