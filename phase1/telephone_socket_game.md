Telephone Socket Game
=====================

Purpose: Have fun, anthropomorphicificizieedkljsdklg sockets and servers so they're easier to keep track of.

Fun #1: Write a script to find your IP address
----------------------------------------------

1. You can see the configuration with
   ```
   $ ifconfig
   lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
     options=3<RXCSUM,TXCSUM>
     inet6 ::1 prefixlen 128
   ...etc...
   ```
2. You can filter the output of that by piping it through `ag`
3. Ag can be given a regular expression as an argument,
   it will filter which lines of stdin it displays.
   Filter it for lines that match inet.
   After you see the match for inet, filter those results for lines that match broadcast,
   there should only be one line in the output.
   Mine looks like this:

   ```
   inet 10.3.98.101 netmask 0xfffff000 broadcast 10.3.111.255
   ```

   If you have more than one, make sure that it matches both "inet" and "broadcast".
4. You can pass Ruby a program to run as an argument (as opposed to passing it a filename with Ruby code inside of it).
   Do this by using the `-e` flag and giving the program as the second argument.
   Try this example:

   ```
   $ ruby -e 'puts "hello, world"'
   hello world
   ```
5. If you invoke ruby with the `-n` flag, it will run the program against each line of its standard input.
   The current line will be placed into the global variable `$_`.
   Combine the `-n` and `-e` flags to print the inspection of each line of standard input.
   Then type some lines of text into the console to make sure it inspects and prints them.
6. Pipe the results of your filtered ifconfig through a Ruby program that inspects them.
   You should see the same line you saw in step 3, but inspected. My output looks like this:

   ```ruby
   "\tinet 10.3.98.101 netmask 0xfffff000 broadcast 10.3.111.255\n"
   ```
7. Use your knowledge of Ruby to split the standard input, my output looks like this:

   ```ruby
   ["inet", "10.3.98.101", "netmask", "0xfffff000", "broadcast", "10.3.111.255"]
   ```
8. We'll assume your IP is always the second element. IDK if that's reasonable or not, if it doesn't make sense for you, then adjust as appropriate.
   Print your ip

   ```
   10.3.98.101
   ```
9. Save that in a program named "myip", make it executable, make sure you can run it like this:
   ```
   $ myip
   10.3.98.101
   ```
9. Now copy that to your clipboard by piping its output into `pbcopy`



Fun #2: Omg, lists!
-------------------

We're going to pass messages through all the students!
The order will be:

> James, Megan, Vince, Sean, Derreck, Greg, Matthew, Dongmin, Javi

Each of you will need to find your IP, start a server,
and open a socket to the IP/Port of the person after you.
Tell the person before you what your IP is and what port you chose,
so they can connect to you.

Use the examples in the [tcp sockets](https://github.com/CodePlatoon/curriculum/blob/master/phase1/tcp_sockets.md)
material to get connected. Make sure the person before you can send you messages.
Make sure you can send messages to the person after you.


1. Read a message from the person before you, print it to `$stdout`,
   then send it to the person after you. We should all see the message,
   and it should pop up on my screen!
2. Same thing, but prepend your name before printing.
   What will the output look like on my screen?
3. Same thing, but instead of prepending your name, append it.
4. Same thing but both prepend and append your name!
5. This time only PREPEND your name, and pass the message you receive to the next person.
   But instead of only passing it, we'll allow them to send a message back.
   So read from the next person, and THEN APPEND your name and send it back to the person before you!
6. Contemplate!!
