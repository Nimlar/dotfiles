# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d ~/man ]; then
#   MANPATH="~/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d ~/info ]; then
#   INFOPATH="~/info:${INFOPATH}"
# fi