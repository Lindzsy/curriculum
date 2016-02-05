Command Line Arguments Homework!
================================

Expectations
------------

* With these, use `.each` where it is appropriate, rather than the `while` loop,
  unless the problem specifically says to do otherwise.
* Compare your solutions with mine once you finish them, or if you
  get stuck for more than 20 minutes (but not until then).
  If you get stuck and look at my solution, then after you finish it,
  erase it and write it without looking (cache the knowledge you gain!)
  https://gist.github.com/JoshCheek/765e5b89c271fe170bdd

How to receive command line arguments
-------------------------------------

When you run a program like this:

```sh
$ ruby my_program.rb abc def ghi
```

We know that Ruby turns them into an array of strings like this:

```ruby
["abc", "def", "ghi"]
```

You can get that array, in Ruby, by using ARGV, like this:

```ruby
ARGV # => ["abc", "def", "ghi"]
```


A program to print each argument
--------------------------------

Write a program, in `print_each.rb` that prints each argument.
In the example below, the line with the dollar sign is the line
where we run it. The rest are the output.

```
$ ruby print_each.rb abc def ghi "jkl mno"
abc
def
ghi
jkl mno
```


A program to join all the arguments
-----------------------------------

I'm going to assume you can figure out what you're supposed to do
in the example below, based on the example above, and the name of
the challenge.

```
$ ruby join_all.rb abc def ghi jkl" "mno
abcdefghijkl mno
```


A program to print the longest argument
---------------------------------------

If there is a tie, go with the first match.

```
$ ruby print_first_longest.rb a bcde fg
bcde

$ ruby print_first_longest.rb abc de fg
abc

$ ruby print_first_longest.rb abc d efg
abc
```


Same thing, but for the last match
----------------------------------

```
$ ruby print_last_longest.rb a bcde fg
bcde

$ ruby print_last_longest.rb abc de fg
abc

$ ruby print_last_longest.rb abc d efg
efg
```


First argument determines whether first or last
-----------------------------------------------

```
$ ruby print_choose_longest.rb first abc d efg
abc

$ ruby print_choose_longest.rb last abc d efg
efg

$ ruby print_choose_longest.rb first a bcde fg
bcde

$ ruby print_choose_longest.rb first abc de fg
abc
```


First argument chooses which argument to print
----------------------------------------------

```
$ ruby  print_at.rb 0 a b c
a

$ ruby  print_at.rb 1 a b c
b

$ ruby  print_at.rb 2 a b c
c

$ ruby  print_at.rb 3 a b c


$ ruby print_at.rb -1 a b c
a
```


Print whether two strings are equal
-----------------------------------

For this problem, only, don't use the `==` method on strings,
instead loop over each character to see whether they're equal.
If the strings have different length... well, then you already
know whether they're equal ;)

```
$ ruby strings_equal.rb abc abc
equal

$ ruby strings_equal.rb abc abcd
not equal

$ ruby strings_equal.rb abcd abc
not equal

$ ruby strings_equal.rb axc abc
not equal
```


Calculator
----------

Don't worry about order of operations on this one, we'll say that each operation
applies in the order that it was provided. Spend a few minutes noticing patterns
in the arguments before you try thinking through this one.


```
$ ruby calculator.rb 1 + 2
3.0

$ ruby calculator.rb 1 + 2 + 10
13.0

$ ruby calculator.rb 10 - 3 + 6
13.0

$ ruby calculator.rb 4 '*' 5
20.0

$ ruby calculator.rb 1 + 4 '*' 5
25.0

$ ruby calculator.rb 2 + 4 '*' 5
30.0

$ ruby calculator.rb 20 / 4
5.0

$ ruby calculator.rb 20 / 8
2.5

$ ruby calculator.rb 100 / 5 / 2 + 5 '*' 2 - 15 / 3
5.0
```
