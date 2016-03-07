Web Notes
---------

This project is based on one I made for Turing,
which can be seen [here](https://github.com/turingschool/curriculum/blob/master/source/projects/http_yeah_you_know_me.markdown).

Project Overview
----------------

In this project we'll begin to introduce HTTP, the protocol that runs the web,
and build a functioning web server to put that understanding into action.

Learning Goals
--------------

* Practice breaking a workflow into a system of coordinating components
* Practice using TDD at the unit, integration, and acceptance levels
* Understand how the HTTP request/response cycle works
* Practice implementing basic HTTP requests and responses
* See how design decisions we make allow this to be easy... or difficult :P


The Project
-----------

You're going to build a web application to serve your
[notes project](https://github.com/CodePlatoon/curriculum/blob/master/phase1/notes-project.md).


Iteration 0 - Pass my acceptance test
-------------------------------------

This step will build a valid rack server.

* I've provided an acceptance test [here](web_notes_acceptance_test.rb).
* You **will** need to make your own unit tests around parsing the request and generating the response.
* To see how other servers have parsed request, play with the code in [exploring_rack.rb](exploring_rack.rb).
* Create a binary named `notes_server`, which will require the server code and run it.
  You can skip the acceptance test on this one.


Iteration 1 - Your own app
--------------------------

Now that you can serve rack apps, make an app that returns a body with an HTML form in it.
It has one field, named "query". When submitted, it makes a GET request to "/search",
with the query embedded in the path like this: `/search&query=array%20add`.
Place the query string in the env hash at the key `QUERY_STRING`.
You don't need to make a web request to unit test this, your server parses the web request into a hash,
so you can test your app by calling it with the same hash.

To unit test this, just give it a hash like your server would have created.
Again, you can play with [exploring_rack.rb](exploring_rack.rb)
to see how other servers have done this.


Iteration 3 - Serving your notes
--------------------------------

The form from the previous step should be returned when people make requests to the root.
And since the form submission makes requests to `/search`, we'll list our our notes on that page.
Here, you might choose to do an unordered list, or a table... or if you have other ideas,
have at it :) If you don't know how to make an HTML list or table, then use a search engine to
find an example you can base yours off of.


Iteration 4 - Selecting your notes
----------------------------------

Select the notes you display at `/search` based on what's in the query string.
Note that the `%20` is really a space:

```ruby
" "          # => " "
  .ord       # => 32
  .to_s(16)  # => "20"
  .to_i(16)  # => 32
  .chr       # => " "
```

Your app should select notes that match the query string.
This functionality already exists in your notes app project,
you'll pass selectors based on the query rather than based on `ARGV`


Iteration 5 - Adding notes
--------------------------

Create a second form on the root page that will send a `POST` request to `/notes`.
It should have inputs for a description, example, and additional matchers.

You will need to parse the body to pass this test.
Keep in mind that if you read too far, you will lock your server up.
Take a look through the headers, one of them tells you how far to read.
Place the body into an IO object at the key `rack.input`.

The submitted information should be added to the notes such that it can then be matched in subsequent requests.


Iteration 6 - persisting notes
------------------------------

Store your notes should be read in from a file.
When you add notes, they should be saved back into the file so that they are still available when you restart.
