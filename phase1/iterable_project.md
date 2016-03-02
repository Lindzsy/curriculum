Iterable... your version of Enumerable
======================================

This will get made better in time ...maybe ;)~

Include it into your linked list
You'll need to define `each` on your linked list
then Iterable defines map, select, etc


Bare minimums to be able to make Iterable
the next project. You'll only be making unit tests
for this one... don't get too into that, it's
only good for certain types of problems, which
are not the ones you will usually have.


#### Modules

You need em. Here is Comparable, it gives you less than, greater than,
etc, all based off one method you define: `<=>`, the space ship operator.

```ruby
Enumerable.class # => Module

Comparable.class # => Module
Comparable.instance_methods # => [:<, :>, :<=, :>=, :==, :between?]

# Use a module
1 <=> 0 # => 1
1 <=> 1 # => 0
1 <=> 2 # => -1

"b" <=> "a" # => 1
"b" <=> "b" # => 0
"b" <=> "c" # => -1
```


Lets use it in a class!

```ruby
class Potato
  ancestors # => [Potato, Object, PP::ObjectMixin, Kernel, BasicObject]
  include Comparable
  ancestors # => [Potato, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]

  attr_reader :num_eyes
  def initialize(num_eyes)
    @num_eyes = num_eyes
  end
  def <=>(potato)
    self.num_eyes <=> potato.num_eyes
  end
end

boy    = Potato.new(4) # => #<Potato:0x007fbf0095d578 @num_eyes=4>
latvia = Potato.new(6) # => #<Potato:0x007fbf0095d2a8 @num_eyes=6>

boy    # => #<Potato:0x007fbf0095d578 @num_eyes=4>
latvia # => #<Potato:0x007fbf0095d2a8 @num_eyes=6>

boy <   latvia # => true
latvia < boy   # => false
boy > boy      # => false
```

Lets make our own!

```ruby
# Define a module
module Equitable
  def <(whatev)
    result = (self <=> whatev)
    -1 == result
  end
end

class OtherPotato
  include Equitable
  attr_reader :num_eyes
  def initialize(num_eyes)
    @num_eyes = num_eyes
  end
  def <=>(potato)
    self.num_eyes <=> potato.num_eyes
  end
end

girl = OtherPotato.new 17
french_fry = OtherPotato.new 42

girl < french_fry # => true
french_fry < girl # => false
```


#### Blocks

You need em, because Enumerable works by calling `each`,
like Comparable used the `<=>`.

Here's an example, there's also the block video
for more nuanced exploration about how blocks work.


```ruby
class Array
  def my_each(&shit_to_do)
    i = 0
    while i < length
      element = self[i] # => "a", "b", "c"
      shit_to_do.call(element)
      i += 1
    end
    self
  end
end

result = []
['a', 'b', 'c'].my_each do |char|
  result << "*#{char.upcase}*"
end
result # => ["*A*", "*B*", "*C*"]
```
