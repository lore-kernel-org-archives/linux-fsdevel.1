Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBC2EACF2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905937; cv=none; b=jqYVyMJ3AylJEVRw7cqKq5wG97YnijMd55DVGE87q6nqtoIz86a4xw8XohIfY6uMIjm6giy2Zl8Uw/HlYpQ0VI9NbcpSDaW/eoGVNpqKoVJVEXVwUfIPMzLk/VBWGipG68h0ANel1oESaRHtMHC3crLW7coqxt2dEawUII4ZU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905937; c=relaxed/simple;
	bh=nyjoWywOAhloBk5Cq6FV1lF9rQZxx4FAzXX6ECBBWEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHJ7SasbHPPYySnD7QcHUJXvuEnT31gN6S4ThrPdxPXT2HYU02GhRIZoFteutsMFZM8/ooHeZnBN2+G+PBuuhLlabCWVRJlwz3/L5Io5QZHWGpJzMI3HkC/hN+GoCgUiwhaXdLg4shLmjWJwgTTAEEJh5Utf6mytT1XNjjjWLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEnqUsSh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEnqUsSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFCBC4CEF7;
	Mon, 30 Mar 2026 21:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774905937;
	bh=nyjoWywOAhloBk5Cq6FV1lF9rQZxx4FAzXX6ECBBWEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEnqUsSh24ujvu25uHkEb8VwMsVjucAB7fMiBc9P0Boh4XYxqjxNmNmKMkHfnrhZt
	 Yizx1oWCUBDKDbXCzVF16EXQNGwKBFdAI9S3YgRJNz++yV06K6oJWydM9OyRlDEOjF
	 Fuwjh0IflrdPli5A3siTg5o4azrB5cMFEaTfkZuesxsKfIgSkl2M+UYec7vFOfFiIz
	 DXd1epVEzUPXxuKqbp1v2I48fWrD1wmV7KDik9kWYBV3NAD66eQCNCn94Gb4+WoCav
	 1owOFH/qCu+n7LKOExJxaFrgiQPT/TJRSaUu9aLs5e8Uh0Xlu/2oedvVWwE670sKgC
	 4MPSXYzVssQsA==
Date: Mon, 30 Mar 2026 14:25:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>, \@magnolia.djwong.org
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 04/25] Add a new daemonize API
Message-ID: <20260330212535.GF6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-4-b1ca8fcbf60f@bsbernd.com>
 <20260327220614.GH6254@frogsfrogsfrogs>
 <db13185d-787a-41a2-9204-ba469a5cf5b1@bsbernd.com>
 <20260330174529.GR6202@frogsfrogsfrogs>
 <27b4ec23-ea81-4945-a25d-b2a73bf51074@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b4ec23-ea81-4945-a25d-b2a73bf51074@bsbernd.com>

On Mon, Mar 30, 2026 at 08:26:58PM +0200, Bernd Schubert wrote:
> 
> 
> On 3/30/26 19:45, Darrick J. Wong wrote:
> > On Sat, Mar 28, 2026 at 12:07:35AM +0100, Bernd Schubert wrote:
> >> Hi Darrick,
> >>
> >> On 3/27/26 23:06, Darrick J. Wong wrote:
> >>> On Thu, Mar 26, 2026 at 10:34:37PM +0100, Bernd Schubert wrote:
> >>>> Existing example/ file systems do the fuse_daemonize() after
> >>>> fuse_session_mount() - i.e. after the mount point is already
> >>>> established. Though, these example/ daemons do not start
> >>>> extra threads and do not need network initialization either.
> >>>
> >>> AFAICT the situation here with the extra threads and async FUSE_INIT is:
> >>>
> >>> a) You can't start them until after fuse_daemonize() because that might
> >>>    fork the whole process
> >>
> >> The extra threads are not cloned - they stay attached to the parent.
> > 
> > <nod>  I guess I should have said that explicitly -- "...because that
> > might fork the whole process, and all threads remain attached to the
> > parent."
> > 
> >>>
> >>> b) You don't want to start them until you know that the mount()
> >>>    succeeds (maybe?)
> >>
> >> For me the other way around, I want to start them before the mount and
> >> let them do things like network connection/authorization. Not nice if
> >> the mount has already suceeded and then part of the initialization fails
> >> and a stale mount come up.
> > 
> > <nod> That makes sense, you want to acquire resources and start the
> > threads (or fail) before calling mount().
> > 
> >>> c) You need those threads to be active to start serving the fuse
> >>>    requests that come after FUSE_INIT
> >>>
> >>> d) libfuse apparently starts even more threads to wait on the iouring
> >>>    queues after the fuse server returns from FUSE_INIT.
> >>
> >> Actually it starts these threads from FUSE_INIT and before replying
> >> FUSE_INIT success. In order to tell the fuse-client/kernel if
> >> fuse-server wants io-uring.
> > 
> > Got it.  Now I see the "XXX: Add an option to make non-available
> > io-uring fatal" code 20 lines up.
> > 
> >>> e) fuse_loop_mt() starts up the request handler threads and waits for
> >>>    the session to exit and/or for mt_finish to be sem_post()ed.
> >>>
> >>> Does that sound right?
> >>
> >>
> >>>
> >>> Looking at fuse4fs, I realize that it need /not/ start its background
> >>> threads from the FUSE_INIT handler; all that should be done after
> >>> daemonize before calling fuse_session_loop_mt.  The only reason I wrote
> >>
> >> So after the mount? What is if starting the threads would fail for some
> >> reason?
> > 
> > Right now they're optional features (monitor memory PSI file and flush
> > cache) so it's no big deal if they don't initialize.  But that *does*
> > make the case for adding the parent/child pipelines so that you can
> > daemonize earlier and report failures to the parent process.
> > 
> > Hrm.  Thinking about this more, the new fuse_daemonize_XXX calls make it
> > possible for any fuse server to do pre-mount() initialization in the
> > child and report the outcome to the parent.  Even if that fuse server
> > doesn't know, care, or try to enable sync FUSE_INIT.
> > 
> > So this new API really is separate from FUSE_SYNC_INIT.  The latter
> > depends on the former, but the reverse is not true.
> 
> Absolutely, as I wrote somewhere, this is basically my 3rd implementation of the same thing.

<nod>  

> > 
> >>> it that way was blind patterning after fuse2fs, which doesn't call
> >>> daemonize() directly, so FUSE_INIT is the first time any fuse2fs code
> >>> gets called after daemonizing.
> >>>
> >>>> fuse_daemonize() also does not allow to return notification
> >>>> from the forked child to the parent.
> >>>>
> >>>> Complex fuse file system daemons often want the order of
> >>>> 1) fork - parent watches, child does the work
> >>>>
> >>>> Child:
> >>>>     2) start extra threads and system initialization (like network
> >>>>        connection and RDMA memory registration) from the fork child.
> >>>>     3) Start the fuse session after everything else succeeded
> >>>>
> >>>> Parent:
> >>>>     Report child initialization success or failure
> >>>
> >>> Under classic async FUSE_INIT, the sequence in most fuse servers is:
> >>>
> >>> 1) The parent opens /dev/fuse and mounts the fuse filesystem before even
> >>>    daemonizing
> >>>
> >>> 2) Mounting the fuse fs causes an async FUSE_INIT to be sent to the
> >>>    queues, which sits there because nobody's looking for event yet
> >>>
> >>> 3) The parent daemonize()s, and the child proceeds with setting signal
> >>>    handlers and starting up the fuse-request processing threads
> >>>
> >>> 4) The parent exits, the child continues on to set up the fuse worker
> >>>    threads
> >>>
> >>> 5) One of the request handler threads finally reads /dev/fuse to find
> >>>    the FUSE_INIT request and processes it
> >>>
> >>> 6) do_init (in the lowlevel fuse library) starts up the uring workers
> >>>    if the kernel acknowledges the uring feature.  The fuse server has
> >>>    no means to discover if the fusedev would permit uring before
> >>>    calling mount().
> >>
> >> Yeah, initially I wanted to handle that through an ioctl and independent
> >> of FUSE_INIT, Miklos had asked to change that.
> > 
> > <nod>
> > 
> >>> Does my understanding make sense?
> >>>
> >>>> A new API is introduced to overcome the limitations of
> >>>> fuse_daemonize()
> >>>>
> >>>> fuse_daemonize_start() - fork, but foreground process does not
> >>>> terminate yet and watches the background.
> >>>
> >>> But with sync FUSE_INIT this is not workable because the child has to
> >>> have done (4) before (1) can complete, or it has to set up a temporary
> >>> request handler thread to process the FUSE_INIT.  That's partly why
> >>> fuse_daemonize_start/success/fail() is created here, right?
> >>
> >> I have written two similar APIs for two different daemons at DDN (one in
> >> C and the other in C++), independent of sync FUSE_INIT. For us it is
> >> important to only create the mount point when the network connection
> >> works - that is done by threads not under control from libfuse. With
> >> network you want to see something like "authorization failure" or "host
> >> not reachable" in foreground.
> >>
> >> With sync FUSE_INIT the additional issue of
> >> FUSE_INIT-creates-the-io-uring ring thread came up - even the
> >> <libfuse>/example/* file systems all don't work, because now
> >> fuse_session_mount() creates the ring threads, then comes
> >> fuse_daemonize() - parent exits - ring threads gone.
> > 
> > <nod>
> > 
> >>> And the rest of the reason for the new functions is to enable
> >>> communication between the parent and child processes -- if one dies
> >>> the other can find out about it; and the child can tell the parent the
> >>> outcome of mount()ing the filesystem.
> >>>
> >>> I wonder -- if you know that the kernel supports synchronous FUSE_INIT,
> >>> can you start the main event handling threadpool (i.e. the one created
> >>> in fuse_loop_mt.c) after opening /dev/fuse (obviously) but before
> >>> calling mount()?  That would make a hard requirement of having at least
> >>> one event handling thread, but you wouldn't have to create this temp
> >>> thread just to handle the FUSE_INIT.
> >>
> >> That would work and I believe it would be feasible for libfuse examples,
> >> but what about all the other real file systems out there? They would
> >> need to be rewritten to get sync INIT? And how many people understand
> >> the difference between sync and async init? Is this temp thread causing
> >> issues?
> > 
> > Don't fuse server authors already need to adapt their codebases to the
> > new fuse_daemonize_* calls if either they want to start threads or want
> > sync INIT?
> 
> If run with io-uring yes, otherwise I guess not, the current condition is
> 
> 	if (!se->want_sync_init &&
> 		(se->uring.enable && !fuse_daemonize_is_used())) {
> 		if (se->debug)
> 			fuse_log(FUSE_LOG_DEBUG,
> 					"fuse: sync init not enabled\n");
> 		return 0;
> 	}
> 
> 
> want_sync_init needs to be set if you had your own daemonization process
> (as we have at DDN). 
> 
> > 
> > The problem I have with the temp thread is that it adds a fourth(?)
> > piece of code that handles fuse requests (the existing ones being
> > single-thread read, multi-thread read, iouring) and I think "err, more
> > code that everyone has to understand".
> 
> We can actually switch single threaded to fuse_loop_mt.c and remove 
> fuse_loop.c altogether. I.e. just run a single worker thread with 
> fuse_loop_mt.c

<nod> At this point fuse3.pc always links in -lpthread so I concede that
there aren't really any "single threaded" (aka pthreadless) fuse servers
anymore.

> > Granted, any server that wants sync FUSE_INIT will basically have to be
> > a multithreaded server.
> 
> Does it?

Well libfuse starts one background thread to handle the FUSE_INIT, which
(in my mind) means the fuse server must be careful about thread
synchronization.  But these days there aren't many complex storage
programs that don't pull in pthreads.

> > 
> > Shifting to fuse servers, adding a background thread does have some side
> > effects -- if you want to use pthread_[gs]etspecific from fuse operation
> > handlers, you have to know that FUSE_INIT will run in a different thread
> > from the ones set up by fuse_session_loop_mt.  If the fuse server needs
> > to preallocate the thread-specific variables, it has to know to add an
> > extra preallocation for the FUSE_INIT thread.
> > 
> > (Or you can't use them from FUSE_INIT)
> 
> Hmm, I was hoping these would libfuse internal threads and you never would
> need to care about such things.

Libraries love to leak things, I'm afraid. :(

Granted if you /did/ want to use pthread_setspecific you'd also have to
be aware of (or at least disable) libfuse's ability to scale the fuse
worker pool size up and down.

> >>> Even better the daemonize() changes reduce to just the pipe between
> >>> parent and child and watching either for a return value or the POLLERR
> >>> when either program fails unexpectedly.
> >>
> >> We also need to send a signal to the parent that child has success. How
> >> many pipes we use is an internal detail? If we find a better way later
> >> to reduce the number of pipes, even better.
> > 
> > <nod> Between the parent and child of a fork() operation that's fine, we
> > can update the interface at any time.
> > 
> >>>> fuse_daemonize_success() / fuse_daemonize_fail() - background
> >>>> daemon signals to the foreground process success or failure.
> >>>>
> >>>> fuse_daemonize_active() - helper function for the high level
> >>>> interface, which needs to handle both APIs. fuse_daemonize()
> >>>> is called within fuse_main(), which now needs to know if the caller
> >>>> actually already used the new API itself.
> >>>>
> >>>> The object 'struct fuse_daemonize *' is allocated dynamically
> >>>> and stored a global variable in fuse_daemonize.c, because
> >>>> - high level fuse_main_real_versioned() needs to know
> >>>> if already daemonized
> >>>> - high level daemons do not have access to struct fuse_session
> >>>> - FUSE_SYNC_INIT in later commits can only be done if the new
> >>>> API (or a file system internal) daemonization is used.
> >>>
> >>> I don't know exactly what's required to switch libfuse into uring mode.
> >>> It look as though you inject -oio_uring as a mount option, then libfuse
> >>> sets up the uring, starts some extra workers to handle the ring(?) and
> >>> puts them to sleep.  If the kernel says it supports uring in FUSE_INIT
> >>> then do_init wakes them up.  Each uring thread submits SQEs and waits
> >>> for fuse requests to appear as CQEs, right?
> >>
> >> Yeah, we can also make that later on a default, without the -oio_uring
> >> option (there is also env for ci test purposes to enforce io-uring
> >> mode). Right now it starts too many threads (got distracted today and
> >> didn't send the new version of ring reduction patches - will try
> >> tomorrow). And I also expected bugs in all that new code, so I didn't
> >> want to make it a default.
> > 
> > <nod>
> > 
> >>>
> >>> So after a fuse server negotiates with the kernel about iouring, the
> >>> background threads started by fuse_loop_mt just sit there in read()
> >>> doing nothing else, while new fuse requests get sent to userspace as a
> >>> CQE, right?
> >>
> >> Exactly.
> > 
> > Any reason not to cancel those threads?
> 
> When and why do you want to cancel them? After at fork time and recreate
> them in the fork child? I'm not sure how much liburing likes that. At
> lease with IORING_SETUP_SINGLE_ISSUER and/or IORING_SETUP_COOP_TASKRUN.

Eh, let's leave it alone then :)

> > 
> >> My question is now, are you ok with the new fuse_daemonize API? It
> >> sounds a bit like you don't like it too much.
> > 
> > Now that I've come back with a fresher mind, I think I'm ok with the
> > daemonize API itself.  I've a few minor nits to pick, so I'll reply to
> > the patch itself.
> 
> 
> So now it is about the temporary thread ;)

Yep.  FWIW even now I don't hate it so much as to nak it :P

> Thanks for all your reviews!

Likewise!

--D

> 
> Bernd
> 
