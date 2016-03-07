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
The acceptance test is [here](web_notes_acceptance_test.rb).
You **will** want to make your own unit tests around parsing the request
and generating the response.

Create a binary named `notes_server`, which will require the server code and run it.
You can skip the acceptance test on this one.


Iteration 1 - Your own app
--------------------------

Now that you can serve rack apps, make an app that returns a body with an HTML form in it.
It has one field, named "query". When submitted, it makes a GET request to "/search", with
the query embedded in the path like this: `/search&query=array%20add`.
To unit test this, just give it a hash like your server would have created.


Iteration 3 - Serving your notes
--------------------------------

Your app needs to be able to serve the form on requests to `/`,
and list out your notes when you make a request to `/search`.


Iteration 4 - Selecting your notes
----------------------------------

Place the query string in the env hash at the key `QUERY_STRING`.
Your app should select notes that match the query string.
This functionality already exists in your notes app project,
you'll pass selectors based on the query rather than based on `ARGV`


Iteration 5 - Adding notes
--------------------------

Create a second form on the root page that will send a `POST` request to `/notes`
with a description, example, and additional matchers.
You will need to parse the body to pass this test.
Keep in mind that if you read too far, you will lock your server up... take a look through the headers, one of them tells you how far to read.
Place the body into an IO object at the key `rack.input`.

The submitted information should be added to the notes such that it can then be matched in subsequent requests.


Iteration 6 - persisting notes
------------------------------

Store your notes should be read in from a file. When you add notes, they should be saved back into the file so that they are still available when you restart.
