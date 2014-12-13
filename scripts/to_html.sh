#/bin/bash
SCRIPTS=$(dirname $0)
ROOT=$SCRIPTS/..
SRC=$ROOT/src
HTML=$ROOT/html

if [ ! -d $HTML ]; then
    mkdir $HTML
fi

$SCRIPTS/get_index.py > $HTML/index.html

for md in $(ls $SRC | grep '.*\.md')
do
    pandoc -s -c $SCRIPTS/style.css $SRC/$md -o $HTML/$(echo $md | sed -e 's/\(p[0-9]\{3\}\)_.*\.md/\1/').html
done

cp $SCRIPTS/style.css $HTML/
cp $SCRIPTS/style_index.css $HTML/