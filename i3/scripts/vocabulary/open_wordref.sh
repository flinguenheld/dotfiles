#!/bin/sh

if [[ $button == 1 ]]; then
    sed -n 1p ~/.config/i3/scripts/vocabulary/links.txt | bash
elif [[ $button == 3 ]]; then
    sed -n 2p ~/.config/i3/scripts/vocabulary/links.txt | bash
fi
