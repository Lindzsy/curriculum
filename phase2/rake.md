Rake
====

What
----

Rake is a gem that makes it easy to
run code from the command-line.
Each thing you can run is called a "task",
for historical reasons.


Why
---

It's more convenient than having
a large number of executables.


Where to get more in-depth info
-------------------------------

Go to the [github page](https://github.com/ruby/rake)
and look through the examples and links.


Most important piecs
--------------------

#### Rakefile

Put your rake code (tasks) in this file.
Here, we'll make one task named "hello".
And we'll give it a description so that
we know what it does when we ask what tasks there are.

```ruby
desc 'Say hello!'
task :hello do
  puts "hello, world!"
end
```


#### Running tasks

Now we can run our task with:

```sh
$ rake hello
hello, world!
```


#### Listing tasks

We can get a list of tasks by passing the `-T` flag to rake.
(what does that probably stand for?)

```ruby
$ rake -T
rake hello  # Say hello
```


#### Tasks that run programs

Rake gives you a method, `sh`, for running programs
(like Open3, but less formal). You can call it from
within a task.

```ruby
desc 'Say hello!'
task :hello do
  puts "hello, world!"
end

desc 'Run my tests!'
task :test do
  sh "bundle exec mrspec"
end
```

And lets list them

```sh
$ rake -T
rake hello  # Say hello!
rake test   # Run my tests!
```


#### A default task

Lets say there's one task you run most frequently.
Probably that's running our tests. We can make that
task run by default, when none are specified.

```ruby
task default: :test

desc 'Say hello!'
task :hello do
  puts "hello, world!"
end

desc 'Run my tests!'
task :test do
  sh "bundle exec mrspec"
end
```

And now, to run tests, I can say:

```sh
$ rake
```
