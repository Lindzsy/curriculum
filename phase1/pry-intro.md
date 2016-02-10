Pry Intro
=========


Purpose
-------

* Get you excited about what you can do with pry
* Learn basic things you can do with it


Example
-------

Make a [pwd](https://github.com/turingschool/waypoints/blob/master/waypoints/pwd_and_pry.md)
by figuring out how to do that in pry.


Setup
-----

Install pry and pry-doc.
The current release seems broken, so install like this:

```sh
$ gem install pry --version 0.10.1
$ gem install pry-doc
```

* Create a pry cheatsheet:
* How to specify a method
  * `some_obj.method` Call the method on the object
  * `SomeClass#instance_method` Call the method on instances of the class
* Edit `~/.pryrc` to set editor to vim: `Pry.editor = 'vim'`
* To add a pry to a file: `require 'pry'; binding.pry`
* In vim: `<Leader>-p`
* You can start it from the shell with `$ pry`

When in the pager
-----------------

A pager is the thing that displays information when there's
too much to fit on the page (you might get stuck in it).

* `q` to get out
* `j` to go down
* `k` to go up
* `C-l` to clear (Control-L)

Commands
--------

* `help` - See what commands you can run
* `whereami` - Show code surrounding the current context.
* `!` - Clear the input buffer, use when you typed something incorrectly and want to get out of it
* `ls -v obj` - Show all the methods and variables on other objects
* `show-source` - Show the source for a method or class. SUPER USEFUL!!
* `cd obj` - Change context into obj (sets self to that object)
* `cd ..` - Change context back out of that object.
* `ls -v` - Show all the methods and variables on self
* `edit` - Allows you to edit code without rerunning the program. I use it to put another pry into a method that I'm about to call.
* `exit` - Quit out of current pry session. C-D also works.
* `exit!` - Quit the program

Your turn, practice on these
----------------------------

```ruby
class Horse
  def initialize(name)
    @name = name
  end
  def screamed_name
    @name.upcase
  end
end

bob = Horse.new 'Bessie-Cheetos'

5.times do
  require "pry"
  binding.pry
end
```
