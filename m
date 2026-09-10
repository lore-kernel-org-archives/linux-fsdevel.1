Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384445947FE;
	Thu, 10 Sep 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067978; cv=none; b=PjNkRpIi2kDfVHNRKtZCI70bDGoI9wUDk0j3JeccfvEKQN1JoEuPQrwSPagRwkgWact+V4FJ6euTHyeHMOKCrs9SfLjeEQP4qhVeVph+S01pnMXiiADFVK9ziZcaQdZUPivJr6oVDgkm9vakfEH8gCNL83rwnhnkAm3R6PggJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067978; c=relaxed/simple;
	bh=mMSamL8Xto4hyhBrhUMnOSbYDmMBmzWWTor8bGkbNRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6+k3RCwxd4EeJh/4RUo7HJMXlMyWGLY+2apoE0IrdQUGL8zsBlzKgRmLHeXfJIRWC3eVTCSd4kk8iN7O3DGCJ051r0RmHT3qUI6vvXKjDimZ9q+XgwGUjLx8w7BvGQprLOrROI3qNjpe3s7ZuEmST2665tp+7DOu9P3BQsapUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X7SvXni/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7SvXni/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bmUNJy9Nu15CoZ6GTfg+GAxUmN7j/4iTaUecL7MID4k=; b=X7SvXni/u0xxFB0IacibI2DHCs
	oXnWz3V7P/2pYqWQxeub+dUiL1tINFXXo60Dv+yxGulYp5Tw+nLeXXimaPsWXycIwogYL34d+tMGG
	UeyKKr70Q+8bMaQj5hdYpEv4sFreUlZ9ZaAaMYed8U94AhHgrPF6nuauwtC5bKZkI2A/ikm107+tc
	ieDZqOP1uxoL+NLV1uawS+Dh7iP8zL+5Jke1e3PKF9x6Nr7co7ceFIHCoXc+i/MO6bS5AdNL8Ul3G
	8Ciu+poVr9WZ2gUrtrrDe5dqZNXs2VvXm10eIfZVCmAs5bn+Pa3vQcIuqOfOtaGJEN9qsLiRUTOoO
	gGu/kxXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4kId-00000003AJn-0nh1;
	Thu, 10 Sep 2026 19:19:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D8A06300400; Thu, 10 Sep 2026 21:19:01 +0200 (CEST)
Date: Thu, 10 Sep 2026 21:19:01 +0200
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
Subject: Re: [PATCH 4/4] sched/cache: Introduce task_struct->sched_cache_grp
Message-ID: <20260910191901.GW776954@noisy.programming.kicks-ass.net>
References: <cover.1789061845.git.tim.c.chen@linux.intel.com>
 <4532ec4fd5beb829bccb85822a19360fa4191fe6.1789061845.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4532ec4fd5beb829bccb85822a19360fa4191fe6.1789061845.git.tim.c.chen@linux.intel.com>

On Thu, Sep 10, 2026 at 10:46:12AM -0700, Tim Chen wrote:

> Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

:-(

> ---
>  fs/exec.c                  |  14 ++++
>  include/linux/sched.h      |   3 +
>  kernel/exit.c              |  26 +++++--
>  kernel/fork.c              |  23 ++++++
>  kernel/sched/cache_sched.c |  19 +++++
>  kernel/sched/fair.c        | 142 +++++++++++++++++++++----------------
>  kernel/sched/sched.h       |   3 +
>  7 files changed, 164 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e..7a8a9954343e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -882,6 +882,20 @@ static int exec_mmap(struct linux_binprm *bprm)
>  	active_mm = tsk->active_mm;
>  	tsk->active_mm = mm;
>  	tsk->mm = mm;
> +#ifdef CONFIG_SCHED_CACHE
> +	{
> +		struct sched_cache_group *old_grp, *new_grp;
> +
> +		old_grp = rcu_dereference_protected(tsk->sched_cache_grp, true);
> +
> +		/* Acquire the reference before publishing the pointer. */
> +		new_grp = sched_cache_group_get(mm->sched_cache_grp);
> +
> +		rcu_assign_pointer(tsk->sched_cache_grp, new_grp);
> +		if (old_grp)
> +			sched_cache_group_put(old_grp);
> +	}
> +#endif

Guys no! This is horrific crap. This is not how we do things and I would
have expected you all to know this.

Have you heard of this new fangled thing called a function?

Imagine all of those being just:

	sched_cache_exec_mmap(tsk, mm);


Also: rcu_dereference_protected(.c = true) is another offence, that's
just wrong.


> diff --git a/kernel/exit.c b/kernel/exit.c
> index 006edcc0c2c5..442535778ce1 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -552,23 +552,25 @@ void mm_update_next_owner(struct mm_struct *mm)
>   * Subtract the memory footprint of the current task from
>   * mm.
>   */
> -static void exit_mm_sched_cache(struct mm_struct *mm)
> +static void exit_mm_sched_cache(void)
>  {
> +	struct sched_cache_group *grp =
> +		rcu_dereference_protected(current->sched_cache_grp, true);
>  	unsigned long fp, sub;
>  
> -	if (!current->total_numa_faults)
> +	if (!grp || !current->total_numa_faults)
>  		return;
>  	/*
>  	 * No lock protection due to performance considerations.
>  	 * Make sure the group footprint does not become
>  	 * negative.
>  	 */
> -	fp = READ_ONCE(mm->sched_cache_grp->footprint);
> +	fp = READ_ONCE(grp->footprint);
>  	sub = min(fp, current->total_numa_faults);
> -	WRITE_ONCE(mm->sched_cache_grp->footprint, fp - sub);
> +	WRITE_ONCE(grp->footprint, fp - sub);
>  }
>  #else
> -static inline void exit_mm_sched_cache(struct mm_struct *mm)
> +static inline void exit_mm_sched_cache(void)
>  {
>  }
>  #endif /* CONFIG_SCHED_CACHE CONFIG_NUMA_BALANCING */
> @@ -585,7 +587,19 @@ static void exit_mm(void)
>  	if (!mm)
>  		return;
>  
> -	exit_mm_sched_cache(mm);
> +	exit_mm_sched_cache();
> +
> +#ifdef CONFIG_SCHED_CACHE
> +	{
> +		struct sched_cache_group *grp =
> +			rcu_dereference_protected(current->sched_cache_grp, true);
> +
> +		rcu_assign_pointer(current->sched_cache_grp, NULL);
> +
> +		if (grp)
> +			sched_cache_group_put(grp);
> +	}
> +#endif

Seriously, WTF ?!

>  
>  	mmap_read_lock(mm);
>  	mmgrab_lazy_tlb(mm);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 416758c8a3d4..2e79548cb7c1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1599,6 +1599,19 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
>  
>  	tsk->mm = mm;
>  	tsk->active_mm = mm;
> +#ifdef CONFIG_SCHED_CACHE
> +	{
> +		/*
> +		 * A task holds its own reference on the group, separate from
> +		 * the reference held by its mm_struct. Acquire it before
> +		 * publishing the pointer.
> +		 */
> +		struct sched_cache_group *grp =
> +			sched_cache_group_get(mm->sched_cache_grp);
> +
> +		rcu_assign_pointer(tsk->sched_cache_grp, grp);
> +	}
> +#endif

And again.

>  	return 0;
>  }
>  
> @@ -2599,6 +2612,16 @@ __latent_entropy struct task_struct *copy_process(
>  bad_fork_cleanup_namespaces:
>  	exit_nsproxy_namespaces(p);
>  bad_fork_cleanup_mm:
> +#ifdef CONFIG_SCHED_CACHE
> +	/*
> +	 * copy_mm() took a task reference on the cache group; a failed fork
> +	 * never reaches exit_mm(), so release it here to avoid leaking the
> +	 * group and its per-CPU buffer.
> +	 */
> +	sched_cache_group_put(rcu_dereference_protected(p->sched_cache_grp, true));
> +	RCU_INIT_POINTER(p->sched_cache_grp, NULL);
> +#endif
> +
>  	if (p->mm) {
>  		mm_clear_owner(p->mm, p);
>  		mmput(p->mm);

Drugs, it must be drugs and lots of it :-(

Please, try again.
