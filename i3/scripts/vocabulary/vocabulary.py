#!/usr/bin/python
# 2022 - Florent Linguenheld

""" Impressive script to display vocabulary in the bar !

    Fill the file 'words.txt' with a list (one word per line).
    This script will take randomly one word and scrap it on WordReference.com.

    Then it will fill the file 'current.txt' with :
        - line 1 : a command to open www.wordreference.com on the word page.
        - line 2 : same with www.macmillandictionary.com.
        - line 3 : a html sentence with the word and its defintion to display in the bar. """

from random import randint
from pathlib import Path

from scrap_wordref import scrap_wordref

PATH = f'{Path.home()}/.config/i3/scripts/vocabulary/'

# Read the list words file
words = []
with open(f'{PATH}/words.txt', 'r') as file:
    pass

    for line in file:
        words.append(line[:-1])

# Randomise one and scrap !
word = words[randint(0, len(words) - 1)]

# Scrap on wordReference.com
dict = scrap_wordref(word)

# Build the sentence
if 'error' in dict:
    formated_text = "<span foreground='#EBB4A2'><b>English words</b> : </span>"
    formated_text += f"<span foreground='#FFF'>{dict['error']}</span>"

elif 'notfound' in dict:
    formated_text = f"<span foreground='#A1C5DA'><b>{word}</b> : </span>"
    formated_text += f"<span foreground='#EBB4A2'>{dict['notfound']}</span>"

else:
    formated_text = f"<span foreground='#A1C5DA'><b>{dict['word']}</b></span>"
    formated_text += f" - <span foreground='#AED4EB' font-style='italic'>({dict['type']})</span>"
    formated_text += f" - <span foreground='#FFF'>{dict['synonym']}</span>"
    formated_text += f" - <span foreground='#EBB4A2' font-style='italic'>{dict['translation']}</span>"

# Fill file
with open(f'{PATH}/current.txt', 'w') as file:
    file.write(f'i3-msg -q exec firefox https://www.wordreference.com/enfr/{word}\n')
    file.write(f'i3-msg -q exec firefox https://www.macmillandictionary.com/dictionary/british/{word}\n')
    file.write(f'{formated_text}\n')  # Jump mandatory to i3bar
