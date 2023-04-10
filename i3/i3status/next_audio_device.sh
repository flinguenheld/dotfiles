#!/bin/bash

# FLinguenheld 2023
# This script allows to set the next default sink/source
# You can use pavucontrol to activate/deactivate them


usage () {
    echo "Usage: ${0} : [o|i][h]"
    echo
    echo 'Set the next device Output/Input as the default device.'
    echo '   o:   set the output device (sink).'
    echo '   i:   set the input device (source).'
    echo '   h:   help.'
}

while getopts oih OPTION
do
    case ${OPTION} in
        o)
            TYPE='sinks'
            INOUT='output'
            DEFAULT='Default Sink'
            COMMAND=set-default-sink
            ;;
        i)
            TYPE='sources'
            INOUT='input'
            DEFAULT='Default Source'
            COMMAND=set-default-source
            ;;
        h)
            usage
            exit 0
            ;;
        ?)
            usage >&2
            exit 1
            ;;
    esac
done

if [[ ! -v TYPE ]]
then
    echo 'No argument given' >&2
    usage >&2
    exit 1
fi

# --
DEVICES=$(pactl list short "${TYPE}" | grep ${INOUT} | awk '{print $2}' | tr '\n' ' ')

CURRENT=$(pactl info | grep "${DEFAULT}" | awk '{print $3}')
NEW=$(echo "${DEVICES}" | awk -F "${CURRENT}" '{print $2}' | awk '{print $1}')

# Take the first one if it was the last
if [[ -z "${NEW}" ]]
then
    NEW=$(echo "${DEVICES}" | awk '{print $1}')
fi

pactl "${COMMAND}" ${NEW}
exit 0
