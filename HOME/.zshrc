uname=`uname`
alias rk='eval `keychain --agents gpg --eval`'
alias ls='ls --color=auto'
alias cal='cal -3'
alias pwgen='pwchars="alnum punct"; for chars in `echo $pwchars |sed "s/ /\n/"`; do charset="[:$chars:]$charset"; tr -dc "$charset" < /dev/random | fold -w 24 |head -n5; done; unset charset'
alias pwgenrng='pwchars="alnum punct"; for chars in `echo $pwchars |sed "s/ /\n/"`; do charset="[:$chars:]$charset"; tr -dc "$charset" < /dev/random | fold -w 24 |head -n5; done; unset charset'
if [[ "x$uname" == "xDarwin" ]]; then
	alias ls='gls --color=auto'
	alias cal='gcal .'
fi
alias rgrep='egrep -rHni'
alias rldp='. ~/.zshrc'
alias isotoday='date +%Y%m%d'
PATH=/usr/local/bin:/usr/local/sbin:~/bin:~/localapps/bin:~/android-sdk/sdk/platform-tools:~/android-sdk/sdk/tools:$PATH

if [ -s ~/.zshrclocal ]; then
	. ~/.zshrclocal
fi
if [ -s /etc/zsh_command_not_found ]; then
	. /etc/zsh_command_not_found
fi
if [ -s ~/.pythonrc ]; then
	export PYTHONSTARTUP=~/.pythonrc
fi
#if `locate bin/java`; then
#	JAVA_HOME="$(/usr/libexec/java_home)"
#fi

# Set up the prompt
fpath=(~/.zsh/functions $fpath)

autoload -U ~/.zsh/functions/*(:t)
autoload -Uz promptinit compinit vcs_info
setopt prompt_subst
promptinit
if [ ${UID} = 0 ]; then
	prompt physosvcs red
else
	prompt physosvcs
	if [[ `hostname` =~ "^.*\.zh\.local" ]]; then
		if [[ "x$uname" == "xDarwin" ]]; then
			eval `keychain --agents gpg --eval`
		else
			eval `keychain --eval`
		fi
	fi
fi



setopt histignorealldups sharehistory

GIT_EDITOR='vim'
VISUAL='vim'
export EDITOR=$VISUAL
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[3~' delete-char


# set a pretty term title
case $TERM in
	rxvt*)
		precmd () {vcs_info; print -Pn "\033]0;%n@%m: %~\007"}
		TERM=xterm  # i wish this weren't necessary
	;;
	xterm*)
    precmd () {vcs_info; print -Pn "\e]0;%n@%m: %~\007"}
	;;
esac

