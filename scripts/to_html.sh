#/bin/bash
for md in $(ls | grep '.*\.md')
do
    pandoc $md -o html/$(echo $md | sed -e 's/\(.*\)\.md/\1/').html
done
