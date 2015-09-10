#!/bin/bash

## extremely simple script that I use when adding, removing or transitioning 
## between recipients. not doing much in the way of error handling.
## Typical usage: find . -name "*gpg" -exec recryptgpg.sh {} \;

GPG_IDS='A467FF58 E1D6480F'

recrypt () {
	src=`mktemp`
	dst=`mktemp`

	## I want a name of a good temporary file that's available, but I don't want 
	## that file to be created just yet because I will test for its presence 
	## below before making filesystem changes to the original file.

	rm -f $dst
	file="$1"
	cp "$file" $src
	gpg2 -d $src | gpg2 `for i in $GPG_IDS; do echo -n "-r $i " ; done` \
		-o $dst -e
	if [ -f $dst ]; then
		## for testing purposes
		cp "$file" "$file".bak
		mv $dst "$file"
	else
		echo -e "\n\t** ERROR did not make changes to $file"
	fi

	rm -f $src
}

if [ -f "$1" ]; then
	echo -e "\nWorking on $1 ...\n"
	recrypt "$1"
else 
	echo "You must specify a present file in order to recrypt it."
fi

