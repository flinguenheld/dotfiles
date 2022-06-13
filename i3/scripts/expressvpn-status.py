#!/usr/bin/python

import os


stream = os.popen('expressvpn status')
output = stream.read()

icon = "<span size='x-large'></span>"
text = f"<span foreground='#e53838'>{icon} </span><b>Impossible de lire le status d'expressvpn</b>"
for line in output.split('\n'):
    if 'Connected to' in line:
        text = f"<span foreground='#8ee000'>{icon} </span>{line[10:]}"
        break

    elif 'Not connected' in line:
        text = f"<span foreground='#faa918'>{icon} {line}</span>"
        break

print(text)
