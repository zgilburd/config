#!/bin/bash
for i in `find \`pwd\` -maxdepth 1|grep -v -e LICENSE -e README.md`; do ln -sf $i ~/;done
cd ~/git/
git clone https://github.com/chriskempson/tomorrow-theme.git
git clone https://github.com/tpope/vim-surround.git 
git clone https://github.com/edsono/vim-matchit.git 
git clone https://github.com/groenewege/vim-less.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-pathogen.git         

