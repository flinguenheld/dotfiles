#!/usr/bin/python
import os


stream = os.popen('expressvpn status')
output = stream.read()

text = "Impossible de lire le status d'expressvpn"
for line in output.split('\n'):
    if 'Connected to' in line:
        text = line[10:]
        break

    elif 'Not connected' in line:
        text = line
        break

print(text)
