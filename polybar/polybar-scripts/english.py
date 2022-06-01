#!/usr/bin/python

import csv
from random import randint
from pathlib import Path


table = []
path = f'{Path.home()}/.config/polybar/polybar-scripts/words.csv'
with open(path, newline='') as csvfile:
    reader = csv.reader(csvfile)

    for row in reader:
        table.append(' - '.join(row))


print(table[randint(0, len(table) - 1)])
