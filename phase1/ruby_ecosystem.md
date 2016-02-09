Ruby Ecosystem
==============

Purpose
-------

Understand how people write Ruby code so we can know where to look for code,
what to expect when we look at it, and how to write code that is congruent with
everyone else's.

Be able to require a file easily (something that persistently fucks newbies up).


Naming conventions
------------------

If you had a flying machine:
* `class FlyingMachine; end` name the class with `CamelCase`
* `flying_machine.rb` name the file with `snake_case` and a `.rb` file extension
* `flying_machine = FlyingMachine.new` name local variables with `snake_case`


The `$LOAD_PATH`
----------------

How does `require` work?

[material](https://github.com/turingschool/lesson_plans/blob/master/ruby_01-object_oriented_programming_with_ruby/load_path_and_require.markdown)
