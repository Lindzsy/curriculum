Structures for Representing Nouns
=================================


Purpose
-------

* Learn the core data types we can use to model any nouns
* Understand that the concrete is a manifestation of the abstract.
  Don't anyone bring up theory of forms -.^ Plato and I don't see eye to eye.
* Pattern match on a concept across languages and across representations.
* Become comfortable with the idea of creating our own representations.
* Understand that syntax is the textual representation,
  which is different from semantics, the underlying meaning.

If I can't give them that, they will still be confused about instance variables vs local variables a month later,
and will be trying to memorize thousands of contexts and rules to make sense of it.
Once they understand how to work with these data structures, they can make sense of any topic by modeling
the topic in them and then using their knowledge about how to work with them to understand how to work with the new topic.
ie a directory is a hash, keys are filenames/dirnames, values are files/dirs.
A path is an array of dirnames. The $PATH variable is an array of paths to look in when running programs,
etc. I want this super early so that I can use it to make all future material simpler.
I also want it rendered in many languages so that they see the underlying patterns of the structures
(that it's about the relationships, not the syntax).
Then, when I describe something abstract, like the object model,
or the DOM, and they say "yeah, but what is it?" expecting something concrete,
I can say "it's an idea, like a hash/obj/dictionary/associative array/key value pairs"


Getting familiar
----------------

We'll do this part together.

### The 6 core values

* Text
* Numbers
* True / False
* Collections by name
* Collections by order
* Nothingness

### In our words:

* Name
* SKU (stock keeping unit)
* Coin Flip
* Warehouses
* Boxes
* Floor Space

### Ruby

In Ruby, you can find out which type of value something is
by asking it what its class is. The word "Something" is pretty
abstract. In Ruby, everything you can pass around as a value
is called an "object". We'll talk later about the details of what
makes something an object, but for now, you can think of an object
as anything you can work with.

* Nothingness - `nil`
* True - `true`
* False - `false`
* Text - (String) - `"abc"`
* Collections by order - (Array) - `[1,2,3]`
* Collections by name - (Hash) - `{"a" => 1, "b" => 2}`
* Numbers - `1` - (Integer, Float) - `1`, `12.34`, `4611686018427387904`


### JSON

Install a program named `jq`, which will allow us to look at JSON in a much nicer manner.

Mac:

```sh
$ brew install jq
```

Linux:

```sh
$ sudo apt-get install jq
```

Lets take a look at some JSON.

```
$ curl 'https://api.github.com/repos/JoshCheek/mrspec' | jq .
$ curl 'https://api.github.com/search/users?q=JoshCheek' | jq .
$ curl 'https://rubygems.org/api/v1/search.json?query=cucumber&page=2' | jq .
```

Working as a group, try to identify things that you think correspond to each of our values:

* Nothingness
* True / False
* Text
* Collections by order
* Collections by name
* Numbers

Try to guess their types (do they have integers and floats like Ruby?)
find examples that support your idea.

Verify the idea: JSON stands for "JavaScript Object Notation", it's valid JavaScript.
What do you know of that can run JavaScript code? Go there and paste the JSON into it.
Make sure that works, then save the JSON to a variable (give it a name so you can refer
back to it later). You can do this with `var myjson = {"a":1};` except swap it with your JSON ;)


### YAML

Lets do the same thing with YAML. Rubygems provides a number of URLs that will return YAML to us:

[http://guides.rubygems.org/rubygems-org-api/](http://guides.rubygems.org/rubygems-org-api/)

```sh
$ curl 'https://rubygems.org/api/v1/search.json?query=cucumber&page=2' | jq .
```


### Clojure

Lets figure this one out together!
I've got Clojure installed, we can launch an interactive session (a REPL)
with `$ lein repl`. And we can ask the type of `2` with `(type 2)`.

Lets make some hypotheses about how we might enter the above ideas,
and about what it might say their type is!


Working with these structures
-----------------------------

Lets take a detour to look at how we can interact with these structures.
Go ahead and make [your first cheatsheets](first_cheatsheet.md).

We'll walk through one or two together, then break out into groups to do a couple together
from each section, and then, do the remaining ones from each section by yourself.


Forms
-----

Quick, take a 20 minute break and return with a form for something.
Maybe a post office would have one that you have to fill out in order to send a letter.
Maybe a sheet you have to fill out to sign up for some service.
When you return, we'll analyze the forms we found to try and find examples of these structures there, as well.


Reflect
-------

Write a reflection where you consider what you learned.
Try to answer these questions.

* Compare implementations
  * What are the similarities?
  * What are the differences
* The structures
  * Which is your favourite (and why)?
  * Why these structures?
  * Can you think of any other types of data that we don't have a structure for?
  * What would we lose if we removed some of these?
* Look up the words "syntax" and "semantics" and write down the definitions.
  Which part of what you learned today is syntax? Which part is semantics?
  Include specific examples.
* Why are we starting here and not somewhere else?
* Modeling (describing relationships)
  * How could you represent this sentence in Ruby: My friend's name is, Janet.
  * Find a real-world example that you can describe with these, similar to mine (maybe a sports team or the train system)
  * Can you think of any real-world examples that you can't describe with these types?
* Are all collections of names ordered?
  * If they are, how come?
  * If they aren't, do you lose or gain anything?


In groups, create your own
--------------------------

* Make up your own syntax for each of these structures.
* Look at some of the data we saw when we used `curl`, and represent that using your structure.
* Use each other's to describe a relationship
