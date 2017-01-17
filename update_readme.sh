#!/bin/sh

cat README.md.tmpl > README.md

find . -iname '*.md' | while read line; do
	URL=`echo $line | sed 's/\.md$//; s/^\.\///'`
	if [ "$URL" = "README" ]; then
		continue
	fi
	TITLE=`cat "$line"  | grep '===' -B 1 | head -1`
	echo "* [$TITLE][$URL]" >> README.md
done

echo >> README.md

find . -iname '*.md' | while read line; do
	URL=`echo $line | sed 's/\.md$//; s/^\.\///'`
	if [ "$URL" = "README" ]; then
		continue
	fi
	TITLE=`cat "$line"  | grep '===' -B 1 | head -1`
	echo "[$URL]: https://factorio-realms.com/tutorials/$URL" >> README.md
done
