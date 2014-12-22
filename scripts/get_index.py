#!/usr/bin/env python3
import re, os, sys

def extract(filename):
    with open( filename, 'r' ) as f:
        strm = f.read()
        m = re.search('# BEGIN index(.+)# BEGIN main(.+)# END main.+付録(.+)# END index', strm, re.DOTALL)
        return m.groups()
        
def main_to_html(text):
    data = []

    for i in text.split('\n'):
        data.append(i.replace(' ','').split(','))

    output = '''<style>
    td.date{
        text-align: right;
    }
    td.title{
        text-align: center;
    }
    </style>
    <table>
    <tr>
    <th>日付</th>
    <th>タイトル</th>
    <th>文責</th>
    <th>ページ数</th>
    </tr>
    '''
    year = '1900'

    for i in data:
        if len(i) == 1:
            year = i[0]
        else:
            date, title, author, page = i[0], i[1], i[2], i[3]
            if len(page) == 1:
                ppage = '00' + page
            elif len(page) == 2:
                ppage = '0' + page
            elif len(page) == 3:
                ppage = page
            output += '''<tr>
            <td class='date'>{0}/{1}</td>
            <td class='title'><a href="./p{5}.html">{2}</a></td>
            <td class='author'>{3}</td>
            <td class='page'>{4}p</td>
            </tr>'''.format(year, date, title, author, page, ppage)

    output += '</table>'
    return output

def text_to_html(text):
    output = '<table>\n'
    for l in text.split('\n'):
        if l.strip() == '':
            pass
        else:
            title_page = l.replace(' ','').split(',')
            title, page = title_page[0], title_page[1]
            if len(page) == 1:
                ppage = '00' + page
            elif len(page) == 2:
                ppage = '0' + page
            elif len(page) == 3:
                ppage = page
            output += '''<tr>
            <td><a href="./p{2}.html">{0}</a></td>
            <td>{1}p</td>
            </tr>
            '''.format(title, page, ppage)
    output += '</table>'
    return output

if __name__ == '__main__':
    scriptsdir = os.path.dirname(sys.argv[0])
    rootdir = scriptsdir + '/..'
    srcdir = rootdir + '/src'
    
    filename = os.path.join( srcdir, 'p006_目次.txt' )
    data = extract(filename)
    
    output = '''
    <!DOCTYPE html>
    <html lang='ja'>
    <head>
    <link rel="stylesheet" type="text/css" href="./style_index.css">
    <meta charset='UTF-8'>
    </head>
    <body>
    <h1>吉田寮資料集「在寮期限」の到来からその終結へ<br/>1985-90</h1>
    <h2>目次</h2>
    '''
    output += text_to_html(data[0])
    output += main_to_html(data[1])
    output += '<h3>付録</h3>\n'
    output += text_to_html(data[2])
    output += '</body></html>'
    print(output)
    