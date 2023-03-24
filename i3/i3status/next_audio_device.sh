#!/bin/bash

# FLinguenheld 2023
# This script allows to set the next default sink
# You can use pavucontrol to activate/deactivates sinks

CURRENT=$(pactl info | grep 'Default Sink' | awk '{print $3}')
NEW=$(pactl list sinks | grep 'Name:' | awk '{print $2}' | tr '\n' ' ' | awk -F ${CURRENT} '{print $2}' | awk '{print $1}')

# Take the first one if it was the last
if [[ -z ${NEW} ]]
then
    NEW=$(pactl list sinks | grep 'Name:' | awk '{print $2}' | tr '\n' ' ' | awk '{print $1}')
fi

pactl set-default-sink ${NEW}
exit 0
