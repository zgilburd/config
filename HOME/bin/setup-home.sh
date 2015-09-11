#!/bin/bash
srclist=(`find \`pwd\` -maxdepth 1|grep -v -e LICENSE -e README.md | tail \
	-n +2`)
repo_list=(
https://github.com/chriskempson/tomorrow-theme.git
https://github.com/tpope/vim-surround.git 
https://github.com/edsono/vim-matchit.git 
https://github.com/groenewege/vim-less.git
https://github.com/tpope/vim-fugitive.git
https://github.com/tpope/vim-pathogen.git)

git_repos () {
	echo "Cloning/updating the required git repos."
	for i in ${repo_list[*]}; do
		localdir=`echo "$i" | awk -F "/" '{print $NF}' | sed -e "s/.git$//"`
		if [[ -d $HOME/git/$localdir ]]; then
			cd $HOME/git/$localdir
			git pull > /dev/null 2>&1 && echo "Successfully updated $localdir" ||
				echo "Failed to update $localdir"
		else
			cd $HOME/git
			git clone $i > /dev/null 2>&1 && 
			echo "Successfully cloned $localdir" || echo "Failed to clone $localdir"
		fi
	done
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
	read answer
	check_answer $answer
	if [[ "x$continue" == "xyes" ]]; then
		for i in ${newlinks[*]}; do
			ln -sf $i $HOME
		done
	fi
else
	echo "No new links to create!"
fi

continue="xno"
echo -en "\nDo you want to clone/update the required git repos? [Y/n] "
read answer
check_answer $answer
if [[ -z $answer || "x$continue" == "xyes" ]]; then
	git_repos
fi
	
if [[ $exists ]]; then
	echo -e "\nLocal linking conflicts detected!\n"
	printf "$HOME/%s\n" ${localnames[*]}
	msg="Do you want to DELETE the local copy and re-link from source? [y/N]"
	really_sure=0
	continue="no"
	while [[ $really_sure -lt 2 ]]; do
		echo "$msg"
		read answer
		check_answer $answer
		if [[ "x$continue" == "xyes" ]]; then
			msg="Are you REALLY SURE - this is the last prompt! [y/N] "
			really_sure+=1
		else
			exit 0
		fi
	done
	for i in ${exists[*]}; do
		shortname=`echo $i | awk -F "/" '{print $NF}'`
		rm -rf $HOME/$shortname
		ln -sf $i $HOME
	done
fi
