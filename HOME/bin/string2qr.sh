#!/bin/bash
qrfile=`mktemp`
echo $qrfile
qrencode -o $qrfile $1
feh $qrfile &
sleep 1
rm -f $qrfile
