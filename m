Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04697391E74
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212675; cv=none; b=iv4o47nfeVo8hwx7md4OGrLC45QiZqK8FFBIeAe4jzCLG4EILrBWP6T7epLoxeA5Wp2xPrPg098MBhZ9EnZ5QrJP/Yx1rIbPH91zTGSuqsjau0eDNzIcl5EFHrFwPR/wy6YgPEQGSbvFbqumuzYUql4edU09zwxqqHIvE+OQojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212675; c=relaxed/simple;
	bh=vOjA2ynksWtPJ98im95NDkY+9D5YOvJCXOUrd2UoU7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsAOUoUa/l07T9KkOUWgLlDFnCmk49jxOaRbZc8kRmHet7v6bba80WNWQ0z2TRtT5bj7YMlcGE4I9SQN4W9z81c4ObeYfjBxmBZG1kq7ID6ZSWZ0wQjJhMATaXPN3wtLOp8ylIDfOsH2H25z/sOiokrKwxZSPx5vRztozNOiz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxDvERCS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxDvERCS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8520161fdb9so246010b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788212672; x=1788817472; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVDll6WIE5UiMa75pvf0sUPkvEMMcWUBr73CfpmM+D0=;
        b=nxDvERCSBxvlBc7MgQf8wPJAbjuSuBNsQMNqOQMkS4Q4mKIRIUaHSkOZd195w0rL2+
         fz/EzhIwh2Ra58jVt6q6QMzHsjO+S48CfHp/lllaayXl54Gx8Hq/KSuupziuzOrjtu/T
         KJJ6dI0RVXaAJb42eUiHSD0KNw26w6rJAFCuYhjGuMLsaMTOt21VRbDur0/1KlQD1eTk
         FplBiEFdT06vOnseBZjUu9ZkWr46DJs8L2pWqVXBRrIVB67LXWGm1kmyqxDDkQ3Eajg7
         SkRS2P1KqEJ9GqPXN9oGx4SMG0m2ZWstDiMHbt4AY6ykwXhPYrraUjROHw7Bm6aLnam+
         KGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788212672; x=1788817472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aVDll6WIE5UiMa75pvf0sUPkvEMMcWUBr73CfpmM+D0=;
        b=HLKFDlC9ftYvub9Y593Knt1FXwvWBkmyaGVRGQvRzuA7t+/MnXjLxwVYefJGv08LaW
         J/vDXzleiDLsHVPlwCmsRqr0ohph4KsWBsUUnCXmmq8tAI7IXJODKYsEeDRtJQ8JLrq0
         /F8a0mG4Y/PDE8zw5SSRCXtB7kHq8CFxdENQgEUhAb316YqjdcNmHQmaBq/JTGZdZ9xv
         wHslFnBLhQWEljlcAiMABK5c1uxZArdT++akMHkpO/oi5d70O+357Ao/0nPkQc9ONaJP
         0TnCOjMUvKJTmi1tMpEdMvTmD9cmsymkTud71pVc6iZAkZ8W6MmDv0YlVym2G6hcD4AD
         p45Q==
X-Forwarded-Encrypted: i=1; AHgh+RpUaV3XGKrDh9pt+D9sIhTbZ8IGnTNrspJrm9IdCwafY93MDf8ZaFWwIj6MkWNxLYne4JY59KRwZQcvf/gZ@vger.kernel.org
X-Gm-Message-State: AFuF++lA8Tr+gCnkohKeCamksWTonraTCz91ZkLujZrpTHTjWfF4E3Ai
	ehdJRF7q0XSwgWNiwRVsJXi1C2Dpfdxa1DV2Gx3UVhd81LXrtzr+nnpe
X-Gm-Gg: AR+sD12LB/AKfCxOoSkjkrKQXAhgxVuyFk6K/JEIisSQ8Ghfa2X84/yB/fQFRIYwFLu
	Yz9kplx93AUsXh8s0SqP9eB3t6+CCjdwmVmX6LeW5y3aM+s7i+OIgPE+CraFXAKDrmDMuTBC6hA
	2+No+hzV9L9c0QHy6C2XZVfbQPt0lOb4wlGCWEqBhM/h6hnlxX4yj1NWPA1pchNQaVO0M7mTSf0
	hXbjQ2QzSy3uZphb6EPSiTi9oerZUWLtCl7BAX6uJKWa3PdVCLo/a+pxq2F7kMfLN/o4GKdi/oT
	basAB36vCb1famrPbkp9yOp4OhYcDOOo4f/Vg1pcYkbEEccdeZAp1t6HoDDWKWYLLVp5jubiML+
	3jDTSb5E0ENJLf4+KDH0oCTsXNoBR2xTN9IjO6PSwIZnrTRpauQmv8lkiJPP8b/CvO4bmIQ0N9+
	lszSJTwqLkIqmDQr4aSHF12RrWHH+XT/GkYydUk/V6gcmRW1SmAhiDhSGpnWUZj9Dbv6+e4uEo1
	uGSSCE=
X-Received: by 2002:a05:6a00:ab0a:b0:84e:7ec:aa42 with SMTP id d2e1a72fcca58-85629f09863mr48227025b3a.10.1788212672297;
        Mon, 31 Aug 2026 14:44:32 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be5d9b768sm87355b3a.3.2026.08.31.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:44:31 -0700 (PDT)
Date: Tue, 1 Sep 2026 06:44:25 +0900
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
Message-ID: <apX1ufR1reYZ9LBc@v4bel>
References: <apPb-Dr4nPYuHQOK@v4bel>
 <825d9dcc-b052-4367-a9c7-15efc4b354f8@intel.com>
 <apXV6t-7drLDf-lL@v4bel>
 <a1a0bc24108e68656041dc17824d6b88b4120058.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1a0bc24108e68656041dc17824d6b88b4120058.camel@linux.intel.com>

On Mon, Aug 31, 2026 at 01:25:06PM -0700, Tim Chen wrote:
> On Tue, 2026-09-01 at 04:28 +0900, Hyunwoo Kim wrote:
> > On Mon, Aug 31, 2026 at 12:22:45PM +0800, Chen, Yu C wrote:
> > > Hi Hyunwoo,
> > > 
> > > On 8/30/2026 3:30 PM, Hyunwoo Kim wrote:
> > > > When the waker cannot use the wakelist, ttwu_queue() takes the target rq
> > > > lock and goes down into update_curr(). If the target rq belongs to another
> > > > CPU, the task handed to account_mm_sched() is the one running on that CPU,
> > > > not the task being woken.
> > > > 
> > > > account_mm_sched() reads p->mm and updates mm->sc_stat. Nothing keeps that
> > > > mm alive. The rq lock and rq->cpu_epoch_lock it holds have nothing to do
> > > > with the lifetime of the mm.
> > > > 
> > > > If that task happens to be in execve(), exec_mmap() points tsk->mm and
> > > > tsk->active_mm at the new mm, and exec_mm_put_old() from setup_new_exec()
> > > > drops the old one. free_bprm() does the same when exec fails. On the way
> > > > from mmput() down to __mmdrop(), mm_destroy_sched() calls free_percpu() on
> > > > sc_stat.pcpu_sched and free_mm() returns the mm_struct.
> > > > 
> > > > Whoever already read the old pointer keeps using it. It adds to runtime in
> > > > the freed per-cpu area and reads sc_stat in the freed mm_struct. Depending
> > > > on the condition it also writes sc_stat.cpu. That is a use-after-free.
> > > > 
> > > > Commit 9f23469401b0 ("sched/cache: Fix potential NULL mm pointer access")
> > > > changed the remaining p->mm dereference to the local variable, and said the
> > > > active_mm reference keeps the structure allocated. That holds for the other
> > > > paths that detach an mm, since they take an mmgrab_lazy_tlb() reference.
> > > > exec reassigns active_mm to the new mm as well, so that reference is gone.
> > > > What is left is the mm_users reference in bprm->old_mm, and dropping it is
> > > > the free.
> > > > 
> > > >               CPU0                                CPU1
> > > > 
> > > >                                        write(pipe)
> > > >                                        try_to_wake_up()
> > > >                                          ttwu_queue()      // takes rq0 lock
> > > >                                            enqueue_task_fair()
> > > >                                              update_curr()
> > > >                                                update_se()
> > > >                                                  account_mm_sched()
> > > >                                                    mm = rq0->curr->mm
> > > >                                                          // old mm
> > > >    execve()
> > > >      exec_mmap()                       // tsk->mm = new mm
> > > >      setup_new_exec()
> > > >        exec_mm_put_old()
> > > >          mmput() -> ... -> __mmdrop()
> > > >            mm_destroy_sched()          // free_percpu()
> > > >            free_mm()
> > > >                                                    read mm->sc_stat.epoch
> > > >                                                          // use-after-free
> > > > 
> > > 
> > > Ah, thanks for catching this.
> > > 
> > > > ---
> > > >   fs/exec.c             |  1 +
> > > >   include/linux/sched.h |  4 ++++
> > > >   kernel/events/core.c  |  2 ++
> > > >   kernel/sched/fair.c   | 16 ++++++++++++++++
> > > >   4 files changed, 23 insertions(+)
> > > > 
> > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > index 745f6eb5279e6..6194c38807980 100644
> > > > --- a/fs/exec.c
> > > > +++ b/fs/exec.c
> > > > @@ -916,6 +916,7 @@ static void exec_mm_put_old(struct mm_struct *old_mm)
> > > >   {
> > > >   	setmax_mm_hiwater_rss(&current->signal->maxrss, old_mm);
> > > >   	mm_update_next_owner(old_mm);
> > > > +	sched_cache_exec_done();
> > > >   	mmput(old_mm);
> > > >   }
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index 8b3d47a325cca..6ae31bffe049e 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -2415,10 +2415,14 @@ struct sched_cache_stat {
> > > >   	int cpu;
> > > >   } ____cacheline_aligned_in_smp;
> > > > +void sched_cache_exec_done(void);
> > > > +
> > > >   #else
> > > >   struct sched_cache_stat { };
> > > > +static inline void sched_cache_exec_done(void) { }
> > > > +
> > > >   #endif
> > > >   #ifndef MODULE
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index a6c8e38a31104..2f29cbccf03f1 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -5427,6 +5427,8 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
> > > >   	if (!cd)
> > > >   		return -ENOMEM;
> > > > +	/* @old, loaded by the try_cmpxchg() below, is only stable under RCU. */
> > > > +	guard(rcu)();
> > > 
> > > Is this change related to this UAF issue?
> > 
> > Duh.. that one is unrelated. My mistake.
> > 
> > > 
> > > > +/* exec() has switched to the new mm and is about to drop the old one. */
> > > > +void sched_cache_exec_done(void)
> > > > +{
> > > > +	struct rq_flags rf;
> > > > +	struct rq *rq;
> > > > +
> > > > +	/*
> > > > +	 * account_mm_sched() dereferences rq->curr->mm under this rq's lock,
> > > > +	 * so a remote CPU can still be using the old mm. The lock cycle waits
> > > > +	 * for it, and the store to tsk->mm cannot be reordered past the
> > > > +	 * release, so later acquirers see the new mm.
> > > > +	 */
> > > > +	rq = this_rq_lock_irq(&rf);
> > > 
> > > A smart fix, learnt! It behaves like a synchronize_rcu() to protect against
> > > the read in account_mm_sched(). Small open: since the context of invoking
> > > account_mm_sched() is preemption-disabled, I wonder if we can simply use
> > > synchronize_rcu() directly instead of this_rq_lock_irq() - just to avoid
> > > contention for rq-lock in heavy system?
> 
> Thanks to Kyunwoo to show this potential use-after-free problem.

It is a real, triggerable issue.

> 
> While synchronize_rcu() avoids rq lock, it could introduce a long delay
> of a full grace period that will be undesirable.
> 
> 
> I think a better fix is to decouple sc_stat from mm and make it its own structure.
> Then we can do proper refcounting and rcu management on sc_stat itself.
> We will let task points to sc_stat with proper ref count and change the access
> as task->sc_stat directly nstead of via task->mm->sc_stat.
> 
> Then we will know sc_stat exists in account_mm_sched() execution
> as long as a task points to it and do not have to worry that sc_stat is
> released due to the mm life cycle.
> 
> In the first 2 patches of the prctl control series for cache aware scheduling
> we posted, we introduced the change I described above and should 
> fix this issue without additional rq locking or synchronize_rcu() overhead.
>  https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.intel.com/
> 
> We should probably prioritize to merge the first couple of patches from
> that series now in light of this issue.  It will make maintenance and future
> modification of the cache aware scheduling code easier.

That is a fairly large change. 

If you add a Reported-by: tag for this UAF to the patch, I am fine with 
handling it that way.


Best regards,
Hyunwoo Kim
