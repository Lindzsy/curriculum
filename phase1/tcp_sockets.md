TCP Sockets
===========

Server
------

The server waits for requests and sends responses.

```ruby
# Register your program to accept requests
require 'socket'                    # code is in the standard library
host   = 'localhost'                # serving from your computer
port   = 3001                       # to allow multiple programs to serve content, they each get a number, called a "port"
server = TCPServer.new host, port   # make the server

# Take a request
socket = s.accept                   # waits until you something connects
socket.gets                         # read a line (this is the same `gets` method you call on `$stdin`)
socket.read 5                       # read 5 characters from the input
socket.print "hello!"               # write "hello!" back into the socket (this is the same print you call on `$stdout`)
socket.close                        # close the input and output streams

# Unregister your program
server.close
```


Client
------

The client opens a socket to the server, sends a request, and reads a response.

```ruby
require 'socket'                    # code is in the standard library
host   = 'localhost'                # you could also put "google.com" here, and then print an http request
port   = 3001                       # fun fact: default port for internet servers is 80

socket = TCPSocket.new host, port   # connect
socket.puts "hello!\nworld"         # same as printing to $stdout
socket.gets                         # same as reading from $stdin
socket.close                        # disconnect
```


Talking across the network
--------------------------

You can find your host on the current network (so that others can connect to your computer).
Others on your network can connect to this host/port and you can talk back and forth with them.

```sh
$ ifconfig | ruby -n -e 'puts $1 if /inet *([^ ]*).*?broadcast/'
```


Example HTTP request
--------------------

Here, we're going to format the strings we send in a format known as HTTP.
When we connect to google, we'll request a search for "ruby",
this is what your browser sends and receives if you click
[https://www.google.com/search?q=ruby](https://www.google.com/search?q=ruby).

```ruby
require 'socket'

# Connect to Google on the default internet port
socket = TCPSocket.new 'google.com', 80

# Send an http request
socket.print "GET /search?q=ruby HTTP/1.1\r\n" # path of a search for "ruby"
socket.print "\r\n"                            # no headers

# Read the response
socket.gets # => "HTTP/1.1 200 OK\r\n"
loop do
  line = socket.gets
  # => "Date: Mon, 07 Mar 2016 14:39:59 GMT\r\n"
  #    ,"Expires: -1\r\n"
  #    ,"Cache-Control: private, max-age=0\r\n"
  #    ,"Content-Type: text/html; charset=ISO-8859-1\r\n"
  #    ,"P3P: CP=\"This is not a P3P policy! See https://www.google.com/support/accounts/answer/151657?hl=en for more info.\"\r\n"
  #    ,"Server: gws\r\n"
  #    ,"X-XSS-Protection: 1; mode=block\r\n"
  #    ,"X-Frame-Options: SAMEORIGIN\r\n"
  #    ,"Set-Cookie: NID=77=OXmp6k5XNFcFC8gMcUWo5KTh4vmDUvjDvo7QpSdPvL-ozSfLKhU-MOSr6SrvP6IhvSltmgbvr-PJquKJtvy4e7NX6HiBMyWn-jr0IHkfem0vc-JXDGrgCqlbXFuTlk1etEjAXgYuy1BEQg; expires=Tue, 06-Sep-2016 14:39:59 GMT; path=/; domain=.google.com; HttpOnly\r\n"
  #    ,"Accept-Ranges: none\r\n"
  #    ,"Vary: Accept-Encoding\r\n"
  #    ,"Transfer-Encoding: chunked\r\n"
  #    ,"\r\n"
  break if line == "\r\n"
end

socket.read 200 # => "8000\r\n<!doctype html><html itemscope=\"\" itemtype=\"http://schema.org/SearchResultsPage\" lang=\"en\"><head><meta content=\"text/html; charset=UTF-8\" http-equiv=\"Content-Type\"><meta content=\"/images/brandin"

# End the request
socket.close # => nil
```
