#!/bin/bash
PID=`ps auxwwwww|grep mux|grep -ve muxclose -e grep|grep $1|awk '{print $2}'`
if [[ $PID ]]; then
	kill $PID
else
	echo "no such mux session found"
fi
