Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B337EFF1;
	Wed, 16 Sep 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563780; cv=none; b=hkCr3YtHYfRdSDqs0OydK4bj+YCFU5px2M7lVToM/ZjBMz5tOanYS9laOFZLBuEGQ+ENkV69qlPvcC8pkkGI/2c9bIwf/SDEP0sCAiIQUz1+2CIeR2KCxEpUxAqq5Zj9tIvdUCnjfV+Vehfob6QR+jXHI2OTpWPFIBiiRotgr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563780; c=relaxed/simple;
	bh=Dg6XjoTti4BW7q8X8VJWSfaXqAoeaS1PnmT6DxOiryI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpgoX/jCB29s3xVjaYTw7owHJ5qBRdX+ISwKiuUtop1mJ9v7tcr52ygN/UsjtXGQ904oYYINWhAE5KZXItWbkJHe0wFM0OABkhwYS4wHPXwt2qyCeJVMttqZ1fLkG3fI5XALKlQ2J4sAblH46qwfrCDxmwJxuDPSj1bpObnodak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YtFeZrsn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YtFeZrsn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bywUojkkDxv7YhCqZv+tPm5XeEwqdNL7YKjmi3qlnMo=; b=YtFeZrsnU+A7BU1JaX4MyXUmv0
	Afu3u0xlzKl09/oYqpikzQAlV95NIXZVXjc0zFmWkjmIgY73Q37I8wvWN0GbTkXOjuuNQ2PjHAp/o
	TSIp1/ZpiG+WTquDJjQCFQZ9TDty73m7pQijpYxw//tytzQqs7rqvrs5BOInr+ho68tZOsra2OE+u
	RzQpdzqBLqC7ZkvTRIdt9tWetnBoa4CFxkc2J1jtvmvyR/STiXUfZa0cAxDtDcO254OOsE+Piectw
	zYpreQeVIdF4Vsz4cACf3CfOOuR6eTqOBfgKt+GqYfiTbsDnLcMtQt6vKWnoMso93wLRnPkfh5A7S
	2mfphi+g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6pHY-00000004VjY-1lcM;
	Wed, 16 Sep 2026 13:02:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F144A300328; Wed, 16 Sep 2026 15:02:35 +0200 (CEST)
Date: Wed, 16 Sep 2026 15:02:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
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
	Lu Wang <wanglu.priv@gmail.com>, Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched/cache: Introduce task_struct->sched_cache_grp
Message-ID: <20260916130235.GG776954@noisy.programming.kicks-ass.net>
References: <cover.1789061845.git.tim.c.chen@linux.intel.com>
 <4532ec4fd5beb829bccb85822a19360fa4191fe6.1789061845.git.tim.c.chen@linux.intel.com>
 <20260910191901.GW776954@noisy.programming.kicks-ass.net>
 <72bd9014ee83d5833bc1c78379ead84458045867.camel@linux.intel.com>
 <aqgF7JHKxQaE0W4b@chenyu-dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqgF7JHKxQaE0W4b@chenyu-dev>

On Mon, Sep 14, 2026 at 10:34:20PM +0800, Chen Yu wrote:
> On Thu, Sep 10, 2026 at 03:50:56PM -0700, Tim Chen wrote:
> > On Thu, 2026-09-10 at 21:19 +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 10, 2026 at 10:46:12AM -0700, Tim Chen wrote:
> > > > @@ -882,6 +882,20 @@ static int exec_mmap(struct linux_binprm *bprm)
> > > > +
> > > > +		old_grp = rcu_dereference_protected(tsk->sched_cache_grp, true);
> > > > +
> > > 
> > > Also: rcu_dereference_protected(.c = true) is another offence, that's
> > > just wrong.
> 
> Got it, will fix it.
> If I understand correctly, the "c" should never pass an explicit const value?

Right, that is a bit of an anti-pattern. The 'c' thing is there to
validate your claim of this in fact being an update side, eg. you
holding the write lock and all that.

> The original idea was that, in exec_mmap(), the current running task is the only
> writer to change tsk->sched_cache_grp, so the condition is true,
> 
> To fix it, it might be turned into the following for now:
> rcu_dereference_protected(tsk->sched_cache_grp, tsk == current);
> like deref_curr_numa_group().
> 
> In the future if task tagging is supported, the race condition of multiple
> updates would require a pi_lock for this task, and it will become:
> rcu_dereference_protected(tsk->sched_cache_grp, lockdep_is_held(&p->pi_lock));
> like what we have done in the prctl based cache aware scheduling patch set:
> https://lore.kernel.org/lkml/50fe2db1a62ea2376a87d0c14778b1ff456d11ec.1787955777.git.tim.c.chen@linux.intel.com/

Right, it might also make sense to have a helper, like:

#define rcu_deref_sched_cache_grp(tsk) \
	rcu_dereference_protected((tsk)->sched_cache_grp, (tsk) == current)

such that you don't have to keep repeating this thing over and over.
Also consider if rcu_dereference_protected() makes sense, I tend to
unconditionally use rcu_dereference_*check().

The only architecture where it really makes a difference is Alpha, and
nobody cares about that anymore.
