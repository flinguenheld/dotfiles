#!/usr/bin/python3

import os


class Py3status:

    def expressvpn(self):
        stream = os.popen('expressvpn status')
        output = stream.read()

        text = f"<span foreground='#e53838'> <b>Impossible de lire le status d'expressvpn</b></span>"
        for line in output.split('\n'):
            if 'Connected to' in line:
                text = f"<span foreground='#8ee000'> {line[10:]}</span>"
                break

            elif 'Not connected' in line:
                text = f"<span foreground='#faa918'> {line}</span>"
                break

        return {
            'full_text': text,
            'cached_until': self.py3.time_in(3)
        }
