Capybara Cheatsheet
===================

Inspired by https://gist.github.com/zhengjia/428105

Get it
------

```
$ gem install capybara
```

Set it up
---------

Here we'll set it up to run against a Sinatra application.

```ruby
require 'capybara'
require 'sinatra/base'

# An app to hit with Capybara
class MyApp < Sinatra::Base
  enable :inline_templates
  get '/users/:id' do
    "User number #{params[:id]} is an uppity know-it-all"
  end
end

# Configure Capybara
Capybara.app = MyApp # In Rails, set it to Rails.application
page = Capybara.current_session

# Visit a page and look at some info
page.visit "/users/456"
page.status_code  # => 200
page.current_path # => "/users/456"
page.current_url  # => "http://www.example.com/users/456"
page.body         # => "User number 456 is an uppity know-it-all"
```

Using it
--------

Here is a cheatsheet of various ways to use it.

```ruby
require 'capybara'
last_env = nil
body     = ""
Capybara.app = Proc.new do |env|
  last_env = env
  headers  = {'Content-Type' => 'text/html', 'Content-Length' => body.length}
  [200, headers, body.lines]
end
page = Capybara.current_session


# ===== Navigation  =====
# this is like typing into your URL bar and hit return
page.current_path # => nil
page.visit '/omg'
page.current_path # => "/omg"


# =====  Clicking links/buttons  =====
body = "
  <a href='/first'  id='link-1'>Link 1</a>
  <a href='/second' id='link-2'>Link 2</a>
  <form action='/third'>
    <p><input type='submit' id='button-1' value='Button 1'></p>
  </form>
"
page.visit '/'

# click link by id
page.click_on 'link-1'
page.current_path # => "/first"

# click link by its text
page.click_on 'Link 2'
page.current_path # => "/second"

# button by its text
page.click_on 'Button 1'
page.current_path # => "/third"


# =====  Interacting with forms  =====
body = "
  <form action='/'>
    <label for='thought-id'>Thought</label>
    <input type='text' name='thought-name' id='thought-id'>
    <p><input type='submit' value='Submit'></p>
  </form>
"
page.visit '/'

# Fill in a form field by its label
page.fill_in 'Thought', with: 'by label'
page.click_on 'Submit'
last_env['QUERY_STRING'] # => "thought-name=by+label"

# Fill in a form field by its id
page.fill_in 'thought-id', with: 'by id'
page.click_on 'Submit'
last_env['QUERY_STRING'] # => "thought-name=by+id"

# other optoins I haven't gotten to
# choose('A Radio Button')
# check('A Checkbox')
# uncheck('A Checkbox')
# attach_file('Image', '/path/to/image.jpg')
# select('Option', :from => 'Select Box')


# =====  Scope to a subset of the page  =====
body = "
  <div class='c1'><a href='/link1'>Link</a></div>
  <div class='c2'><a href='/link2'>Link</a></div>
"
page.visit '/'

# use a CSS selector and place the behaviour within the block
page.within '.c1' do
  page.click_on 'Link'
  page.current_path # => "/link1"
end

page.within '.c2' do
  page.click_on 'Link'
  page.current_path # => "/link2"
end


# =====  Querying  =====
body = "
  <div class='c1'></div>
  <p>existing content</p>
  <p style='display: none'>hidden content</p>

  <ul>
    <li>a</li>
    <li>b</li>
  </ul>
"
page.visit '/'

# Existence of CSS selector
page.has_css? '.c1' # => true
page.has_css? '.c2' # => false

# Existence of visible text on the page
page.has_content? 'existing content'    # => true
page.has_content? 'nonexisting content' # => false
page.has_content? 'hidden content'      # => false

# search for every element matching a CSS selector
page.all('li')   # => [#<Capybara::Node::Element tag="li" path="/html/body/ul/li[1]">, #<Capybara::Node::Element tag="li" path="/html/body/ul/li[2]">]
    .map(&:text) # => ["a", "b"]

# searching for one element matching a css selector
page.find('li:first').text # => "a"
page.find('li:last').text  # => "b"


# =====  Elements  =====
body = "
  <a href='/first'>a</a>
  <a href='/second'>b</a>
"
page.visit '/'
links = page.all('a')

# .text to see the text within them
links.map { |e| e.text } # => ["a", "b"]

# brackets to access attributes
links.map { |e| e[:href] } # => ["/first", "/second"]


# =====  Debugging  =====
page.methods.grep(/save/)
# => [:save_page,
#     :save_and_open_page,
#     :save_screenshot,
#     :save_and_open_screenshot]
