#use by ubuntu 12.04 for startx command

gnome-settings-daemon &      # handles themes, starts gnome-screensaver. You may have to use gconf to disable it setting the background.
#nm-applet &                  # assuming you're using Network Manager
#gnome-power-manager &        # for laptops and stuff
#gnome-volume-manager &       # for mounting CDs, USB sticks, and such
#nautilus --no-desktop &
eval `gnome-keyring-daemon`  # SSH/GPG agent

if [ -x .xsession.$(hostname) ]; then
	. $HOME/.xsession.$(hostname)
fi

exec awesome                 # awesome receives xinit's process id; when it terminates, X will be terminated
