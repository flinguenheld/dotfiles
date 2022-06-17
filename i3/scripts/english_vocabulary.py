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

import requests
from bs4 import BeautifulSoup
import re


UNWANTED_CHARACTERS = r'[(⇒)]'


class Py3status:

    PATH = f'{Path.home()}/.config/i3/scripts/vocabulary/'
    PATH_WORDS = f'{PATH}words/'

    words = []

    def english_vocabulary(self):

        # Choose a file and read it
        files_list = listdir(self.PATH_WORDS)
        with open(f'{self.PATH_WORDS}{files_list[randint(0, len(files_list)-1)]}', 'r') as file:
            for line in file:
                self.words.append(line[:-1])

        # Randomise one word and scrap !
        word = self.words[randint(0, len(self.words) - 1)]

        # word = 'TestWordNotFound'
        # Scrap on wordReference.com (exclude "traductions supplémetaires" and "formes composées")
        dict = self.scrap_wordref(word, nb_without_id=1, id_to_include=['phrasal_verbs'])

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
        with open(f'{self.PATH}/links.txt', 'w') as file:
            file.write(f'i3-msg -q exec brave-browser https://www.wordreference.com/enfr/{word}\n')
            file.write(f'i3-msg -q exec brave-browser https://www.macmillandictionary.com/dictionary/british/{word}\n')

        with open(f'{self.PATH}/translations.txt', 'w') as file:
            file.write('current=2\n')
            file.write(f'{formated_text}')

        return {
            'full_text': 'vocaaaaaaaaa',
            'cached_until': self.py3.time_in(3)
        }

    def scrap_wordref(self, word, nb_without_id=2, id_to_include=['phrasal_verbs', 'compound_forms']):
        """ Go to www.wordreference.com on the 'word' page and take the first line of each part to save :
                {word, type, synonym, translation}

            Words have often severals translations, this script will return a dictionary with one
            dictionary per translation.

            Their translations are organised in tables, usually :
                - Principales traductions
                − Traductions supplémentaires
                - Verbes à particule
                - Formes composées

            The two first don't have any id, so you can skip or include them with argument : 'nb_without_id'.
            And include others with their id with argument : 'id_to_include'.

            If the word doesn't exist in WordRef, return the dict with a 'notfound' field
            or with a 'error' field if there was a problem during the connection.
            (check 'error-msg' to display the error message) """

        result = {}

        try:
            page = requests.get(f'https://www.wordreference.com/enfr/{word}')

            if page.status_code == 200:
                html_text = page.text

                soup = BeautifulSoup(html_text, 'html.parser')

                if soup.find('div', id='noTransFound'):
                    result['notfound'] = "doesn't exist in wordref"

                else:

                    nb = 1  # Used as key in the dictionary
                    for i, tr in enumerate(soup.find_all('table', class_='WRD')):

                        if i < nb_without_id or 'id' in tr.attrs and tr.attrs['id'] in id_to_include:

                            for nested_tr in tr.find_all('tr'):

                                # Only the first line has an id (skip the others, they contain French synonyms and examples)
                                if 'id' in nested_tr.attrs:

                                    new_translation = {}
                                    for j, td in enumerate(nested_tr.find_all('td')):

                                        match j:
                                            case 0:
                                                new_translation['word'] = re.sub(UNWANTED_CHARACTERS, '', td.find('strong').text)
                                                new_translation['type'] = td.find('em').find(text=True)

                                            case 1:
                                                in_brackets = re.findall(r'\(.*?\)', td.text)
                                                in_brackets = [re.sub(UNWANTED_CHARACTERS, '', t) for t in in_brackets]
                                                new_translation['synonym'] = ' - '.join(in_brackets)

                                            case default:
                                                new_translation['translation'] = re.sub(UNWANTED_CHARACTERS, '', td.find(text=True))

                                    result[str(nb)] = new_translation
                                    nb += 1

            else:
                result['error'] = "Bad url"

        except Exception as err:
            result['error'] = 'Error connection'
            result['error-msg'] = err

        self.py3.storage_set('scraped', result)
        # return result


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)



# if __name__ == "__main__":
#     with open(f'{Path.home()}/.config/i3/scripts/vocabulary/links.txt', 'r') as file:
#         for line in file:
#             print(line[:-1])

#     print('--')
#     with open(f'{Path.home()}/.config/i3/scripts/vocabulary/translations.txt', 'r') as file:
#         for line in file:
#             print(line[:-1])


