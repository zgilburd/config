#!/bin/bash
mykey=a467ff58
if [[ ! -f $1 ]]; then
	echo "arg not a file"
	exit 1
fi
tmpfile=`mktemp`
cwd=`pwd`
gpg2 --batch --yes -r $mykey -o $tmpfile -e $cwd/$1
mv $tmpfile $cwd/$1.gpg
rm -fi $cwd/$1
