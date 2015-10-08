#!/bin/sh

TEMPDIR=`mktemp -d`
IMGFILE=$TEMPDIR/screen-lock.png
#import -window root $IMGFILE 
if scrot -m $IMGFILE; then
	PROCEED=true
	convert $IMGFILE -scale 1% -scale 10000% $IMGFILE 
	i3lock -i $IMGFILE
else
	echo "could not save screenshot"
fi
rm -rf $TEMPDIR
if $PROCEED; then
	sleep 60
	if ps -p `pidof i3lock` > /dev/null 2>&1; then
		xset dpms force off
	fi
else
	echo "aborting"
fi
