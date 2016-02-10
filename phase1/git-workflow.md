Git Workflow
------------

* [https://vimeo.com/154774489](https://vimeo.com/154774489)
* [going through this material](https://vimeo.com/154897603)

Model
-----

* Every commit is immutable. It never changes.
* You're only ever adding. Never deleting
* So how do I delete? Add a deletion.
* When you change the past, you're fucking everyone who has the present.
* Your repository is an aggregation of all your commits... all your additions and deletions.
* A branch is a named commit.

master                          bulldog
       \                      /
        _|                  |_
(...) <-- (f4b8226) <-- (c308c98)


Cardinal Rules
--------------

* Commit constantly
* run git status after everything you do


Practice this
-------------

Make a waypoint in front of you, then you can practice

```sh
# Make a directory to work in
$ mkdir git-practice
$ cd git-practice

# Tell git to consider the directory a repository
$ git init

# Make suere I see the file
$ gs # aka git status

# Add a file to the staging area (this first commit gets a branch named "master" by default)
$ ga Readme.md # aka git add Readme.md

# Make sure the file is added to the staging area
$ gs

# The staging area is a pending commit, I look at each change
# and I like the change, I add it to staging.
$ git commit -m 'Add a readme'

# Make sure it got committed
$ gs

# Make a change
$ vim Readme.md

# Make sure I see the change
$ gs

# Check the diff to see what I changed
$ gd Readme.md # git diff

# If I like it
$ ga Readme.md
$ gs

# Better put a commit on it
$ git commit -m 'A little more enthusiasm (except on line 1) ;)'
```

Manual:

```
$ man git
```
