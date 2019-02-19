#!/bin/bash
#
# I can monitor and print diffs for the plain-text export of a Google
# Doc. Originally conceived to deal with Sherwood's theatre community's
# inability to use calendaring software for maintaining a calendar of
# rehearsals and performance, it ended up being more generally useful.
# No authentication support is available, so the target document must
# be at least publicly readable.
#
# The general usage pattern is to wire a cron task that invokes this
# script w/ the document ID and an optional case-insensitive `egrep`
# pattern which matches the subset of lines you care about. With no
# diffs, the script is silent. If there are diffs, a unified diff will
# be printed to STDOUT followed by a horizontal rule, and then the
# whole document (post-filter, if filtering is enabled).
#
# While the script is standalone, it uses the current directory as a
# place to cache stuff in various text files. There's no way to set
# an alternate scratch space.

ID="$1"
PATTERN="$2"

if [ "$ID" = "" ]; then
	echo "Usage: `basename $0` docId [ egrepPattern ]"
	exit 1
fi

cd `dirname $0`

URL="https://docs.google.com/document/export?format=txt&id=$ID"
RAW="$ID.raw.txt"
CURR="$ID.curr.txt"
PREV="$ID.prev.txt"
DIFF="$ID.diff.txt"

curl -s $URL > $RAW

if [ "$PATTERN" = "" ]; then
	cp $RAW $CURR
else
	cat $RAW | egrep -i "$PATTERN" > $CURR
fi

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
