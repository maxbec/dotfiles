#!/bin/sh

echo "Cloning repositories..."

PERSONAL_GITHUB=git@github.com:maxbec
NAVIGAITE_GITHUB=git@github.com:navigaite

SITES=$HOME/Sites
LARAVEL=$SITES/Navigaite

# Personal
git clone $PERSONAL_GITHUB/openHAB-Alignment-Tool.git $SITES/openHAB-Alignment-Tool
git clone $PERSONAL_GITHUB/AMIGAA-Control-Station.git $SITES/AMIGAA-Control-Station

# Navigaite
git clone $NAVIGAITE_GITHUB/maimaldrei-mietkatalog.git $SITES/maimaldrei-mietkatalog
git clone $NAVIGAITE_GITHUB/maimaldrei-importer.git $SITES/maimaldrei-importer
git clone $NAVIGAITE_GITHUB/navigaite-website.git $SITES/navigaite-website
