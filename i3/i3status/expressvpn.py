#!/usr/bin/python

import os


class Py3status:

    icon = "<span font-size='130%'></span>"

    def expressvpn(self):

        stream = os.popen('expressvpn status')
        output = stream.read()

        text = f"<span foreground='#e53838'>{self.icon} </span><b>Impossible de lire le status d'expressvpn</b>"
        for line in output.split('\n'):
            if 'Connected to' in line:
                text = f"<span foreground='#8ee000'>{self.icon} </span>{line[10:]}"
                break

            elif 'Not connected' in line:
                text = f"<span foreground='#faa918'>{self.icon} {line}</span>"
                break

        return {
            'full_text': text,
            'cached_until': self.py3.time_in(3)
        }
