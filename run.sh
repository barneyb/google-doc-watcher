#!/bin/bash

ID="1t9EU4JzmTm0UEzWr0F2ZS40A-yZbwZBlFYYvkCNIle8"
PATTERN="([23]/[0-9][0-9]?)|rally|lindsay|nun|super"

cd `dirname $0`

URL="https://docs.google.com/document/export?format=txt&id=$ID"
RAW="$ID.raw.txt"
CURR="$ID.curr.txt"
PREV="$ID.prev.txt"
DIFF="$ID.diff.txt"

curl -s $URL > $RAW

cat $RAW | egrep -i "$PATTERN" > $CURR

touch $PREV # just in case
diff -u -i -w $PREV $CURR > $DIFF
if [ "$?" = "0" ]; then
	# diff exists zero if there no differences were found
	exit
fi

cat $DIFF
echo
echo -n "----------------------------------------"
echo "----------------------------------------"
echo

cat $CURR
mv $CURR $PREV
