#!/bin/bash

TXT=$(expressvpn status | grep --fixed-strings "Not connected")

if [[ -z $TXT ]]
then
  TXT=$(expressvpn status | grep --fixed-strings "Connected to" | cut --delimiter="m" --field=2-5)
fi

if [[ -z $TXT ]]
then
  TXT="Wait ..."
fi

echo $TXT
