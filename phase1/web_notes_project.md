Web Notes
---------

This project is based on one I made for Turing,
which can be seen [here](https://github.com/turingschool/curriculum/blob/master/source/projects/http_yeah_you_know_me.markdown).


Project Overview
----------------

You're going to build a web application to serve your
[notes project](https://github.com/CodePlatoon/curriculum/blob/master/phase1/notes-project.md).

We'll build it from the ground up, so that when we move into Rails, we have a much deeper
understanding of what it's doing, and what is possile.

Note that this will build on the Notes Project, so you need to have done that first.


Learning Goals
--------------

* Practice breaking a workflow into a system of coordinating components
* Practice using TDD at the unit, integration, and acceptance levels
* Understand how the HTTP request/response cycle works
* Practice implementing basic HTTP requests and responses
* See how design decisions we make allow this to be easy... or difficult :P


Iteration 0 - Pass my acceptance test
-------------------------------------

This step will get us a valid rack server.

* I've provided an acceptance test [here](web_notes_acceptance_test.rb).
* You **will** need to make your own unit tests around parsing the request and generating the response.
  Not only will you pass my pedantic testing requirements, but it will be much much easier.
  If you don't know what to send on the IO object, then go do the [http](https://github.com/turingschool/waypoints/blob/master/waypoints/http.md)
  waypoint again, focus on understanding what you're seeing, why you're seeing it, why I'm having you go back and look at it,
  and which things you see come from which places in our code.
* To talk across the internet, you'll need to set up a TCP server.
  Go through the [example code](https://github.com/CodePlatoon/curriculum/blob/master/phase1/tcp_sockets.md),
  and take the time to understand the relationships between the pieces.
  Introduction to [sockets](https://vimeo.com/158073174) (where you all connect to my machine).
  Here are the class videos, you can see Google's [HTTP response](https://vimeo.com/158096735)
* To see how other servers have parsed the requests, play with the code in [exploring_rack.rb](exploring_rack.rb).
* To parse the body, you'll have to figure out which key and format body come in as.
  Use the exploring rack example.
  Keep in mind that if you read too far, you will lock your server up.
  Take a look through the headers, one of them tells you how far to read.
* Create a binary named `notes_server`, which will require the server code and run it.
  You can skip the acceptance test on this one.
* This is the same thing I did in front of you at Chicago Ruby [link](https://vimeo.com/157390424).


Iteration 1 - Your own app
--------------------------

Now that you can serve rack apps, make an app that returns a body with an HTML form in it.
It has one field, named "query". When submitted, it makes a GET request to "/search",
with the query embedded in the path like this: `/search&query=array%20add`.
Place the query string in the env hash at the key `QUERY_STRING`.
You don't need to make a web request to unit test this, your server parses the web request into a hash,
so you can test your app by calling it with the same hash.

To unit test this, just give your app a hash like your server would have created.
Look at the body that it returns to make sure it has some of the words you expect to be in there.
Ie somewhere in that body is a form, or when you set the query string to search for an array,
it has some content from the notes dealing with arrays, and none from the notes that don't.

How do you figure out what to give the hash?
Play with [exploring_rack.rb](exploring_rack.rb) to see how other servers have done this.
Look at the HTTP request using netcat, then compare that with the hash the server gives you.

Also, there is a big list of the expected keys, [here](http://www.rubydoc.info/github/rack/rack/master/file/SPEC).


Iteration 2 - Serving your notes
--------------------------------

The form from the previous step should be returned when people make requests to the root path.
And since the form submission makes requests to `/search`, we'll list our our notes on that page.
Here, you might choose to do an unordered list, or a table... or if you have other ideas,
have at it :) If you don't know how to make an HTML list or table, then use a search engine to
find an example you can base yours off of.


Iteration 3 - Selecting your notes
----------------------------------

Select the notes you display at `/search` based on what's in the query string.
If you see a bunch of stuff that looks like "%21" in the query string,
this is because it doesn't want to use certain characters, since they have other meanings.
It "escapes" these characters by p
Note that the `%20` is really a space:

```ruby
"!"          # => "!"
  .ord       # => 33
  .to_s(16)  # => "21"
  .to_i(16)  # => 33
  .chr       # => "!"
```

Your app should select notes that match the query string.
This functionality already exists in your notes app project,
you'll pass selectors based on the query rather than based on `ARGV`

The easy way to do this is:

* Submit a request with all the letters you can type on your keybaord,
  look at what comes into the request.
* Then write a test that says some piece of code can take the version in the request,
  and turn it into the version in you submitted in the form.
* Break down the different things that can happen, and write a test that shows
  the piece of code can do each of those smaller ideas.
* Then write the code that does this.
* Then wire that piece of code into place in your app.


Iteration 4 - Adding notes
--------------------------

Create a link (anchor tag) on the root page that will send the user to `/notes/new`,
where they will be presented with a form to submit a new note.
This form should allow them to submit a description, example, and additional selectors.

When they submit the form, it should `POST` requests to `/notes`.
Note that a `POST` request will place the data into the body rather than the query string.
You'll still have to parse it the same way.

The submitted information should be added to the notes
such that it can then be matched in subsequent requests.


Extension - Persisting notes
------------------------------

When I add a note and restart the server, it remembers the note.
You can do this by saving and loading notes from a JSON file.
[Here](https://github.com/CodePlatoon/curriculum/blob/master/phase2/json.md)
is some material showing how to do that.


Extension - All Status Codes
----------------------------

Don't just support 200 OK, support them all!
When the app returns a status code,
use the human words described at the link Yumin posted,
[httpstatuses.com](https://httpstatuses.com/).


Extension - Error handling
--------------------------

When the app explodes, have the server render response with a status of
500 Internal server Error, and some body stating that there was a server error.
You'll may need another acceptance test to test this,
though if you put some thought into decoupling, you can do it with a unit test.

When the path doesn't match any of the `REQUEST_METHOD` / `PATH_INFO` pairs,
return a status of 404 Not Found, and some body stating that it couldn't find
the thing the app requested.


Extension - Logging
-------------------

Logging means that we record some useful information in a log.
The `REQUEST_METHOD` and `PATH_INFO` seem pretty useful, probably log those.
If you want to see some other information, log that, too.

You might record it by doing something like `$stdout.puts "some useful info"`,
but that would spam the tests and wouldn't allow us to do things like saving
the logs for later. So a better plan is to provide an IO stream to the server
when you create it. It can print into whatever stream you give it,
`@log.puts "some useful info"` and then you can give it `$stdout` from your
`bin/notes_server`, and you can give it `StringIO.new` from your test.


Extension - Natty notes
-----------------------

Use HTML and CSS to produce an interface that is pleasant to use.
It should be consistent, and CSS that is shared between pages
should be accessed through a separate request so that multiple pages
can reference it.

If your HTML is stored in a String in your application, you're going
to have an issue where you have to restart your server every time you
make a change, since it's running in memory. Restarting loads it from
the source code again, so you can see your changes.
That's going to make it really painful, so take those strings out of
your code and put them in their own files that you read off the file
system every time you make a change.
Now you don't have to restart restart the server every time!

If you're interpolating Ruby code into the string,
use [ERB](https://github.com/CodePlatoon/curriculum/blob/master/phase2/erb.md)
so you can embed Ruby code into the string.


Evaluation Rubric
-----------------

### 1. Overall Functionality

* 4: Application implements the 4 iterations and at least 2 extensions
* 3: Application implements through iteration 4
* 2: Application implements iterations 1 - 3
* 1: Application implements through interation 0 or less,
     or removes functionality from the command-line notes,
     or can't be run with `bin/notes_server`

You can get a 1/2 bonus point by having everyone in your group perform
the [http waypoint](https://github.com/turingschool/waypoints/blob/master/waypoints/http.md)
in front of me. This can be applied to an "iffy" step (ie if I'm having
difficulty giving you the full point, we can apply this to compensate and get the full point)


### 2. Test-Driven Development

* 4: Minimal number of acceptance tests to have confidence everything is hooked up correctly, and it works.
* 3: Test names that describe behaviour (I can read them in English and understand how the code works)
* 2: Tests adequately cover the behaviour (ie they try edge cases and illustrate that the test name is actually true)
* 1: Tests fail or have gaps in coverage.


### 3. Fundamental Ruby & Style

* 4: Application passes Rubocop, uses proper naming, and is generally pristine,
     and uses Ruby well, eg the Enumerable methods.
     rather than duplicating it, is named descriptively.
* 3: Application passes Rubocop, uses proper naming, and is generally pristine.
* 2: Application runs but does not pass Rubocop, or has constants that don't match the file,
     incorrect camel/snake casing, commented out code, etc.
* 1: Application generates syntax error or crashes during execution


### 4. Breaking Logic into Components

maybe that it doesn't have code that anticipates some future that will never come,
but makes life harder right now

* 4: Code in lib either doesn't know about the command line / web page,
     or that knowledge is kept to a place, whose responsibility is to handle those things,
     and the core notes code is kept oblivious.
* 3: There is a clear attempt to separate code dealing with the terminal
     (put, print, argv, escape sequences, etc), web page (html, css, web specific request knowledge)
     and code that would be useful in other contexts.
     Methods pulled out of other methods are made private,
     so the outside world doesn't depend on them.
     Methods with bits of functionality broken out of them are placed in
     their own class, not all mixed together.
* 2: Follows the proper directory structure with code in lib, executable in bin,
     tests in test or spec, only one toplevel file in lib,
     the rest are stored within a directory named after the project.
     Classes and modules are namespaced inside a constant.
     Lots of code that adds overhead for the sake of anticipated future use cases
     (really, this is what waterfall is -- the opposite of agile).
* 1: Code is haphazardly placed, filenames are incorrect,
     the `$LOAD_PATH` is littered with files a user could accidentally require.
     `Object` is littered with constants and methods.

### 5. Collaboration

* 4: Frequent committing (ie if half a feature was commplete, then half the
     feature was available to the team, because you didn't hoard the functionality).
     Team members working either together or on functionality that implies a
     shared vision and understanding of the direction.
     CI nearly always passes, and failures are addressed before moving on.
* 3: Pull requests for every iteration, some confusion on the direction / what
     other members are working on.
* 2: Independent work that has no bearing on the team's vision for the project.
* 1: No CI or Failing CI builds that go unnoticed / unaddressed,
     lack of coherence of the product. A useless / nonfunctioning project for
     most of its life (remember how
     [iteration](http://herdingcats.typepad.com/.a/6a00d8341ca4d953ef01a511e114a3970c-pi)
     should work).
