#!/bin/sh
PID=`ps auxwwwww|grep mux|grep -e $1 -ve muxclose|awk '{print $2}'`
if [ $PID ]; then
	kill $PID
else
	echo "no such mux session found"
fi
