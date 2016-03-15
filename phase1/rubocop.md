Rubocop
=======

What
----

Rubocop is a gem that will evaluate your code
and tell you whether there are problems.


Why
---

It's an easy way to give you immediate feedback about
indentation issues, idiom violations, etc. Realistically,
everyone keeps their code in good condition at all points during
development, because:

* It's just easier to do it right than to fix it later
* It makes reading the code much easier to do, because
  it's not formatted haphazardly. This helps prevent
  you from getting lost in the weeds.
* Everyone expects it, and doesn't take people seriously who don't
  keep their code in order. When we see improperly formatted code,
  we assume the dev doesn't care.
* Some issues can cause bugs.


Where to get more in-depth info
-------------------------------

https://github.com/bbatsov/rubocop


Most important pieces
---------------------


#### Installation

Get it through rubygems

```
$ gem install rubocop
```


#### Configuring it

Put a configuration file, ".rubocop.yml",
at the root of your project.

I read through the options yesterday and came
up with [this one](https://github.com/CodePlatoon/curriculum/blob/cf6525fea1ecbbfe26f45fc96539cb2ea50c27f7/phase1/rubocop.yml)


#### Running it

From the root, run it like this:

```sh
$ rubocop --fail-fast
```

It should tell you what issues you have, and what files they are in.


#### Integrate it!

* Add it to Bundler and make a rake task that runs it through
  `sh` and uses `bundle exec`.
* You can set it to run by default, after the "test" task,
  by declaring the default a second time.
* Then commit everything.
* Then go through and fix the issues it finds.
* Then commit everything.
* Keep your code passing as you work on your project.
  Eventually you won't even notice, everything will just be good,
  all the way through.
