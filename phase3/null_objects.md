Null Objects
============

This is part of the [Designing Code](designing-code.md) material.

When you have some object that might be nil, you may need to check to see if it is nil
before you call any methods on it. This can take a fairly simple idea and make it complex,
as well as create a lot of test cases you need to hit.

```ruby
class Node
  def initialize(data, link)
    @data, @link = data, link
  end

  def length
    if @link
      1+@link.length
    else
      1
    end
  end

  def join
    if @link
      @data.to_s + @link.join
    else
      @data.to_s
    end
  end
end

list = Node.new('H', Node.new('e', Node.new('l', Node.new('l', Node.new('o', nil)))))
list.length # => 5
list.join   # => "Hello"
```

We want to move these conditionals out of this object, but if we go any higher, we're
at the toplevel! So, we'll move the decision about the nil-ness up to the top,
(you can see it's already there), but create another object whose job is to encapsulate
the knowledge about what to do when nil. This object will be our "null object".


```ruby
class Node
  def initialize(data, link)
    @data, @link = data, link
  end

  def length
    1+@link.length
  end

  def join
    @data.to_s + @link.join
  end
end

class NullNode
  def length
    0
  end

  def join
    ''
  end
end

list = Node.new('H', Node.new('e', Node.new('l', Node.new('l', Node.new('o', NullNode.new)))))
list.length # => 5
list.join   # => "Hello"
```

Now all the code becomes much easier to read, write and test!
