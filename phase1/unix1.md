Unix
====


Purpose
-------

All your programs are operating in this environment called Unix.
A little understanding about how it works will help you reason
about what is going on and why things might not work.

Unix
----

Unix is your operating system. There is some nuance to what it means vs
linux or BSD, etc. But generally, any operating system that follows a certain
standard, POSIX, can be called Unix. So we're talking about Mac OSX, as well
as the various linuxes.

Prep
----

Make a directory somewhere, and inside it make a bin directory.
In there, make a new empty program. We'll eventually put Ruby code in it, but we
won't save it with a .rb file extension, because we want to run
it like a program (`echo`, `cat`, `mkdir`, etc).

```
$ tree
.
└── bin
    └── hello

1 directory, 1 file
```


Permissions
-----------

Notice that we can't run this program without Ruby.

```
$ ruby bin/hello
Hello, world!


$ bin/hello
The file 'bin/hello' is not executable by this user
```

This is because it does not have permission to execute.

```
$ ls -l bin
total 0
-rw-r--r--  1 josh  staff  0 Feb  9 11:01 hello
```

Lets add executability to its permissions.

```
$ chmod +x bin/hello
```

And check again.

```
$ ls -l bin
total 0
-rwxr-xr-x  1 josh  staff  0 Feb  9 11:01 hello
```

See thhat `-rw-r--r--`? it breaks down like this:

```
    | ----- OWNER ------ | ----- GROUP ------ | ----- OTHERS -----
IDK | Read Write eXecute | Read Write eXecute | Read Write eXecute
-   | r    w     -       | r    -     -       | r    -     -
```

We'll ignore group for now. So looking at owner, it means that you
can read that file and write to it, and everyone else can only read it.
After changing the permissions (see `man chmod` for more details),
we see that we have added executable permissions for everyone.

```sh
$ bin/hello # no error
```


The Shebang
-----------

Since we're saying `bin/hello` instead of `ruby bin/hello`,
how do we tell Unix to run the program with Ruby?
We use a "shebang"

```ruby
#!/usr/bin/env ruby
$stdout.puts "Hello, world!"
```

And check it:

```sh
$ bin/hello
Hello, world!
```

We have to do the `env` thing, because the location of the ruby
executable will likely be different on every machine, but the
location of `env` is consistently at `/usr/bin/env`.

Env will use an "environment variable" called `PATH`,
which is a list of directories. It will go through each
directory, in order, until it finds Ruby, then finally
execute our file with that ruby.

```sh
# see all environment variables
$ env
... lots of output ...

# see the path
$ env | grep PATH
PATH=/usr/local/heroku/bin:...

# make it more readable
$ env | grep PATH | tr : \\n
PATH=/usr/local/heroku/bin
/Users/josh/.gem/ruby/2.1.1/bin
/Users/josh/.rubies/ruby-2.1.1/lib/ruby/gems/2.1.0/bin
/Users/josh/.rubies/ruby-2.1.1/bin
...

# where is our Ruby? Notice its directory is in the PATH
$ which ruby
/Users/josh/.rubies/ruby-2.1.1/bin/ruby

# execute that Ruby with env
$ /usr/bin/env ruby -v
ruby 2.1.1p76 (2014-02-24 revision 45161) [x86_64-darwin13.0]
```


$PWD
----

There is an environment variable named `$PWD`, look at it the way
we looked at the `$PATH` above. Then cd around and look at it again
in each directory you cd into.


Locating executables
--------------------

There is a program, `which`, that tells you where other programs are located:

```
$ which echo
/bin/echo
```

**Question: Where is `which` located?**


$PATH
-----

An array of strings that are directories with executable programs in them.
Unix will look through these directories until it finds the executale.

Lets add our bin directory to the path.

```
# For fish, do this:
$ set -x  PATH  "$PWD/bin"  $PATH

# For bash, do this:
$ export PATH="$PWD/bin:$PATH"
```

Now see where the hello command is:

```
$ which hello
/Users/josh/code/unix1/bin/hello
```

These commands are basically saying "set the path to be the bin directory in my current directory,
followed by all the directories that are currently in it.
Translating set command to Ruby: `PATH = ["/Users/josh/code/unix1/bin"] + PATH`


Experiment
----------

Currently your system does this:

```
$ echo a b c
a b c
```

Figure out how to make a fake echo, using Ruby, and get your system to run it instead:

```
$ echo a b c
You said: a b c
```

Don't worry, things will be normal again when you restart.


Standard Input / Standard Output
--------------------------------

A **file** is a string on the hard drive.
When you access a file, you access it as a stream.

A **stream** is a linked list of characters.
Because it's a linked list, you access the characters sequentially.

Maybe write these in jargon.

When you call `gets`, you are reading a stream.
When you call `puts`, you are writing to a stream.
Unix hooks those two streams up for you, and calls them "standard input" and "standard output".

By default, they will be your keyboard and your display, but they can be hooked up to any stream of characters.


Redirecting Standard Input
--------------------------

Lets pull standard input from a file instead of the keyboard.

First, we'll make a program to do this in an interesting way.
Name it linenums, and have it read in each line of input,
and print that line out with the line number in front of it.

```
#!/usr/bin/env ruby
num  = 1
line = ""

while (line = $stdin.gets)
  $stdout.puts "#{num}. #{line}"
  num += 1
end
```

And make a file, `inputfile`, to give it as its standard input.

```
abc
def
ghi
```

First run it normally so that stdin is the keyboard:

```
$ linenums
i am typing this
1. i am typing this
at the keyboard
2. at the keyboard
and I can press C-d (hold control and press d) to end the input
3. and I can press C-d (hold control and press d) to end the input
```

And now run it with standard input redirected from the file.
You can do that with the `<` character:

```
$ linenums < inputfile
1. abc
2. def
3. ghi
```


Redirecting Standard Output
---------------------------

You can redirect standard output with `>` and `>>`
Look at how we did it with standard input, and devise some experiments
to figure out how these two work.


Piping
------

When you want the output of one program to be sent as the input to another program,
you can separate the two invocations with a pipe, `|`.

```
$ cat inputfile
abc
def
ghi

$ cat inputfile | linenums
1. abc
2. def
3. ghi
```

Challenges
----------

* Write a program, `upcase`, which prints each line of standard input, but with all the characters in uppercase.
  Make it executable and run it from your path.
* Figure out which directory is already in your path (if you took my dotfiles), that you can put your programs into.
* Guess / experiment until you figure out how to remove executability from a program.
* Cat an input file, through line nums, and then upcase
* **tr** is a program that takes two arguments, a string of characters to replace, and a string of characters to replace them with.
* **grep** is a program that prints each line of its standard input, if it contains the characters in its arguments.
* Run the env, program, grep its output for the PATH variable, translate any colons in its output into newlines.
