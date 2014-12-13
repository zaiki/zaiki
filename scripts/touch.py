#!/usr/bin/env python3
import os, sys
from get_index import extract

scriptsdir = os.path.dirname(sys.argv[0])
rootdir = scriptsdir + '/..'
srcdir = rootdir + '/src'
filename = os.path.join( srcdir, 'p006_目次.txt' )

text = extract(filename)[1]
data = []

for i in text.split('\n'):
    data.append(i.replace(' ','').split(','))

year = '1900'

for i in data:
    if len(i) == 1:
        year = i[0]
    else:
        date, title, author, page = i[0], i[1], i[2], i[3]
        month, day = ( i.strip() for i in date.split('/') )
        if len(page) == 1:
            ppage = '00' + page
        elif len(page) == 2:
            ppage = '0' + page
        elif len(page) == 3:
            ppage = page
        output = 'p' + ppage + '_' + year + '年' + month + '月' + day + '日' + '_' + title + '.md'
        print(output)