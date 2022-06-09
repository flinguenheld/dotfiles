#!/usr/bin/python
# 2022 - Florent Linguenheld

import requests
from bs4 import BeautifulSoup
import re


UNWANTED_CHARACTERS = r'[(⇒)]'


def scrap_wordref(word):
    """ Go to www.wordreference.com on the 'word' page, parse the section 'Principales traductions'.
        Then, take the first line of each part and save :
            {word, type, synonym, translation}

        Usually, words have severals translations, this script will return a dictionary with one
        dictionary per translation.

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

                nb = 1
                for tr in soup.find('table', class_='WRD').find_all('tr'):

                    # Only the first line has an id
                    if 'id' in tr.attrs:

                        new_translation = {}
                        for j, td in enumerate(tr.find_all('td')):

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

    return result


if __name__ == "__main__":

    # result = scrap_wordref('work on')
    result = scrap_wordref('cold chisel')
    for k, r in result.items():
        print(f'{k} : {r}')
