How Ruby Works
==============

AKA object model.


Purpose
-------

This is the simple / elegant explanation of how Ruby works, based on three structures.
They can understand the stack because it's just a linked list.
They can understand inheritance, because it's just a linked list.
I'll give them the main 3 structures and then tons of questions and challenges
that they can only answer by using the model (the 3 structures).
If they do well at this, they will know how Ruby works better than many people who've been writing it for years.
I might also give them tools for reflection, so they can query the system to get feedback to validate their thoughts.


Prerequesites
-------------

This assumes you're okay with common data structures like hashes/arrays/strings.
Also, it goes better if you have a feel for what linked lists are.


What is a programming language?
-------------------------------

A programming language is a way for you to tell the computer what to do (maybe add that to your jargon file).
Every programming language has to give you two things:

1. Represent data (eg our nil/numbers/strings/arrays/hashes)
2. Manipulate that data (eg methods)

So... how does Ruby do these two things?


The three structures of Ruby
----------------------------

These three structures define how Ruby works.

### Objects -- hold the data

An object is a hash with the keys `"class"`, and `"instance_variables"`.

**The purpose of an object is to store data, via its instance variables.**

If we think of the object as a **noun**, we need some **verbs** to act on it!
The verbs are methods, and those are stored in classes, not objects,
so we give each object the `"class"` key,
in order to locate the methods we can call on it.

```ruby
{ "class" =>    someclass, # in reality, not nil, but one of the hashes defined below
  "instance_variables" => {
    "@year"  => 1994,      # some example instance variables.
    "@make"  => "Toyota",  # in reality, the values are other objects (other hashes like this one)
    "@model" => "Camry",   # but for simplicity, I'll write them like this.
  }
}
```


### Classes -- hold the methods, named sets of instructions

A class is a hash it has the keys `"superclass"`, `"methods"`, and `"constants"`.

A class is also an object, which means that it also has the keys that objects have:
`"class"`, and `"instance_variables"`.

**The purpose of the class is to store the instructions for operating on an object.**

Each car's year may be different, which is why we store it on the object.
But each car's set of steps for incrementing the odometer are the same: `@odometer += 1`
These are methods... functions... steps... instructions... **verbs**.

If we had put them on the car itself, there would be frivolously
redundant sets of instructions on every object.
So we put the methods in one common place that all cars can go to to find: the class.

```ruby
{ # class stuff
  "superclass" => some_class, # Look here if I don't have the method you want.
  "methods"    => {},         # keys are method names, values are the method bodies
  "constants"  => {},         # keys are constant names (eg "Object", "String"),
                              # values are any Ruby object (ie any hash with a class and superclass)

  # object stuff
  "class"              => some_class,
  "instance_variables" => {},
}
```

Note that method bodies are instructions to Ruby to do things like
"get an instance variable", "set a local variable", "call a method", etc.
If you want to see what they look like, here is some code to do it:
[https://gist.github.com/JoshCheek/a8e9dbb6f54fd1a69216](https://gist.github.com/JoshCheek/a8e9dbb6f54fd1a69216)


### Bindings -- Keep track of where we are in code

A binding is a hash with keys of `"self"`, `"local_variables"`, `"return_value"`, `"next_binding"`.

**The purpose of a binding is to store the information we need to actually execute the code.**

If you think of objects as **nouns** and classes as **verbs**, the binding might be your **sentence**.
If you think of objects as **ingredients** and classes as **recipes**, the binding might be your **kitchen**, your counter, a mixing bowl, your oven, a cutting board... anything which facilitates the preparation of the food according to the recipe.

* If a method says to set an instance variable,
  we need to know which object to set it on.
  So the binding has a `"self"`.
* A method might need a variable that nothing else needs.
  So the binding has a hash of `"local_variables"`.
* When the method is finished, it wants to send the result of its calculations
  back to the code that called it, so the binding has a `"return_value"`.
* When the method is done being executed, we want the code that called it to resume execution,
  so the binding has a `"next_binding"` -- the one that called it.

```ruby
{ "self"            => some_object,  # where to set/get instance variables, find `self`, and call "implicit" methods
  "local_variables" => {"num" 1},    # keys are variable names, values are objects (things with classes and instance variables)
  "return_value"    => some_object,
  "next_binding"    => some_binding,
}
```


### The stack is a linked list of bindings

The stack points at the "head" of a linked list,
this is where we are currently executing code.

When we call a method, we put a new binding on with:

* `"self"` set to the object we called the method on
* `"local_variables"` will have keys of the argument names, and values of whatever we passed it.
* `"return_value"` set to `nil` (this is why empty methods return `nil`)
* `"next_binding"` set to the binding that called it

When we leave a method, we remove the binding at the head of the list,
causing us to resume executing code at the old binding.

We call it a stack, because it nicely fits the metaphor of... stacks of things.
If you have a stack of pancakes, and you put another one on (often called pushing),
then you couldn't get to the one that used to be on top, until you took it back off
(often called popping). Anything with this behaviour of
_"the **Last** thing I put **in** is the **first** thing I get **out**"_ is a stack.
In our case, it's done with a linked list of hashes.


Questions
---------

Avoid searching the internet, unless you get really stuck.

Methods to help you on your journey (Probably add them to a cheatsheet):

```
self
caller
local_variables

some_object.class
some_object.methods
some_object.instance_variables
some_object.instance_variable_set("@variable_name", "value")
some_object.instance_variable_get("@variable_name")

SomeClass.constants
SomeClass.instance_methods(false)
SomeClass.superclass

some_object.method(:method_name).owner
some_object.method(:method_name).source_location
```

* General
  * How many types of variables are there?
  * What is the difference between a local variable and an instance variable?
  * If I have no local variables, what must `abc` be?
  * What is `puts`?
  * What is `gets?"
  * What is `require`?
* Local Variables
  * If you have a local variable named `abc` and an argument named `abc`, which one will you get when you ask for `abc`
  * When do local variables "die"? (as in they go away)
* Variables and methods
  * What is `puts`?
  * What kind of variable must arguments be?
* Method invocation
  * What object are methods looked up on?
  * If I call a method and don't say what object I'm calling it on, what object is it probably called on?
  * When you call a method, can it see the local variables of another method?
  * When you invoke a method, where does Ruby go to look for that method?
  * If Ruby can't find the method there, where will it look next?
  * If Ruby can't find the method there, either, where will it look next?
  * Will Ruby stop looking for the method? If So:
    * When?
    * Why?
    * What will it do at this point?
  * If String is an object, what do we know about it?
  * Where are the `String` class's methods stored?
  * Where is the `new` mehthod defined?
  * What is the first method that Ruby calls on an object?
  * What other methods are defined where `new` is defined? What do they do?
  * What is the algorithm for method lookup?
* Constants
  * Where are constants stored?
  * What constant holds the `String` class? (you can ask a class what constants it has with the `.constants` method)
  * What constant holds the `Object` class?
  * When do constants "die"? (as in they go away)
  * Can you reassign a constant?
  * Can you change the value of a constant?
  * What happens when Ruby can't find the constant?
* Instance variables
  * If you have two cars, one is a Camry, the other an F150, what instance variables exist? What are their values? Where do they exist?
  * What object are instance variables stored on?
  * How do you find methods that can operate on an instance variable?
  * Which objects can a method operate on?
  * When do instance variables "die"? (as in they go away)
  * If you access an instance variable without defining it, what will it return?
  * What does `attr_reader` do?
  * What does `attr_writer` do?
  * What does `attr_accessor` do?
  * Why does `colour = "blue"` not invoke the `colour=` method?
  * How many arguments does the `color=` method take?
* What is the point of an object? (Why does Ruby even bother with them?)
  * If you didn't have an object, how could you write the same code?
