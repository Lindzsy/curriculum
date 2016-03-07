require 'notes/web' # <-- you'll need to make this
require 'net/http'  # this is from the stdlib

class AcceptanceTest < Minitest::Test
  def run_server(port, app, &block)
    server = Notes::Web.new(app, Port: 9292, Host: 'localhost')
    thread = Thread.new { server.start } # The thread allows the server to sit and wait for a request, but still return to here so we can send it.
    thread.abort_on_exception = true
    block.call
  ensure
    thread.kill
    server.stop
  end


  def test_it_accepts_and_responds_to_a_web_request
    path_info = "this value should be overridden by the app!"

    app = Proc.new do |env_hash|
      path_info = env_hash['PATH_INFO']
      body      = "hello, class ^_^"
      [200, {'Content-Type' => 'text/plain', 'Content-Length' => body.length, 'omg' => 'bbq'}, [body]]
    end

    run_server 9292, app do
      response = Net::HTTP.get 'localhost:9292/users'
      assert_equal 200,                response.code
      assert_equal 'bbq',              response.headers[:omg]
      assert_equal "hello, class ^_^", response.body
      assert_equal '/users',           path_info
    end
  end


  def test_it_handles_multiple_requests
    app = Proc.new { |env_hash| [200, {'Content-Type' => 'text/plain'}, []] }

    run_server 9292, app do
      assert_equal 200, Net::HTTP.get('localhost:9292/').code
      assert_equal 200, Net::HTTP.get('localhost:9292/').code
    end
  end


  def test_it_starts_on_the_specified_port
    app = Proc.new do |env_hash|
      [ 200,
        {'Content-Type' => 'text/plain', 'Content-Length' => 5},
        ['hello']
      ]
    end

    run_server 9293, app do
      assert_equal 'hello', Net::HTTP.get('localhost:9293/').body).to eq 'hello'
    end
  end
end
