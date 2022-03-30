#!/usr/bin/env python3

"""
This script extracts all birthday-entries from abook and creates recurring appointments in calcurse.

abook:
    Abook is a text-based addressbook program designed to use with mutt mail client.
    (--> https://abook.sourceforge.io/)

calcurse:
    calcurse is a calendar and scheduling application for the command line.
    (--> https://www.calcurse.org/)
"""


### Imports ###
import re
from os import path
from datetime import datetime as dt

from config import *


### Code ###

def _check_files():
    """ Checks if needed files from abook and calcurse are found. """
    infile = path.join(DIR_ABOOK, "addressbook")
    outfile = path.join(DIR_CALCURSE, "apts")

    for file in [infile, outfile]:
        if path.isfile(file):
            pass
        else:
            exit(f"{file} could not be found.")
    return infile, outfile


def _pull_calcurse(file):
    """ Extracts all birthdays that are stored in calcurse as a set. """
    pattern = f"\d\d\/\d\d\/\d{4} \[1\] {{1Y}} {BIRTHDAY} .*"
    st = set()
    with open(file, 'r') as f:
        data = f.read()
        ite = re.finditer(pattern, data)
    for i in ite:
        bday, name = i[0].split(f'{BIRTHDAY} ')
        bday = dt.strptime(bday[:10], '%m/%d/%Y')
        st.add((name, bday))
    return st


def _pull_abook(file):
    """ Extracts all birthdays that are stored in abook as a set. """
    pattern = "name=.*\nbirthday=(\d{4}|-)-.*"
    st = set()
    with open(file, 'r') as f:
        data = f.read()
        ite = re.finditer(pattern, data)
    for i in ite:
        name = i[0].split('\n')[0][5:]
        bday = _reformat_date(i[0].split('birthday=')[1][:10])
        st.add((name, bday))
    return st


def _reformat_date(indate):
    """ Formats the date from abook-format to datetimeobject. """
    if indate[0] == "-":
        outdate = dt.strptime(indate, '--%m-%d')
    else:
        outdate = dt.strptime(indate, '%Y-%m-%d')
    return outdate


def _write_to_calcurse(outfile, st):
    """ Adds all birthday-entries above other existent appointments in calcurse apts-file. """
    pattern = f"\d\d\/\d\d\/\d{4} \[1\] {{1Y}} {BIRTHDAY} .*\n"
    with open(outfile, 'r+') as f:
        data = re.sub(pattern, '', f.read())
        f.seek(0)
        f.truncate()
        for tpl in st:
            date = dt.strftime(tpl[1], '%m/%d/%Y')
            f.write(f"{date} [1] {{1Y}} {BIRTHDAY} {tpl[0]}\n")
        f.write(data)


def main():
    infile, outfile = _check_files()
    combined_set = _pull_abook(infile) | _pull_calcurse(outfile)
    _write_to_calcurse(outfile, combined_set)


if __name__ == "__main__":
    main()
