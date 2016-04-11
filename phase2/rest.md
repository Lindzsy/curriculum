REST
====

REST is a way of thinking about data
that you interact with through HTTP requests
(aka on the internet).


Routing
-------

Routing is about 2 things:

* The request method (GET in the example below)
* The path (/users/5 in the example below)

```
GET /users/5 HTTP/1.1
User-Agent: curl/7.30.0
Host: localhost:3003
Accept: */*

```


RESTful routing
---------------

RESTful routing is about:

* Treating the request method as a **verb**
* Treating the path as a **noun**

In our above example, the client is saying to the server:

* "I would like to get user number 5"
* "I would like to GET /users/5"


The verbs (request methods)
---------------------------

First think about these as operations on a file,
it's helpful, because that's the context they were derived in.

* POST - used to **create** a new file (it wi in the request body)
* GET - used to **read** a file (this Unix parlance for retrieving, think `File.read`)
* PUT -  used to **update** a file (completely replace it)
* PATCH - same as PUT, but for a portion of the file
* DELETE - used to **delete** a file

So the verbs allow us to create, read, update, and delete files.
For brevity, people have shortened this set of operations to the
acronym "CRUD". The "C" and the "D" make a lot of sense.
The "R" is confusing unless you think about it like a file.
The "U" would be better as "replace", IMO, but hey,
they were named a long time ago.

If you want to learn more about these, check out
http://www.restapitutorial.com/lessons/httpmethods.html


The nouns - Resources
---------------------

In REST, they call the noun a "resource".
This is to keep it general enough that it can apply to more than just files.
Instead of a file, our resource might be a row in our database.
In our above example, it's a user, it could be something like an
address, or a subscription which tells us how much the user needs to pay
every month.

More generally, a resource is some piece of data stored on the server.


Single resources vs collections
-------------------------------

If a file is like a row in a database, then a directory
is like a table in the database, because a directory contains files,
and a table contains rows.

If we have a table called users, then a GET request to "/users"
is like asking to see all of the users, and a GET request to "/users/5"
is like asking to see user number 5.


Rails conventions
-----------------

Here is a list of request methods,
paths, controllers, controller methods, and descriptions.
Look at the names and descriptions, and try to group them
into the 8 routes that Rails would give you for a resource.

```
/photos/:id
PhotosController
#show
/photos/:id
DELETE
PhotosController
#edit
update a specific photo
/photos
/photos/:id
PhotosController
#update
display a specific photo
return an HTML form for editing a photo
delete a specific photo
/photos/:id
GET
PhotosController
#create
PhotosController
#destroy
return an HTML form for creating a new photo
GET
PATCH
GET
display a list of all photos
update a specific photo
PhotosController
#update
GET
/photos
PUT
/photos/new
PhotosController
#new
/photos/:id/edit
PhotosController
#index
create a new photo
POST
```

When you're done, you can check your answer
[here](http://guides.rubyonrails.org/routing.html#crud-verbs-and-actions).
That page probably has all the information you'll ever need
to do routing in Rails.


Dealing with other verbs
------------------------

If I'm using a social media site, I might want to send a friend request.
But I can't send a requst "REQUEST-FRIENDSHIP /users/23",
there is no verb for it.

The way to deal with situations like this is to turn your verb into a noun:
"POST /friends" and include their id in the body of the request: `user_id=23`
(we're assuming that my id is known since I'm the logged in user who
submitted the request).


Deviating from REST
-------------------

Of course, you may have need to deviate, for example:

* Maybe the resource is implicit:
  to see my profile, I'd expect to go to "/profile", not "/users/5"
* Maybe the resource is sensitive:
  I probably shouldn't be able to see an index of all the users when
  I'm on gmail.
* Maybe the resource can't be deleted:
  if I take out a loan, and money gets put in my bank account,
  I shouldn't be able to send a DETELE request to "/loans/8284"
  and have my debt be forgotten.


Setting up routes in Rails
--------------------------

You tell Rails about your verb/noun pairs in "config/routes.rb"
If what you have is close enough to the idea described above,
then you can just call the method `resources` and pass the name,
and it will set up 8 default routes for you.

Play around with some of the methods from [here](http://guides.rubyonrails.org/routing.html)

```ruby
# This code works as of Rails 4.2
require 'action_dispatch/routing'
require 'action_dispatch/routing/inspector'
Rails ||= Class.new { def self.method_missing(*) self end } # hack to get around router coupling
route_set = ::ActionDispatch::Routing::RouteSet.new
at_exit { puts ActionDispatch::Routing::RoutesInspector.new(route_set.routes).format(ActionDispatch::Routing::ConsoleFormatter.new).lines.map(&:chomp) }

# Once you have something you like, copy it into config/routes.rb
route_set.draw do
  resources :users
end

# >>    Prefix Verb   URI Pattern               Controller#Action
# >>     users GET    /users(.:format)          users#index
# >>           POST   /users(.:format)          users#create
# >>  new_user GET    /users/new(.:format)      users#new
# >> edit_user GET    /users/:id/edit(.:format) users#edit
# >>      user GET    /users/:id(.:format)      users#show
# >>           PATCH  /users/:id(.:format)      users#update
# >>           PUT    /users/:id(.:format)      users#update
# >>           DELETE /users/:id(.:format)      users#destroy
```
