Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98C4FC8F9;
	Fri, 18 Sep 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738418; cv=none; b=shSROzSPXx2JLPopH4alHftA8EGjO7gBBYZ9+YFoA/4K7f2VVk5U0cTmypweAhzQ0ZoRHilTxa8FKuL8ddyLR7Kxan6bL49ed+mf8kGsFGl9GwKwQx9jEZidM2+xEHSoNZeIzLSfZ/f71yqwwczBxrqV4E3QGQWbZc5ZKfmBdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738418; c=relaxed/simple;
	bh=/Tmv7LbzDaqdwmyOnL3Ms7oDq4Jz7UKUvmatswN/lgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbcW1FAqaR8HRonZFf9Nx2wccVd/QbN2rRwqkdbSt/mmsx4cOBG8mBaD1zOmfJivydzI5OGZViLkcJWarWYrG3nC48pdVI/VjlNtUi2g6k1CnN1SlEJOiivYOyXK6PL33XTPH/CwrlftSysPiAkcNYmlu2uVDk2NtPUj5Pdwmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nre12zSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nre12zSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050D51F000FF;
	Fri, 18 Sep 2026 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789738416;
	bh=GakW/jyw2WKm8P0r1Hyy2EtB+8kZHDDr5ILgeIU3TTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nre12zSFEZj6AxBe4+WVzUlkMcdC+/awKkJWcu+08/s5KVpZ3J0/I19rSO0Dpsafl
	 ZiXQNy6Ia581usrFlSG/RKreyXMclax++76kj7xJOGL+OfJYei734waXZhxpOwNoAH
	 XcL50O+4XXiXhghO0jlpVJOBVW6Jh8rEaqqvZQw2WWrBnZeMk205/TG1KIA4Bcwzar
	 eUFJ8QO/hMtQc5133iFVrO2WmE23d7ApV/YNGhMsCwUFhaz/uqXr6PZAdCpZjDVvma
	 fNcUc6FRiR/ot/W9YlZubSS6JqSNtohexiwpcavpsKEkicIzYpHUuSUwh++PX1XQ5z
	 AFmF8wASYPzFQ==
Date: Fri, 18 Sep 2026 15:33:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: NeilBrown <neil@brown.name>, Chris Mason <mason@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, io-uring@vger.kernel.org
Subject: Re: user workers as coredumpers [Re: [PATCH 1/6] coredump: don't
 switch a dumper that has no files] table
Message-ID: <20260918-gliederung-schematisch-innehalten-7ab359d08bf7@brauner>
References: <20260915-work-coredump-fixes-v1-1-f354ca41780c@kernel.org>
 <20260916194837.3732307-1-mason@kernel.org>
 <20260917-staunen-sparsam-infusion-83238c68d21f@brauner>
 <178960987412.207413.3957049392884487413@noble.neil.brown.name>
 <20260917-zahnpasta-aufweichen-flackern-1182320f5c81@brauner>
 <20260918-tonart-umgeladen-gesponnen-519fca5172bd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918-tonart-umgeladen-gesponnen-519fca5172bd@brauner>

On Fri, Sep 18, 2026 at 02:28:58PM +0200, Christian Brauner wrote:
> On Thu, Sep 17, 2026 at 10:49:36AM +0200, Christian Brauner wrote:
> > On Thu, Sep 17, 2026 at 11:51:14AM +1000, NeilBrown wrote:
> > > On Thu, 17 Sep 2026, Christian Brauner wrote:
> > > > > When I reproduced this one, it ended up deadlocking with the fix applied.
> > > > > 
> > > > > vhost worker (the dumper)          sibling thread
> > > > > =========================          ==============
> > > > > get_signal() -> vfs_coredump()
> > > > >   coredump_close_files()
> > > > >     hands sibling a new table ---> switch_files_struct()
> > > > >     coredump_wait_inactive()         put_files_struct(old table)
> > > > >       waits for sibling's switch       last close of the vhost fd
> > > > >                                      vhost_net_release()
> > > > >                                        __vhost_worker_flush(): waits
> > > > > 
> > > > > AI suggests making the vhost thread requeue the signal for someone more
> > > > > suitable?
> > > > 
> > > > Afaict, this is conceptually a generic problem with letting coredump
> > > > close files for any type of user worker where the worker is the dumper
> > > > and the sibling thread closes the fd that causes it to be stopped and
> > > > waits for it to exit. So this needs thinking and we should drop coredump
> > > > closing files for now.
> > > > 
> > > 
> > > It appears to me that there is already infrastructure in place to handle
> > > the generic problem.  vhost_task has a "handle_sigkill" function which
> > > cleans up on sig kill so that siblings won't keep waiting for it.
> > > get_signal() detects PF_USER_WORKER tasks and lets them complete
> > > normally rather than aborting them, so that handle_sigkill can be called.
> > > 
> > > So the problem is "simply" an ordering problem. vfs_coredump() closes
> > > files before handle_sigkill can run.
> > > Maybe handle_sigkill() could be passed to (a version of) get_signal(),
> > > or maybe get_signal() could indicate to the PF_USER_WORKER caller that
> > > vfs_coredump() still needs to be run.
> > 
> > Oh good, it's worse. This isn't specific to this patchset. This class of
> > bugs I mentioned is reproducible on current mainline with SQPOLL:
> > 
> >   io-wq worker (the dumper)               SQPOLL thread
> >   =========================               =============
> >   io_wq_worker()                          io_sq_thread()
> >     get_signal()                            io_sqd_handle_event()
> >       vfs_coredump()
> >         coredump_wait()
> >           zap_threads()
> >             zap_process(): SIGKILL ---->      get_signal(): SIGKILL, returns
> >           wait_for_completion_state(        io_uring_cancel_generic(true, sqd)
> >             &core_state->startup)             io_uring_clean_tctx()
> >           waits for every thread to             io_wq_put_and_exit()
> >           reach coredump_task_exit()              io_wq_exit_workers()
> >                                                     wait_for_completion(
> >                                                       &wq->worker_done)
> >                                                     waits for the worker's
> >                                                     io_worker_exit(), which
> >                                                     runs after get_signal()
> 
> So I thought a bit about this yesterday and had some brief discussions
> bout this as well. I think we should kill this whole bug class by
> ensuring that PF_USER_WORKERs never participate in a coredump. So
> something like:
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index ec30550951ec..e3c271cf1314 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3021,6 +3021,21 @@ bool get_signal(struct ksignal *ksig)
>  		 */
>  		current->flags |= PF_SIGNALED;
>  
> +		/*
> +		 * PF_USER_WORKER threads will catch and exit on fatal signals
> +		 * themselves. They have cleanup that must be performed, so we
> +		 * cannot call do_exit() on their behalf. Note that ksig won't
> +		 * be properly initialized, PF_USER_WORKER's shouldn't use it.
> +		 *
> +		 * They must not dump core either. The dumper waits for every
> +		 * other thread in the group to exit, and a sibling's exit path
> +		 * may in turn wait for this worker's own exit, which only runs
> +		 * after get_signal() returns: io_sq_thread() ends up in
> +		 * io_wq_exit_workers() and waits there for its io-wq workers.
> +		 */
> +		if (current->flags & PF_USER_WORKER)
> +			goto out;
> +
>  		if (sig_kernel_coredump(signr)) {
>  			if (print_fatal_signals)
>  				print_fatal_signal(signr);
> @@ -3036,15 +3051,6 @@ bool get_signal(struct ksignal *ksig)
>  			vfs_coredump(&ksig->info);
>  		}
>  
> -		/*
> -		 * PF_USER_WORKER threads will catch and exit on fatal signals
> -		 * themselves. They have cleanup that must be performed, so we
> -		 * cannot call do_exit() on their behalf. Note that ksig won't
> -		 * be properly initialized, PF_USER_WORKER's shouldn't use it.
> -		 */
> -		if (current->flags & PF_USER_WORKER)
> -			goto out;
> -
>  		/*
>  		 * Death signals, no core dump.
>  		 */
> 
> Afaict the main consequence of this is for a thread-group with a bunch
> of spawned workers where the thread-group leader exits prematurely
> before all workers: any worker that takes a coredump signal via ptrace()
> shenanigans won't create a coredump anymore. I think that's entirely
> acceptable.

So to put some details on it after some research:

io-wq workers die with their owner's exit() and vhost workers with the
files table. But SQPOLL threads don't necessarily. So if a premature
thread-group leader exits then an SQPOLL thread can be left. The SQPOLL
thread pins the fdtable through CLOSE_FILES, the fdtable pins the io
ring, the rings pins the thread.

So here's how the behavior would change with my proposed patch:

|                case                |                           mainline                           |  PF_USER_WORKERS don't dump             
|────────────────────────────────────|──────────────────────────────────────────────────────────────|───────────────────────────────
| leader gone, no signal             | zombie leader + iou-sqp, not reapable, lingers until SIGKILL | same                          
|────────────────────────────────────|──────────────────────────────────────────────────────────────|───────────────────────────────
| leader gone, SIGSEGV into iou-sqp  | killed by signal 11, core written                            | exited with status 0, no core 
|────────────────────────────────────|──────────────────────────────────────────────────────────────|───────────────────────────────
| leader gone, SIGTERM into iou-sqp  | exited with status 0                                         | exited with status 0          
|────────────────────────────────────|──────────────────────────────────────────────────────────────|───────────────────────────────
| leader alive, SIGSEGV into iou-sqp | whole group killed by 11, core written                       | process survives, worker gone 
|────────────────────────────────────|──────────────────────────────────────────────────────────────|───────────────────────────────

Please note that only ptrace() can be used to inject a coredump signal
into such SQPOLL threads.

TL;DR: with PF_USER_WORKERS not being eligible from writing coredumps
any coredump signal sent to them is ignored. They just exit.

The alternative to this is akin to what Neil proposed where the coredump
signal is retargeted towards a non-PF_USER_WORKER thread.

One should note that PF_USER_WORKERs very much intentionally blog
everything apart from SIGKILL and SIGSTOP so being able to change their
signal mask via ptrace() is questionable in the first place.

In fact, the more I think about it I keep thinking we should do both:

(1) PF_USER_WORKERs can't become a dumper
(2) ptrace() should not be able to alter the signal mask for a PF_USER_WORKER
