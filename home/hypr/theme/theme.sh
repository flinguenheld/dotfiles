#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>
##
## Script To Apply Themes

## Theme ------------------------------------
DIR="$HOME/.config/hypr"

## Directories ------------------------------
PATH_MAKO="$DIR/mako"
PATH_ROFI="$DIR/rofi"
PATH_WAYB="$DIR/waybar"

## Source Theme File ------------------------
CURRENT_THEME="$DIR/theme/current.bash"
DEFAULT_THEME="$DIR/theme/default.bash"
PYWAL_THEME="$HOME/.cache/wal/colors.sh"

## Check if current file exist
if [[ ! -e "$CURRENT_THEME" ]]; then
	touch "$CURRENT_THEME"
fi

## Default Theme
source_default() {
	cat ${DEFAULT_THEME} > ${CURRENT_THEME}
	source ${CURRENT_THEME}
	altbackground="`pastel color $background | pastel lighten 0.10 | pastel format hex`"
	altforeground="`pastel color $foreground | pastel darken 0.30 | pastel format hex`"
	modbackground=(`pastel gradient -n 3 $background $altbackground | pastel format hex`)
	accent="$color4"
	notify-send -h string:x-canonical-private-synchronous:sys-notify-dtheme -u normal -i ${PATH_MAKO}/icons/palette.png "Applying Default Theme..."
}

## Random Theme
source_pywal() {
	# Set you wallpaper directory here.
	WALLDIR="`xdg-user-dir PICTURES`/wallpapers"

	# Check for wallpapers
	check_wallpaper() {
		if [[ -d "$WALLDIR" ]]; then
			WFILES="`ls --format=single-column $WALLDIR | wc -l`"
			if [[ "$WFILES" == 0 ]]; then
				notify-send -h string:x-canonical-private-synchronous:sys-notify-noimg -u low -i ${PATH_MAKO}/icons/picture.png "There are no wallpapers in : $WALLDIR"
				exit
			fi
		else
			mkdir -p "$WALLDIR"
			notify-send -h string:x-canonical-private-synchronous:sys-notify-noimg -u low -i ${PATH_MAKO}/icons/picture.png "Put some wallpapers in : $WALLDIR"
			exit
		fi
	}

	# Run `pywal` to generate colors
	generate_colors() {	
		check_wallpaper
		if [[ `which wal` ]]; then
			notify-send -t 50000 -h string:x-canonical-private-synchronous:sys-notify-runpywal -i ${PATH_MAKO}/icons/timer.png "Generating Colorscheme. Please wait..."
			wal -q -n -s -t -e -i "$WALLDIR"
			if [[ "$?" != 0 ]]; then
				notify-send -h string:x-canonical-private-synchronous:sys-notify-runpywal -u normal -i ${PATH_MAKO}/icons/palette.png "Failed to generate colorscheme."
				exit
			fi
		else
			notify-send -h string:x-canonical-private-synchronous:sys-notify-runpywal -u normal -i ${PATH_MAKO}/icons/palette.png "'pywal' is not installed."
			exit
		fi
	}

	generate_colors
	cat ${PYWAL_THEME} > ${CURRENT_THEME}
	source ${CURRENT_THEME}
	altbackground="`pastel color $background | pastel lighten 0.10 | pastel format hex`"
	altforeground="`pastel color $foreground | pastel darken 0.30 | pastel format hex`"
	modbackground=(`pastel gradient -n 3 $background $altbackground | pastel format hex`)
	accent="$color4"
}

## Wallpaper ---------------------------------
apply_wallpaper() {
	sed -i -e "s#WALLPAPER=.*#WALLPAPER='$wallpaper'#g" ${DIR}/scripts/wallpaper
	bash ${DIR}/scripts/wallpaper &
}

## Mako --------------------------------------
apply_mako() {
	# mako : config
	sed -i '/# Mako_Colors/Q' ${PATH_MAKO}/config
	cat >> ${PATH_MAKO}/config <<- _EOF_
		# Mako_Colors
		background-color=${background}
		text-color=${foreground}
		border-color=${modbackground[1]}
		progress-color=over ${accent}

		[urgency=low]
		border-color=${modbackground[1]}
		default-timeout=2000

		[urgency=normal]
		border-color=${modbackground[1]}
		default-timeout=5000

		[urgency=high]
		border-color=${color1}
		text-color=${color1}
		default-timeout=0
	_EOF_

	pkill mako && bash ${DIR}/scripts/notifications &
}

## Rofi --------------------------------------
apply_rofi() {
	# rofi : colors
	cat > ${PATH_ROFI}/shared/colors.rasi <<- EOF
		* {
		    background:     ${background};
		    background-alt: ${modbackground[1]};
		    foreground:     ${foreground};
		    selected:       ${accent};
		    active:         ${color2};
		    urgent:         ${color1};
		}
	EOF
}

## Waybar ------------------------------------
apply_waybar() {
	# waybar : colors
	cat > ${PATH_WAYB}/colors.css <<- EOF
		/** ********** Colors ********** **/
		@define-color background      ${background};
		@define-color background-alt1 ${modbackground[1]};
		@define-color background-alt2 ${modbackground[2]};
		@define-color foreground      ${foreground};
		@define-color selected        ${accent};
		@define-color black           ${color0};
		@define-color red             ${color1};
		@define-color green           ${color2};
		@define-color yellow          ${color3};
		@define-color blue            ${color4};
		@define-color magenta         ${color5};
		@define-color cyan            ${color6};
		@define-color white           ${color7};
	EOF

	pkill waybar && bash ${DIR}/scripts/statusbar &
}

## Hyprland --------------------------------------
apply_hypr() {
	# hyprland : theme
	sed -i ${DIR}/hyprtheme.conf \
		-e "s/\$active_border_col_1 =.*/\$active_border_col_1 = 0xFF${accent:1}/g" \
		-e "s/\$active_border_col_2 =.*/\$active_border_col_2 = 0xFF${color1:1}/g" \
		-e "s/\$inactive_border_col_1 =.*/\$inactive_border_col_1 = 0xFF${modbackground[1]:1}/g" \
		-e "s/\$inactive_border_col_2 =.*/\$inactive_border_col_2 = 0xFF${modbackground[2]:1}/g" \
		-e "s/\$group_border_active_col =.*/\$group_border_active_col = 0xFF${color2:1}/g" \
		-e "s/\$group_border_inactive_col =.*/\$group_border_inactive_col = 0xFF${color3:1}/g" \
		-e "s/\$group_border_locked_active_col =.*/\$group_border_locked_active_col = 0xFF${color1:1}/g" \
		-e "s/\$group_border_locked_inactive_col =.*/\$group_border_locked_inactive_col = 0xFF${color4:1}/g" \
		-e "s/\$groupbar_text_color =.*/\$groupbar_text_color = 0xFF${foreground:1}/g"
}

## Source Theme Accordingly -----------------
if [[ "$1" == '--default' ]]; then
	source_default
elif [[ "$1" == '--pywal' ]]; then
	source_pywal
else
	echo "Available Options: --default  --pywal"
	exit 1
fi

## Execute Script ---------------------------
apply_wallpaper
apply_mako
apply_rofi
apply_waybar
apply_hypr
