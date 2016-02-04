#!/bin/sh
devices=`lsusb | grep HHKB`
if [[ $devices ]]; then
	xmodmap -e "keycode 102 = Super_L"
fi
