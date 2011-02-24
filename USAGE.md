`toto` usage:
=============

	toto [-h|--help] [-V|--version] [-d|--debug] [-v|--verbose]
	    [-f|--file <task_file>] [-l|-L|--logfile <log_file>] [-N|--no-line-number]
	    COMMAND [COMMAND_OPTIONS]

	  Maintains a todo list in a simple man-editable text file.
	  Supports task priority and due dates.

	  Note: If your system has the non-enhanced version of 'getopt' (which is the
	  case by default on BSD systems, including Mac OS), only the short version
	  of the following options are available.

	    --help, -h       : Print this help, then exit.
	    --version, -V    : Print the software version, then exit.
	    --debug, -d      : Extended information about the script function.
	    --verbose, -v    : Display a summary of the executed operations.

	    --file, -f       : Specifies the file to read the current tasks.
	                       Default: $TOTO_TASK_FILE environment variable or
	                       /Users/Guillaume/todo.txt
	    --logfile, -l, -L: Specifies the file to log the completed tasks.
	                       Default: $TOTO_LOG_FILE environment variable or
	                       /Users/Guillaume/done.txt
	    --no-line-number, -N:
	                       Do not display the task line number before each task.

	COMMANDS and associated options:

	  a|add <[P] task>   : Adds a new task in the list.
	                       P is the prority marker :
	                       use '!' or '+' for important tasks;
	                       use '', '-' or '=' for default priority tasks;
	                       use '_' for low priority tasks.
	                       Note: 'X' is reserved for completed tasks.

	  [P] task           : An alias for 'add [P] task'

	  ls|list            : List uncompleted tasks in the order they were set.
	      [a|all]        : Include completed but not logged tasks in the list.
	      [b|both]       : List all tasks, including completed and logged tasks.
	      [!|+|i|h|important|high]:
	                       Only list high priority tasks.
	      [_|u|l|unimportant|low]:
	                       Only list low priority (i.e. someday) tasks.
	      [-|=|d|default]: Only list default priority tasks.
	      [X|c|completed|done]:
	                       Only list completed tasks.
	      [L|log]        : List logged tasks.

	  la|list-all        : An alias for 'list all'

	  ll|list-log        : An alias for 'list log'

	  r|rank             : List the uncompleted task in the following order
	                       1) high priority, 2) default priority,
	                       3) low priority.
	                       Within each section, tasks are display in the order they were set.

	  D|due              : List uncompleted tasks with a matching due date.
	                       The due date in the taks is specified using 'due:YYYY-MM-DD'.
	                       If no due date parameter is given, diplay the tasks due today.
	      [YYYY-MM-DD]   : Display tasks due on the specified date.
	      [+N(y|m|w|d)]  : Display tasks due in the next N years, months, week, days.
	      [o|overdue]    : Display overdue tasks (due today and before).

	  m|mark <N>         : Mark the task number N with the specified marker
	      [!|+|i|h|important|high] :
	                       Mark the task number N as high priority.
	      [_|u|l|unimportant|low] :
	                       Mark the task number N as low priority.
	      [-|=|d|default]: Mark the task number N as default priority.
	      [X|c|completed|done]:
	                       Mark the task number N as completed.

	  !|+|i|h|important|high <N>:
	                       An alias for 'mark N high'
	  _|u|l|unimportant|low <N>:
	                       An alias for 'mark N low'
	  -|=|default <N>    : An alias for 'mark N default'
	  X|c|completed|done <N>:
	                       An alias for 'mark N completed'

	  L|log [N|[a|all]]  : Log the task N if it is marked as completed.
	                       If no task number is specified, or 'a' or 'all' is given
	                       as task number, all completed tasks are logged.

	  s|search           : Return all the unlogged tasks matching PATTERN.
	     [b|both]        : Search for PATTERN in both task file and the log file.
	     [l|log]         : Search for PATTERN in the logged tasks only.
	     PATTERN         : PATTERN to search for. This can be a string (no quotes
	                       required) or a valid extended regular expression.

	  e|edit <N|[a|all]> <PATTERN/REPLACEMENT>:
	                       Edit task number N by replacing the specified PATTERN
	                       by the specified REPLACEMENT. One can use strings or
	                       regular expressions, as per the 'sed' command.
	                       When 'a' or 'all' is specified as task number, all tasks
	                       matching PATTERN are edited using REPLACEMENT.
