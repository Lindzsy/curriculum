Structures for Representing Nouns
=================================


Purpose
-------

* Learn the core data types we can use to model any nouns
* Understand that the concrete is a manifestation of the abstract.
  Don't anyone bring up theory of forms -.^ Plato and I don't see eye to eye.
* Pattern match on a concept across languages and across representations.
* Become comfortable with the idea of creating our own representations.


Make a cheatsheet
-----------------

Open an editor and make a cheatsheet as we go through this.


The 6 core values
------------------

* Nothingness
* True / False
* Text
* Collections by order
* Collections by name
* Numbers


Implementations
---------------

* Ruby: nil, true, false, strings, arrays, hashes, ints, floats
* JSON: null, true, false, strings, arrays, objects, floats
* YAML: null, bool, int, float, string, sequence, mapping
* A form: n/a, checkbox, text, dividers, named fields, numbers


Reflect
-------

* Compare implementations
  * What are the similarities?
  * What are the differences
* The structures
  * Which is your favourite (and why)?
  * Why these structures?
  * Can you think of any other types of data that we don't have a structure for?
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

* Make up your own syntax
* Use each other's to describe a relationship


Identify the structure
----------------------

Describe the structure you see in:

* `$ echo $PATH`
* `$ curl -i http://google.com'
* A url with query parameters (eg search for something on Amazon.com)
* Find a lisp exmaple (or maybe Elm)
