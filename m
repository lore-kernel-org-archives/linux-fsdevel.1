Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215D354AE3;
	Wed, 16 Sep 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563310; cv=none; b=poUAO+2cR2WZcKTyYAcw3zaYnNl1ZtrTbOAWrW7oCFeGgezPNi7v185xMWeJvJDBWuGx7lF7skOdKykQ5aNGIFWthCPU5tIm0DQYS8CdZHJtKjtiRsHzx8peAFaGc58gJ+DPJdxYaOAEOOGz4oGQNjTUr6A7HQQwka44X7JviO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563310; c=relaxed/simple;
	bh=o3HXw3Mv/4rCCbM+5kPCF3F8lTAWafj/kNeojieFM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We4nkLJQuFGXTQId0MkbKKz+drvHR/eU1lqyWtqJ6eDE1xsrZq8Lsnd4Lq8fXmw1mPDAePqqpuIED8EOrupaF6SS7/RH/uosiO3jqP5dFkBPZ3inGEKqa5FwEq5iOS8eeVYGbkDPplXimVrnEz0bPLT79ReGduUMZMGKtUWK8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kL2FeXHk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kL2FeXHk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3+6Kr80JG4BpC+G12cdr/A75Y8Inn6C+PumT0UpV3iA=; b=kL2FeXHkacHaFxdFGZoyyMtDG7
	qVtQ95V5o5JnWtfqovZodaKZTyDq7rRGm4juqrkFIfvNv7/FRNCmx/rgv9+9cBzJmxNDsORbe5YO4
	EBjLOt9S7vviqc9E+5Rj3TsFZvqTNdkmiZmfP+bgfg2iqI9I3FJ2YxWo5tVYQClwBxaAJSafk/QBp
	7UD9D0JS7VJoOky5XYBLvsIObwPtcOsNPXtuoJV/FJewNWmwuQtWz8kjSATnhWXXjFwoQbRr/Thc0
	Fw2sAxshJ56i6FiSwe5n2WDyQvK376fO1967y4rHuxtN5tz/Ii5es595YxihBgb+CjRx1na6Z7xab
	Xd/UpRJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6p9t-00000004Tte-28nx;
	Wed, 16 Sep 2026 12:54:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80F96300328; Wed, 16 Sep 2026 14:54:40 +0200 (CEST)
Date: Wed, 16 Sep 2026 14:54:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	Ricardo Neri-Calderon <ricardo.neri-calderon@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Lu Wang <wanglu.priv@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/cache: Decouple sched_cache_group from mm
Message-ID: <20260916125440.GF776954@noisy.programming.kicks-ass.net>
References: <cover.1789061845.git.tim.c.chen@linux.intel.com>
 <cb678eddae708e2865ec69a04edf999119c2168a.1789061845.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb678eddae708e2865ec69a04edf999119c2168a.1789061845.git.tim.c.chen@linux.intel.com>

On Thu, Sep 10, 2026 at 10:46:11AM -0700, Tim Chen wrote:

> +static void sched_cache_group_free_rcu(struct rcu_head *rcu)
> +{
> +	struct sched_cache_group *grp =
> +		container_of(rcu, struct sched_cache_group, rcu);
> +
> +	/* free_percpu() may be called from atomic context. */

That comment is misleading at best. This is rcu-free context. And
free_percpu() is not allowed from actual atomic context on RT.

> +	free_percpu(grp->pcpu_sched);
> +	kfree(grp);
> +}
> +
> +void sched_cache_group_put(struct sched_cache_group *grp)
> +{
> +	if (!grp || !refcount_dec_and_test(&grp->refcnt))
> +		return;
> +
> +	call_rcu(&grp->rcu, sched_cache_group_free_rcu);
> +}
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 32213801ea39..b5a823f0a622 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

> @@ -1669,18 +1677,35 @@ void mm_init_sched(struct mm_struct *mm,
>  		epoch = rq->cpu_epoch;
>  	}
>  
> -	raw_spin_lock_init(&mm->sc_stat.lock);
> -	mm->sc_stat.epoch = epoch;
> -	mm->sc_stat.cpu = -1;
> -	mm->sc_stat.next_scan = jiffies;
> -	mm->sc_stat.nr_running_avg = 0;
> -	mm->sc_stat.footprint = 0;
> +	raw_spin_lock_init(&grp->lock);
> +	grp->epoch = epoch;
> +	grp->cpu = -1;
> +	grp->next_scan = jiffies;
> +	grp->nr_running_avg = 0;
> +	grp->footprint = 0;
> +	refcount_set(&grp->refcnt, 1);
>  	/*
> -	 * The update to mm->sc_stat should not be reordered
> -	 * before initialization to mm's other fields, in case
> +	 * The update to grp->pcpu_sched should not be reordered
> +	 * before initialization to grp's other fields, in case
>  	 * the readers may get invalid mm_sched_epoch, etc.
>  	 */
> -	smp_store_release(&mm->sc_stat.pcpu_sched, _pcpu_sched);
> +	smp_store_release(&grp->pcpu_sched, _pcpu_sched);
> +	/*
> +	 * Publish the group last.  Not every reader qualifies it by
> +	 * grp->pcpu_sched - can_migrate_llc_task() only checks that the
> +	 * pointer is non-NULL before reading grp->footprint and
> +	 * grp->nr_running_avg - so a reachable group must already be
> +	 * fully initialized.
> +	 */
> +	mm->sched_cache_grp = grp;

If it is a publish it needs to be store-release.

> +	return 0;
> +}
> +
> +void mm_destroy_sched(struct mm_struct *mm)
> +{
> +	if (mm->sched_cache_grp)
> +		sched_cache_group_put(mm->sched_cache_grp);
> +	mm->sched_cache_grp = NULL;
>  }
>  
>  /* because why would C be fully specified */
> @@ -1738,7 +1763,7 @@ static int get_pref_llc(struct task_struct *p, struct mm_struct *mm)
>  	if (!mm)
>  		return -1;
>  
> -	mm_sched_cpu = READ_ONCE(mm->sc_stat.cpu);
> +	mm_sched_cpu = READ_ONCE(mm->sched_cache_grp->cpu);
>  	if (mm_sched_cpu != -1) {
>  		mm_sched_llc = llc_id(mm_sched_cpu);
>  
> @@ -1781,11 +1806,15 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
>  	/*
>  	 * init_task, kthreads and user thread created
>  	 * by user_mode_thread() don't have mm.
> +	 *
> +	 * A kthread can temporarily adopt an mm via kthread_use_mm(),
> +	 * so p->mm alone does not imply a user task.

This seems like a related but distinct fix, no?

>  	 */
> -	if (!mm || !mm->sc_stat.pcpu_sched)
> +	if (!mm || p->flags & PF_KTHREAD || !mm->sched_cache_grp ||
> +	    !mm->sched_cache_grp->pcpu_sched)
>  		return;

Is this susceptible to TOCTOU ?

>  
> -	pcpu_sched = per_cpu_ptr(mm->sc_stat.pcpu_sched, cpu_of(rq));
> +	pcpu_sched = per_cpu_ptr(mm->sched_cache_grp->pcpu_sched, cpu_of(rq));
>  
>  	scoped_guard (raw_spinlock, &rq->cpu_epoch_lock) {
>  		__update_mm_sched(rq, pcpu_sched);
> @@ -1798,11 +1827,11 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
>  	 * If this process hasn't hit task_cache_work() for a while invalidate
>  	 * its preferred state.
>  	 */
> -	if ((long)(epoch - READ_ONCE(mm->sc_stat.epoch)) > llc_epoch_affinity_timeout ||
> +	if ((long)(epoch - READ_ONCE(mm->sched_cache_grp->epoch)) > llc_epoch_affinity_timeout ||
>  	    invalid_llc_nr(mm, p, cpu_of(rq)) ||
>  	    exceed_llc_capacity(mm, cpu_of(rq))) {
> -		if (READ_ONCE(mm->sc_stat.cpu) != -1)
> -			WRITE_ONCE(mm->sc_stat.cpu, -1);
> +		if (READ_ONCE(mm->sched_cache_grp->cpu) != -1)
> +			WRITE_ONCE(mm->sched_cache_grp->cpu, -1);
>  	}
>  
>  	mm_sched_llc = get_pref_llc(p, mm);

Perhaps it makes sense to have a local:

	struct sched_cache_group *scg = READ_ONCE(mm->sched_cache_grp);

because as is, the compiler is free to keep re-loading that. I mean,
dumb, but allowed. Also the local variable will shorten some of those
long expressions.


Somewhat applicable to the rest of the patch too, where it makes sense
and all that.
