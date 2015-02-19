#!/bin/bash
cat ~/.mykey | ssh $1 "mkdir -p ~/.ssh; cat - > ~/.ssh/authorized_keys"
