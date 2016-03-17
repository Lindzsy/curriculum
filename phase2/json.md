JSON
====

What
----

JSON is a string format for storing data.
Its name means _"JavaScript Object Notation"_,
because its syntax is based on JavaScript.

JSON can store nil, true, false, numbers, strings, arrays, and hashes... our 6 structures

Why
---

It is frequently used in APIs, and as a persistence format (a way of storing data in a file),
because it is human readable, natural for anyone who understands JavaScript, easy to parse,
and it contains a set of structures that pretty much every language is able to represent.

You can see an example of JSON in the body of this HTTP response.

```sh
$ curl -i https://api.github.com
```

Where to get more in-depth info
-------------------------------

* [docs](http://www.rubydoc.info/stdlib/json) for the JSON library that ships in Ruby's stdlib.
* [json.org](http://www.json.org/) has really good technical information about JSON.
* [wikipedia](https://en.wikipedia.org/wiki/JSON) has some history and background information.
* [jsonlint.com](http://jsonlint.com/) will tell you whether your JSON is valid.


Most important pieces
---------------------

#### Loading

There is a reasonable implementation in the standard library, thus you can get it with simply:

```ruby
require 'json'
```


#### Turn Ruby into JSON

You can call the singleton method `JSON.dump` to turn Ruby into JSON.

Note that what we call "nil", JSON calls "null",
and what we call a "hash", JSON calls an "object".

```ruby
JSON.dump [nil, true, false, 123, 12.34, "abc", [], {}]
# => "[null,true,false,123,12.34,\"abc\",[],{}]"
```


#### Turn JSON into Ruby

You can call the singleton method `JSON.parse` to turn JSON into Ruby.

```ruby
JSON.parse '[null,true,123]' # => [nil, true, 123]
```



#### The topmost element should be an array or hash

I think this is stupid, but nonetheless, that's how the specification has it.

```ruby
JSON.parse '[]'  # => []
JSON.parse '{}'  # => {}
JSON.parse '12'  # => JSON::ParserError: 784: unexpected token at '12'
```

You can tell Ruby's JSON parser to ignore this rule with the `quirks_mode` keyword argument.

```ruby
JSON.parse '12', quirks_mode: true # => 12
```


#### Symbols vs Strings

JSON doesn't have Symbols, so they become Strings.

```ruby
JSON.dump [:abc] # => "[\"abc\"]"
```

However, we frequently use symbols as hash keys in Ruby,
so you can tell the JSON parser to turn hash keys into symbols
with the `symbolize_names` keyword argument.

```ruby
JSON.parse '[{"a":1}, {"b":2}]', symbolize_names: true  # => [{:a=>1}, {:b=>2}]
JSON.parse '[{"a":1}, {"b":2}]', symbolize_names: false # => [{"a"=>1}, {"b"=>2}]
JSON.parse '[{"a":1}, {"b":2}]'                         # => [{"a"=>1}, {"b"=>2}]
```


#### Example: To JSON and back

Here, we'll take a Ruby array, dump it to JSON, save that JSON in a file,
read the file back into memory, and parse the JSON back into Ruby.
In the end, we get out what we put in.

```ruby
require 'json'

original = [{'a' => 1}, {'b' => 2}]  # => [{"a"=>1}, {"b"=>2}]
json     = JSON.dump  original       # => "[{\"a\":1},{\"b\":2}]"
File.write "example.json", json

# Between these steps, we could shut the program down,
# turn off the computer, go for vacation, and come back

from_disk = File.read 'example.json'  # => "[{\"a\":1},{\"b\":2}]"
parsed    = JSON.parse from_disk      # => [{"a"=>1}, {"b"=>2}]
original == parsed                    # => true
```

Note that you now have a file in your current directory named "example.json",
probably cat it out to see, then delete it.
