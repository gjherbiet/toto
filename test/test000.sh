#!/bin/bash
echo -e "\e[1;34m==>\e[0m Testing command line parsing (optional arguments)"

which grep > /dev/null || \
	(echo "'grep' is required for this test." && exit 1)

OUTFILE="test/$(basename $0 .sh)_out.txt"
TASKFILE="test/$(basename $0 .sh)_todo.txt"
LOGFILE="test/$(basename $0 .sh)_done.txt"


# Help
echo "Testing help (-h)"
./toto -h > "$OUTFILE" && \
grep -q "COMMANDS and associated options" "$OUTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Version
echo "Testing version (-V)"
./toto -V > "$OUTFILE" && \
grep -q "This is toto v" "$OUTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Debug
echo "Testing version (-d)"
./toto -d > "$OUTFILE" && \
grep -q "Debug mode ON" "$OUTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Debug
echo "Testing verbose (-v)"
./toto -v > "$OUTFILE" && \
grep -q "Verbose mode ON" "$OUTFILE" || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)

# Default files location
echo "Testing default files location"
./toto > "$OUTFILE" && [ -r $HOME/todo.txt ] && [ -r $HOME/done.txt ] || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)
rm -f "$HOME/todo.txt"
rm -f "$HOME/done.txt"

# Files from environment variables
echo "Testing files location from environment variables"
TOTO_TASK_FILE=$TASKFILE TOTO_LOG_FILE=$LOGFILE ./toto > "$OUTFILE" && \
[ -r $TASKFILE ] && [ -r $LOGFILE ] || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)
rm -f "$TASKFILE"
rm -f "$LOGFILE"

# Files from user flags
echo "Testing files location from user flags"
./toto -f $TASKFILE"_FLAG" -l $LOGFILE"_FLAG" > "$OUTFILE" && \
[ -r $TASKFILE"_FLAG" ] && [ -r $LOGFILE"_FLAG" ] || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)
rm -f $TASKFILE"_FLAG"
rm -f $LOGFILE"_FLAG"

# Files from user flags
echo "Testing files location from user flags (alternate option)"
./toto -f $TASKFILE"_FLAG" -L $LOGFILE"_FLAG" > "$OUTFILE" && \
[ -r $TASKFILE"_FLAG" ] && [ -r $LOGFILE"_FLAG" ] || (echo -e "\e[1;31m!!! \e[0m Failed" && exit 2)
rm -f $TASKFILE"_FLAG"
rm -f $LOGFILE"_FLAG"


rm -f $OUTFILE