#!/bin/bash

## Set GTK Themes, Icons, Cursor and Fonts

THEME='Arc-Dark'
ICONS='a-candy-beauty-icon-theme'
CURSOR='Bibata-Modern-Ice'

# FONT='Noto Sans 11'
FONT='Noto Sans 10'
# FONT='CaskaydiaCove 10'

SCHEMA='gsettings set org.gnome.desktop.interface'

apply_themes() {
	${SCHEMA} gtk-theme "$THEME"
	${SCHEMA} icon-theme "$ICONS"
	${SCHEMA} cursor-theme "$CURSOR"
	${SCHEMA} font-name "$FONT"
}

apply_themes
