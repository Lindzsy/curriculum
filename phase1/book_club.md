Book Club Itinerary
===================

Purpose
-------

The purpose of this session is to understand the "outside-in" (sometimes called "top-down") paradigm.
We'll do this by building on top of something that doesn't exist, and disallowing our minds from going down into the implementation,
so we can stay in context, and really understand what we are trying to accomplish. For me, this always felt like magic because you make some tiny change at the toplevel,
and huge swaths of unwritten code just shift underneath of you (in fact, I gave [a presentation](https://vimeo.com/31267109)
about it, where that's exactly how I described it). At this level, it's free to make huge sweeping changes,
the old unwritten hasn't cost us anything to write it yet, and so neither does the new unwritten code.
As you make a change up here, half the code you would have written is rendered useless, discarded, and replaced with new unwritten code.

Then, we will go down one layer and implement the things that they are depending on, using the same technique.
And to make that work, we will go down to the next level of abstraction, implementing whatever is already being used by the code above them.
I'm interested to see if this can help us gain an understanding of how the code we write is very specifically crafted to be the "how" for the higher level "what".
This was a revolutionary discovery for me, It utterly changed the way that I thought and that I approached problem solving.



What We're Going To Do
----------------------

The challenge that we'll do is a translation of the one that I made up for myself to learn this process. It was one of my "enlightening moments",
where I looked at everything differently aferwards. And yes, I mean *everything* (not just code). I think it was one of my big "learning to think" moments.
A new paradigm, I suppose. Though I did have a strong foundation of all the low-level libs and such before I did it, but I don't think that's necessary to get the benefit.

The challenge we will solve is to imagine we're in a book club, and make an itinerary for it so that when we meet,
we have a plan and we're not all just sitting around unsure of what to say or do. We'll choose the Little Book of Talent, since the chapters are nice and short.

But the code we write on Friday is not the product, it's just a delivery mechanism for the real product: The itinerary.


Part 1: Big Picture
-------------------

Have answers to these questions, we'll discuss them when we meet:

* **Who all is in this book club?** You can make this up, but you need to make it concrete and understand what you're trying to accomplish. You're in the book club, I'm in the book club, who else?
* **Why are they in the book club?** They're joining for a reason, what is it? What do you want to get out of this book club? What do I want to get out of it? The others?
* **How does your itinerary help them to that end?** You're going to do some work, right? How do you know it's the right work? How do you know it's useful? How will it help [name of participant] have a better experience as a result? This will help you decide what to put into the itinerary.

Use your imagination, none of this exists yet, so you can literally make it anything you want. There are no rules about the book club itself, only about the process.
Think about the book club you want to be in, think about who wants to be in your book club.
What do they want to do? What do they want to know? I am not going to give you requirements for it, because you will make the requirements up yourself,
based on a consideration of the domain, the participants, the needs. Really put yourself in the shoes of someone attending,
you should be able to take this itinerary and *actually* run a book club off of it.


Part 2: Read the chapters
-------------------------

Read tips #18 and #22 in the Little Book of Talent.
As you read it, write down the itinerary of what we should do during the meeting after having read them.
This is not code, it's just your notes, in English.
If you write them on paper, you should be able to photocopy them and hand them out to the rest of us, and we can read them and understand the plan.
If you write them in an editor, you should be able to email them to us, and that's all we need, no code even needs to be written.

As you build the itinerary, keep in mind the questions you answered above.
These will help you make decisions about what needs to occur, should you add something to the itinerary?
Should you remove it? Will this itinerary satisfy the reasons we joined? You want us to leave going "wow, that was great, I can't wait for the next meeting!".


Part 3: Consolidate our itineraries
-----------------------------------

We'll get together and agree on how the book club should go.


Part 4: Translate description to code
-------------------------------------

Choose syntax that makes it easy to talk about the book club.


Part 5: Implement
-----------------

Lets get together and say "what would it take to make this bit work"?
We don't really know where we're going, just what the next step is.
