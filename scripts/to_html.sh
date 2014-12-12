#/bin/bash
SCRIPTS=$(dirname $0)
ROOT=$SCRIPTS/..
SRC=$ROOT/src
HTML=$ROOT/html

if [ ! -d $HTML ]; then
    mkdir $HTML
fi

for md in $(ls $SRC | grep '.*\.md')
do
    pandoc $SRC/$md -o $HTML/$(echo $md | sed -e 's/\(.*\)\.md/\1/').html
done
