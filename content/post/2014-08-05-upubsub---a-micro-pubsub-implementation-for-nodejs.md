+++
title = "uPubSub - A micro pub/sub implementation for NodeJS"
description = ""
date = "2014-08-05"
categories = ["Software Development"]
tags = ["javascript", "pubsub", "nodejs"]
aliases = ["2014/08/05/upubsub---a-micro-pubsub-implementation-for-nodejs/"]
+++

So I built my own PubSub...

&lt;dramatic pause, awaiting shouts of "Not Invented Here syndrome!"&gt;

heh. So I did this as a product of my need for an eventing system for one of my
secret side-projects, built using the CQRS and Event-Sourcing paradigms, for
which I needed a simple PubSub as my output. This grew slightly when I
implemented a simple Event Store and needed to latch onto all of the events that
pass through the system.

In my case I have no need of a topic-based approach or clever error-handling.
I've not even considered Promises and I don't want to think about NodeJS vs.
Browser Compatibility. It's all very interesting stuff but I need to stay
focused if I'm ever to finish what I'm doing, and of course if my requirements
evolve past the abilities of my simple little PubSub I'll be more than happy to
swap to a 3rd-party library.

A whirlwind tour:

{{< highlight bash >}}
$ npm install --save upubsub
{{< /highlight >}}

then

{{< highlight javascript >}}
var uPubSub = require('upubsub'),
    pubsub = new uPubSub();

function handler(message) {
  console.log("Handling " + message);
}

pubsub.subscribe("eventName", handler);
pubsub.publish("eventName", "foo"); // outputs "Handling foo"
pubsub.unsubscribe("eventName", handler);
{{< /highlight >}}

For now I have a nice little pubsub that dispatches in an async manner, and does
as little clever stuff as possible. It's available from my
[github](https://github.com/ahri/upubsub) and
[npm](http://npmjs.org/package/upubsub) and weighs in at 66 loc and 1.72kb. If
you want to use it in a browser it'll need to be run through
[browserify](http://browserify.org).

One thing that did catch me out is that my app was built with a fluent interface
which doesn't play nice when the output is events and the write-model is getting
updated later than the next fluent call. Oops. I could just force the pubsub to
be synchronous for testing purposes (the main use of the fluent API) but this
seems like cheating!
