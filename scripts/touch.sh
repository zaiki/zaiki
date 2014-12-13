#!/bin/bash
for i in $(cat touch.txt)
do
    if [ ! -f ../src/$i ]; then
	touch ../src/$i
	cat<<EOF>../src/$i
<header>
<h1 class="title"></h1>
<h2 class="author"></h2>
</header>
EOF
    fi
done
