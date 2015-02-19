#!/bin/bash
for i in `find \`pwd\` -maxdepth 1|grep -v -e LICENSE -e README.md`; do ln -sf $i ~/;done
