#!/bin/bash
SCRIPTS=$(dirname $0)
ROOT=$SCRIPTS/..
SRC=$ROOT/src
HTML=$ROOT/html

if [ -d $HTML ]; then
    rm -rf $HTML
fi
