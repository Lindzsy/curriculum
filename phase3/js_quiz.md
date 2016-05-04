JS Recap
========

Async
-----

* **What do you need to avoid?** blocking
* **why?** 1 thread
* **how?** pass callback onto event queue
* **common example?** ajax
* **why no sleep?** it blocks
* **what instead?** setTimeout
* **what is a common solution to annoyingnes of callbacks?** promises
* **what do promises let you do?** write synchronous code
* **method do you invoke for happy path on promises?** `.then`

Prototypical Inheritance
------------------------

* **when you access a property, where does it look?** in the object
* **if it can't find the property there, where does it look?** in the prototype
* **if it can't find the property there, where does it look?** in the prototype's prototype
* **If I had an object in a variable `proto`, how would I create a new object with `proto` as its prototype?** `Object.create(proto)`

Pieces of Inheritance
---------------------

* **How many interesting pieces are there to JavaScript's inheritance model?** 3
* **What are they?** Constructor, prototype, object
* **When you type `new Car()`, what do we call `Car`?** Constructor
* **In V8, how do you get from an object to its prototype?** `.__proto__`
* **How do you get from an object to its constructor?** `.constructor`
* **How do you get from a constructor to the prototype?** `.prototype`

Current object
--------------

* **In a method, how do you access the current object?** this
* **What is `this` by default?** global object
* **What is the global object in the browser?** `window`
* **If I call `brant.smoke()`, what is `this` inside the `smoke` method?** `brant`
* **What's the problem with this code?** `nums.forEach(function(num) { this.total += num })` it won't know what `this` is
* **What does Zach do to avoid this?** set `var self = this` at the beginning of each function, and then refer to `self` instead of `this`

Es6 function shorthand
----------------------

* **What's the new fancy function syntax called?** fat arrow
* **If your fat arrow fits on one line, what can you omit?** curly braces and return
* **If your fat arrow takes only one argument, what can you omit?** parens around the argument
* **What is the new shorter way of writing `function(a) { return a + 1 }`?** `a => a + 1`
* **What is `this` inside the fat arrow?** `this` from the defining environment
* **What's nice about `nums.forEach(num => this.total += num)`?** It will keep track of `this`

I didn't cover these, but:

* You can set self for a function by using? `bind`
* You can call a function `call` and `apply`

  ```javascript
  function a(b) { return this.c + b; };
  a.apply({c: 1}, [2]) // => 3
  a.call({c: 1}, 2)    // => 3
  ```

Namespacing
-----------

* **If you forget to use `var` when declaring aa variable, where does it get placed?** On the global object
* **If you're at the toplevel and you use `var`, where does it get defined?** On the global object
* **What do people do to avoid this?** Wrap all the code in a function and immediately call it

What gets printed in this code?
-------------------------------

```javascript
console.log("one");

setTimeout(
  function() {
    console.log("two");
    setTimeout(function() { console.log("three"); }, 0);
    console.log("four");
  },
  1000
);

setTimeout(function() { console.log("five") }, 0);

console.log("six");
```

Answer: one, six, five, two, four, three

**What if we add this to the bottom?**

```javascript
while(true) {
}
```

Answer: one, six

What gets printed in this code?
-------------------------------

```javascript
function countSomeStuffs() {
  console.log("one");
  setTimeout(function() { console.log("two");   }, 0);
  setTimeout(function() { console.log("three"); }, 0);
  console.log("four");
}

console.log("five");
countSomeStuffs();
console.log("six");
```

Answer: five, one, four, six, two, three


What gets printed in this code?
-------------------------------

```javascript
function Counter() { this.count = 0 }

Counter.prototype.countNums = function(numbers) {
  numbers.forEach(function(num) { this.count += num; });
}

var counter = new Counter();
global.count = 0;
counter.countNums([2,4,5]);

console.log({counter: counter.count, global:  global.count});
```

Answer: `{ counter: 0, global: 11 }`


What gets printed in this code?
-------------------------------

```javascript
function Counter() { this.count = 0 }

Counter.prototype.countNums = function(numbers) {
  numbers.forEach(num => this.count += num);
}

var counter = new Counter();
global.count = 0;
counter.countNums([2,4,5]);

console.log({counter: counter.count, global:  global.count});
```

Answer: `{ counter: 11, global: 0 }`
