#!/bin/bash

function move_sinks_to_new_default {
    DEFAULT_SINK=$1
    pactl list sink-inputs | grep 'Sink Input #' | grep -o '[0-9]\+' | while read SINK
    do
        pactl move-sink-input $SINK $DEFAULT_SINK
    done
}

inc=${1:-1}
num_devices=$(pactl list sinks | grep -c Name:)
sink_arr=($(pactl list sinks | grep Name: | sed -r 's/\s+Name: (.+)/\1/'))
default_sink=$(pactl get-default-sink)
default_sink_index=$(for i in "${!sink_arr[@]}"; do if [[ "$default_sink" = "${sink_arr[$i]}" ]]; then echo "$i"; fi done)
default_sink_index=$(( ($default_sink_index + $num_devices + $inc) % $num_devices ))
default_sink=${sink_arr[$default_sink_index]}
pactl set-default-sink $default_sink
