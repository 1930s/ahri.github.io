---
title: "Blogging Platforms"
description: ""
date: "2014-07-28"
categories: ["Software Development"]
tags: []
aliases: ["scribbles/2014/07/28/blogging-platforms/"]
---

A pretty general title, but I've been putting some thought into it. It's one of those projects I'd like to do at some point that isn't now. I'll call them [scribbles](/categories.html#scribbles-ref).

So what I'm thinking is that while I like editing in Vim, it doesn't quite suit me as a blogging environment. To be clear I suppose that text editors don't suit me as blogging environments and I'd prefer to see what I'm doing as I'm doing it. [Ghost](http://ghost.org) is pretty nice, but I haven't put much time into understanding its way of doing things, and having gotten into [Jekyll](http://jekyllrb.com) and just pushing up to GitHub I think I'd miss the transparency of the approach.

I'd like something that can mix up a few bits and pieces, and since I think in trees, here's a sketch:

* Markdown

  It's nice, and I appreciate that it's readable in text editors if that's what I want

* Flat files

  Both the source and result should be flat so that hosting is easier

* Live Reload

  Having that instant feedback helps to avoid mistakes, it's pretty easy to achieve this these days, without nasty hooks into the browser

* Native code blocks

  I want to be able to stick some code in and have it highlighted, and not need some other service, even though GitHub's gists are cool

* A nice text editor that supports Vim key bindings

  Because why would you want to type any other way? ;)

I might code something up sometime, perhaps with a mixture of NodeJS, event sourcing and some other bits and pieces. Of course, it's just as likely that I'll end up getting used to using Vim & Jekyll as my environment and not waste any further time on it!
