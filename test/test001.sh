#!/bin/bash
echo -e "\e[1;34m==>\e[0m Testing 'list' action"

which grep > /dev/null || \
	(echo "'grep' is required for this test." && exit 1)

which wc > /dev/null || \
	(echo "'wc' is required for this test." && exit 1)

which diff > /dev/null || \
	(echo "'diff' is required for this test." && exit 1)

OUTFILE="test/$(basename $0 .sh)_out.txt"
ALTFILE="test/$(basename $0 .sh)_alt.txt"
TASKFILE="test/$(basename $0 .sh)_todo.txt"
LOGFILE="test/$(basename $0 .sh)_done.txt"

# List
echo "Testing 'list' as default action"
./toto -f "$TASKFILE" -l "$LOGFILE" > "$OUTFILE" && \
	[ `cat $OUTFILE | grep -E "^(1:|2:|4:|5:|7:|8:|9:|10:|11:)" | wc -l` -eq 9 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Explicit list
echo "Testing 'list'"
./toto -f "$TASKFILE" -l "$LOGFILE" list > "$ALTFILE"
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List alternative
echo "Testing 'ls'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls > "$ALTFILE"
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List all
echo "Testing 'list all'"
./toto -f "$TASKFILE" -l "$LOGFILE" list all > "$OUTFILE" && \
	[ `cat $OUTFILE | wc -l` -eq 11 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List all (alternative)
echo "Testing 'list a'"
./toto -f "$TASKFILE" -l "$LOGFILE" list a > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List all (alternative)
echo "Testing 'ls all'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls all > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List all (alternative)
echo "Testing 'ls a'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls a > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List all (alternative)
echo "Testing 'list-all'"
./toto -f "$TASKFILE" -l "$LOGFILE" list-all > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List all (alternative)
echo "Testing 'la'"
./toto -f "$TASKFILE" -l "$LOGFILE" la > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List both
echo "Testing 'list both'"
./toto -f "$TASKFILE" -l "$LOGFILE" list both > "$OUTFILE" && \
	[ `cat $OUTFILE | wc -l` -eq 15 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List both	 (alternative)
echo "Testing 'list b'"
./toto -f "$TASKFILE" -l "$LOGFILE" list b > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List both	 (alternative)
echo "Testing 'ls b'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls b > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List log
echo "Testing 'list log'"
./toto -f "$TASKFILE" -l "$LOGFILE" list log > "$OUTFILE" && \
	[ `cat $OUTFILE | wc -l` -eq 4 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List log (alternative)
echo "Testing 'list L'"
./toto -f "$TASKFILE" -l "$LOGFILE" list L > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List log (alternative)
echo "Testing 'ls L'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls L > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List log (alternative)
echo "Testing 'list-log'"
./toto -f "$TASKFILE" -l "$LOGFILE" list-log > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List log (alternative)
echo "Testing 'll'"
./toto -f "$TASKFILE" -l "$LOGFILE" ll > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important
echo "Testing 'list important'"
./toto -f "$TASKFILE" -l "$LOGFILE" list important > "$OUTFILE" && \
	[ `cat $OUTFILE | grep -E "^(2:|7:|9:|10:)" | wc -l` -eq 4 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'list high'"
./toto -f "$TASKFILE" -l "$LOGFILE" list high > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'list i'"
./toto -f "$TASKFILE" -l "$LOGFILE" list i > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'list h'"
./toto -f "$TASKFILE" -l "$LOGFILE" list h > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'list !'"
./toto -f "$TASKFILE" -l "$LOGFILE" list "!" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'list +'"
./toto -f "$TASKFILE" -l "$LOGFILE" list "+" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'ls important'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls important > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'ls high'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls high > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'ls i'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls i > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'ls h'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls h > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'ls !'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls "!" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List important (alternative)
echo "Testing 'ls +'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls "+" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant
echo "Testing 'list unimportant'"
./toto -f "$TASKFILE" -l "$LOGFILE" list unimportant > "$OUTFILE" && \
	[ `cat $OUTFILE | grep -E "^(5:|11:)" | wc -l` -eq 2 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'list low'"
./toto -f "$TASKFILE" -l "$LOGFILE" list low > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'list u'"
./toto -f "$TASKFILE" -l "$LOGFILE" list u > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'list l'"
./toto -f "$TASKFILE" -l "$LOGFILE" list l > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'list _'"
./toto -f "$TASKFILE" -l "$LOGFILE" list "_" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'ls low'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls unimportant > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'ls low'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls low > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'ls u'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls u > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'ls l'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls l > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List unimportant (alternative)
echo "Testing 'ls _'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls "_" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List default
echo "Testing 'list default'"
./toto -f "$TASKFILE" -l "$LOGFILE" list default > "$OUTFILE" && \
	[ `cat $OUTFILE | grep -E "^(1:|4:|8:)" | wc -l` -eq 3 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)
	
# List default (alternative)
echo "Testing 'list d'"
./toto -f "$TASKFILE" -l "$LOGFILE" list d > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List default (alternative)
echo "Testing 'list -'"
./toto -f "$TASKFILE" -l "$LOGFILE" list "-" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List default (alternative)
echo "Testing 'list ='"
./toto -f "$TASKFILE" -l "$LOGFILE" list "=" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List default (alternative)
echo "Testing 'ls d'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls default > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List default (alternative)
echo "Testing 'ls d'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls d > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List default (alternative)
echo "Testing 'ls -'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls "-" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List default (alternative)
echo "Testing 'ls ='"
./toto -f "$TASKFILE" -l "$LOGFILE" ls "=" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List completed
echo "Testing 'list completed'"
./toto -f "$TASKFILE" -l "$LOGFILE" list completed > "$OUTFILE" && \
	[ `cat $OUTFILE | grep -E "^(3:|6:)" | wc -l` -eq 2 ] || \
	(echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)
	
# List completed (alternative)
echo "Testing 'list done'"
./toto -f "$TASKFILE" -l "$LOGFILE" list "done" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List completed (alternative)
echo "Testing 'list c'"
./toto -f "$TASKFILE" -l "$LOGFILE" list c > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List completed (alternative)
echo "Testing 'list X'"
./toto -f "$TASKFILE" -l "$LOGFILE" list X > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List completed (alternative)
echo "Testing 'ls completed'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls "completed" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List completed (alternative)
echo "Testing 'ls done'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls "done" > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List completed (alternative)
echo "Testing 'ls c'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls c > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# List completed (alternative)
echo "Testing 'ls X'"
./toto -f "$TASKFILE" -l "$LOGFILE" ls X > "$ALTFILE" && \
diff $OUTFILE "$ALTFILE" > /dev/null || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)


rm -f $OUTFILE
rm -f $ALTFILE