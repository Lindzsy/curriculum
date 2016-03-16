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


Iteration 4 - Adding notes
--------------------------

Create a second form on the root page that will send a `POST` request to `/notes`.
It should have inputs for a description, example, and additional matchers.

You will need to parse the body to pass this test.
Keep in mind that if you read too far, you will lock your server up.
Take a look through the headers, one of them tells you how far to read.
Place the body into an IO object at the key `rack.input`.

The submitted information should be added to the notes such that it can then be matched in subsequent requests.


Iteration 5 - persisting notes
------------------------------

Store your notes somewhere that you can add them and they will still be around.
You can do this by sticking them into a JSON file, or a database.
When you add notes, they should be saved back into the file so that they are still available when you restart.
