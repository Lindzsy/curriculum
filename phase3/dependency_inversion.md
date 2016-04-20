Dependency Inversion Principle (DIP)
====================================

This is part of the [Designing Code](designing-code.md) material.

> * High-level modules should not depend on low-level modules. Both should depend on abstractions.
> * Abstractions should not depend on details. Details should depend on abstractions.

-- [wikipedia](https://en.wikipedia.org/wiki/Dependency_inversion_principle)

Basically, instead of directly depending on something problematic,
we'll move that dependency earlier in the callstack and allow the caller
to give us the dependency.

**Inverting the dependency gives us control over the environment the code operates in**

## The need

This is our code:

```ruby
# file: get_integer.rb
print 'Enter an integer: '
input = gets.chomp
until input == input.to_i.to_s
  print 'That\'s not an integer! Try again: '
  input = gets.chomp
end
puts "Your integer is: #{integer}"
```

We executed this by hand by going to the shell
and running `ruby get_integer.rb`, and it worked
the way we wanted ...but we realize that as we go
forward, we'll want to get more integers and do
fun things with them.

We don't want to have to keep entering
inputs by hand to make sure we didn't break the program as we refactor it.
It would be tedious to check if we got it right by hand,
we want to be able to instantly know if our code works... we want unit tests.

But how do we test this?
And what happens when we want to get our integer from somewhere else?


## Inverting the dependency

For this code, we'll need to put something before it in the callstack,
currently there can't be anything, because it's at the top.
So we'll put it into a method.

```ruby
def get_int
  print 'Enter an integer: '
  input = gets.chomp
  until input == input.to_i.to_s
    print 'That\'s not an integer! Try again: '
    input = gets.chomp
  end
  puts "Your integer is: #{input}"
end
```

After that, we need to give it the place to get the input from and send
the output to. Lets make our dependencies explicit by changing our `gets`
to `$stdin.gets` and our `puts` to `$stdout.puts`.

```ruby
def get_int
  $stdout.print 'Enter an integer: '
  input = $stdin.gets.chomp
  until input == input.to_i.to_s
    $stdout.print 'That\'s not an integer! Try again: '
    input = $stdin.gets.chomp
  end
  $stdout.puts "Your integer is: #{input}"
end

get_int
```

Now we can see that we depend on standard input and standard output.
We want to push that earlier in the callstack (where we're calling `get_int`),
so lets first get them out of the core of our code by making them local variables.


```ruby
def get_int
  stdout = $stdout
  stdin  = $stdin
  stdout.print 'Enter an integer: '
  input = stdin.gets.chomp
  until input == input.to_i.to_s
    stdout.print 'That\'s not an integer! Try again: '
    input = stdin.gets.chomp
  end
  stdout.puts "Your integer is: #{input}"
end

get_int
```

And now we can pass them in from the outside.

```ruby
def get_int(stdin, stdout)
  stdout.print 'Enter an integer: '
  input = stdin.gets.chomp
  until input == input.to_i.to_s
    stdout.print 'That\'s not an integer! Try again: '
    input = stdin.gets.chomp
  end
  stdout.puts "Your integer is: #{input}"
end

get_int $stdin, $stdout
```

At this point, the dependency is inverted.
It's still there, but we have the ability to inject the thing it talks to!


### What's this let us do?

Now we could test it with something like StringIO.

```ruby
def get_int(stdin, stdout)
  stdout.print 'Enter an integer: '
  input = stdin.gets.chomp
  until input == input.to_i.to_s
    stdout.print 'That\'s not an integer! Try again: '
    input = stdin.gets.chomp
  end
  stdout.puts "Your integer is: #{input}"
end


require 'stringio'
require 'minitest/autorun'
class GetIntTest < Minitest::Test
  def test_get_int
    stdin  = StringIO.new "a\nb\n1\nc"
    stdout = StringIO.new

    get_int stdin, stdout

    assert_equal "c", stdin.gets
    assert_equal "Enter an integer: That's not an integer! Try again: That's not an integer! Try again: Your integer is: 1\n",
                 stdout.string
  end
end
```

Or we could make up our own class for testing:

```ruby
class FakeInput
  attr_reader :remaining

  def initialize(*values)
    @remaining = values
  end

  def gets
    remaining.shift
  end
end

class FakeOutput
  attr_reader :printed

  def initialize
    @printed = []
  end
  def puts(str)
    @printed << "#{str}\n"
  end
  def print(str)
    @printed << str
  end
end

class GetIntTest < Minitest::Test
  def test_get_int
    stdin  = FakeInput.new "a\n", "b\n", "1\n", "c"
    stdout = FakeOutput.new

    get_int stdin, stdout

    assert_equal ["c"], stdin.remaining
    assert_equal [ "Enter an integer: ",
                   "That's not an integer! Try again: ",
                   "That's not an integer! Try again: ",
                   "Your integer is: 1\n"
                 ],
                 stdout.printed
  end
end
```

Or we simulate an interaction based on what a previous user entered.


### Practice

Now it's your turn!

```ruby
value = ARGV.shift.to_f
until ARGV.empty?
  operator = ARGV.shift
  case operator
  when '+' then value += ARGV.shift.to_f
  when '-' then value -= ARGV.shift.to_f
  when '*' then value *= ARGV.shift.to_f
  when '/' then value /= ARGV.shift.to_f
  else raise "Invalid operator: #{operator.inspect}"
  end
end
puts value
```

Here's the current test suite O.o

```ruby
RSpec.describe 'our program' do
  it 'adds two numbers' do
    ARGV.replace(['1', '+', '2'])
    $stdout = StringIO.new
    load 'calculator.rb'
    expect($stdout.string.to_f).to eq 3
  end

  it 'subtracts two numbers' do
    ARGV.replace(['10', '-', '2'])
    $stdout = StringIO.new
    load 'calculator.rb'
    expect($stdout.string.to_f).to eq 8
  end

  it 'divides two numbers' do
    ARGV.replace(['9', '/', '2'])
    $stdout = StringIO.new
    load 'calculator.rb'
    expect($stdout.string.to_f).to eq 4.5
  end

  it 'multiplies two numbers' do
    ARGV.replace(['9', '*', '2'])
    $stdout = StringIO.new
    load 'calculator.rb'
    expect($stdout.string.to_f).to eq 18
  end

  it 'can perform multiple operations' do
    ARGV.replace(['100', '/', '5', '/', '2', '+', '5', '*', '2', '-', '15', '/', '3'])
    $stdout = StringIO.new
    load 'calculator.rb'
    expect($stdout.string.to_f).to eq 5
  end

  it 'raises if given an invalid operator' do
    ARGV.replace(['1', '&', '2'])
    $stdout = StringIO.new
    expect { load 'calculator.rb' }.to raise_error 'Invalid operator: "&"'
  end
end
```
