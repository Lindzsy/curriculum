Notes
-----

We often take notes, eg I have a cheatsheets directory where I store ideas.
But if it's difficult to get to those notes, I probably won't look at them.

Lets make that information easily accessible by building a program whose job
is to store the notes and let us query them easily.
We'll name the program `notes`

I've added some integer and array notes to mine, and when I run it it shows me all the notes:

![running without selecting anything](no-selections.jpg)

If I run with the argument "array", it will only show me the array notes.

![selecting notes about arrays](select-array.png)

If I run with the argument "int" it will only show me the integer notes.

![selecting notes about ints](select-int.jpg)

If I run with the argument "add", it shows me notes about addition,
"add int" shows me notes about addition of integers, and "add arr" shows
me notes about adding arrays.

![selecting by multiple criteria](multiple-selections.png)

Notes are added into the program by editing its source code, ie

```sh
# in fish
$ vim (which notes)

# in bash
$ vim `which notes`
```


Iterations
----------

To complete this project, you need to iteratively add small bits of functionality
to a working program. You will only get credit for completed iterations.

**All iterations must be test driven, and in your git history**

(note that I've literally provided acceptance tests, and the
[building a gem](https://github.com/turingschool/lesson_plans/tree/master/electives/building-a-gem)
tutorial shows you how to test a program from the outside)


### 1. It displays all notes by default

Add a few notes to the program, and when you run `notes`, it should print them.
Don't make this step hard, you can literally pass it with a big puts statement.

```
$ ruby bin/notes
Add 1 to 2    1 + 2  # => 3
Subtract 5 from 2    2 - 5  # => -3
Is 1 less than 2    1 < 2  # => true
Is 1 equal to 2    1 == 2 # => 3
Is 1 greater than 2    1 > 2  # => 3
Is 1 less than or equal to 2    1 <= 2 # => 3
Is 1 greater than or equal to 2    1 >= 2 # => 3
Convert 1 to a float    1.to_f # => 3
Concatenate two arrays    [1,2] + [2, 3]   # => [1, 2, 2, 3]
Remove elements in second array from first    [1,2,4] - [2, 3] # => [1,4]
Access an element in an array by its index    ["a","b","c"][0] # => "a"
Find out how big the array is    ["a","b"].length # => 2
```


### 2. It can be run from anywhere

Same as the previous version, but instead of running it with `$ ruby bin/notes`,
you run it with `$ notes`, and it works from anywhere on your computer.

```
$ notes
Add 1 to 2    1 + 2  # => 3
Subtract 5 from 2    2 - 5  # => -3
Is 1 less than 2    1 < 2  # => true
Is 1 equal to 2    1 == 2 # => 3
Is 1 greater than 2    1 > 2  # => 3
Is 1 less than or equal to 2    1 <= 2 # => 3
Is 1 greater than or equal to 2    1 >= 2 # => 3
Convert 1 to a float    1.to_f # => 3
Concatenate two arrays    [1,2] + [2, 3]   # => [1, 2, 2, 3]
Remove elements in second array from first    [1,2,4] - [2, 3] # => [1,4]
Access an element in an array by its index    ["a","b","c"][0] # => "a"
Find out how big the array is    ["a","b"].length # => 2
```


### 3. Select notes whose description matches an argument from the command line

We want to be able to select only the relevant notes.
When I pass a single command-line argument, it should not show
me any notes whose description doesn't match the argument.

```
$ notes
Add 1 to 2    1 + 2  # => 3
Find out how big the array is    ["a","b"].length # => 2

$ notes Add
Add 1 to 2    1 + 2  # => 3

$ notes big
Find out how big the array is    ["a","b"].length # => 2
```


### 4. Select notes whose example matches an argument from the command line

```
$ notes
Add 1 to 2    1 + 2  # => 3
Find out how big the array is    ["a","b"].length # => 2

$ notes length
Find out how big the array is    ["a","b"].length # => 2
```


### 5. Matching is case insensitive

```
$ notes
Add 1 to 2    1 + 2  # => 3
Find out how big the array is    ["a","b"].length # => 2

$ notes ADD
Add 1 to 2    1 + 2  # => 3

$ notes add
Add 1 to 2    1 + 2  # => 3
```


### 5. It treats multiple arguments as successive filters

```
$ notes
Add 1 to 2    1 + 2  # => 3
Find out how big the array is    ["a","b"].length # => 2
Add two arrays    [1,2] + [2, 3]   # => [1, 2, 2, 3]

$ notes array
Find out how big the array is    ["a","b"].length # => 2
Add two arrays    [1,2] + [2, 3]   # => [1, 2, 2, 3]

$ notes add
Add 1 to 2    1 + 2  # => 3
Add two arrays    [1,2] + [2, 3]   # => [1, 2, 2, 3]

$ notes array add
Add two arrays    [1,2] + [2, 3]   # => [1, 2, 2, 3]
```

### 6. It allows me to search by hidden information

In this example, the first note can be searched by "add",
but I keep trying to find it with "plus".
And when I search for "integer", I should be able to see all my results!

When I enter the word in the program,
I want to be able to tell it that the first note should
be able to match "plus" and "integer", as well.

This allows me to run the program like this:

```
$ notes
Add 1 to 2    1 + 2  # => 3
Subtract 2 from 1    1 - 2  # => 3
Concatenate two arrays    [1,2] + [2, 3] # => [1, 2, 2, 3]

$ notes plus
Add 1 to 2    1 + 2  # => 3
Concatenate two arrays    [1,2] + [2, 3] # => [1, 2, 2, 3]

$ notes integer
Add 1 to 2    1 + 2  # => 3
Subtract 2 from 1    1 - 2  # => 3
```

### 8. The `-h` flag prints a description
prints notes whose value has multiple lines on multiple lines (aligned)
prints every other line coloured


Extensions
----------

### 7. Line the values up
### 9. Supports multiline values
### 10. Colours every other line


Evaluation Rubric
-----------------

Coming Soon!

