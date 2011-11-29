*toto*: a simple todo list manager based on man-editable text files
==============================================================================

* You manage todo list(s) but want to access/edit them **anytime, anywhere**

* You don't want to spend time into **sorting** tasks in projects, context, etc. (although it is still doable...) **rather than doing** your tasks

* You still want to be able to **prioritize** tasks and assign them a **due date**

* You don't want a heavy, proprietary, click-click-click interface but still
have an **overview of what to focus on next**

... then `toto` is (well, *might be*) for you!

If not try [todo.txt](http://todotxt.com/), [t](http://stevelosh.com/projects/t/) or [taskwarrior](http://taskwarrior.org/projects/show/taskwarrior/).

What is *toto*?
---------------

`toto` is a bash script that will use robust unix tools (namely `grep` and `sed`) to manage a simple, text-based, man-editable todo list file.

Using `toto` you can simply add tasks, edit them, change their priority level and due date, mark them as completed, log them... Of course, you can also have a **quick overview of what remains to be done, sorted by importance or chronologically**.

But most importantly: **you can still edit your todo list with a simple text editor**. While other tools (even command-line based) use UUID or other strange format for your task list, with `toto` the file is kept as simple as **YOU** would have typed it :

	- This is my first task
	= This is a second task
	! The following task is of high importance
	_ The fifth task is less important and can be done later
	- The sixth task is due next week due:2011-02-28
	+ The seventh task is another way to mark importance
	- A new standard task due:2011-02-23
	Another standard task (format not recommended)
	! This entry shall be overdue due:2011-02-11
	! This task is due today due:2011-02-22
	X This task is due today but completed due:2011-02-22

The secret lies in that there is one task entry per line, prefixed by an importance/completion marker.

### Why is it so awesome?

Having a simple, man-editable text file allows you to edit your task list without relying only on `toto`.

An obvious idea is to use a text editor, but you can also synchronize your todo list with services like [Simplenote](http://simplenoteapp.com/) or [Dropbox](http://www.dropbox.com/), or your own DAV server, and edit it from anywhere.

Text-based storage also works well with content versioning systems, such as `git`, `hg`, `bazaar` (and even with `svn` for the old-fashioned folks!)

Oh, please, get me started!
---------------------------

### Setting things up

First, clone this repository or download the archive of the latest version. Put everything in the folder of your choice (say `$HOME/toto`).

For convenience, add this directory to your `PATH` variable, and/or create an alias for the `toto` command. For instance, add the following to your `.bashrc` file:

	alias toto="$HOME/toto/toto"
	alias t='toto' # This will improve my productivity by 3/4!

Next, invoke `toto` from the command prompt. By default, the `list` command is triggered. If everything goes well, `toto` shall display the following:

	$ toto
	==> $HOME/todo.txt was created.
	==> $HOME/done.txt was created.

`toto` simply created the required files for him to perform, at their default location. As those files are empty, no task was listed.

### Adding and listing tasks

To add a task simply to the following

	$ toto add - This is my first task

You will hence create a new entry `This is my first task` with default priority marker `-`. It is recommended to always use a priority marker. However tasks without a priority marker are considered having the default priority.

In short:

* No marker, `- ` or `= ` are for default priority;
* `! ` or `+ ` are for high priority;
* `_ ` is for low priority;
* `X ` is for completed tasks.

Let's add a second, higher priority task. The `add` command is purely optional, so you can directly tell `toto` about the priority and content of your entry:

	$ toto + High priority task


Now display our todo list (all existing tasks are prefixed by their line number on the task list file, which identifies the task):

	$ toto
	1:_ This is my first task
	2:+ High priority task

If you want to avoid the line numbers to be displayed (because you do not
intend to modify any of the task), you can add the `-N` or `--no-line-number` option to your call:

	$ toto -N
	_ This is my first task
	+ High priority task

Note that we could have called `toto list` or `toto ls`, they are all equivalent.

### Using priority

To order tasks by priority, simply use `toto rank` or `toto r`:

	$ ./toto rank
	2:+ High priority task
	1:_ This is my first task

### Completing tasks

To mark a task as complete, use `toto mark N done`, where `N` is the file line number of the task. `toto mark N X`, `toto mark N d`, `toto m N done`, `toto m N X`, `toto m N d`, `toto done N`, `toto X N` and `toto d N` are equivalent calls:

	$ toto mark 2 done
	$ toto
	1:_ This is my first task

We can see that the completed task has disappeared from the list. This is because the `list` action only displays unachieved tasks.

To include the completed tasks in the list, invoke:

	$ toto list all
	1:_ This is my first task
	2:X High priority task

...or `toto ls all`, `toto list a`, `toto ls a`, `toto list-all`, `toto la` equivalently.

### I need help

You have seen that `toto` has many commands and many alternative calls for each command. This is because it can hence adapt better to your need, habits, skills, etc.

If you ever need help on a particular function, trigger `toto -h` (or `toto --help` ...) or read the `USAGE` file.

Going further
-------------

### Using due dates

Prioritizing tasks helps fighting procrastination, knowing what I must do now puts me to work...

You can add a due date to any task using the keyword `due:YYYY-MM-DD` in the task description (`YYYY` is obviously the year, `MM` the month, `DD` the date).

	$ toto + Buy christmas presents due:2011-12-24

Next, you can use some convenient requests to display tasks that are due soon. 
The following examples respectively show how to display the tasks due today, on a specified date, within the next 3 days and within the next 2 weeks:

	$ toto due
	$ toto due 2011-02-23
	$ toto due +3d
	$ toto due +2w

The *near future* syntax (`+3d`, `+2w`) is based on the parameters read by `date -v`.

Note that you can also use `toto due overdue` (or `toto D o`) to see unachieved tasks that were due in the past (but that never happens to you, right ?)

### Can I use another location for the `toto` files?

YES. You can either invoke `toto` with optional arguments:

	$ toto -f /path/to/todo.txt -l /path/to/done.txt

You can also set the `TOTO_TASK_FILE` and `TOTO_LOG_FILE` environment variables. A good way to do so is to add the following to your `.bashrc`:

	export TOTO_TASK_FILE=/path/to/todo.txt
	export TOTO_LOG_FILE=/path/to/done.txt

Not that, even when the environment variables are defined, the optional arguments `-f` (or `--file`) and `-l` (or `--logfile`) override them.

### By the way, what are these `todo.txt` and `done.txt` file?

All the tasks you create are stored in the file designated by the `TOTO_LOG_FILE` variable (or `$HOME/todo.txt` by default). This remains true even when you mark them as completed.

However, after some time, this file may contain several dozens (or hundreds, depending on your productivity) completed tasks. They are a not displayed by `toto list`, but they still appear when you manually edit the file.

Therefore, you can periodically perform a `toto log`. This will simply move all completed file to the *log*, i.e. the file pointed by the `TOTO_LOG_FILE` environment variable (or `$HOME/done.txt` by default).

### Really, no project nor context support?

So, GTD enthusiast, right?

Built-in support, no. And this is not planned. But imagine you tag all the tasks related to a given context using `@context`. It's then very easy to get the tasks relevant to this context using our friend `grep`:

	$ toto list | grep "@context"
	$ toto rank | grep "@context"

You can do the same with tags like `#project`, `%requirement`, etc...

### Stream support

Do you want more goodness? Ok, here is **stream support**!

As any good GNU command-line tool, you can feed `toto` with some stream, and the corresponding actions will be executed. For instance try:

	$ echo "! A new important task added from the standard input" | toto
	$ echo "rank" | toto
	$ echo "_ 1" | toto
	$ echo "done 1" | toto
	$ echo "list" | toto

This also support multiline streams. So if you have a second todo file that you want to merge with the main one, of course you can open both files in your text editor and do some copy-pasting. But this is way cooler:

	$ cat secondary_todo.txt | toto

Even more impressive, you can use `toto -N` option to copy only a subset of your tasks from your secondary task file to the main one. The following example shows how to, for instance, merge important tasks only:

	$ toto -N -f secondary_todo.txt list high | toto

On `toto`'s todo list
---------------------

	! More extensive testing and bug fixing (currently ongoing)
	_ Automated due date generation
	_ Colored output based on priority level
	_ Add-ons and external tools
	_ Distributed CVS integration

Licensing
---------

`toto` is distributed under the terms of the GNU General Public License version 3.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License in the `gpl-3.0.txt` for more details.

Errr, what about the name?
--------------------------

Obviously, there already exist many projects named `todo`, `todo.txt`, `t` and the like...

During the development, I happened to misspell several times *todo* for *toto*, perhaps because *toto, titi, tutu* is somewhat the French equivalent for *foo, bar, baz*.

This sounded like a reasonable yet original name.  