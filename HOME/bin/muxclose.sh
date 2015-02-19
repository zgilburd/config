#!/bin/bash
ps auxwwwwww|grep mux |grep $1|awk '{print $2}' | xargs kill
