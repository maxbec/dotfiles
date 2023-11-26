#!/bin/sh

echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Create a Projects directory"

mkdir $HOME/Projects/Personal
mkdir $HOME/Projects/Navigaite

echo "Cloning repositories..."

PERSONAL_GITHUB=git@github.com:maxbec
NAVIGAITE_GITHUB=git@github.com:navigaite

SITES=$HOME/Sites
PERSONAL=$SITES/Personal
NAVIGAITE=$SITES/Navigaite

# Personal
git clone $PERSONAL_GITHUB/openHAB-Alignment-Tool.git $PERSONAL/openHAB-Alignment-Tool
git clone $PERSONAL_GITHUB/AMIGAA-Control-Station.git $PERSONAL/AMIGAA-Control-Station

# Navigaite
git clone $NAVIGAITE_GITHUB/maimaldrei-mietkatalog.git $NAVIGAITE/maimaldrei-mietkatalog
git clone $NAVIGAITE_GITHUB/maimaldrei-importer.git $NAVIGAITE/maimaldrei-importer
git clone $NAVIGAITE_GITHUB/navigaite-website.git $NAVIGAITE/navigaite-website
