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

<table>
  <tr>
    <td>Like this</td>
    <td><%= ruby code %></td>
  </tr>
  <tr>
    <td>And like this</td>
    <td><%  ruby code %></td>
  </tr>
</table>


With an equal sign
------------------

The first one lets you embed the result of running Ruby code.

```ruby
require 'erb'
@number = 123
ERB.new('abc <%= @number %> defg').result(binding())
# => "abc 123 defg"
```

Without an equal sign
---------------------

The second does not put the result of the code into the string,
it is intended to be used for control flow.

```ruby
require 'erb'
erb = ERB.new('1<% if show_two %>2<% end %>3')

show_two = true
erb.result(binding())  # => "123"

show_two = false
erb.result(binding())  # => "13"
```

Using them together
-------------------

Lets put them both together

```ruby
@names = %w[Sally Sue Sarah]
template = <<-HTML
<ul>
<% @names.each do |name| %>
  <li><%= name %></li>
<% end %>
</ul>
HTML
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

Instance variables and local variables
--------------------------------------

You are passing a binding, which has access to local variables and `self`.
Thus, the renderer can access local variables through the binding,
and can access instance variables, through the object at the binding's `self`.


Seeing the code generated from the template
-------------------------------------------

If you're having difficulty understanding
what the template is going to do, you
can see the Ruby code that it would generate
like this:

```ruby
require 'erb'
erb  = ERB.new("abc <% if @show_2 %>2<% end %> defg\n")
code = erb.src.gsub(/ *; */, "\n")
puts code
```

In our case, if we ran that, it would print out this:

```ruby
#coding:UTF-8
_erbout = ''
_erbout.concat "abc "
if @show_2
_erbout.concat "2"
end
_erbout.concat " defg\n"

_erbout.force_encoding(__ENCODING__)
```
