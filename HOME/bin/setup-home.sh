#!/bin/bash
srclist=(`find \`pwd\` -maxdepth 1| grep -v -e LICENSE -e README.md | \
	tail -n +2`)

repo_list=(
https://github.com/chriskempson/tomorrow-theme.git
https://github.com/tpope/vim-surround.git 
https://github.com/edsono/vim-matchit.git 
https://github.com/groenewege/vim-less.git
https://github.com/tpope/vim-fugitive.git
https://github.com/majutsushi/urxvt-font-size.git
https://github.com/tpope/vim-pathogen.git)

make_other_link () {
	mkdir -p ~/.vim/bundle/
	cd $HOME/git
	for i in `echo $*`; do
		if [[ $i =~ urxvt || $i =~ pathogen || $i =~ tomorrow-theme ]]; then
			echo "not linking $i"
			true
		else
			echo "linking $i"
			ln -sf $HOME/git/$i ~/.vim/bundle/
		fi
	done
	ln -sf $HOME/git/tpope-vim-pathogen/autoload ~/.vim/autoload
	mkdir -p ~/.urxvt/ext
	ln -sf $HOME/git/majutsushi-urxvt-font-size/font-size ~/.urxvt/ext/
	ln -sf $HOME/git/chriskempson-tomorrow-theme/vim ~/.vim/bundle/tomorrow-theme
}

git_repos () {
	echo -e "Cloning/updating the required git repos.\n"
	mkdir -p $HOME/git
	for i in ${repo_list[*]}; do
		gitdir=`echo $i | awk -F \/ '{ print $(NF-1)"-"$NF }' | sed -e "s/.git$//"`
		if [[ -d $HOME/git/$gitdir ]]; then
			cd $HOME/git/$gitdir
			git pull > /dev/null 2>&1 && echo "Successfully updated $gitdir" ||
				echo "Failed to update $gitdir"
		else
			cd $HOME/git
			git clone $i $gitdir > /dev/null 2>&1 && 
			echo "Successfully cloned $gitdir" || echo "Failed to clone $gitdir"
		fi
		if [ -z $gitdirs ]; then
			gitdirs="$gitdir"
		else
			gitdirs="$gitdir $gitdirs"
		fi
	done
	echo "making links for $gitdirs"
	make_other_link $gitdirs
}

check_answer () {
	test=`echo "x$1" | grep -iE "^xy$"`
	if [[ -z $test ]]; then
		continue="no"
	else
		continue="yes"
	fi
}


echo -e "Setting up home directory. Will attempt to create links for:\n"

printf "%s\n" ${srclist[*]}

for i in ${srclist[*]}; do
	localname=`echo $i | awk -F "/" '{ print $NF }'`
	if [[ -d ~/$localname || -f ~/$localname || -h ~/$localname ]]; then
		exists+=($i)
		localnames+=($localname)
	else
		newlinks+=($i)
	fi
done

if [[ $newlinks ]]; then
	echo -e "\nThese links do not already exist and can be created cleanly:\n"
	printf "%s\n" ${newlinks[*]}
	echo -en "\nDo you want to create new links? [y/N] "
	if [[ $1 == '-y' ]]; then
		continue="yes"
	else
		read answer
		check_answer $answer
	fi
	if [[ "x$continue" == "xyes" ]]; then
		for i in ${newlinks[*]}; do
			ln -sf $i $HOME
		done
	fi
else
	echo -e "\nNo new links to create!"
fi

continue="xno"
echo -en "\nDo you want to clone/update the required git repos? [Y/n] "
if [[ $1 == '-y' ]]; then
	continue="yes"
else
	read answer
	check_answer $answer
fi
if [[ -z $answer || "x$continue" == "xyes" ]]; then
	git_repos
fi
	
if [[ $exists ]]; then
	echo -e "\nLocal linking conflicts detected!\n"
	printf "$HOME/%s\n" ${localnames[*]}
	msg="\nDo you want to DELETE the local copy and re-link from source? [y/N] "
	really_sure=0
	continue="no"
	while [[ $really_sure -lt 2 ]]; do
		echo -en "$msg"
		if [[ $1 == '-y' ]]; then
			continue="yes"
		else
			read answer
			check_answer $answer
		fi
		if [[ "x$continue" == "xyes" ]]; then
			msg="\nAre you REALLY SURE - this is the last prompt! [y/N] "
			really_sure+=1
		else
			exit 0
		fi
	done
	for i in ${!exists[*]}; do
		rm -rf $HOME/${localnames[$i]}
		ln -sf ${exists[$i]} $HOME
	done
fi

