ERB
===

ERB lets you embed Ruby code in a String.
It is very common to get your string by reading a file.
For you, that's probably an HTML file.

Accessing ERB
-------------

It ships with Ruby, so you don't need to install it,
you only need to require it.

```ruby
require 'erb'
```


The two ways to use ERB
-----------------------

There are 2 ways to use ERB

| Like this      | `<%= ruby code %>` |
| And like this  | `<%  ruby code %>` |


With an equal sign
------------------

The first one lets you embed the result of running Ruby code.

```ruby
@data = {description: 'Add two numbers together', example: '10 + 2 # => 12'}

template = <<-HTML
<div class="description"><%= @data[:description] %></div>
<div class="example"><%= @data[:example] %></div>
HTML

ERB.new(template).result(binding())
# => "<div class=\"description\">Add two numbers together</div>
#    <div class=\"example\">10 + 2 # => 12</div>"
```

Without an equal sign
---------------------

The second does not put the result of the code into the string,
it is intended to be used for control flow.

```ruby
erb = ERB.new('1<% if @show_two %>2<% end %>3')

@show_two = true
erb.result(binding())  # => "123"
@show_two = false
erb.result(binding())  # => "13"
```

Using them together
-------------------

Lets put them both together

```ruby
@names = %w[Sally Sue Sarah]
template = '<ul>
<% @names.each do |name| %>
  <li><%= name %></li>
<% end %>
</ul>'
ERB.new(template).result(binding())
# => "<ul>
#
#      <li>Sally</li>
#
#      <li>Sue</li>
#
#      <li>Sarah</li>
#
#    </ul>"
```
