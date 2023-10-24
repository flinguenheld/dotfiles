#!/bin/bash

COLOR=$(hyprpicker)
IMAGE=/tmp/${COLOR}.png

if [[ "$COLOR" ]]; then
	# copy COLOR code to clipboard
	echo $COLOR | tr -d "\n" | wl-copy
	# generate preview
	convert -size 48x48 xc:"$COLOR" ${IMAGE}
	# notify about it
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i ${IMAGE} "$COLOR, copied to clipboard."
fi
