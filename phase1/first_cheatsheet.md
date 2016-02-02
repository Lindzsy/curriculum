First Cheatsheets
=================

Purpose
-------

* Boil the thousands of methods down to just a few that are going to be used constantly
* Have working, concrete examples of those methods that can be referenced when confused
* Students need to make their own cheatsheets, by making them, they interact with the
  idea and they create their own explanation. Otherwise, it's just more shit to memorize.
* Additionally, they should not reference external tools. Building the cheatsheet is
  an opporutnity to practice using science to make sense of the world. That's far far
  far more valuable than saving a few hours by looking up the answers.

Instructions
------------

Make a directory `~/cheatsheets`, which is where you can place
cheatsheets that you will make to help you as you move forward.

First make the cheatsheets below and copy the contents into them.
Then, experiment in `SeeingIsBelieving` or `pry` to come up with examples
of each of the things below. Place the example underneath the method name.
When you think you understand the method, add an explanation next to it.

When you think you can explain what the class is (eg for Integer we filled in
"Integers are whole numbers"), then go ahead and fill it in. Be as verbose ase you need,
we will continue to refine these over time, today you need detail,
but later you can remove details to just leave the essence of the idea.

**Do not use documentation to answer these questions**

Hypothesize from the name and experiment. If you get stuck, leave it for later
and move on to another one. At some point, you will need the thing you couldn't
figure out, and then you can come back to it with the context to understand why it's there.


The cheatsheets
---------------

I would name this `integer.rb`

```ruby
# =====  Integer  =====
# description: Integers are whole numbers.

# + Adds two numbers together
1 + 2 # => 3

# -
# <
# ==
# >
# <=
# >=
# to_f
```

And this one `array.rb`

```ruby
# =====  Array  =====
# description:

# +
# -
# <<
# []
# length (same as size)
# join
# pop
# shift
# each
```

If you don't know what this one should be named, look back at the
pattern of names we've used thus far :)

```ruby
# =====  Booleans  =====
# description:

# &&
# ||
# if
# unless
```

```ruby
# =====  String  =====
# description:

# length
# +
# ==
# []
# []=
# chars
# chomp
# upcase
# downcase
# empty?
# include?
# sub
# gsub
# scan
```

```ruby
# =====  Float  =====
# description:

# +
# -
# <
# ==
# >
# <=
# >=
# to_i
```

```ruby
# =====  Hash  =====
# description:

# []
# []=
# delete
# each
# fetch
# key?
```
