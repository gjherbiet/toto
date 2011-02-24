#!/bin/bash
echo -e "\e[1;34m==>\e[0m Testing 'due' action"

which grep > /dev/null || \
	(echo "'grep' is required for this test." && exit 1)

which wc > /dev/null || \
	(echo "'wc' is required for this test." && exit 1)

which diff > /dev/null || \
	(echo "'diff' is required for this test." && exit 1)

OUTFILE="test/$(basename $0 .sh)_out.txt"
ALTFILE="test/$(basename $0 .sh)_alt.txt"
TASKFILE="test/$(basename $0 .sh)_todo.txt"
LOGFILE="test/test001_done.txt"

cp "test/test001_todo.txt" "$TASKFILE"
TODAY=`date -j +%Y-%m-%d`
./toto -f "$TASKFILE" -l "$LOGFILE" "add - A task to do today due:$TODAY"

# Due
echo "Testing 'due'"
./toto -f "$TASKFILE" -l "$LOGFILE" "due" > "$OUTFILE" && \
	[ `cat $OUTFILE | grep -E "^(12:)" | wc -l` -eq 1 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Due alternative
echo "Testing 'D'"
./toto -f "$TASKFILE" -l "$LOGFILE" "D" > "$ALTFILE"
diff $OUTFILE "$ALTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Due overdue
echo "Testing 'due overdue'"
./toto -f "$TASKFILE" -l "$LOGFILE" "due overdue" > "$OUTFILE" && \
	[ `cat $OUTFILE | grep -E "^(2:|5:|8:)" | wc -l` -eq 3 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Due overdue alternative
echo "Testing 'due o'"
./toto -f "$TASKFILE" -l "$LOGFILE" "due o" > "$ALTFILE"
diff $OUTFILE "$ALTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Due overdue alternative
echo "Testing 'D overdue'"
./toto -f "$TASKFILE" -l "$LOGFILE" "D overdue" > "$ALTFILE"
diff $OUTFILE "$ALTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Due overdue alternative
echo "Testing 'D o'"
./toto -f "$TASKFILE" -l "$LOGFILE" "D o" > "$ALTFILE"
diff $OUTFILE "$ALTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)


rm -f $TASKFILE
rm -f $OUTFILE
rm -f $ALTFILE