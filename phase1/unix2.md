Things I Give My Children
=========================

* Redirecting
  * `$ echo hello > some_file` Write echo's stdout to the file named `somefile`
  * `$ echo world >> some_file` Append echo's stdout to the file named `somefile`
  * `$ wc < some_file` Set somefile as the stdin of `wc` (rather than the keyboard)
* Pipes
  * `$ echo hello | tr eo xy` Set echo's stdout to tr's stdin
* Environment variables
  * named strings that get passed to a program when you run it (a "child" process)
  * `$ echo $HOME` Access them in the shell
  * `$ env` List the environment variables
  * `$ set -x varname thevalue` set an environment variable in fish
  * `$ export varname=thevalue` set an environment variable in bash

Questions
---------

* What kind of variable is $PATH?
* How many environment variables do you have? (`env` and `wc`)
* Why do you have to use `echo` to see the environment variable?
* If environment variables are sent to child processes,
  which structure do they probably come in as, in a Ruby program?


Things My Parents Gave Me
=========================

* `$stdin` the input stream (keyboard or file or something)
* `$stdout` the output strem (monitor or file or something)
* `$stderr` a second output stream for reporting errors and other metadata
* `ARGV` an array of strings which were passed to the program when it was run
* `ENV` a hash of the environment variables


Things I Gave My Parents
========================

* Exit status


Questions
---------

* Can you set an environment variable and then show that you can access it from a Ruby program?
* Which environment variable would you need to access if you wanted to write `which`?
* Look at the environment variables and try to figure out what the different ones mean
