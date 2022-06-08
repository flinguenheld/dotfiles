#!/usr/bin/python
import os


stream = os.popen('expressvpn status')
output = stream.read()

text = "<span foreground='#F24405'><b> Impossible de lire le status d'expressvpn</b></span>"
for line in output.split('\n'):
    if 'Connected to' in line:
        text = f"<span foreground='#9EF8EE'> {line[10:]}</span>"
        break

    elif 'Not connected' in line:
        text = f"<span foreground='#FA7F08'> {line}</span>"
        break

print(text)
