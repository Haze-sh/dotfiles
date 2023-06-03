#!/bin/sh

cd $HOME/ledger-web
virtualenv .venv
. .venv/bin/activate
./manage.py runserver
