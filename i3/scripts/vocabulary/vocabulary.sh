#!/bin/sh
# 2022 - Florent Linguenheld

# Manage the impressive script to display vocabulary in the bar !
# A word has usually several translations, that is why you can clic :
#       button 1 to display the next meaning
#       button 3 to display the previous meaning
#
# Or generate a new word with the button 3
#
# The scrip vocabulary.py generates randomly a new word.
# Then it writes one html sentence per meaning on the file : 'translations.txt'
# The first file line is reserved for the index of the current translation


# read the current index line displayed and count the possibilities
declare -i current_line=$(awk -F '=' '/^current/ {print $2}' ~/.config/i3/scripts/vocabulary/translations.txt)
declare -i nb_lines=$(wc -l ~/.config/i3/scripts/vocabulary/translations.txt | awk '{ print $1 }')
declare -i new_line=$current_line


# If there is a clic, change the index and erase the value
if [[ $button == 1 ]]; then

    let new_line++
    if [ "$new_line" -gt "$nb_lines" ]; then
        new_line=2
    fi
    sed -i "s/current=${current_line}/current=${new_line}/" ~/.config/i3/scripts/vocabulary/translations.txt

elif [[ $button == 3 ]]; then

    let new_line--
    if [ "$new_line" -lt 2 ]; then
        new_line=$nb_lines
    fi
    sed -i "s/current=${current_line}/current=${new_line}/" ~/.config/i3/scripts/vocabulary/translations.txt

# Generate a new word
else
    ~/.config/i3/scripts/vocabulary/vocabulary.py
    new_line=2
fi

# Display the selected line
sed -n "$new_line"p ~/.config/i3/scripts/vocabulary/translations.txt | head
