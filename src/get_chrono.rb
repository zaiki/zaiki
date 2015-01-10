#!/usr/bin/env ruby

str = File.open(File.join(File.dirname(__FILE__),'p557_年表.txt'),'r'){|f| f.read}
str = str.gsub(/^[ ]*$\n/,'')

output = <<"EOF"
<!DOCTYPE html>
    <html lang='ja'>
        <head>
            <link rel="stylesheet" type="text/css" href="./style_chrono.css">
            <meta charset='UTF-8'>
        </head> 
        <body>
        <h1>年表</h1>
        <p class="remark"></p>
        <table>
EOF

buffer={date:"",contents:""}

def flash buffer
    retval = ""
    if not ( buffer[:date] == "" and buffer[:contents] == "" )
        retval = <<"EOF"
<tr>
    <td class="date">#{buffer[:date].strip}</td>
    <td class="contents">#{buffer[:contents].strip}</td>
</tr>
EOF
    end
    buffer[:date], buffer[:contents] = "", ""
    return retval
end

str.each_line do |l|
    if /^年表/ =~ l
    elsif /^＊/ =~ l
        output = output.gsub(/<p class="remark"><\/p>/,"<p class=\"remark\">#{l}<\/p>")
    elsif /^\d{4}年$/ =~ l 
        output << flash(buffer) << "<tr id=\"#{l.strip.sub(/年/,'')}\"><td colspan=\"2\" class=\"year\">#{l.strip}</td></tr>\n"
    elsif /^(\d{1,2}日,|\d{1,2}月\d{1,2}日,|\d{1,2}月[^,]*,)/ =~ l
        output << flash(buffer)
        buffer[:date], buffer[:contents] = l.split(',')
    else
        buffer[:contents] << l << "<br/>"
    end
end

output << flash(buffer) << <<"EOF"
</table>
</body>
</html>
EOF

puts output