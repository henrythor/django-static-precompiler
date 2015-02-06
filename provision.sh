#!/bin/bash

############
# packages #
############

sudo aptitude update
sudo aptitude install -y virtualenvwrapper python-dev ruby-dev node npm sqlite3

sudo gem install sass -v 3.4.9
sudo gem install compass -v 1.0.1

# Fix path to nodejs executable
if [ ! -e /usr/local/bin/node ]; then
    sudo ln -s /usr/bin/nodejs /usr/local/bin/node
fi

sudo npm install -g coffee-script@1.7.1
sudo npm install -g less@1.7.4


##############
# virtualenv #
##############

source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

# Create virtualenv
if [ ! -e ~/.virtualenvs/staticprecompiler ]; then
    mkvirtualenv staticprecompiler
fi

echo "cd /vagrant; export DJANGO_SETTINGS_MODULE=static_precompiler.tests.django_settings" > ~/.virtualenvs/staticprecompiler/bin/postactivate

workon staticprecompiler

if [ ! -e ~/.pip ]; then
    mkdir ~/.pip
fi

echo -e "[global]\ndownload_cache = ~/.cache/pip" > ~/.pip/pip.conf

pip install django==1.7.4
pip install watchdog
pip install -e .
