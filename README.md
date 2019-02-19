# Google Doc Watcher

I can monitor and print diffs for the plain-text export of a Google
Doc. Originally conceived to deal with Sherwood's theatre community's
inability to use calendaring software for maintaining a calendar of
rehearsals and performance, it ended up being more generally useful.
No authentication support is available, so the target document must
be at least publicly readable.

The general usage pattern is to wire a cron task that invokes this
script w/ the document ID and an optional case-insensitive `egrep`
pattern which matches the subset of lines you care about. With no
diffs, the script is silent. If there are diffs, a unified diff will
be printed to STDOUT followed by a horizontal rule, and then the
whole document (post-filter, if filtering is enabled).

While the script is standalone, it uses the current directory as a
place to cache stuff in various text files. There's no way to set
an alternate scratch space.
