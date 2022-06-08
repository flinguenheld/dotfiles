#!/usr/bin/python
# 2022 - Florent Linguenheld

import requests
from bs4 import BeautifulSoup
import re


UNWANTED_CHARACTERS = r'[(⇒)]'


def scrap_wordref(word):
    """ Go to wordref, parse and return a dictionary with the first meaning.
        word, type, synonym, translation.

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
                for i, td in enumerate(soup.find('table', class_='WRD').find('tr', class_='even')):

                    match i:
                        case 0:
                            result['word'] = re.sub(UNWANTED_CHARACTERS, '', td.find('strong').text)
                            result['type'] = td.find('em').find(text=True)

                        case 1:
                            in_brackets = re.findall(r'\(.*?\)', td.text)
                            in_brackets = [re.sub(UNWANTED_CHARACTERS, '', t) for t in in_brackets]
                            result['synonym'] = ' - '.join(in_brackets)

                        case default:
                            result['translation'] = re.sub(UNWANTED_CHARACTERS, '', td.find(text=True))

        else:
            result['error'] = "Bad url"

    except Exception as err:
        result['error'] = 'Error connection'
        result['error-msg'] = {err}

    return result


if __name__ == "__main__":
    print(scrap_wordref('work on'))
    print(scrap_wordref('chicken'))
