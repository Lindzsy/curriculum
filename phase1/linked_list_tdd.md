TDD a Linked List!
==================

Lets make a linked list!

Process
-------

* First, explain what a linked list is,
* Then read the requirements and the code below
* Then write out, in english, a description of how it works
* Then turn each idea in the description into a test name
* Then fill in the fist three tests
* Then skip the second two
* Then write enough code to make the first one pass
* Then do the normal red/green/refactor process through the rest.


Support the interface of array
------------------------------

* `[]`
* `<<`
* `push`
* `pop`
* `shift`
* `unshift`
* `delete_at`


Example
-------

```ruby
list = LinkedList.new  # => ()

list[0]      # => nil
list << 'b'  # => ("b")
list[0]      # => "b"
list[1]      # => nil

list.push 'c'  # => ("b" -> "c")
list[0]        # => "b"
list[1]        # => "c"
list[2]        # => nil

list.pop  # => "c"
list[0]   # => "b"
list[1]   # => nil

list.unshift 'a'  # => ("a" -> "b")
list[0]           # => "a"
list[1]           # => "b"
list[2]           # => nil

list.shift  # => "a"
list[0]     # => "b"
list[1]     # => nil

list << 'c' << 'd' << 'e'  # => ("b" -> "c" -> "d" -> "e")
list.delete_at 2           # => "d"
list                       # => ("b" -> "c" -> "e")
list.delete_at 1           # => "c"
list                       # => ("b" -> "e")
list.delete_at 0           # => "b"
list                       # => ("e")
list.delete_at 0           # => "e"
list                       # => ()
list.delete_at 0           # => nil
list                       # => ()
```
