---
title: "Getting into Containers"
description: "Cheap sort-of-virtualisation"
date: "2015-11-14"
categories: ["Software Development"]
tags: ["docker"]
aliases: ["containers/2015/11/14/getting-into-containers/"]
---

For a while now I've been experimenting with [Docker](https://www.docker.com/)
which provides a useful level of abstraction over Containers. I'm still finding
my feet in this exciting new world of cheap sort-of-virtualisation but so far
I'm really enjoying the isolation they provide, allowing for explicit bundling
of dependencies and repeatable builds. You can probably see how interested I've
been from my [github history](https://github.com/search?q=user%3Aahri+docker)
these past months!

One thing I have found is that I don't really trust other people's builds all
that much and have been preferring to roll my own in most cases, which has the
benefit of forcing me to learn the tool but obviously contributes to the
existing problem that we already have lots of images purportedly doing the same
thing - just have a look at [the number of
images](https://hub.docker.com/search/?q=caddy) for
[Caddy](https://caddyserver.com/) to get idea of this problem.

The problem is two-fold: the first half is that builds are not necessarily
trustworthy because they aren't signed - this is currently being addressed by
the Docker team. The second half is more subtle though; with the tech being so
new people are all doing their own thing in their own way; lots of images
require volumes mounting with configuration being provided that way, while
others prefer to take it from a central configuration provided by
[Consul](https://www.consul.io/) or [etcd](https://coreos.com/etcd/). Personally
I'm erring towards stdin and command-line arguments where possible, largely
because I don't like the volume solution and don't have any experience with the
enterprise-level key-value stores.

Watching the trends and best-practises should prove very interesting indeed.
