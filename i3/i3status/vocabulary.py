#!/usr/bin/python3

from random import randint
from pathlib import Path
from os import listdir
import webbrowser

import requests
from bs4 import BeautifulSoup
import re


class Py3status:

    """
    Practice your English vocabulary.

    This module displays text to practice your english vocabulary like this :
        word - type - synonym - french translation - nb/total

    You have to create .txt files in the folder 'vocabulary/' and write one word per line.
    This module will opens randomly a file and takes one word.
    Then, it will scrap the website "www.wordreference.com" to find this word and pick up translations.
    (See the method '_scrap_wordref' for more details)

    You can use the scroll wheel to display the next/previous translation of this word.
    You can use the left or the right button to open wordreference or macmillan dictionary on firefox.
    Finally, click on other button to generate a new word.

    Format placeholders:
        cycle: Time to generate a new word
            (default '300 seconds')

    Color options:
        color_word = '#1cb0f6'
        color_type = '#14d4f4'
        color_synonym = '#ffffff'
        color_translation = '#e53838'
        color_index = '#f2f2f2'
        color_error = '#e53838'

    Requires:
        requests
        BeautifulSoup

    @author: Florent Linguenheld
    """

    PATH_WORDS = f'{Path.home()}/.config/i3/i3status/vocabulary/'
    UNWANTED_CHARACTERS = r'[(⇒)]'

    cycle = 300

    def vocabulary(self):

        # Don't scrap after an user clic !
        if self.py3.storage_get('on_clic'):
            self.py3.storage_set('on_clic', False)

        else:

            # Choose a file and read it
            words = []
            files_list = listdir(self.PATH_WORDS)
            with open(f'{self.PATH_WORDS}{files_list[randint(0, len(files_list)-1)]}', 'r') as file:
                for line in file:
                    words.append(line[:-1])

            # Randomise one word and scrap !
            selected_word = words[randint(0, len(words) - 1)]
            self._scrap_wordref(word=selected_word, nb_without_id=1, id_to_include=['phrasal_verbs'])

        # --
        # Build the full text with the current translation
        full_text = str()

        # print(self.py3.storage_get('error'))
        test = self.py3.storage_get('error')
        # if self.py3.storage_get('error'):
        if test:
            full_text += "<span foreground='#E53838'><b>English words</b> : </span>"
            full_text += f"{self.py3.storage_get('error-msg')[:60]}…"

        else:
            words = self.py3.storage_get('words')
            current_index = self.py3.storage_get('current_index')

            # full_text += f"<span foreground='{self.color_word}'><b>{words[current_index]['word']}</b></span>"
            full_text += f"<span foreground='{self.py3.COLOR_WORD}'><b>{words[current_index]['word']}</b></span>"
            full_text += f" - <span foreground='{self.py3.COLOR_TYPE}' font-style='italic'>" \
                f"({words[current_index]['type']})</span>"
            full_text += f" - <span foreground='{self.py3.COLOR_SYNONYM}'>{words[current_index]['synonym']}</span>"
            full_text += f" - <span foreground='{self.py3.COLOR_TRANSLATION}' font-style='italic'>" \
                f"{words[current_index]['translation']}</span>"
            full_text += f" - <span foreground='{self.py3.COLOR_INDEX}'>" \
                f"<small>{current_index + 1}/{len(words)}</small></span>"

        return {
            'full_text': full_text,
            'cached_until': self.py3.time_in(self.cycle)
        }

    def on_click(self, event):
        """
        event will be a dict like
        {'y': 13, 'x': 1737, 'button': 1, 'name': 'example', 'instance': 'first'}
        """

        # Next / previous translation
        if event['button'] == 4 or event['button'] == 5:

            if event['button'] == 5:
                new_index = self.py3.storage_get('current_index') + 1

                if new_index >= len(self.py3.storage_get('words')):
                    new_index = 0

            elif event['button'] == 4:
                new_index = self.py3.storage_get('current_index') - 1

                if new_index < 0:
                    new_index = len(self.py3.storage_get('words')) - 1

            self.py3.storage_set('current_index', new_index)
            self.py3.storage_set('on_clic', True)

        # Open wordreference and mac
        elif event['button'] == 1:
            webbrowser.get('firefox').open(f"https://www.wordreference.com/enfr/{self.py3.storage_get('current_word')}")
            self.py3.storage_set('on_clic', True)

        elif event['button'] == 3:
            webbrowser.get('firefox').open(f"https://www.macmillandictionary.com/dictionary/british/{self.py3.storage_get('current_word').replace(' ', '-')}")
            self.py3.storage_set('on_clic', True)

    # --
    def _scrap_wordref(self, word, nb_without_id=2, id_to_include=['phrasal_verbs', 'compound_forms']):
        """
        Scrap the website www.wordreference.com
        It tries to access to the word's page. If ok, makes the soup and loops in div to find translations.
        It will take the first line for each translation with fields : word, type, synonym, translation.

        The translation number could be important, by default it will take the two first parts, the phrasal_verbs
        and the compound_forms parts.

        All fields are saved in a dictionary. The latter will be saved in the py3.storage 'words'.
        If error, it will put the py3.storage field 'error' on True

        parameters:
            word : to search
            nb_without_id : (default 2) number of <table> without id to scrap (see the wordreference website)
            id_to_include : (default phrasal_verbs, compound_forms) <table> with id to scrap
        """

        self.py3.storage_set('error', True)
        self.py3.storage_set('error-msg', "")
        self.py3.storage_set('words', "")
        self.py3.storage_set('current_index', 0)
        self.py3.storage_set('current_word', word)

        try:
            page = requests.get(f'https://www.wordreference.com/enfr/{word}')

            if page.status_code == 200:
                html_text = page.text

                soup = BeautifulSoup(html_text, 'html.parser')

                if soup.find('div', id='noTransFound'):
                    self.py3.storage_set('error-msg', f"{word} doesn't exist in WordRef")

                else:

                    result = []
                    for i, tr in enumerate(soup.find_all('table', class_='WRD')):

                        if i < nb_without_id or 'id' in tr.attrs and tr.attrs['id'] in id_to_include:

                            for nested_tr in tr.find_all('tr'):

                                # Only the first line has an id (skip the others, they contain French synonyms and examples)
                                if 'id' in nested_tr.attrs:

                                    new_translation = dict()
                                    for j, td in enumerate(nested_tr.find_all('td')):

                                        if j == 0:
                                            new_translation['word'] = re.sub(self.UNWANTED_CHARACTERS, '', td.find('strong').text)
                                            new_translation['type'] = td.find('em').find(text=True).text if td.find('em').find(text=True) != None else ""

                                        elif j == 1:
                                            in_brackets = re.findall(r'\(.*?\)', td.text)
                                            in_brackets = [re.sub(self.UNWANTED_CHARACTERS, '', t) for t in in_brackets]
                                            new_translation['synonym'] = ' - '.join(in_brackets)

                                        else:
                                            new_translation['translation'] = re.sub(self.UNWANTED_CHARACTERS, '', td.find(text=True))

                                    result.append(new_translation)

                    self.py3.storage_set('error', False)
                    self.py3.storage_set('words', result)

            else:
                self.py3.storage_set('error-msg', f'Connexion error : {page.status_code}')

        except Exception as err:
            self.py3.storage_set('error-msg', str(err))


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
