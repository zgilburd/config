#!/bin/sh

TEMPDIR=`mktemp -d`
IMGFILE=$TEMPDIR/screen-lock.png

scrot -m $IMGFILE
#import -window root $IMGFILE
convert $IMGFILE -scale 2% -scale 5000% $IMGFILE
i3lock -i $IMGFILE
rm -rf $TEMPDIR
sleep 60; pgrep i3lock && xset dpms force off

