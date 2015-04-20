# User dependent .bashrc file

# See man bash for more options...
  # Don't wait for job termination notification
set -o notify

  # Don't use ^D to exit
  # set -o ignoreeof
  # ^D exits bash too conveniently: require to press twice to exit
  #export IGNOREEOF=1

  # Don't put duplicate lines in the history.
export HISTCONTROL=erasedups:ignoredups
if [ `hostname` == "gnx2221" ]; then
	export HISTFILE=~/.bash_history

#better to check bash version
	# do not complete an empty line
	shopt -s no_empty_cmd_completion
	# recursively search the tree when ** is specified
	shopt -s globstar
	# /some/path without a command runs a cd /some/path
	shopt -s autocd
	# directory names may contain small typos and still will be understood
	shopt -s cdspell
	# check !! !? repel from history and don't run them automatically
	shopt -s histverify

else

	export HISTFILE=$HOME/.bash_histories/$(hostname)
	if [ ! -e "$HISTFILE" ]; then
		cp "$HOME/.bash_history" "$HISTFILE"
	fi

fi
export HISTFILESIZE=10000
export HISTSIZE=10000
#export CDPATH=".:~:/cygdrive"
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls'

if [ -z "$LSF_ENVDIR" ] ; then
PS1=$'\\[\\033]0;\\w\\007\n\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\] \n$'
else
PS1=$'\w$ '
fi
PS2='> '
PS4='+ '

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/atria/bin"
#local gnx2221 configuration
PATH=/media/home/toromano/bin:~/local/bin:$PATH
export PYTHONPATH=~/local/lib/python2.7/site-packages
#end gnx2221 conf, should be move to a local file
PATH=~/bin:$PATH

# Some example alias instructions
alias less='less -r -i'
# alias rm='rm -i'
# alias whence='type -a'
alias rot13='tr a-mn-zA-MN-Z n-za-mN-ZA-M'
#alias grep='grep -n'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'



# Some example functions
function settitle() { echo -n "]2;$@]1;$@"; }

#export LANG="en_US.UTF-8" 

# add Solarized option
case "$TERM" in
xterm*)
    TERM=xterm-256color
    DIRCOLOR=`dircolors ~/.dircolors/dircolors.256dark 2>/dev/null`
    if [ -z "$DIRCOLOR" ]; then
        DIRCOLOR=`dircolors ~/.dircolors/dircolors.older.256dark`
    fi
    eval $DIRCOLOR
    ;;
*)
    ;;
esac


# add completion in python shell
export PYTHONSTARTUP=$HOME/.pythonrc.py
unset command_not_found_handle

# Remove Unity global menu
export UBUNTU_MENUPROXY=0

#beautifukl man page
#if [ -e /usr/bin/most ]; then 
#	export MANPAGER=/usr/bin/most
#fi

#ST anoing prompt, and add mine (save to disk all history immediatlly)
export PROMPT_COMMAND="history -a"

#ST SunOx issue :
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
