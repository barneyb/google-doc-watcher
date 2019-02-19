#!/bin/bash

URL="https://docs.google.com/document/export?format=txt&id=1t9EU4JzmTm0UEzWr0F2ZS40A-yZbwZBlFYYvkCNIle8"

cd `dirname $0`

curl -s $URL > newsies.txt

cat newsies.txt | egrep -i '([23]/[0-9][0-9]?)|rally|lindsay|nun' > curr.txt

touch prev.txt # just in case
if diff -u -i -w prev.txt curr.txt; then
	# nothing changed
	exit
fi

echo
echo -n "----------------------------------------"
echo "----------------------------------------"
echo

cat curr.txt
cp curr.txt prev.txt
