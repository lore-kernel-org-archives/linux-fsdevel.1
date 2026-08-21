Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6174302FC;
	Fri, 21 Aug 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301011; cv=none; b=LHtgkOR3MvawEBI9avRY2rWr2r1/g2IHBjNgzrt0Qv9yo0QOPUrSr5IVkVWD+PY8k5a0DDhWd0zVXICb5v271vMqMIOkNlHkiPuIXJAOLRghkNJD4OMVZ1DdQ+JGBE7IWNw5mTttDjvVqAG0oCHZ6wj3C+JH42yE/OJVwQv5KX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301011; c=relaxed/simple;
	bh=yQM9EwOQSt4eWKGD5WkSLlcBSpxVBDNRKDVQYCrEtNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNEYzWqz1tm6w0jxA9OwFB1dKIKH/WBdF8zpIvO8qS241Cm80lngM80Hc2Uiuq4D4x1sjqOgmhg58cNcAiofRDI47dmCgDNHBKqmESQ9Yzatzq4xQdzhAPIXT3+05VOAooh1Mon6mw7U+RkhXbC6bRxEAqxYIwPQF3vZvLVQAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CF9L2Va9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CF9L2Va9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gl8fb8JjOt7jyq6F4GMJVng/PK8CkvTTmG/1jkQcCUI=; b=CF9L2Va9gTD+NorHUbJTKqnVLP
	kYOg4FP0jVIAsFtNlh6p4dlRvKJuzF5QMOmD9R+10HG0MOwvM+Q+HujowTaMR7mzGDC/G93mM+dCL
	kk0Wwe9rY4jk05zN2Zjz3v+UIDBJ/XCN+0nNkBDJzx2LMi0C5gwxlW4qbTs7H42tX+1scSKZ6XzRE
	D9TCe0coTTo2+63FASsyoK+znEUZFZOYmiscvDsWGgs+cnlY9Ro4vMf46E2fqL6sm2ii0kVo73cl6
	w/Vw3yc8XwdN6OqCstsGdj8fggYaeOTPx92KJRSzBGrO2yRt2AodfkDrboApkrZ5T1c4ZRMNYFrC+
	fC5+xvaQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxKdW-0000000H18n-05r2;
	Fri, 21 Aug 2026 08:30:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE85E300324; Fri, 21 Aug 2026 10:30:00 +0200 (CEST)
Date: Fri, 21 Aug 2026 10:30:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <20260821083000.GF687043@noisy.programming.kicks-ass.net>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
 <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com>
 <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
 <aobKfyGHkdMcleoc@google.com>
 <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
 <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com>

On Thu, Aug 20, 2026 at 06:11:40PM +0200, Miklos Szeredi wrote:
> On Thu, 20 Aug 2026 at 12:41, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Also, you'd be putting suspend success in the hands of userspace, that
> > sounds like a mighty fail right there.
> 
> Freeze ordering is also a hard/impossible problem without the help of
> userspace.

In case of fuse, perhaps.

> One obvious heuristic is if task has a /dev/fuse fd open,
> it is a server.  This simple ordering between server and non-server
> tasks fails if
> 
>  - task X is a server of A, while also doing ops on B
> 
>  - task X is server, blocked on task Y which is not a server
> 
> What about adding a flag to mutex/rwsem that allows making them
> freezable at setup time?  Then fuse fs could set that flag for its
> locks (including VFS locks).

That would be adding conditionals to the mutex, something we all pay
for, always.

I was thinking it shouldn't be too hard to add a graph to the tasklist,
where each task has a list of other tasks that should be frozen before
it.

That way the task iteration in try_to_freeze_tasks() can be modified to
iterate this list (recursively; depth-first etc.) before it goes and
freezes the initial task.

Obviously adding a link to the graph needs to ensure the whole thing
stays free of cycles, but that is 'details' :-)

And while this is fairly straight forward to make work, I fear it is the
wrong shape for the problem, since the server is more of an 'after'
rather than a 'before' relation. You would have to add all clients to
the before of the server.

Another approach might be to have each task have a list of tasks that
needs to be done later, and have this relation be counted in the
destination task.

Then, on freeze, create a list of all tasks and start iteration, for
each task that has a non-zero count of prior tasks, move it to the tail.
This relies on freeze points being a location where a task has no
relations. Such that when a task is frozen, it has no dependencies.

Then, again assuming it was a non-cyclic graph, it will always finish
the freeze in an order that resolves the dependencies.

This might be a little more tricky to implement, but should be doable.

In both scenarios the tracking of the actual dependencies is of course
going to be key.

One way would be for each file op to be wrapped like 'link-$op-unlink'
such that the client (the task doing the file op) gets linked to the
server (the task responsible for satisfying the request) before it can
block, and unlinked once its done.

Link/unlink could be a simple as:

	struct task_struct *client, *server;

link;
	atomic_inc(&server->freezer_count);
	client->freezer_link = server;

unlink:

	atomic_dec(&client->freezer_link->freezer_count);
	client->freezer_link = NULL;

And the freezer should assert: !task->freezer_link, to ensure you
cannot be frozen while still having a link out, since this would keep
the link target's count elevated and inhibit freezer forever more.

This also deals with the server being a client of yet another fuse
filesystem. Creating cycles in fuse mounts would already be a recipe
for disaster today, without all this, so I'm assuming this all just
'works'.

Does any of that make sense?
