#!/usr/bin/python
# 2022 - Florent Linguenheld

""" Impressive script to display vocabulary in the bar !

    Put files with words in the folder 'words'.
    Files have to be in .txt and have just one word per line (words with several parts are ok but the
    result with WordReference is not sure)

    This script will take randomly one file then one word and scrap it on WordReference.com.

    Then it will fill the file 'current.txt' with :
        - line 1 : a command to open www.wordreference.com on the word page.
        - line 2 : same with www.macmillandictionary.com.
        - line 3 : a html sentence with the word and its defintion to display in the bar. """

from random import randint
from pathlib import Path
from os import listdir

from scrap_wordref import scrap_wordref

PATH = f'{Path.home()}/.config/i3/scripts/vocabulary/'
PATH_WORDS = f'{PATH}words/'

words = []

# Choose a file and read it
files_list = listdir(PATH_WORDS)
with open(f'{PATH_WORDS}{files_list[randint(0, len(files_list)-1)]}', 'r') as file:
    pass

    for line in file:
        words.append(line[:-1])

# Randomise one word and scrap !
word = words[randint(0, len(words) - 1)]

# word = 'aurniset'
# Scrap on wordReference.com
dict = scrap_wordref(word)

# Build the html sentence
formated_text = str()

if 'error' in dict:
    formated_text += "<span foreground='#EBB4A2'><b>English words</b> : </span>"
    formated_text += f"<span foreground='#FFF'>{dict['error']} (with : {word})</span>"

elif 'notfound' in dict:
    formated_text += f"<span foreground='#A1C5DA'><b>{word}</b> : </span>"
    formated_text += f"<span foreground='#EBB4A2'>{dict['notfound']}</span>"

else:

    for key, translation in dict.items():

        formated_text += f"<span foreground='#A1C5DA'><b>{translation['word']}</b></span>"
        formated_text += f" - <span foreground='#AED4EB' font-style='italic'>({translation['type']})</span>"
        formated_text += f" - <span foreground='#FFF'>{translation['synonym']}</span>"
        formated_text += f" - <span foreground='#EBB4A2' font-style='italic'>{translation['translation']}</span>"
        formated_text += f" - <span foreground='#F2F2F2'><small>{key}/{len(dict)}</small></span>"
        formated_text += '\n'

# Fill file
word = word.replace(' ', '%20')
with open(f'{PATH}/links.txt', 'w') as file:
    file.write(f'i3-msg -q exec firefox https://www.wordreference.com/enfr/{word}\n')
    file.write(f'i3-msg -q exec firefox https://www.macmillandictionary.com/dictionary/british/{word}\n')

with open(f'{PATH}/translations.txt', 'w') as file:
    file.write('current=2\n')
    file.write(f'{formated_text}')
