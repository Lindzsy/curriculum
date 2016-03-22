Capybara Challenge 1
====================

Install phantomjs, a js web browser:

```
$ brew install phantomjs
$ gem install capybara poltergeist launchy
```

Then start a pry session and load up the internet!

```ruby
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist
page = Capybara.current_session
page.visit 'https://vimeo.com/user47788820'
page.save_and_open_screenshot
page.save_and_open_page
page.save_screenshot('screenshot.png')
```

You might also encounter bad JavaScript (most sites have bad JavaScript, I've found).
To prevent this from killing Capybara, you can set some setting somewhere.
If you hit this, you'll have to figure out what to google for to figure out how to set it
(let me know if you find it).

Can you use [Capybara](https://github.com/jnicklas/capybara) to find [Code Platoon's](https://vimeo.com/user47788820)

* shortest video?
* Longest video?
* Video with the most views?
* Video with the least views?
* Video with the most comments?
* Most recent video?
* First video?
* Can you use it to cheat at synseer? (you might have to go down to the driver for this one -- I haven't tried it yet)
