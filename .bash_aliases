#default aliases

# Some example alias instructions
alias less='less -r -i'
# alias rm='rm -i'
# alias whence='type -a'
alias rot13='tr a-mn-zA-MN-Z n-za-mN-ZA-M'
alias grep='grep -d skip'

function _proxy(){
PROXY_SERVER=$1
PROXY_PORT=$2
export  http_proxy=http://$PROXY_SERVER:$PROXY_PORT/
export https_proxy=http://$PROXY_SERVER:$PROXY_PORT/
export no_proxy=".st.com"
extra_ps1_info="$extra_ps1_info"⇲
}

function unproxy(){
unset http_proxy
unset https_proxy
extra_ps1_info=${extra_ps1_info/⇲/}

}

function buildprompt() {
	precmd_functions+=(beep_chkerr)
	extra_ps1_info="$extra_ps1_info"🔔
}

function remove_precmd_functions () {
	for i in "${!precmd_functions[@]}";do
		if [ "${precmd_functions[$i]}" == "$1" ]; then
			unset precmd_functions[$i]
		fi
	done
}

function unbuildprompt(){
	remove_precmd_functions beep
	extra_ps1_info=${extra_ps1_info/🔔/}
}


gvimn() { command gvim "$@"; }
gvimss() { (command gvim --serverlist | grep -i "^$1$" > /dev/null 2>&1 ) && (echo "open ${*:2} in server $1" && command gvim --servername "$1" --remote-silent "${@:2}" ) || (echo "open ${*:2} in server $1" && command gvim --servername "$1" "${@:2}" ) ; }
#g () { [ -z "$(command gvim --serverlist)" ] && command gvim "$@" || command gvim --remote-silent "$@" ; }
gvim () { MY_VIM_SERVERNAME=$(git config --local --get perso.vimserver) && gvimss "$MY_VIM_SERVERNAME" "$@" || gvimss GVIM "$@" ; unset MY_VIM_SERVERNAME ; }
gvims () {
	git config --local --add perso.vimserver "$1"
	gvimss "$@";
	}
gvim_clean () {
      MY_VIM_SERVERNAME=$(git config --local --get perso.vimserver) && find ~/.vim/sessions/ -iname "$MY_VIM_SERVERNAME" -print -exec mv {} /tmp/ \;
      unset MY_VIM_SERVERNAME ;
}

beep() { echo -e '\a' ; (paplay /usr/share/sounds/gnome/default/alerts/drip.ogg &) }
beep_error() { echo -e '\a'; (paplay /usr/share/sounds/ubuntu/stereo/dialog-error.ogg &) }
beep_chkerr() { if test $? -eq 0; then beep ; else beep_error ; fi; }

#tag() { echo "awful.tag.selected().name=\"$1\"" |  awesome-client ; }
tag() {
   if [ $# -eq 1 ]; then
      echo -e "awful = require(\"awful\")\nawful.tag.selected().name=\"$1\"" |  awesome-client ;
   fi
   if [ $# -eq 2 ]; then
      echo -e "tags[mouse.screen][$2].name=\"$1\"" |  awesome-client ;
   fi
   if [ $# -eq 3 ]; then
       echo -e  "tags[$3][$2].name=\"$1\"" |  awesome-client ;
   fi
}

# management of .files in git
alias .git="GIT_DIR=~/.sync/.git git"

function m() {
        mplayer "${1/https/http}" -loop 0
        return $?
}

alias sssh="TERM=xterm ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
function fr () { find "${2:-.}" -name "$1" -exec readlink -f '{}' \; ; }

function check_preexec(){
	for i in "${!preexec_functions[@]}"
	do
		echo "preexec_functions[$i]: ${preexec_functions[$i]}"
		[ -n "$1" ] &&  type "${preexec_functions[$i]}" |& sed 's/^/  /'
	done
}

#$1 nb tick
#$2 time of one ticks (default 5min)
function ccwait(){
  local nb=$1
  local t=${2:-5}
  for i in $(seq "$nb") ; do
    sleep $(( t * 60 ))
    echo "$i ticks ellapsed, remain $(( nb - i )) * $t min"
  done
  beep
}
