#!/bin/bash

# FLinguenheld 2023
# This script allows to set the next default source
# You can use pavucontrol to activate/deactivates sinks

SOURCE=$(pactl list short sources | grep input | awk '{print $2}' | tr '\n' ' ')

CURRENT=$(pactl info | grep 'Default Source' | awk '{print $3}')
NEW=$(echo ${SOURCE} | awk -F ${CURRENT} '{print $2}' | awk '{print $1}')

# Take the first one if it was the last
if [[ -z ${NEW} ]]
then
    NEW=$(echo ${SOURCE} | awk '{print $1}')
fi

pactl set-default-source ${NEW}
exit 0
