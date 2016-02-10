Code Platoon - Curriculum
=========================

Phase 1 - Introduction to programming with Ruby
-----------------


Topics: Environment, Ruby, Problem Solving, Good Habits

### Week 1


Topics: Editor, Ruby, Terminal

#### Expectations

Topics: positive behaviour, collaboration, grit
[material](https://github.com/CodePlatoon/curriculum/blob/master/phase1/expectations.md)

#### Get to know each other


#### Become familiar with editor (What editor do we want to use? Probably Atom or Emacs, might depend on dev env, eg are we doing cloud based?)

* Practice the mechanical skills of, making files, deleting them, editing them
* Learn first Keybindings
* Alternate between solving problems using [SiB](https://github.com/JoshCheek/seeing_is_believing) and practicing keybindings / editing
* Demonstrate that you can perform these tasks

#### Initial Setup

Some stuff from my [setup instructions](https://github.com/JoshCheek/1508/blob/master/initial-setup.md) and probably [dotfiles](https://github.com/JoshCheek/dotfiles-for-students)

#### Become familiar with the terminal

Be able to perform [these katas](https://github.com/JoshCheek/team_grit/blob/master/cheatsheets_other/shell.md) by the end (mechanical practice)

#### Become familiar with the OS (Mac?)

Practice poweruser keybindings

#### Mindset of a learner

[material](https://github.com/CodePlatoon/curriculum/blob/master/phase1/mindset_of_a_learner.md)

#### Seeing Is Believing

Introduce our laboratory

#### Have them create cheatsheets for the primitives (String, Integer, Array, Hash, booleans)

* [example](https://github.com/JoshCheek/ruby-kickstart/tree/master/cheatsheets)
* Demonstrate an [ECM](http://orgmode.org/worg/org-faq.html#ecm) eg to show how map works:

  ```ruby
  ['a', 'b'].map { |c| c.upcase }  # => ["A", "B"]
  ```

#### Structures for representing nouns

The JSON data types, across representations

#### The power and danger of abstractions

[material](phase1/the_power_and_danger_of_abstractions.md)

#### Representing nouns

How to model data using the JSON data types.

#### Exercises

* Create a linked list using
  [toplevel methods and arrays](https://gist.github.com/JoshCheek/e8dfba74a0ec7e9d8400/53a6c7555284c2d3272bf5638f8d8efc78303ff9#file-15_ways_to_make_a_linked_list-rb-L31),
  tests will be provided
* Create a linked list using
  [toplevel methods and hashes](https://gist.github.com/JoshCheek/e8dfba74a0ec7e9d8400/53a6c7555284c2d3272bf5638f8d8efc78303ff9#file-15_ways_to_make_a_linked_list-rb-L81),
  tests will be provided

#### Structure of the Object Model

[Structure of the Object Model](https://github.com/JoshCheek/object-model-hash-style#objects-are-just-linked-lists)

* Toplevel methods, local variables, callstack, parameters
* Objects (ivars/class)
* Classes (superclass/methods/constants)

### Week 2


Topics: Ruby in context

#### Unix

Topics: $PATH, input/output streams, file permissions, executbales

#### Ruby

Topics: $stdin, $stdout, $stderr, ARGV, ENV

#### Unix

Topics: environment variables, pipes, redirecting input/output

#### Ruby Miniprojects

Create these programs:

* [wc](https://github.com/JoshCheek/team_grit/blob/master/katas/wc.rb)
* [echo](https://github.com/JoshCheek/team_grit/blob/master/katas/echo.rb)
* [cat](https://github.com/JoshCheek/team_grit/blob/master/katas/cat.rb)

#### Ruby ecosystem

Topics: Namespacing, multiple files in Ruby (load path), naming conventions across files and classes
[material](phase1/ruby_ecosystem.md)

#### Pry Intro

phase1/pry-intro.md

#### Exploring gems using pry

Go through [Discovery With Pry](https://vimeo.com/151341394),
along with me, where we figure out the FFaker gem by looking around in pry.

#### Nokogiri Challenge

https://github.com/turingschool/challenges/blob/master/parsing_html.markdown

#### Git fundamentals

* The basic model to use when thinking
* My cardinal rule of git: "run git status after everything you do"
* Practice the commit workflow (I've got it written down somewhere, will have to find it)
* "Get over yourself" aka commit constantly

#### Ruby exercieses

Various [ruby exercises](https://github.com/turingschool/ruby-exercises) (probably objects and methods)

* To practice modeling domains using objects
* To practice using git to commit

#### Maybe refactoring exercises

Probably this materail: [material](https://github.com/JoshCheek/1508/blob/master/katas/blowing_bubbles_part1.rb)
Here is a video of me doing it: [https://vimeo.com/137837006](https://vimeo.com/137837006).

### Week 3


Topics: Testing and More objects

#### Mechanics of testing

Topics: testing
[Mechanics of testing](https://github.com/JoshCheek/how-to-test) (the hard skills)

* TODO: Do we want to use minitest or RSpec, or don't care?
* Have them demonstrate they can repeat all the hard skills

#### How to explore

Topics: explore, pry, testing
Exploring with pry (to see how feedback is useful, and build intuition)
We'll use pry to go in and figure out how minitest runs our tests
(if we use RSpec instead, then it's probably not worth it,
b/c RSpec is much larger and more sophisticated, not ripe for entry level discovery)

#### Starting a project

Topics: project management, bdd
Discuss how to start a project [bdd](https://gist.github.com/JoshCheek/37e4cf3bea6541023bab)

#### Mindset of testing

Topics: testing, tdd
Show how this manifests in the [mindset of testing](https://github.com/JoshCheek/how-to-test#watch-me-build-a-calculator-in-this-way) (the soft skills)

* How to think about testing
* What tests to write
* Watch me do it
* Students repeat it
* Demonstrate they can mimic my process and thought patterns

#### Mechanics of testing

Topics: testing, exercise, git
Use testing and git on a linked list that uses toplevel methods and objects

#### Mechanics of testing

Topics: testing, refactoring
Use testing and git on a linked list where the behaviour is moved into the objects

* This will likely lead to test pain because each test probably uses the
  interface directly. So we'll get to talk about tdd (in this case,
  refactor the tests to introduce abstractions, then move the methods 1 at a time)
* Maybe have them set it aside and go through more
  [refactoring exercises](https://github.com/JoshCheek/1508/blob/master/katas/blowing_bubbles_part2.rb)
  (video of me doing it https://vimeo.com/137837005)
* Maybe them do both iterative solutions and recursive solutions,
  pushing the logic down into the node.

#### Object Model: singleton classes

Topics: object model, singleton classes

#### HTTP Parser

Topics: testing, project
[HTTP Parser](https://github.com/JoshCheek/programming_is_fun/blob/master/spec/request_spec.rb)
(uses streams, strings, testing, and we can define the interface as `ParseHttp.call`
which will use singleton classes, and starts prepping them for the web)

### Week 4


Topics: How to approach a project

#### Practice starting a project

Topics: project management, tdd
Practice starting a project the way I do

* Watch me do Chisel, a markdown parser.
  * [project](http://tutorials.jumpstartlab.com/projects/chisel.html)
  * [video](https://vimeo.com/131588133)
* They attempt to mimic my approach
* Watch me do chisel again
* They attempt to mimic my approach again
* Watch me do chisel again (this time in 20ish minutes)
* They practice on one they haven't seen me do, [Character Count](https://vimeo.com/139372804)

#### Project: Building a gem

Project: [building a gem](https://github.com/turingschool/lesson_plans/tree/master/electives/building-a-gem)
Uses all the stuff they learned last week + the stuff they learned this week,
lets us talk about design

### Week 5


Topics: Modules, Blocks

#### Blocks

Topics: blocks
* How they work
* Follow the flow through the program

#### Your own #each

Topics: blocks, enumerables
Add `each` method to their linked list

#### Discovering modules

Topics: object model, modules
* Modules as mixins and namespaces
* Have them infer the structure from their knowledge of the object model

#### Enumerable#map

Topics: blocks, enumerables
Create Enumerable#map together

#### Project

Topics: blocks, enumerables
Project: create some subset of the Enumerable module
[example](https://vimeo.com/133626457)

Include it into their linked list so they can see that
they get the `map` methods and so forth

### Week 6


Topics: HTTP

#### Project: HTTP / web framework / web server

Topics: blocks
* [Webserver project](https://github.com/turingschool/curriculum/blob/master/source/projects/http_yeah_you_know_me.markdown)
* [My reflections](https://gist.github.com/JoshCheek/9e5bf0ed673ed80ec010)
* My web framework

* Build the project in the way we described
* Refactor to achieve clarity / modularity
* Refactor to support the Rack interface?
* Extract the server and framework into gems
* Add more status code support

If any of their other work can be given a web interface, lets do that!

Phase 2 - Internet / Rails
-----------------


Topics: internet, rails

### Week 7


Topics: Databases, templating languages, html

#### ActiveRecord without Rails

Topics: Seeing is Believing, ActiveRecord, db patterns, interfaces, CRUD, validating
[example](https://gist.github.com/JoshCheek/53877049e76f98447249)

#### Metaprogramming behind ActiveRecord

Topics: metaprogramming, ActiveRecord
Enough metaprogramming for AR to not be magic

#### Erb

Topics: erb
ERB in plain Ruby

#### Project: C is for cookie, and cookie is for me!

Topics: cookies
Add the ability to get / set cookies to their web framework

#### Project: build our own active record

Topics: erb
Build our own ActiveRecord

### Week 8


Topics: Rails, MVC, Cookies, Sessions, ActiveRecord, ActiveSupport, Migrations

#### Intro to Rails

Topics: Rails, MVC
High level (what are the pieces, why are they there, how do they fit together?) They need to be able to define the scaffolded pieces of Rails, by hand by the end of this.

#### ActiveRecord in Rails

Topics: ActiveRecord, migrations, models
ActiveRecord in Rails migrations, config

#### Rails in isolation

Topics: Rails
Various Rails pieces in isolation [[https://github.com/JoshCheek/playgrounds][Example]];
Know how to discover What ActiveSuport gives them
Know how to discover what ViewHelpers give them
Routing
Query Params and forms
Forms

#### Rails Views Tips and Techniques

Topics: Rails
https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/rails_views_tips_and_techniques.markdown

#### Build a single page Rails app that serves a linked list

Topics: Rails
Using the ides from the prev lesson, we just need a nodes resource, where each node has the id of some other node. Then the show page contains a link to that node. They need to pattern match to be able to explain how this is a linked list.

#### Testing with Capybara

Topics: capybara, testing
* [Minimal Testing Example](https://gist.github.com/JoshCheek/f71d7d5d749401733a5e)
* [Feature Testing](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/feature_testing_rails_minitest_rspec.markdown)
* [Capybara](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/feature_testing_in_sinatra_with_capybara.markdown)

#### Rails project

Topics: Rails, MVC, Authentication
[Betsy](https://github.com/Ada-Developers-Academy/C3Projects--bEtsy)

### Week 9



#### Form / Route helpers

Topics: forms, routes
[Forms](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/submitting-forms.md)
[Form and Route helpers](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/forms_and_route_helpers_in_rails.markdown)

#### Controller filters

Topics: Controller filters
[Controller Filters][http://guides.rubyonrails.org/action_controller_overview.html#filters

#### Validations

Topics: Validations
Test suite where they have to show they can use the 5 or so most common validations

#### Authentication

Topics: Authentication, Sessions
Tell them what authentication is.
Have them figure out how to use it (eg, like below)
The conceptual idea for discovering sessions, from my HYYKM notes:
In the morning tell them "each user's hello_count needs to be unique", then the morning class is to guide their exploration until they realize they can do this with cookies. Afternoon is to implement the solution (code to parse and write cookies). Next day's class: have them figure out how to tamper with their hello count, then "Don't allow your hello count to be tampered with", guide their exploration until they think of encryption. Give them the smallest viable example, now go do it. Later, after they've seen it in Rails, have them extract their session data.

Then have them add it to their web app
Use the image from here?:

These might be relevant:
* [https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/sessions_cookies_and_flashes.markdown](Sessions / Cookies / Flashes)
* [https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/rails/session.md)

Get code samples from here: [Ada's authentication](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/user-authentication.md)

#### Authentication

Topics: Authentication, Rails
Have them implement authentication in Rails
[Turing's authentication](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/authentication.markdown)

Have them decrypt it from the browser (or put this later to remind them of the topic?)
[Decrypting a Rails Session](https://gist.github.com/JoshCheek/7b1c1eb231dfa83098be)

### Week 10


Topics: APIs

#### Consuming an API

Topics: APIs
* [Consuming an API](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/consuming-an-api.md#practice)
* Add a challenge for each of the APIs at the bottom of this page. eg:
  * Find me titles of books dealing with HTTP
* What else can you find? (maybe make a mashup of several of these?)

#### Build an HTTP client

Topics: APIs, HTTP
Build Your own HTTP client

#### Project: Ant sparring!

Topics: APIs, project
* [Ant Sparring](https://github.com/slagyr/ant_sparring)

* Use your HTTP client to talk to the ant game!
* Practice separating the game logic from the API so that you can test it and play it w/o the server running
* Work on designing your app so that you can do all of these things,
  but still have all the functionality available when the server is not runing
* Prepare for Enova API by practicing against the ant game (assuming their project is similar)

### Week 11


Topics: API, OAuth, JRuby

#### API project

Topics: APIs
https://github.com/Ada-Developers-Academy/C3Projects--SeeMore

#### Make a sorting video with JRuby!

Topics: JRuby, Java, sorting, algorithms
* Build sorting algorithms, then draw them using JRuby!
* [Example](https://vimeo.com/channels/sortalgorithms)
* We could do other fun JRuby things, eg Robot for automation, Swing for GUI apps,
  but this seems like a good one to me b/c it lets us do algorithms at the same
  time, and it lets us reflect on how different algorithms work!

Phase 3 - Frontend and Javascript
-----------------


Topics: Javascript, Frontend

### Week 12



#### Resources

Topics: javascript, documentation
Show them where the MDN docs are.

* [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
* [Web](https://developer.mozilla.org/en-US/docs/Web/Reference/API)

#### Getting feedback

Topics: feedback
* Setup node so they can have a REPL
* Show them a few tricks:
  * functions to strings
  * reflective methods (eg Object.keys)

#### Gaining context

Topics: arrays, DOM, functions
* https://github.com/mdn/advanced-js-fundamentals-ck/tree/1266706b188590da8d682cca046227ae5a307842/tutorials/01-array-prototype-methods
* Give them some challenges that require them to play with Arrays, Strings, Numbers, Objects, true, false, undefined, null, so that we don't spend a long time covering ideas they are already famiilar with (ie show them their Ruby knowledge translates and begin getting comfortable with JS)
* Cover Array prototype methods for the same reason, and b/c they're very useful, and it will give them an opportunity to ask any questions from the above.
* Cover anonymous functions / blocks to
* priming for JS Object model.
* Some DOM manipulation (gain context into where / how this is commonly used)
* Should there be more of an intro to the DOM? (We can play with it from Ruby, possibly build our own model like we've done with other examples)

#### Functional Paradigm

Topics: functional programming
* https://github.com/mdn/advanced-js-fundamentals-ck/tree/gh-pages/tutorials/02-functions
* This style is common in JS, and in functional languages (and it shows up from time to time in Ruby, too)
* It's also a gentler introduction, allowing them to be productive without knowing all the ins and outs of the object model.
* 01-calling-functions.md
  * var vs fn, hoisting, first-class, reference vs invocation, cursory behaviour of `this`
* 03-what-is-this.md
  * 4 rules of this
  * call and apply (2 interfaces to do the same thing)
  * write your own bind
  * edge case: callbacks (TODO: discuss what a calback is)
* 02-currying-and-partial-application.md
  * Partial application (have them discover this)
  * Closures and scope
  * Examples / context
* 04-recursion.md
* 05-generators.md
  * Async / Generators
  * Understanding generators to better define what async is and where its boundaries are
  * (find that video where they define these constructs -- event queue)

#### JavaScript Challenges

Topics: linked lists, jQuery, DOM
* redo linked list with toplevel functions + objects
* Something with jQuery and the DOM to get them playing with it and see something practical they can apply these ideas to. Might be nice to introduce these things first, and then have their challenges be in this context so that as they learn the topics, they can contemplate how they might be used to manipulate the DOM, something they can see the effects of.

### Week 13


Topics: advanced JS, the web

#### Object Oriented JS (mechanics and paradigms)

* https://github.com/mdn/advanced-js-fundamentals-ck/tree/gh-pages/tutorials/03-object-oriented-javascript
* 01-introduction-to-object-oriented-javascript.md
  * JS Object Model
  * new keyword (have them implement their own?)
  * Constructors
  * `this` in an OO context
  * implicit return of the instance
  * Capitalization is convention
* 02-building-a-chainable-api.md
  * Common interface patterns (eg jQuery)
  * Contemplating abstraction
* 03-canvas-and-object-oriented-javascript.md
  * (as a vehicle for talking about OOJS)
  * First see what it looks like procedurally
  * Add the constraint to do this 10x
  * Refactoring to OO

#### Challenge

* Redo linked list with a constructor / prototype
* If we wind up introducing other data structures, we can have them swap out which one they do,
  we'll be doing this one frequently enough that we can expand on it and do something more fun like binary search trees.

#### Events / working with the DOM

* https://github.com/mdn/advanced-js-fundamentals-ck/tree/1266706b188590da8d682cca046227ae5a307842/tutorials/04-events
* 01-basic-events.md
  * also builtin querying api
  * event listeners
* 02-event-bubbling.md / 03-adding-and-removing.md / 05-event-delegation.md
  * Maybe have them do the experiment and then define their own set of rules to explain it
  * Patterns for avoiding repetition (eg defining the event listener on the pre-existing elements and also on ones you add later)
* 04-keycodes.md
  * some exercises to do interesting stuff
* 06-data-attributes.md
  * "Another thing I thought about for JS that I tried to teach all the time is proper use of DOM selectors for JS behavior.
    Classes and Ids are often used by designers so attaching to them for JS behavior becomes fragile,
    since they may rename or move the classes for style changes.  I always like to use data-ids and then
    communicate that if you see a data-id that means JS is attached there.  Any other part of it -- the HTML or the CSS is still liable to change.
    This also implies to not have your JS be dependent on a specific HTML structure as designers can change that a lot too." -- Ben Voss
  * C style namespacing

#### Environment

Npm, lodash, (browserify | webpack) -- find a good resource for the basics of these things
* Not necessary to know all their ins and outs, just enough to support the game time below

#### Project

* Build their own game
* https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/gametime_project.markdown
* TODO: Some kind of project where JS is used to add dynamic functionality to a Rails app?

### Week 14



#### Capstone Project

Objectives

* Work on a team
* Practice project management / agile on a larger scale

Possibilities

* Something that integrates a Rails backend with Google Maps

### Week 15



#### Capstone Project

Continue Capstone project

### Week 16



#### Unallocated

Topics: Leaving this open
I historically understimate, so it makes sense to shoot for less time rather than perfect time.  Leaving this open to be allocated as appropriate.



License
-------
Unless otherwise noted, this curriculum by Josh Cheek is licensed under - [Creative Commons Attribution-NonCommercial-ShareAlike 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/)
