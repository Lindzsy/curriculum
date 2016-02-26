TDD a Linked List!
==================

Lets make a linked list!

If you struggle
---------------

Consider working through some [linked list challenges](https://github.com/JoshCheek/linked_list_challenges).


Process
-------

* First, explain what a linked list is
* Then read the requirements and the code below
* Then write out, in english, a description of how it works
* Then turn the example into an acceptance test (one big test that exercises everything)
* Then turn each description into a test name
* Then fill in the fist three tests
* Then skip the second two
* Then write enough code to make the first one pass
* Then do the normal red/green/refactor process through the rest
* As you make each unit test pass, go back and make the acceptance tests pass


Support the interface of array
------------------------------

* `LinkedList#shift`
* `LinkedList#unshift`
* `LinkedList#[]`
* `LinkedList#<<`
* `LinkedList#push`
* `LinkedList#pop`
* `LinkedList#delete_at`


Example (aka make this your acceptance test)
--------------------------------------------

```ruby
list = LinkedList.new  # => #<LinkedList:0x007f9a19154770>

list[0]      # => nil
list << 'b'  # => #<LinkedList:0x007f9a19154770 @head=#<LinkedList::Node:0x007f9a191542e8 @data="b", @link=nil>>
list[0]      # => "b"
list[1]      # => nil

list.push 'c'  # => #<LinkedList:0x007f9a19154770 @head=#<LinkedList::Node:0x007f9a191542e8 @data="b", @link=#<LinkedList::Node:0x007f9a1914fc70 @data="c", @link=nil>>>
list[0]        # => "b"
list[1]        # => "c"
list[2]        # => nil

list.pop  # => "c"
list[0]   # => "b"
list[1]   # => nil

list.unshift 'a'  # => #<LinkedList:0x007f9a19154770 @head=#<LinkedList::Node:0x007f9a1914e988 @data="a", @link=#<LinkedList::Node:0x007f9a191542e8 @data="b", @link=nil>>>
list[0]           # => "a"
list[1]           # => "b"
list[2]           # => nil

list.shift  # => "a"
list[0]     # => "b"
list[1]     # => nil
```


How to define the brackets and shovel
-------------------------------------

```ruby
def [](index)
end

def <<(data)
end
```


Stretch chalenges!
------------------

### `LinkedList#each`

For this one, you might want to re-watch our [blocks](https://vimeo.com/156462214) video.

```ruby
list = LinkedList.new << 'a' << 'b' << 'c'
list.each do |element|
  element # => "a", "b", "c"
end  # => #<LinkedList:0x007fc07b0e2e80 @head=#<LinkedList::Node:0x007fc07b0e2d40 @data="a", @link=#<LinkedList::Node:0x007fc07b0e2a20 @data="b", @link=#<LinkedList::Node:0x007fc07b0e2930 @data="c", @link=nil>>>>
```


### `LinkedList#map`

```ruby
list = LinkedList.new << 'a' << 'b' << 'c'
list.map { |char| char.upcase } # => ["A", "B", "C"]
```


### `LinkedList#inspect`

If you get the above done, then try defining `LinkedList#inspect` to look like this:

```ruby
LinkedList.new << 'a' << 'b' << 'c'  # => ("a" -> "b" -> "c")
```


### `LinkedList#delete_at`

```ruby
list = LinkedList.new      # => #<LinkedList:0x007fdbb910e860>
list << 'c' << 'd' << 'e'  # => #<LinkedList:0x007fdbb910e860 @head=#<LinkedList::Node:0x007fdbb910e658 @data="c", @link=#<LinkedList::Node:0x007fdbb910e5e0 @data="d", @link=#<LinkedList::Node:0x007fdbb910e568 @data="e", @link=nil>>>>
list.delete_at 2           # => "e"
list                       # => #<LinkedList:0x007fdbb910e860 @head=#<LinkedList::Node:0x007fdbb910e658 @data="c", @link=#<LinkedList::Node:0x007fdbb910e5e0 @data="d", @link=nil>>>
list.delete_at 1           # => "d"
list                       # => #<LinkedList:0x007fdbb910e860 @head=#<LinkedList::Node:0x007fdbb910e658 @data="c", @link=nil>>
list.delete_at 0           # => "c"
list                       # => #<LinkedList:0x007fdbb910e860 @head=nil>
list.delete_at 0           # => nil
list                       # => #<LinkedList:0x007fdbb910e860 @head=nil>
list.delete_at 0           # => nil
list                       # => #<LinkedList:0x007fdbb910e860 @head=nil>
```


### `LinkedList.[]`

How to define a singleton method:

```ruby
def LinkedList.[](*elements)
  require 'pry'
  binding.pry
end

LinkedList['a', 'b', 'c'] # => #<LinkedList:0x007fb5b98d2018 @head=#<LinkedList::Node:0x007fb5b98d1758 @data="a", @link=#<LinkedList::Node:0x007fb5b98d1500 @data="b", @link=#<LinkedList::Node:0x007fb5b98d0588 @data="c", @link=nil>>>>
```
