#!/usr/bin/python

import argparse
import os
from time import sleep

parser = argparse.ArgumentParser()
parser.add_argument('-l', '--lock', action='store_true', help='Launch i3lock')
parser.add_argument('-e', '--logout', action='store_true', help='Exit the current session')
parser.add_argument('-s', '--sleep', action='store_true', help='Suspend')
parser.add_argument('-r', '--reboot', action='store_true', help='Reboot now')
parser.add_argument('-o', '--poweroff', action='store_true', help='Shutdown now')
args = parser.parse_args()


sleep(1)

if args.lock:
    os.system("i3lock")
elif args.logout:
    os.system("i3-msg exit")
elif args.sleep:
    os.system("systemctl suspend")
elif args.reboot:
    os.system("systemctl reboot")
else:
    os.system("systemctl poweroff")
