Representing Nouns
==================

Purpose
-------

* Be able to represent arbitrary structures using the types we learned in [Structures for Representing Nouns](structures_for_representing_nouns.md)
* Make sense of new ideas because we will have a language for making sense of them
  without having to learn them wholecloth. ie if we can represent it with these structures,
  and we know how to work with these structures, then we can understand what is possible,
  and infer things about topics we've only just begun learning.
* Intuitively understand how these things define how Ruby works, quickly gaining a deep
  comprehension and natural intuition for why things are the way they are, as well as
  being able to predict the existence of things we haven't been taught.


Contemplate
-----------

* How many structures allow you to give names to things?
* Which structure would you use to represent yes/no?
* Which structure allows you to say "I have a bunch of these things"
* Which structure would you use to represent a quantity?
* Which structure would you use to represent compliance/noncompliance?
* Which structure would you use to represent agreement/disagreement?
* Which structure would you use if you didn't have the data that was supposed to be there?
* Which structure would you use to represent position/non-presence?
* How could you use a hash to represent an array?
* How could you use an array to represent a hash?
* If you only had integers and arrays, how could you represent strings?
* If you had an array of strings, how could you represent this with only a string?


Lets play a typing game!
------------------------

[http://play.typeracer.com/](http://play.typeracer.com/)


Represent these things using the structures
-------------------------------------------

* Output of `$ pwd`
* Output of `$ echo "$PATH"`
* A url with query parameters (eg search for something on Amazon.com)
* A directory structure
* `$ curl -i http://google.com'
* A command-line invocation


Vim Break!
----------

Lets do that waypoint, but add in a few from what you learned yesterday!


Progressively more complex representations
------------------------------------------

What structure would you use to represent each of these?

* student name
* student names
* student names with their favourite colour
* student names with their favourite colour
* student names with their favourite colour, by their military branch
* student names with their favourite colour, by their military brancby their
  and instructors with their state of residence, by their names.


File System Break!
------------------

* 4 absolute dirs: `~`, `/`, `.`, `..`
* cd
* pwd


Another progressive example
---------------------------

What structure would you use to represent these quotes?

* "Somewhere, something incredible is waiting to be known."
  * Carl Sagan
* "The secret of getting ahead is getting started"
  * Unknown
* "There is no failure, only feedback"
  * Robert Allen
* "Strive for, progress Not perfection"
  * Unknown

Now modify it to be able to support these two:

* "Isn't that the making of a little scientist?  Curiosity, asking questions, not getting the right answer, deciding to find out for yourself, making a mistake, not giving up, and learning patience. It was all there, and how easily my mother might have crushed that early curiosity and that little scientist in the making might have gone in a different direction."
  * https://www.youtube.com/watch?v=vibssrQKm60#t=9m43s
  * Jane Goodall
* "If you don't change people's language, you don't change the way they think"
  * https://www.youtube.com/watch?v=33VMvoi54wk
  * Dave Snowden

Now modify it to support these two:

* There are only so many things objects can do. Not in the sense that there are a limited number of applications, becuase there will always be new domains to model, but in hte sense that the same structures of objects keep appearing over and over, regardless of the application.
  * Smalltalk Best Practice Patterns (14)
  * Kent Beck
* "Men are disturbed not by things, but by the views which they take of them."
  * the Enchiridion
  * Epictetus


File System + Vim break!
------------------------

Do the two from before


Apply to real things
--------------------

* HTTP
  * `$ curl -i 'https://google.com'`
  * `$ curl -i 'https://api.github.com'`
* Be able to represent some HTML structure.
  * `$ curl 'https://google.com'`
* ruby code?


A few more representations
--------------------------

If there is time.

* Clojure?
* Forms after break?
