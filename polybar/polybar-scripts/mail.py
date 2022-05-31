#!/usr/bin/python
import imaplib
from pathlib import Path


def file(path):
    with open(path, 'r') as f:
        return f.readline(6)


p = ''
for i, j in zip(file(f'{Path.home()}/.pous'), file(f'{Path.home()}/.config/.carp')):
    p += f'{i}{j}'


obj = imaplib.IMAP4_SSL('mail.gandi.net', 993)
obj.login('florent@linguenheld.fr', p)
obj.select()
number = len(obj.search(None, 'UnSeen')[1][0].split())
if number > 0:
    print(number)
else:
    print('')
