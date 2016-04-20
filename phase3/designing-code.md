Designing Code
==============

**Well designed code** is code that pushes integration earlier in the callstack.

**Integration** is the joining of two things.

**The callstack** is the set of locations in code that we will return to when finished with the currently running code.

Imagine a callstack where method `a` calls method `b`, which calls method `c`, which calls method `d`.
Applying this idea, we would have `b` integrate `c` and `d`. But if we pushed the integration of these two ideas
earlier, then we could have `a` integrate the other three.

When one thing can be broken by another, we say it **depends on** that thing.
So here, `a` always depends on `a`, `b`, and `c`. But if we have `b` integrate `c` and `d`, then `c` loses its dependency.
If we push the integration earlier, then `b` loses its two dependencies, as well.

![dependencies](dependencies.png)

This is makes code well designed, because it reduces the number of dependencies.
With few dependencies, you can compose the pieces to do new things that you didn't
initially anticipate. When requirements change, the change is easy to accomodate,
because you are protected from the changing assumptions.


Single Responsibility Principle (SRP)
-------------------------------------


Open Closed Principle (OCP)
---------------------------

[Material](open_closed.md)


Interface Segregation Principle (ISP)
-------------------------------------

Small Surface Area

The tinier the better, hence a function is best



Dependency Inversion Principle (DIP)
------------------------------------

Usually implemented through "dependency injection"
Push a dep earlier in the callstack to its parent.


Dependency removal principle
----------------------------

This one I made up, I like it better than DIP.

String > Socket
name > owner (https://github.com/rails/rails/blob/dda31d59a03adb7e5aa372e72bb66a3886632f2f/activerecord/lib/active_record/connection_adapters/abstract/connection_pool.rb#L824-#L953)
implies:
  Data Structures > Objects
    ie run a migration against a second DB
  Integrate early in the callstack

I don't want your baggage, just give me what I need to do my job, not the whole fkn world.


Null Objects
------------

[Material](null_objects.md)

Presenters
----------

refactor logic from a view to use a presenter


Interactor
----------

refactor logic out of the model and into an interactor


Don't Repeat Yourself (DRY)
---------------------------

move something like db name into a given place (eg selfup/rejs)



SRP
---


command/query
-------------

data structs as objects
-----------------------

function objects
----------------

refactor to presenters
----------------------
