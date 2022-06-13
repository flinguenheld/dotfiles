#!/usr/bin/python
# 2022 - Florent Linguenheld

""" Impressive script to display vocabulary in the bar !

    Put files with words in the folder 'words'.
    These files have to contain one word per line (words with several parts are ok but the
    result with WordReference is not sure)

    This script will take randomly one file then one word and scrap it on WordReference.com.

    Then it will fill two files :
        links.txt :
            - line 1 : a command to open www.wordreference.com on the word page.
            - line 2 : same with www.macmillandictionary.com.

        translations.txt
            - line 1 : current=2 (the number of the current displayed line)
            - line … : a html sentence with the word and its defintion to display in the bar. """

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
    for line in file:
        words.append(line[:-1])

# Randomise one word and scrap !
word = words[randint(0, len(words) - 1)]

# word = 'TestWordNotFound'
# Scrap on wordReference.com (exclude "traductions supplémetaires" and "formes composées")
dict = scrap_wordref(word, nb_without_id=1, id_to_include=['phrasal_verbs'])

# Build the html sentence
formated_text = str()

if 'error' in dict:
    formated_text += "<span foreground='#E53838'><b>English words</b> : </span>"
    formated_text += f"<span foreground='#FFF'>{dict['error']} (with : {word})</span>"
    formated_text += '\n'  # Jump mandatory !

elif 'notfound' in dict:
    formated_text += f"<span foreground='#1CB0F6'><b>{word}</b> : </span>"
    formated_text += f"<span foreground='#E53838'>{dict['notfound']}</span>"
    formated_text += '\n'

else:
    for key, translation in dict.items():

        formated_text += f"<span foreground='#1CB0F6'><b>{translation['word']}</b></span>"
        formated_text += f" - <span foreground='#14d4f4' font-style='italic'>({translation['type']})</span>"
        formated_text += f" - <span foreground='#FFF'>{translation['synonym']}</span>"
        formated_text += f" - <span foreground='#E53838' font-style='italic'>{translation['translation']}</span>"
        formated_text += f" - <span foreground='#F2F2F2'><small>{key}/{len(dict)}</small></span>"
        formated_text += '\n'

# Fill files
word = word.replace(' ', '%20')
with open(f'{PATH}/links.txt', 'w') as file:
    file.write(f'i3-msg -q exec brave-browser https://www.wordreference.com/enfr/{word}\n')
    file.write(f'i3-msg -q exec brave-browser https://www.macmillandictionary.com/dictionary/british/{word}\n')

with open(f'{PATH}/translations.txt', 'w') as file:
    file.write('current=2\n')
    file.write(f'{formated_text}')


# if __name__ == "__main__":
#     with open(f'{PATH}links.txt', 'r') as file:
#         for line in file:
#             print(line[:-1])

#     print('--')
#     with open(f'{PATH}translations.txt', 'r') as file:
#         for line in file:
#             print(line[:-1])


