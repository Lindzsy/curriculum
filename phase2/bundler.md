Bundler
=======

What
----

A gem that makes sure your code uses the right versions of other gems,
and that they are all compatible with each other.


Why
---

To allow you to have many versions of gems on your computer,
but load and use only the ones you intend.

To allow everyone on your team to know that they are using
the exact same code (people used to say "it works on my computer")

We'll use this later today to allow another website (Travis CI)
to download and use the gems we are using locally.


Where to get more in-depth info
-------------------------------

Go to the [website](http://bundler.io/)! They have wonderful documentation.


Most important pieces
---------------------

#### Getting Bundler

See if you have Bundler

```sh
$ type bundler
```

If not, install it with Rubygems:

```sh
$ gem install bundler
```


#### Telling Bundler what gems you use

To use Bundler, you need to tell it what gems you are using.
You do this by declaring them in a file named Gemfile.
Here is a sample:

```ruby
# tell Bundler where to download your gems from
source 'http://rubygems.org'

# Tell it we want to use mrspec version 0.3.1
gem 'mrspec', '= 0.3.1'
```

Go ahead and make an empty directory and place this in a Gemfile there.


#### Resolving and installing gems

Now that you have a Gemfile, you can tell Bundler to install those gems.
It will look at what you said you need, and it will look at what those
gems, in turn, need, and "resolve" them all. This just means that
it will choose versions that are all compatible.

You can tell it to resolve and install the gems like this:

```sh
$ bundle install
```


#### Tracking the resolved gems

Now that you've installed the gems, you may notice that you have
an additional file, the Gemfile.lock

You probably don't have to ever mess with it,
but this is where, Bundler places the information about
which gems and versions it's chosen, based on your Gemfile.


#### Running your code within Bundler

So, now you have a set of gems that you want to run with,
and they are installed, but how do you make sure that Ruby
uses the gems?

Bundler gives you a command-line executable for doing this, `bundle exec`.
This command sets some environment variables that affect how Ruby works.
They cause Ruby to only see the gems that you've told Bundler about,
ensuring that you are running under the environment you've had Bundler create for you :)

```sh
$ bundle exec mrspec -v
$ bundle exec gem list
```


#### Fun info!

Here are some Gemfiles from other sources:

* Ruby on Rails manages its gems with Bundler [link](https://github.com/rails/rails/blob/d54de0808c05c3f7c70dee8ab0111a94c8f90d00/Gemfile)
* RSpec does, too! [link](https://github.com/rspec/rspec-core/blob/350c21b6f66a54267ff615ed16604e017122e6be/Gemfile)
* So does Nokogiri! [link](https://github.com/sparklemotion/nokogiri/blob/027a151102083258f5e297c4fecfddca56904a2a/Gemfile)
* When Rails starts you off with a new project, it gives you a Gemfile,
  so that the code on your server will be running the same versions as the code you have locally!
  [link](https://github.com/rails/rails/blob/d54de0808c05c3f7c70dee8ab0111a94c8f90d00/railties/lib/rails/generators/rails/app/templates/Gemfile)
  Check out that file, doesn't it look strange? What's interesting about it?
  What do you think all that stuff does?
