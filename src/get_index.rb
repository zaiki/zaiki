#!/usr/bin/env ruby

def padding_page page
    case page.length
    when 1
        '00'+page
    when 2
        '0'+page
    when 3
        page
    end
end

def text_to_html text
    output = "<table>\n"
    text = text.gsub(/^\s*$\n/, '')
    text.each_line do |l|
        /(.+),(.+)/ =~ l.gsub(/\s/,'')
        title, page = $1, $2
        ppage = padding_page page
        output <<
        <<"EOF"
<tr>
    <td><a href=\"./p#{ppage}.html\">#{title}</a></td>
    <td>#{page}p</td>
</tr>
EOF
    end
    output << "</table>\n"
end

def main_to_html main
    output = <<"EOF"
<table>
    <tr>
    <th>日付</th>
    <th>タイトル</th>
    <th>文責</th>
    <th>ページ数</th>
    </tr>
EOF
    main = main.gsub(/^\s*$\n/,'')
    year = '1990'
    main.each_line do |l|
        contents = l.gsub(/\s/,'').split(',')
        case contents.length
        when 1
            year = contents[0]
        when 4 
            date, title, author, page = contents
            ppage = padding_page page
            output << 
<<"EOF"
<tr>
    <td class='date'>#{year}/#{date}</td>
    <td class='title'><a href=\"./p#{ppage}.html\">#{title}</a></td>
    <td class='author'>#{author}</td>
    <td class='page'>#{page}p</td>
</tr>
EOF
        end
    end
    output << "</table>\n"
end

src = File.join( File.dirname(__FILE__) )
stream = File.open(File.join(src, 'p006_目次.txt'),'r'){|f| f.read }
/# BEGIN index(.+)# BEGIN main(.+)# END main.+付録(.+)# END index/m =~ stream

output = String.new <<'EOF'
<!DOCTYPE html>
    <html lang='ja'>
        <head>
            <link rel="stylesheet" type="text/css" href="./style_index.css">
            <meta charset='UTF-8'>
        </head> 
        <body>
            <h1>吉田寮資料集「在寮期限」の到来からその終結へ<br/>1985-90</h1>
            <h2>目次</h2>
EOF

output << text_to_html($1) << main_to_html($2) 
output << "<h3>付録</h3>\n" << text_to_html($3) 
output << "</body></html>"
puts output