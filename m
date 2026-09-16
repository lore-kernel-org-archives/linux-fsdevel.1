Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843753644A4;
	Wed, 16 Sep 2026 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561877; cv=none; b=Y6N/hs4gB68Gu3Aa8rMTHTH5QvcbkQTEC+Oc4INjYwMBKhh7Nb2+DhVZb2QpXNeA0nq5Y9ShzFNw5/8UKK85/jbO9SWgEUkkaecgr9jiApQDhg6YvApEBHx6Tnc/wO6Df3iHB9dtmqbZm9dHifqL85JFyVzF8ecCSrD0pURanHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561877; c=relaxed/simple;
	bh=/qrxq3UEvVgIbvS70OOLFCeDBe9AYs/mMVxu4zKMSSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCLfTtUcjz5A8T6DQDBwGIlbD+jqU8jUgy+e5CkBzsvSMiHQKsAlWppmPWcsvG10p4qf5cReq1bibkQ7oM1Itj0O+oUmn4uQCCrYY0vGIsWMBSolmTJ5993Azp0zylURTP7TRdFS8PHAmEvL3HtlF3TlUNGhjVDtnXsUs6T0Q0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e3922R9P; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3922R9P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+CZTXTXBpkYDLkHM3H81KdkEWF4+imO91qZpPhQs9rg=; b=e3922R9Pa3dJE7oen76mKNw5N9
	VvvvvkZYZHayIVSaAf2fw5Y85QIsPxqoxncNxhYKbbYc/gBmOrkfvy94nCoOB3K07i9LOTw4imPzu
	GQharzpSZp8Z+zqgJcb0faYKZRQwYFUEoqS/8F89QlYzkIzciXbP1wI2X8VPmISOKl1lMN11dNi/c
	bxFi4JcEU03WNANXH6GLhcuY0tQLqM9P4HrIZuEh9kE99hGKVfBHX8qcXC93g2ArUQ2CiszmqYYqw
	a6XWwn6v/9F0F3Ggw4SKBTheZzdKObS5mCEEBg7Ia3vSVpAozwjCPPfnYDtBG0xqtGTXZRyQGubsh
	2oIcEM2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6omm-00000007qXL-1y4b;
	Wed, 16 Sep 2026 12:30:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CB3503012C6; Wed, 16 Sep 2026 14:30:46 +0200 (CEST)
Date: Wed, 16 Sep 2026 14:30:46 +0200
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
Subject: Re: [PATCH 1/4] sched/cache: Keep nr_pref_llc_running in the
 runnable domain
Message-ID: <20260916123046.GE776954@noisy.programming.kicks-ass.net>
References: <cover.1789061845.git.tim.c.chen@linux.intel.com>
 <82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>

On Thu, Sep 10, 2026 at 10:46:09AM -0700, Tim Chen wrote:
> alb_break_llc() decides whether to break LLC preference during active
> load balance. It does so by testing that every runnable fair task on the
> source rq prefers its LLC:
> 
> 	env->src_rq->nr_pref_llc_running == env->src_rq->cfs.h_nr_runnable
> 
> But the two counters cover different sets. nr_pref_llc_running is updated
> in account_llc_enqueue()/account_llc_dequeue(), next to cfs_rq->nr_queued,
> so it follows queued tasks. h_nr_runnable is updated in set_delayed()/
> clear_delayed() and drops delay-dequeued tasks.
> 
> So under DELAY_DEQUEUE, a preferring task that goes to sleep stays counted
> in nr_pref_llc_running while h_nr_runnable falls. The equality then breaks,
> alb_break_llc() returns false, and active balance is free to pull a task
> off its preferred LLC. Active balance only moves runnable tasks, and this
> is the only LLC check it consults: once the stopper runs, LBF_ACTIVE_LB
> skips the per-task test in can_migrate_task(). The runnable set is the one
> we want.
> 
> Fix it on the counter side. A task should be counted in
> nr_pref_llc_running exactly while it is both queued on its preferred LLC
> (pref_llc_queued) and runnable (!sched_delayed). Define that membership
> once in task_pref_llc_runnable(), and adjust the counter only through
> pref_llc_running_inc()/pref_llc_running_dec() from the four sites that
> change either input: account_llc_enqueue(), account_llc_dequeue(),
> set_delayed() and clear_delayed(). Gating every update on the same
> predicate keeps the delay, wake and dequeue paths from double-counting
> or underflowing; see the comments at those sites for the ordering.
> 
> nr_llc_running and sd->llc_counts are not touched and stay on queued
> semantics.

Needs a fixes tag.

> Reported-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Closes: https://lore.kernel.org/lkml/20260827135000.735138-1-zhanxusheng@xiaomi.com/
> Suggested-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---

> @@ -6395,6 +6428,14 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  
>  static void set_delayed(struct sched_entity *se)
>  {
> +	/*
> +	 * Drop a task leaving the runnable set. Must run before sched_delayed
> +	 * is set, or task_pref_llc_runnable() would already exclude it;
> +	 * clear_delayed() mirrors this after clearing the flag.
> +	 */
> +	if (entity_is_task(se))
> +		pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
> +
>  	se->sched_delayed = 1;
>  
>  	/*

With flat pick stuff only task can get delayed. Now, I think we merged
the cache aware stuff last cycle, so it we backport this (see that Fixes
thing) then this must stay. But then also please make a note to take out
this condition again later.
