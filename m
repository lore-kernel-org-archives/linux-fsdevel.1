Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9529B20A;
	Thu, 10 Sep 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080661; cv=none; b=qNJl6/83T3auLkBZqrvhkUG9UOtCRE+k5xyLit5n1I8DTKMLxFlI5h3NMQcFn0o1AjCXqPHE9QAuOcG0dIuBEPHbOJN0PxEQafVBeOpKzV/YVl+RVSGAS+lDTnrFBFo0oJ0vxYu5a3cReRNP7B51I2kAyA2jmT+B4v1dXoBW1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080661; c=relaxed/simple;
	bh=P7maDS07+h6HnjGuJWTSO8SdcPWU542f5xnMtj80oOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6qlq3B0s9TpWJBb3kOgXYff1eGhsHMQzfI6LpopIZU+38WHg01RnXehDIyLgk7Rr82lhFerjsGzawyKuzX7H2zYaT6ghnX9TGkqyedBGmbXa6k2jngHebn9PXP/896vQv6VxTb25GbEpwuL/llzB4gsNsUnPJay1D/38IvnoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtyCZD4l; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtyCZD4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789080658; x=1820616658;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=P7maDS07+h6HnjGuJWTSO8SdcPWU542f5xnMtj80oOY=;
  b=MtyCZD4lNwVbSXZFx2t0hh141jjWymE1B0gfPtb466VolgRbXFWrOs6F
   d0X/dzo6m+2/4BjXyiGWzQG3VnVqRuCkh+3tcsOr2uYb2Tg9A6+mN/o3Z
   Rsc9XyeDEP7G8vbzzpJCFJH46YopEKZYE2BLhDggaxierlJNHBn49+z4T
   WfNhgLGJhpf5Co27sspeddvvPxwGWdnN2i4NNHt9JknmNcKutADyzETHU
   DzdcuHjEeY/QsKKQqkOu+EiAzDEiTAEzlTpb3P53YgY/VFyU+Xh/GcAeZ
   Bdk5KX82M8N7ZCKhb+pZC7JHnywY5rajcc//L/5gBOVMEQwMBPx9QcVtp
   A==;
X-CSE-ConnectionGUID: kM/2BiolTDKa0eVonEdzdA==
X-CSE-MsgGUID: dw3/bij2TLKS8A7u5qTUrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89558419"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89558419"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:50:57 -0700
X-CSE-ConnectionGUID: q2AyFywVRruYetA+j99ZxA==
X-CSE-MsgGUID: F1zayvQTTme62BN39KwMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="275285741"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:50:57 -0700
Message-ID: <72bd9014ee83d5833bc1c78379ead84458045867.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] sched/cache: Introduce task_struct->sched_cache_grp
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt	 <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak	 <kprateek.nayak@amd.com>,
 Kees Cook <kees@kernel.org>, Christian Brauner	 <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara	 <jack@suse.cz>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Qais Yousef	
 <qyousef@layalina.io>, Aaron Lu <ziqianlu@bytedance.com>, Srikar Dronamraju
	 <srikar@linux.ibm.com>, Vineeth Remanan Pillai <vineethr@linux.ibm.com>, 
 Ricardo Neri-Calderon <ricardo.neri-calderon@linux.intel.com>, Chen Yu
 <yu.c.chen@intel.com>, Lu Wang <wanglu.priv@gmail.com>,  Hyunwoo Kim
 <imv4bel@gmail.com>, Zhan Xusheng <zhanxusheng@xiaomi.com>, Zhan Xusheng	
 <zhanxusheng1024@gmail.com>, Yi Lai <yi1.lai@intel.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Date: Thu, 10 Sep 2026 15:50:56 -0700
In-Reply-To: <20260910191901.GW776954@noisy.programming.kicks-ass.net>
References: <cover.1789061845.git.tim.c.chen@linux.intel.com>
	 <4532ec4fd5beb829bccb85822a19360fa4191fe6.1789061845.git.tim.c.chen@linux.intel.com>
	 <20260910191901.GW776954@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 21:19 +0200, Peter Zijlstra wrote:
> On Thu, Sep 10, 2026 at 10:46:12AM -0700, Tim Chen wrote:
>=20
> > Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>=20
> :-(
>=20
> > ---
> >  fs/exec.c                  |  14 ++++
> >  include/linux/sched.h      |   3 +
> >  kernel/exit.c              |  26 +++++--
> >  kernel/fork.c              |  23 ++++++
> >  kernel/sched/cache_sched.c |  19 +++++
> >  kernel/sched/fair.c        | 142 +++++++++++++++++++++----------------
> >  kernel/sched/sched.h       |   3 +
> >  7 files changed, 164 insertions(+), 66 deletions(-)
> >=20
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 745f6eb5279e..7a8a9954343e 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -882,6 +882,20 @@ static int exec_mmap(struct linux_binprm *bprm)
> >  	active_mm =3D tsk->active_mm;
> >  	tsk->active_mm =3D mm;
> >  	tsk->mm =3D mm;
> > +#ifdef CONFIG_SCHED_CACHE
> > +	{
> > +		struct sched_cache_group *old_grp, *new_grp;
> > +
> > +		old_grp =3D rcu_dereference_protected(tsk->sched_cache_grp, true);
> > +
> > +		/* Acquire the reference before publishing the pointer. */
> > +		new_grp =3D sched_cache_group_get(mm->sched_cache_grp);
> > +
> > +		rcu_assign_pointer(tsk->sched_cache_grp, new_grp);
> > +		if (old_grp)
> > +			sched_cache_group_put(old_grp);
> > +	}
> > +#endif
>=20
> Guys no! This is horrific crap. This is not how we do things and I would
> have expected you all to know this.
>=20
> Have you heard of this new fangled thing called a function?
>=20
> Imagine all of those being just:
>=20
> 	sched_cache_exec_mmap(tsk, mm);
>=20
>=20
> Also: rcu_dereference_protected(.c =3D true) is another offence, that's
> just wrong.
>=20
>=20
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 006edcc0c2c5..442535778ce1 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -552,23 +552,25 @@ void mm_update_next_owner(struct mm_struct *mm)
> >   * Subtract the memory footprint of the current task from
> >   * mm.
> >   */
> > -static void exit_mm_sched_cache(struct mm_struct *mm)
> > +static void exit_mm_sched_cache(void)
> >  {
> > +	struct sched_cache_group *grp =3D
> > +		rcu_dereference_protected(current->sched_cache_grp, true);
> >  	unsigned long fp, sub;
> > =20
> > -	if (!current->total_numa_faults)
> > +	if (!grp || !current->total_numa_faults)
> >  		return;
> >  	/*
> >  	 * No lock protection due to performance considerations.
> >  	 * Make sure the group footprint does not become
> >  	 * negative.
> >  	 */
> > -	fp =3D READ_ONCE(mm->sched_cache_grp->footprint);
> > +	fp =3D READ_ONCE(grp->footprint);
> >  	sub =3D min(fp, current->total_numa_faults);
> > -	WRITE_ONCE(mm->sched_cache_grp->footprint, fp - sub);
> > +	WRITE_ONCE(grp->footprint, fp - sub);
> >  }
> >  #else
> > -static inline void exit_mm_sched_cache(struct mm_struct *mm)
> > +static inline void exit_mm_sched_cache(void)
> >  {
> >  }
> >  #endif /* CONFIG_SCHED_CACHE CONFIG_NUMA_BALANCING */
> > @@ -585,7 +587,19 @@ static void exit_mm(void)
> >  	if (!mm)
> >  		return;
> > =20
> > -	exit_mm_sched_cache(mm);
> > +	exit_mm_sched_cache();
> > +
> > +#ifdef CONFIG_SCHED_CACHE
> > +	{
> > +		struct sched_cache_group *grp =3D
> > +			rcu_dereference_protected(current->sched_cache_grp, true);
> > +
> > +		rcu_assign_pointer(current->sched_cache_grp, NULL);
> > +
> > +		if (grp)
> > +			sched_cache_group_put(grp);
> > +	}
> > +#endif
>=20
> Seriously, WTF ?!
>=20
> > =20
> >  	mmap_read_lock(mm);
> >  	mmgrab_lazy_tlb(mm);
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 416758c8a3d4..2e79548cb7c1 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1599,6 +1599,19 @@ static int copy_mm(u64 clone_flags, struct task_=
struct *tsk)
> > =20
> >  	tsk->mm =3D mm;
> >  	tsk->active_mm =3D mm;
> > +#ifdef CONFIG_SCHED_CACHE
> > +	{
> > +		/*
> > +		 * A task holds its own reference on the group, separate from
> > +		 * the reference held by its mm_struct. Acquire it before
> > +		 * publishing the pointer.
> > +		 */
> > +		struct sched_cache_group *grp =3D
> > +			sched_cache_group_get(mm->sched_cache_grp);
> > +
> > +		rcu_assign_pointer(tsk->sched_cache_grp, grp);
> > +	}
> > +#endif
>=20
> And again.
>=20
> >  	return 0;
> >  }
> > =20
> > @@ -2599,6 +2612,16 @@ __latent_entropy struct task_struct *copy_proces=
s(
> >  bad_fork_cleanup_namespaces:
> >  	exit_nsproxy_namespaces(p);
> >  bad_fork_cleanup_mm:
> > +#ifdef CONFIG_SCHED_CACHE
> > +	/*
> > +	 * copy_mm() took a task reference on the cache group; a failed fork
> > +	 * never reaches exit_mm(), so release it here to avoid leaking the
> > +	 * group and its per-CPU buffer.
> > +	 */
> > +	sched_cache_group_put(rcu_dereference_protected(p->sched_cache_grp, t=
rue));
> > +	RCU_INIT_POINTER(p->sched_cache_grp, NULL);
> > +#endif
> > +
> >  	if (p->mm) {
> >  		mm_clear_owner(p->mm, p);
> >  		mmput(p->mm);
>=20
> Drugs, it must be drugs and lots of it :-(
>=20
>=20

Sorry for the warts in this version.  Will clean it up and send
an update.

Tim
