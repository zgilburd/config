#!/bin/bash

## extremely simple script that I use when adding, removing or transitioning 
## between recipients. not doing much in the way of error handling.
## Typical usage: find . -name "*gpg" -exec recryptgpg.sh {} \;

GPG_IDS='A467FF58 E1D6480F'

recrypt () {
	tmpfile=`mktemp`
	file=$1
	mv $file $tmpfile
	gpg2 -d $tmpfile | gpg2 `for i in $GPG_IDS; do echo -n "-r $i " ; done` -o $file -e
	#mv $tmpfile "$file".bak
	rm -f $tmpfile
}

if [ -f $1 ]; then
	echo -e "\nPWorking on $1 ...\n"
	recrypt $1
else 
	echo bye
fi
	
