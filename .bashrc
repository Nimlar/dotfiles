# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# See man bash for more options...
  # Don't wait for job termination notification
set -o notify

  # Don't use ^D to exit
  # set -o ignoreeof
  # ^D exits bash too conveniently: require to press twice to exit
  #export IGNOREEOF=1

  # Don't put duplicate lines in the history.
export HISTCONTROL=erasedups:ignoredups

#because all bash I may encounter doesn't have all option I want
#I'll get some error messages on some old RH server I still use
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

export HISTFILE=$HOME/.bash_histories/$(hostname)
if [ ! -e "$HISTFILE" ]; then
	mkdir -p "$HOME/.bash_histories"
	touch "$HOME/.bash_history" #if the file didn't exist yet
	cp "$HOME/.bash_history" "$HISTFILE"
fi

export HISTFILESIZE=10000
export HISTSIZE=10000
#export CDPATH=".:~:/cygdrive"
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033]0;\w\007\n\033[32m\]\u@\h \[\033[33m\]\w\[\033[0m\] \n$'

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias rot13='tr a-mn-zA-MN-Z n-za-mN-ZA-M'
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

# android compilation
#export USE_CCACHE=1
PATH=~/bin:$PATH

# locl nodejs installation
PATH=~/local/bin:$PATH

#export LANG="en_US.UTF-8" 

# add Solarized option
case "$TERM" in
xterm*)
    TERM=xterm-256color
    DIRCOLOR=$(dircolors ~/.dircolors/dircolors.256dark 2>/dev/null)
    if [ -z "$DIRCOLOR" ]; then
            DIRCOLOR=$(dircolors ~/.dircolors/dircolors.older.256dark)
    fi
    eval "$DIRCOLOR"
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
