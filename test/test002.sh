#!/bin/bash
echo -e "\e[1;34m==>\e[0m Testing 'rank' action"

which grep > /dev/null || \
	(echo "'grep' is required for this test." && exit 1)

which wc > /dev/null || \
	(echo "'wc' is required for this test." && exit 1)

which diff > /dev/null || \
	(echo "'diff' is required for this test." && exit 1)

OUTFILE="test/$(basename $0 .sh)_out.txt"
ALTFILE="test/$(basename $0 .sh)_alt.txt"
TASKFILE="test/test001_todo.txt"
LOGFILE="test/test001_done.txt"

# Rank
echo "Testing 'rank'"
./toto -f "$TASKFILE" -l "$LOGFILE" rank > "$OUTFILE" && \
	[ `grep -P "2:.*\n7:.*\n9:.*\n10:.*\n1:.*\n4:.*\n8:.*\n5:.*\n11:.*\n" $OUTFILE | wc -l` -eq 8 ] && \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Rank alternative
echo "Testing 'r'"
./toto -f "$TASKFILE" -l "$LOGFILE" r > "$ALTFILE"
diff $OUTFILE "$ALTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)


rm -f $OUTFILE
rm -f $ALTFILE