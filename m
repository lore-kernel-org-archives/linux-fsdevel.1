Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06023471CFA
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259480; cv=none; b=rDz0UnJ9yDjqDSjm7bDyUyoiUTtv8rQHC+JiJHz/U9L+7elq8jonCR8htBwk2GjzOymSh/mJWxgSOmyxKrNMg/30KdUJvjLbG4VhfsJNIDVT8vGEULVBCiaGqHJDUQwzNdwvV7S6EvAV2vn3TAlUHTwNdtwnr9qLdi98FPOMO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259480; c=relaxed/simple;
	bh=yhImsaGycFcpt03nUpS+q6140gDwRTpwnZJCniBIO6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KATN42PiEY2n2ec+FKGLgQyWCtiMo612rxTCBv3ehx3T+Z26Nn7Di0zAocHZekmMvVJ/a6cUSaANInd/LpM3nC+QHbQWgA3ApSA5LVs1wSK972hSbpIuVFjnZaVLexOcn7jxdfOXr5xq314iYnr6LimnrSfdvNSb8X59x/A/IsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3dmU3LE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3dmU3LE"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso3501880a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788259478; x=1788864278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZloK1QMVfYTr7lw3fYmKao90elb4bik95MvHlyNxNk=;
        b=i3dmU3LEMCas6PvduW7m8Imcpm9fC7DGAhShLteR+T7C3W+Y4+xxeb4+azbLnpYju6
         xGpzKcoRxo/zHiDnQ5JiZJ2ZxHgTEXVx/ES0jpOH+OC8a+Vh19LHznEGdG7RQ4+PA7vg
         z6uWC+ruwqC/PF/fRvBBH390PZ4oL7Z4oYqkNi5A7A2vv1WLLWroCR2mDVrbMQ4veER/
         7rjL3rrRTFTmPgu3oPtnxdvNX2LWVKNnXGczka7vwaMVehUA+Iyx6sahmG0YQBl+ua8H
         qTYsPQAWGI7oDEAZT9vcizUvAaK8L+gva5Sr8iMI+DQ48w2a/7vZPi0jxfeSgmmPKa61
         0tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788259478; x=1788864278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jZloK1QMVfYTr7lw3fYmKao90elb4bik95MvHlyNxNk=;
        b=efpYdMqP8oMaCptKu2Wa+ZDR2z3l6V6QByyfuv7yQ/RtXH97Y0cOWw5OpaCaJ59NMk
         xr/o5ABzWwxP/HOBKIv1fL8mQdQi3Y18mz6TFGO911TsPxO98NufrYetFtmdkStrSPQ5
         JY44WXoNab27iDI20g4b8bzn0dv5k92Dz08/cQlejLj58ri6LkR5c/oM6hkq00QjkSCx
         2pmJ2oVG0i42i6w3FhFC81mya5jPONz9UG0SXRkO2rAFu970Dh/TBPaYVJ7sBx0Gpq6s
         82OTAyS+NF9frgdCVQgMp1vENU5fi5Pl8u5i5a4jQZrH+/oCbq9wHJgFFQpdduaBLi7K
         kR/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwv3mBj3uq31eXXC4q95wIXDSycOwp+VHwh8TgeVbE7cm/JRjBPElJz5On6/00UrhzyuDxa1OjTUDwOV7cn@vger.kernel.org
X-Gm-Message-State: AFuF++m+YLoyNQHvDfaXMmHyeqovz12i7Za7JYZyjCieYxzj0YmH1e5P
	i/rT/kvbFV3dbwJq1Hd2+t/J3A8ZA90Lrmm0/07RUchTPGScViZ7ttsy
X-Gm-Gg: AYBFou0L8WuMmmieuaVcU76vx5gGa6MRZuLKZoNuwDQvPRf/8Q3CWmKQy7cUQDYsohs
	b+Z8+dT1CczLi+rM8S5u51tB4XM2D0dIKbjB7FbXpbDATBwyM4V367mt/6N8qY91uoqB59evQuG
	C9eNtkXkBie0r7igCgBlo7/m5SKzxrcTuxwX2l9ewR1YKhTcuG9BAVcrLwHf6QZ+En+5y7PvHwD
	ssxhi1ntSbRPg+fUy4YIOAxp8UMp9jOToKsR/EV//yzfltkkoND+aUtur96oKKv6JgpsgOnZkNM
	AnM16BUdtnagyzvxasJCsCUvVLqdimumxfM0tzm4C6/EOAuaZIhNE8Z4BODqj3CTohSVEMcoFqx
	ystOkay+O922yeuM8OoXgtrFRxklL/eACoDu45HMJjCuyQBxj+BVN5RMlQzFXLMAKsnEmTSP+FA
	Apx5ewiUnvYwMCrT/V0UEP/eHNOhzdXnyfk+n+h+MAVOEwPpCdhY9xkxcQRJs1UYSMFiaCOPNip
	WFvKHW+9ifEBi7j+Uk=
X-Received: by 2002:a17:90b:3ec5:b0:398:e6b6:acc1 with SMTP id 98e67ed59e1d1-39907d6563cmr10056321a91.15.1788259478120;
        Tue, 01 Sep 2026 03:44:38 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d471e75sm5591120a91.8.2026.09.01.03.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:44:37 -0700 (PDT)
Date: Tue, 1 Sep 2026 19:44:31 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, Kees Cook <kees@kernel.org>,
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
Message-ID: <apasjygjnsg1n6em@v4bel>
References: <apPb-Dr4nPYuHQOK@v4bel>
 <825d9dcc-b052-4367-a9c7-15efc4b354f8@intel.com>
 <apXV6t-7drLDf-lL@v4bel>
 <a1a0bc24108e68656041dc17824d6b88b4120058.camel@linux.intel.com>
 <apX1ufR1reYZ9LBc@v4bel>
 <db2436d91e2e04a8a1063553ce64acc74b533f5c.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db2436d91e2e04a8a1063553ce64acc74b533f5c.camel@linux.intel.com>

On Mon, Aug 31, 2026 at 03:10:40PM -0700, Tim Chen wrote:
> On Tue, 2026-09-01 at 06:44 +0900, Hyunwoo Kim wrote:
> > On Mon, Aug 31, 2026 at 01:25:06PM -0700, Tim Chen wrote:
> > > On Tue, 2026-09-01 at 04:28 +0900, Hyunwoo Kim wrote:
> > > > On Mon, Aug 31, 2026 at 12:22:45PM +0800, Chen, Yu C wrote:
> > > > > Hi Hyunwoo,
> > > > > 
> > > > > On 8/30/2026 3:30 PM, Hyunwoo Kim wrote:
> > > > > > When the waker cannot use the wakelist, ttwu_queue() takes the target rq
> > > > > > lock and goes down into update_curr(). If the target rq belongs to another
> > > > > > CPU, the task handed to account_mm_sched() is the one running on that CPU,
> > > > > > not the task being woken.
> > > > > > 
> > > > > > account_mm_sched() reads p->mm and updates mm->sc_stat. Nothing keeps that
> > > > > > mm alive. The rq lock and rq->cpu_epoch_lock it holds have nothing to do
> > > > > > with the lifetime of the mm.
> > > > > > 
> > > > > > If that task happens to be in execve(), exec_mmap() points tsk->mm and
> > > > > > tsk->active_mm at the new mm, and exec_mm_put_old() from setup_new_exec()
> > > > > > drops the old one. free_bprm() does the same when exec fails. On the way
> > > > > > from mmput() down to __mmdrop(), mm_destroy_sched() calls free_percpu() on
> > > > > > sc_stat.pcpu_sched and free_mm() returns the mm_struct.
> > > > > > 
> > > > > > Whoever already read the old pointer keeps using it. It adds to runtime in
> > > > > > the freed per-cpu area and reads sc_stat in the freed mm_struct. Depending
> > > > > > on the condition it also writes sc_stat.cpu. That is a use-after-free.
> > > > > > 
> > > > > > Commit 9f23469401b0 ("sched/cache: Fix potential NULL mm pointer access")
> > > > > > changed the remaining p->mm dereference to the local variable, and said the
> > > > > > active_mm reference keeps the structure allocated. That holds for the other
> > > > > > paths that detach an mm, since they take an mmgrab_lazy_tlb() reference.
> > > > > > exec reassigns active_mm to the new mm as well, so that reference is gone.
> > > > > > What is left is the mm_users reference in bprm->old_mm, and dropping it is
> > > > > > the free.
> > > > > > 
> > > > > >               CPU0                                CPU1
> > > > > > 
> > > > > >                                        write(pipe)
> > > > > >                                        try_to_wake_up()
> > > > > >                                          ttwu_queue()      // takes rq0 lock
> > > > > >                                            enqueue_task_fair()
> > > > > >                                              update_curr()
> > > > > >                                                update_se()
> > > > > >                                                  account_mm_sched()
> > > > > >                                                    mm = rq0->curr->mm
> > > > > >                                                          // old mm
> > > > > >    execve()
> > > > > >      exec_mmap()                       // tsk->mm = new mm
> > > > > >      setup_new_exec()
> > > > > >        exec_mm_put_old()
> > > > > >          mmput() -> ... -> __mmdrop()
> > > > > >            mm_destroy_sched()          // free_percpu()
> > > > > >            free_mm()
> > > > > >                                                    read mm->sc_stat.epoch
> > > > > >                                                          // use-after-free
> > > > > > 
> > > > > 
> > > > > Ah, thanks for catching this.
> > > > > 
> > > > > > ---
> > > > > >   fs/exec.c             |  1 +
> > > > > >   include/linux/sched.h |  4 ++++
> > > > > >   kernel/events/core.c  |  2 ++
> > > > > >   kernel/sched/fair.c   | 16 ++++++++++++++++
> > > > > >   4 files changed, 23 insertions(+)
> > > > > > 
> > > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > > index 745f6eb5279e6..6194c38807980 100644
> > > > > > --- a/fs/exec.c
> > > > > > +++ b/fs/exec.c
> > > > > > @@ -916,6 +916,7 @@ static void exec_mm_put_old(struct mm_struct *old_mm)
> > > > > >   {
> > > > > >   	setmax_mm_hiwater_rss(&current->signal->maxrss, old_mm);
> > > > > >   	mm_update_next_owner(old_mm);
> > > > > > +	sched_cache_exec_done();
> > > > > >   	mmput(old_mm);
> > > > > >   }
> > > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > > index 8b3d47a325cca..6ae31bffe049e 100644
> > > > > > --- a/include/linux/sched.h
> > > > > > +++ b/include/linux/sched.h
> > > > > > @@ -2415,10 +2415,14 @@ struct sched_cache_stat {
> > > > > >   	int cpu;
> > > > > >   } ____cacheline_aligned_in_smp;
> > > > > > +void sched_cache_exec_done(void);
> > > > > > +
> > > > > >   #else
> > > > > >   struct sched_cache_stat { };
> > > > > > +static inline void sched_cache_exec_done(void) { }
> > > > > > +
> > > > > >   #endif
> > > > > >   #ifndef MODULE
> > > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > > index a6c8e38a31104..2f29cbccf03f1 100644
> > > > > > --- a/kernel/events/core.c
> > > > > > +++ b/kernel/events/core.c
> > > > > > @@ -5427,6 +5427,8 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
> > > > > >   	if (!cd)
> > > > > >   		return -ENOMEM;
> > > > > > +	/* @old, loaded by the try_cmpxchg() below, is only stable under RCU. */
> > > > > > +	guard(rcu)();
> > > > > 
> > > > > Is this change related to this UAF issue?
> > > > 
> > > > Duh.. that one is unrelated. My mistake.
> > > > 
> > > > > 
> > > > > > +/* exec() has switched to the new mm and is about to drop the old one. */
> > > > > > +void sched_cache_exec_done(void)
> > > > > > +{
> > > > > > +	struct rq_flags rf;
> > > > > > +	struct rq *rq;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * account_mm_sched() dereferences rq->curr->mm under this rq's lock,
> > > > > > +	 * so a remote CPU can still be using the old mm. The lock cycle waits
> > > > > > +	 * for it, and the store to tsk->mm cannot be reordered past the
> > > > > > +	 * release, so later acquirers see the new mm.
> > > > > > +	 */
> > > > > > +	rq = this_rq_lock_irq(&rf);
> > > > > 
> > > > > A smart fix, learnt! It behaves like a synchronize_rcu() to protect against
> > > > > the read in account_mm_sched(). Small open: since the context of invoking
> > > > > account_mm_sched() is preemption-disabled, I wonder if we can simply use
> > > > > synchronize_rcu() directly instead of this_rq_lock_irq() - just to avoid
> > > > > contention for rq-lock in heavy system?
> > > 
> > > Thanks to Kyunwoo to show this potential use-after-free problem.
> > 
> > It is a real, triggerable issue.
> > 
> 
> Appreciate if you can check whether the first 2 patches in 
> https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.intel.com/
> fixes this issue.
> 
> > > 
> > > While synchronize_rcu() avoids rq lock, it could introduce a long delay
> > > of a full grace period that will be undesirable.
> > > 
> > > 
> > > I think a better fix is to decouple sc_stat from mm and make it its own structure.
> > > Then we can do proper refcounting and rcu management on sc_stat itself.
> > > We will let task points to sc_stat with proper ref count and change the access
> > > as task->sc_stat directly nstead of via task->mm->sc_stat.
> > > 
> > > Then we will know sc_stat exists in account_mm_sched() execution
> > > as long as a task points to it and do not have to worry that sc_stat is
> > > released due to the mm life cycle.
> > > 
> > > In the first 2 patches of the prctl control series for cache aware scheduling
> > > we posted, we introduced the change I described above and should 
> > > fix this issue without additional rq locking or synchronize_rcu() overhead.
> > >  https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.intel.com/
> > > 
> > > We should probably prioritize to merge the first couple of patches from
> > > that series now in light of this issue.  It will make maintenance and future
> > > modification of the cache aware scheduling code easier.
> > 
> > That is a fairly large change. 
> 
> However adding rcu synchronization will slow down the launch of a new process
> too much.  The rq lock solution has less latency in my opinion.  But I
> think decoupling sc_stat is the best solution without adding latency in the
> exec path.
> 
> Wonder what is Peter's opinion?
> 
> > 
> > If you add a Reported-by: tag for this UAF to the patch, I am fine with 
> > handling it that way.
> 
> I'll be happy to do that. If you let us know if those two patches from prctl series fixes
> the bug you found in KASAN log, I can also add a Tested-by tag in addition to Reported-by.

I confirmed that patches 1 and 2 of your series prevent this UAF.


Best regards,
Hyunwoo Kim
