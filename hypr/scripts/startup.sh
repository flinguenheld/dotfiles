#!/bin/bash

#wallpaper fetcher and wallpaper rotator
#type "var" in a terminal to change settings - example
#variety &

SCRIPTSDIR=$HOME/.config/hypr/scripts

# Kill already running process
_ps=(waybar mako)
for _prs in "${_ps[@]}"; do
	if [[ $(pidof ${_prs}) ]]; then
		killall -9 ${_prs}
	fi
done

# Apply themes
${SCRIPTSDIR}/gtkthemes.sh &

# Lauch notification daemon (mako)
${SCRIPTSDIR}/notifications.sh &

# Lauch statusbar (waybar)
${SCRIPTSDIR}/statusbar.sh &

# Xauthority
${SCRIPTSDIR}/xauthority.sh &

dex $HOME/.config/autostart/arcolinux-welcome-app.desktop &

#insync start &
#dropbox &
#telegram-desktop &
#discord &
#nm-applet --indicator
