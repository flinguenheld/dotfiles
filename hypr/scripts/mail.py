#!/usr/bin/env python

import imaplib
import keyring

password = keyring.get_password('mail', 'flo')

obj = imaplib.IMAP4_SSL('mail.gandi.net',993)
obj.login('florent@linguenheld.fr', password if password else '')
obj.select()
number = len(obj.search(None, 'UnSeen')[1][0].split())
if number>0:
    print(str(number) + ' 🖂')
else:
    print('')
