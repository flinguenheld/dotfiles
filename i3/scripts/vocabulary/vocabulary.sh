#!/bin/sh
# 2022 - Florent Linguenheld

# Manage the impressive script to display vocabulary in the bar !
# button 1 to open wordref
# button 2 to open macmilland
# button 3 to force generating a new word
#
# Generate a new word in the file 'current.txt' and read the third line
# The latter contains a html sentence to display


if [[ $button == 1 ]]; then
    sed -n 1p ~/.config/i3/scripts/vocabulary/current.txt | bash
elif [[ $button == 2 ]]; then
    sed -n 2p ~/.config/i3/scripts/vocabulary/current.txt | bash
elif [[ $button == 3 ]]; then
    ~/.config/i3/scripts/vocabulary/vocabulary.py
else
    ~/.config/i3/scripts/vocabulary/vocabulary.py
fi
    sed -n 3p ~/.config/i3/scripts/vocabulary/current.txt | head

