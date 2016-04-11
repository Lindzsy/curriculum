Testing With Web Requests
=========================

Web requests are pain!
----------------------

They are *slooooooow*, their data can change sporadically,
it's difficult to put them into specific situations.

With APIs, you can wind up rate limited,
which means you're making too many requests in an allotted amount of time >.<

You can't work on your site on the train or plane or when you don't have internet access.


Stubbing the internet
---------------------

some wondeful humans have given us the ability to just say
"the internet responds with this HTTP response".
This is called "stubbing".

Stubbing allows our tests to work when there is no internet,
it gives us some control over the content of the requests,
we can set the status code, body, and headers of the response,
and then run our code and it won't know the difference.

All of a sudden, it's easy to test a specific example like an
empty set of tweets coming back, it's easy to know what the
first tweet will be, b/c we control what it is,
and our tests run dramatically faster and dramatically more reliably!


Stubbing with VCR
-----------------

VCR is a gem that allows you to record HTTP requests and then play them back again later.

It will you can record the requests and responses that are made,
and then later, it will stub the internet and reuse the previously recorded
requests and responses.

```ruby
require 'vcr'

VCR.configure do |config|
  # this is where we want to store the requests and responses
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

class VCRTest < Minitest::Test
  def test_recording_and_replaying_a_web_request
    body = VCR.use_cassette "vcr-homepage" do
      # All http requests that are made while this block is in the callstack will be recorded
      # eg the request below might be made by an API client
      # If we've already recorded the requests / responses,
      # then we will stub them instead of recording them, now we aren't making HTTP requests.
      Net::HTTP.get_response(URI('https://github.com/vcr/vcr'))
    end
    assert_match /Record your test suite's HTTP interactions/, body
  end

  def test_ten_requests_are_expensive
    # This one will be suuuuuper slow!
    # But... only the first time!
    uri = URI('https://github.com/CodePlatoon/curriculum/blob/master/phase2/seeless_project.md')
    VCR.use_cassette "seeless" do
      10.times { Net::HTTP.get_response(uri) }
    end
  end
end
```


Stubbing with WebMock
---------------------

Another option for stubbing the internet is WebMock.
It allows us to stub the internet too, but requires us to specifically list
what we expect in the request and what to send back in the response.

```ruby
require 'webmock/minitest'
require 'net/http'

class WebmockTest < Minitest::Test
  include WebMock::API

  def test_stubbinb_a_request
    # Here we tell webmock to stub get requests to github's api
    stub_request(:get, "https://api.github.com").to_return(body: '{
      "current_user_url": "https://api.github.com/user",
      "notifications_url": "https://api.github.com/notifications"
    }')

    # We make the response like normal, but instead of actually making the request,
    # it returns what we stubbed
    response = Net::HTTP.get_response(URI("https://api.github.com"))
    assert_equal "https://api.github.com/user", JSON.parse(response.body)['current_user_url']
  end
end
```
