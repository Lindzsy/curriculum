Seeless
=======

Teams / Goals
-------------

First, get your teams and the goals for your team on this project.
Take 10 minutes to talk about how you want to achieve those goals.


The project
-----------

Based on Ada's [Seemore](https://github.com/Ada-Developers-Academy/C3Projects--SeeMore),
but this is the 1.5 day version. Go ahead and take 15 minutes to
read that project with your pair,
talk about what it looks like to use that site.


How yours is different
----------------------

Instead of building an aggregator,
you only need to consume and present one feed
(we're going for 1.5 days, not weeks :)


Preparation
-----------

Take 5 minutes to get together with your pair and consider
which feed you want to try to consume / come up with a name for the app.

Spend 5 minutes thinking from the perspective of someone using your app,
what it will look like to go through the different pages?
What are the primary ways they are going to want to use your app?
When people talk about "features" or "use cases", this is what they mean.

Take 15 minutes to do some quick sketches of the pages,
how you move around between them, what data you'll see.
It should look something like [this](https://studio.uxpin.com/wp-content/uploads/2014/04/UXPin-.png),
but without that level of detail.
Include things like forms, links, buttons, which data will be presented on which pages,
When people talk about "views", this is what they mean.
For comparison, I came up with 5.


Consider Routing
----------------

Since you've all got a good understanding of how the web works,
the next thing to consider are the routes. How do you get to those
pages you drew?

Lets take an hour to talk about [RESTful routing](rest.md).


The routing of your user flow
-----------------------------

Now take 20 minutes to identify what the route should be for
each of the pages you sketched, and what other routes will need
to exist in order to handle all the behaviour.

The authentication (verifying a user is who they say they are)
will take 2 routes, one to send the user to the service,
and one to sign them in when they return from the service, and then redirect
them to some more useful page.
These are the routes I think authentication will probably use:

```
GET /auth/twitter
  handled by a gem
  Oauth sends them to twitter

GET /auth/twitter/callback
  Handled by SessionsController#create
  create the user if they don't exist
  add user id to session to log them in
  redirect to the root
```

For reference, I came up with a total of 8 routes,
one of them chooses the view based on whether the
user is logged in.



Make your new Rails app
-----------------------

Go ahead and make the new rails app

```
$ rails new your_app_name --skip-turbolinks --skip-spring
$ cd your_app_name
$ git init
$ git add .
$ git status
$ git commit -m 'Brand new Rails app'
$ git status
```

Now put the app on [github](https://github.com/CodePlatoon/curriculum/blob/da4ee129441e2373d839cd8847c9460109585462/phase1/how_to_use_git_for_pairing_on_a_project.md).


Set your routes up
-------------------

Use the code snippet in the REST material,
and reference the comments in config/routes.rb,
playing around until its routes match the ones you wanted
(except for the oauth ones, we'll do that next).


Learn about Oauth
-----------------

Matthew's been working on creating a blog for us in Rails,
several others have joined him at various times.
Since he got Oauth working on it,
I asked him to teach a lesson on what he figured out.

Lets go through that, and then apply the ideas to try and get
it working on our apps.


Find a gem to consume your API
------------------------------

Now you need to figure out how to talk to your API.
At the end of the day, it's just HTTP requests, but
someone has already written the code to talk to the
API, so search around for any gems that already consume it.
What gems are people using?
Are there any promising examples? Blog posts? Tutorials?
Scan them to identify the most relevant bits of data.
What things are you going to need? Write them down somewhere,
What code samples look promising, include those.


Play around with your API
-------------------------

Put a pry into your controller after you get logged in.
Spend a little bit of time figuring out how to get your gem to talk to the service.


Write your acceptance tests
---------------------------

Write in English how your user goes though the pages,
Use [Capybara](capybara_cheatsheet.md) to do that programatically,
wherever you expect to see something, make an assertion.
If you aren't sure how to do it, make it right-enough that
when you get there and it blows up, you'll know what you intended for it to do.
Don't let discomfort with capybara pull you out of context,
you can literally write English pseudocode in places where you don't know what to do.


Let your tests guide you
-------------------------

Run your tests and predict what the failures are going to be.
They should guide you to all the pieces you need.
If they don't, add another test. If it's painful building that much of the world,
then you've identified need for unit tests!


Don't forget about the ActiveRecord Playground
----------------------------------------------

When it comes time to talk to the db,
you can use the [ActiveRecord playground](https://github.com/CodePlatoon/curriculum/blob/da4ee129441e2373d839cd8847c9460109585462/phase2/active_record_playground.rb)
to figure out what they should look like.
Once you have it working, copy the classes into app/models/whateve.rb,
and the schema goes into a new migration (`rails g migration create_tables`).
