#default aliases

# Some example alias instructions
alias less='less -r -i'
# alias rm='rm -i'
# alias whence='type -a'
alias rot13='tr a-mn-zA-MN-Z n-za-mN-ZA-M'
#alias grep='grep -n'

function proxy(){
PROXY_SERVER=172.29.52.166
PROXY_PORT=80
export  http_proxy=http://$PROXY_SERVER:$PROXY_PORT/
export https_proxy=http://$PROXY_SERVER:$PROXY_PORT/

}

function unproxy(){
unset http_proxy
unset https_proxy
}


gvimn() { command gvim "$@"; }
gvimss() { (command gvim --serverlist | grep -i "^$1$" 2>&1 > /dev/null ) && (echo "open ${@:2} in server $1" && command gvim --servername "$1" --remote-silent "${@:2}" ) || (echo "open ${@:2} in server $1" && command gvim --servername "$1" "${@:2}" ) ; }
#g () { [ -z "$(command gvim --serverlist)" ] && command gvim "$@" || command gvim --remote-silent "$@" ; }
gvim () { MY_VIM_SERVERNAME=$(git config --local --get perso.vimserver) && gvimss $MY_VIM_SERVERNAME "$@" || gvimss GVIM "$@" ; unset MY_VIM_SERVERNAME ; }
gvims () {
	git config --local --add perso.vimserver "$1"
	gvimss "$@";
	}
gvim_clean () {
      MY_VIM_SERVERNAME=$(git config --local --get perso.vimserver) && find ~/.vim/sessions/ -iname $MY_VIM_SERVERNAME -print -exec mv {} /tmp/ \;
      unset MY_VIM_SERVERNAME ;
}

beep() { echo -e "\a" ; paplay /usr/share/sounds/gnome/default/alerts/drip.ogg ;  }

#tag() { echo "awful.tag.selected().name=\"$1\"" |  awesome-client ; }
tag() {
   if [ $# -eq 1 ]; then
       echo "awful.tag.selected().name=\"$1\"" |  awesome-client ;
   fi
   if [ $# -eq 2 ]; then
      echo "tags[mouse.screen][$2].name=\"$1\"" |  awesome-client ;
   fi
   if [ $# -eq 3 ]; then
       echo "tags[$3][$2].name=\"$1\"" |  awesome-client ;
   fi
}

# management of .files in git
alias .git="GIT_DIR=~/.sync/.git git"
