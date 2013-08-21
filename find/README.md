[sc]: http://en.wikipedia.org/wiki/Short-circuit_evaluation "Short-circuit evaluation"

# Understanding The Mental Model of Find


## The WRONG Mental Model

When I first started using find, I had a mistaken mental model of how it
worked.  This is what I thought a find command was:

    find [path...] [boolean-filter] [action]

I thought find would enumerate every path within the directories I specified
and for each path that passed the boolean filter I specified it would do some
action on the path.  The default action would be to print the path.  In
pseudocode, I might implement find like this:

    def find(paths=['.'], boolean_filter=true, action=print):
        for path in paths:
            if boolean_filter(path):
                action(path)
            if is_directory(path):
                find(children(path), boolean_filter, action)

Unfortunately this mistaken model of how find works is propagated on the
internet, even in find tutorials.  Here is an example that only hints that its
model is broken in a "gotcha" section at the very end:

- http://content.hccfl.edu/pollock/Unix/FindCmd.htm

### A typical mistake

This mistaken mental model leads to a lot of confusion when users start to
write more complex find commands.  Here is a typical example:

- http://www.linuxforums.org/forum/red-hat-fedora-linux/177489-grep-underscore-problem.html

The user successfully creates a boolean filter that prints all the files they
want to perform an action on:

    find . -name "*.php" -o -name "*.pl" -o -name "*.cgi" -o -name "*.pm" -o -name "*.xml" 

Then they append the action that they want to happen, and problems ensue.  This
command only executes `grep` on the xml files!

    find . -name "*.php" -o -name "*.pl" -o -name "*.cgi" -o -name "*.pm" -o -name "*.xml" -exec grep -il 'db_name' {} \;


## The RIGHT Mental Model

This is what a find command really is:

    find [paths...] [expression]

Find does enumerate every path within the files and directories specified in
the command.  For each path it evaluates a boolean short-circuit expression
which has at least one side effect.  That is a mouthful, but we can break it
down.  Let's look in more detail at what this expression is.

### Atomic boolean expressions

Find has three types of simple boolean expressions:

  - Options.  Always return true and have no side effects.  They affect overall
    operation of find rather than operating on specific paths. An example is
    `-maxdepth`, which tells find to only descend so many levels deep in the
    directory tree as it iterates.
  - Tests.  Have no side effects and return true or false.  Tests operate on
    individual paths.  For example the `-name` expression tests whether the
    basename of a path matches a shell pattern.  E.g. `-name '*.bak'`.
  - Actions.  Have side effects and return true or false.  Actions operate on
    individual paths.  For example `-print` writes the full path to stdout,
    including a newline, and always returns true.  `-delete` tries to delete
    the current path if it is a file or empty directory and returns true iff
    successful.

Options, tests, and actions form the smallest expressions you can use in a find
command.  Here are some very simple examples:

    find . -print  # evaluating the -print expression has the side effect (i.e. action) of printing the current path to stdout.
    find . -delete # evaluating the -delete expression has the side effect of deleting the current path.

### Compound boolean expressions

The atomic boolean expressions can be combined into a compound expression using
boolean operators and [short-circuit
evaluation][sc].  Here are
the boolean operators in decreasing order of precedence:

- `-not`.  `-not expr1` evaluates expr1 and returns the opposite boolean value.
- `-and`.  `expr1 -and expr2` evaluates expr1.  If expr1 returns false, false
  is returned for the compound expression without evaluating expr2.  This is
  what is meant by a short-circuit evaluation.  If expr1 returns true, expr2 is
  evaluated to determine if the compound expression is true or false.  In this
  case the compound expression returns the boolean return value of expr2.
- `-or`.  `expr1 -or expr2` evaluates expr1.  If expr1 returns true, there is
  no need to evaluate expr2 to determine the boolean value of the compound
  expression.  Therefore expr2 is not evaluated and true is returned.  If expr1
  returns false, expr2 is evaluated and its return value is returned as the
  return value of the compound expression.

Importantly there are also parentheses for grouping sub-expressions when order
of precendence is not enough.  There are two very important things to note
about compound expressions:

- `-and` is implicitly inserted between adjacent atomic expressions.  This
  means `expr1 epxr2` is equivalent to `expr1 -and expr2`.  Combined with order
  of precendence it means that `expr1 -or expr2 expr3` is equivalent to `expr1
  -or ( epxr2 -and expr3 )`.  Parentheses are used hear to illustrate the order
  of precendence.
- sub-expressions can be any atomic expression, including actions that have
  side effects (e.g. -delete, -print, -exec), or another compound expression.

Here are some examples that demonstrate the use of [short-circuit
evaluation][sc] to apply an action to only some paths:

    # delete backup files
    find . -name '*.bak' -delete  # note the implicit -and

    # print everything that is not a python file
    find . -name '*.py' -or -print

    # another way to print everything that is not a python file
    find . -not -name '*.py' -print


### Expressions with side effects

A find expression is expected to have some kind of side effect.  Otherwise
there would be no point in running the command!  Some expressions contain an
action that has a side effect.  For those that do not, an implicit `-print`
action is used.

#### The default print side effect

By default, if an expression contains no action (other than `-prune`), then the
expression is transformed into `( expr ) -and -print`.

Here are some commands that have no action in their expressions:

    find . # Special case: the empty expression defaults to -print
    find . -name '*.txt'
    find . -maxdepth 2
    find . -name '*.txt' -or -name '*.py'

And here are the equivalent command, including implicit operators and -print:

    find . -print
    find . -name '*.txt' -and -print
    find . -maxdepth 2 -and -print
    find . \( -name '*.txt' -or -name '*.py' \) -and -print

Pay special attention to the parentheses that are wrapped around that final
command.  The `-print` expression is combined using `-and` with the entire
expression.  It is this transformation which confuses people with the WRONG
mental model.

#### An explicit side effect (or two, or three...)

If a find expression contains an explicit action other than `-prune`, the
expression will not have a `-print` action added.  An expression can have one
or many actions with side effects.  We have already seen some simple
expressions with explicit actions.

Here are some more complex commands with a single action:

    # use -exec to make shell and python scripts executable
    find . \( -name '*.py' -or -name '*.sh' \) -exec chmod ugo+x {} \;

    # delete java class files
    find . -name '*.class' -delete

    # use -print0 to handle paths with spaces(!) in them.
    # count total lines of python source code using xargs, wc, and tail
    find . -name '*.py' -print0 | xargs -0 wc -l | tail -1


Here are some commands with multiple actions:

    # print and delete all backup files
    # two actions, print and delete, are performed on each backup file.
    find . -name '*.bak' -print -delete

    # search for files with TODOs in them
    find . -exec grep -q 'TODO' {} \; -print

    # change directory to include setgid bit, make python scripts executable, and add group write permissions to other files.
    find . -type d -exec chmod 2775 {} \; -or -type f -name '*.py' -exec chmod 775 {} \; -or -type f -exec chmod 664 {} \;


## Righting our Wrongs

Now that you understand the RIGHT mental model of find, it should be easy to
understand what the user in our original problem was doing wrong and how to fix
it.  Here was their working `-print` command:

    find . -name "*.php" -o -name "*.pl" -o -name "*.cgi" -o -name "*.pm" -o -name "*.xml" 

And here is their faulty `-exec` command:

    find . -name "*.php" -o -name "*.pl" -o -name "*.cgi" -o -name "*.pm" -o -name "*.xml" -exec grep -il 'db_name' {} \;

Now that we understand the RIGHT mental model we can write out explicitly the
`-print` command:

    find . \( -name "*.php" -o -name "*.pl" -o -name "*.cgi" -o -name "*.pm" -o -name "*.xml" \) -print

Once we've done that, it is simple to transform this into a working `-exec`
command:

    find . \( -name "*.php" -o -name "*.pl" -o -name "*.cgi" -o -name "*.pm" -o -name "*.xml" \) -exec grep -il 'db_name' {} \;


Now that you grok how find evaluates its expression, you can write an
expression to perform multiple actions on a single path or conditionally
execute different actions on paths.  The sky is the limit.  Go forth and
`find`!

## Further reading

- The find man pages: http://unixhelp.ed.ac.uk/CGI/man-cgi?find
- http://www.softpanorama.org/Tools/Find/find_mini_tutorial.shtml
- http://www.softpanorama.org/Tools/Find/typical_errors_in_using_find.shtml
- A find tutorial with many examples, http://www.grymoire.com/Unix/Find.html,
  some of which use the WRONG mental model (e.g. `find . -print -o -name SCCS
  -prune`) and some of which use the RIGHT one (e.g. `find . \( -name a.out -o
  -name *.o \) -print`).





