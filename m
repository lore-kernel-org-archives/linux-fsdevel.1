Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC8370AD8
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204532; cv=none; b=jz3QeVsV5WQcwUbqQzOUWrP4Sri0rdQghbAUC5WV6SnUNyEzYC7sJTKCLY8U4jOmJPg1lcpRRvLqd0Aa0wcAUsNRnzVo/c+/nXBa9Efv6bPHDBwCaEtgyxebPMe9zrCDpFVfQ+8xZ9oMzxcMeT2yjzaQ/OnldOn0XApX7wyevVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204532; c=relaxed/simple;
	bh=CNc95lDrdiZd8AV1B18H7xEULsiz1hAHeraG4TZsbas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl4E6gvN7fsHtxJo+u6oD3+7eoh9EO/OsxMIyBtHiEy7WbmOvGd6W5UradT0BQSxPfD0E6YEzcUiwYOO2x/kda1VmgL6LemwiaUi50zD8h/MK0mmVFNszt4AygfYkcozulOXSslRFK93lC1W9SEkw8VE92mDG7Gr/9anok+/oQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGpDqF0y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGpDqF0y"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3747314a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788204529; x=1788809329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOrdrxaxaxWhGxafBxna8Qbb07ro71OXhgW0DP7l1OQ=;
        b=SGpDqF0y+LYj9lYiJUKTxXQ6PnhrJ0D4wrPmOj1t4HniEzwK0+9MIcO7hk9JQPUIIT
         gU2R4kekH5d4TCoGd3Xp82Bk50loo8OOFRE51BU/bOl2krZNfbObQRoXY45R1FNUMYoq
         xmXR5zfhyR1ynTGJWYzlHXgPyovYX+rDtX0L/ACbqhM3RBOs/SGzoZmjKV5rYh4rodOx
         YNaiM4+uqoIIx9bhqPLvdr1sD0NMPZEH+oNL1pZM7vD99SrAQpZlZLfw9z3MFBEWoifP
         TcsyQM/W5aVv7t2KD/IhqOcSD3b6u92zTzSvsZrMt/gFUCtHmhx/ZMx7yNGC9AAFh3VX
         0lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788204529; x=1788809329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOrdrxaxaxWhGxafBxna8Qbb07ro71OXhgW0DP7l1OQ=;
        b=kwCoMBnhFGFbxiwBcivvkCZj/hF2ZIMEus6VbmKDey6V816DVsWGOdtvExiaPBMfUx
         lCmGSRKkljwxsieY8zB+tNmPFRDNjeVXnYzGB3ZpzERUX24mSSzkOVEYip1uRAQlXxme
         q654kTl6H0vj35tlX0jou9lZPrCwCAg162JuYPme58BqDCBKJUFfIsS42P39Lnu5dyph
         mVXWhxknWQ3JNz7HOtwpdlD91BxVCbGNyWfshW3FfSVXEwLmbiO2C+wy/ni5xIORXvlX
         0ZKwmz1z2MyNS5GGghRg/roQ65/gP18ZD9p50U7adoNfOhW2MlUMPjoTaueIh0Gww8B4
         bxzQ==
X-Forwarded-Encrypted: i=1; AKwUvByssxprq27lnTa8F5ewEVYCtN2cx0Bmbqn5EXXlMtwUjuubAEHIgCj+0P0SWiytuD64aKX3mY0EX9GoZbfT@vger.kernel.org
X-Gm-Message-State: AFuF++nHw+73VE9UxXgy/Lzi34W1O1LnmwrdJajhV4kobNZRmcTdupiG
	WADz6ogUP3KINIHxP8/h3Bo6eDlZKRWjQMQbzYidQvhLyHBnhX8tWVcb
X-Gm-Gg: AYBFou1SV+8o+GFUmFojXS3pTx6jFRm8nZ372rNAikJvrrTjX7ho/ois5bRl0m6ceKB
	uuwCm+M27NzDKvE71maxHrFZXaX+W9DAADqzVMci4hKq5j+fgB5kB3RaO+cmRStUOyp24q6weVQ
	sWzwnDdfFYW/YwioFFOJteb8tj4WUFkLYXrJFIax1WeQ3es6Sb/l3j2AvF2YxF97j7s0zUcdiau
	HGufzfjM2jAHSE33j6TLA+90fQHeRUQSXdx+WQrlNdai/rM9dX8bCeRvgZzgT7alDKvEfZoXlSN
	VRE9Ihfh9zwg0i4IpbHOVvEJLDBeuRAEWjFzyXi+kFONo7hiBdTCnhx2tpL0Ec7d8AUEwOgUDxl
	cxhKmv9pLZagODeqj+cQnaZEBaULaIadpYu9zXs7E7qC8z/9t1r3CGQo7Ypy6bHlycoaipVJC/L
	fSs5fEUHgr2/5Y29PKGaEFyV5MojxFDSiRgxW9h1FRqqUkbm03vViWoq1+HI/eCRPX6NzXE8ErZ
	bXQbvRM
X-Received: by 2002:a17:90b:5827:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-39907d6909fmr4255743a91.14.1788204529334;
        Mon, 31 Aug 2026 12:28:49 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bcf7c9csm1138684a91.2.2026.08.31.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:28:48 -0700 (PDT)
Date: Tue, 1 Sep 2026 04:28:42 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"chen.yu@linux.dev" <chen.yu@linux.dev>, imv4bel@gmail.com
Subject: Re: [PATCH] sched/cache: Fix use-after-free of the mm replaced by
 exec
Message-ID: <apXV6t-7drLDf-lL@v4bel>
References: <apPb-Dr4nPYuHQOK@v4bel>
 <825d9dcc-b052-4367-a9c7-15efc4b354f8@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825d9dcc-b052-4367-a9c7-15efc4b354f8@intel.com>

On Mon, Aug 31, 2026 at 12:22:45PM +0800, Chen, Yu C wrote:
> Hi Hyunwoo,
> 
> On 8/30/2026 3:30 PM, Hyunwoo Kim wrote:
> > When the waker cannot use the wakelist, ttwu_queue() takes the target rq
> > lock and goes down into update_curr(). If the target rq belongs to another
> > CPU, the task handed to account_mm_sched() is the one running on that CPU,
> > not the task being woken.
> > 
> > account_mm_sched() reads p->mm and updates mm->sc_stat. Nothing keeps that
> > mm alive. The rq lock and rq->cpu_epoch_lock it holds have nothing to do
> > with the lifetime of the mm.
> > 
> > If that task happens to be in execve(), exec_mmap() points tsk->mm and
> > tsk->active_mm at the new mm, and exec_mm_put_old() from setup_new_exec()
> > drops the old one. free_bprm() does the same when exec fails. On the way
> > from mmput() down to __mmdrop(), mm_destroy_sched() calls free_percpu() on
> > sc_stat.pcpu_sched and free_mm() returns the mm_struct.
> > 
> > Whoever already read the old pointer keeps using it. It adds to runtime in
> > the freed per-cpu area and reads sc_stat in the freed mm_struct. Depending
> > on the condition it also writes sc_stat.cpu. That is a use-after-free.
> > 
> > Commit 9f23469401b0 ("sched/cache: Fix potential NULL mm pointer access")
> > changed the remaining p->mm dereference to the local variable, and said the
> > active_mm reference keeps the structure allocated. That holds for the other
> > paths that detach an mm, since they take an mmgrab_lazy_tlb() reference.
> > exec reassigns active_mm to the new mm as well, so that reference is gone.
> > What is left is the mm_users reference in bprm->old_mm, and dropping it is
> > the free.
> > 
> >               CPU0                                CPU1
> > 
> >                                        write(pipe)
> >                                        try_to_wake_up()
> >                                          ttwu_queue()      // takes rq0 lock
> >                                            enqueue_task_fair()
> >                                              update_curr()
> >                                                update_se()
> >                                                  account_mm_sched()
> >                                                    mm = rq0->curr->mm
> >                                                          // old mm
> >    execve()
> >      exec_mmap()                       // tsk->mm = new mm
> >      setup_new_exec()
> >        exec_mm_put_old()
> >          mmput() -> ... -> __mmdrop()
> >            mm_destroy_sched()          // free_percpu()
> >            free_mm()
> >                                                    read mm->sc_stat.epoch
> >                                                          // use-after-free
> > 
> 
> Ah, thanks for catching this.
> 
> > ---
> >   fs/exec.c             |  1 +
> >   include/linux/sched.h |  4 ++++
> >   kernel/events/core.c  |  2 ++
> >   kernel/sched/fair.c   | 16 ++++++++++++++++
> >   4 files changed, 23 insertions(+)
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 745f6eb5279e6..6194c38807980 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -916,6 +916,7 @@ static void exec_mm_put_old(struct mm_struct *old_mm)
> >   {
> >   	setmax_mm_hiwater_rss(&current->signal->maxrss, old_mm);
> >   	mm_update_next_owner(old_mm);
> > +	sched_cache_exec_done();
> >   	mmput(old_mm);
> >   }
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8b3d47a325cca..6ae31bffe049e 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2415,10 +2415,14 @@ struct sched_cache_stat {
> >   	int cpu;
> >   } ____cacheline_aligned_in_smp;
> > +void sched_cache_exec_done(void);
> > +
> >   #else
> >   struct sched_cache_stat { };
> > +static inline void sched_cache_exec_done(void) { }
> > +
> >   #endif
> >   #ifndef MODULE
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index a6c8e38a31104..2f29cbccf03f1 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5427,6 +5427,8 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
> >   	if (!cd)
> >   		return -ENOMEM;
> > +	/* @old, loaded by the try_cmpxchg() below, is only stable under RCU. */
> > +	guard(rcu)();
> 
> Is this change related to this UAF issue?

Duh.. that one is unrelated. My mistake.

> 
> > +/* exec() has switched to the new mm and is about to drop the old one. */
> > +void sched_cache_exec_done(void)
> > +{
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +
> > +	/*
> > +	 * account_mm_sched() dereferences rq->curr->mm under this rq's lock,
> > +	 * so a remote CPU can still be using the old mm. The lock cycle waits
> > +	 * for it, and the store to tsk->mm cannot be reordered past the
> > +	 * release, so later acquirers see the new mm.
> > +	 */
> > +	rq = this_rq_lock_irq(&rf);
> 
> A smart fix, learnt! It behaves like a synchronize_rcu() to protect against
> the read in account_mm_sched(). Small open: since the context of invoking
> account_mm_sched() is preemption-disabled, I wonder if we can simply use
> synchronize_rcu() directly instead of this_rq_lock_irq() - just to avoid
> contention for rq-lock in heavy system?

Yeah, that works too. I think rcu is nicer here as well. I'll do some
testing and send a v2.


Best regards,
Hyunwoo Kim
