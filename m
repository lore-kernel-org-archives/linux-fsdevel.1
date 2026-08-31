Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466AB3B14C0;
	Mon, 31 Aug 2026 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214256; cv=none; b=MRVSxka0ymcvaqb1cC/3feRXH9QRTLfbiXsCMokMii34sx/ZtKuOeWmIZwB2sPRaSD2fdYcZFehBtFyJLlr4BljoRM7IWI4Qlx+70xIcusSU82cZuCx/pODR8lG2BWnvj6H/c+XF6j/8sngreXPNGLKq4WU2xABKJDgmNGagzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214256; c=relaxed/simple;
	bh=74uWWSroKtUahBYD0O1rtruEN1eXOPLWBDX0MXkOELo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZvH1BmjN4JzOp+VZVbTJJ2RAqfctvxsSL5jmO+8nzCFVXEOlY5c+2mPu03gwg/UjznrmtA3X+InzrMlGlg3ETyuMLxmCTns2bb48x1yQlIE0cZCMzBuPUgcX3wEwQHKRm3dRJheVD3Lj3rE/W91qbrm+h8fglIC4DF9pWqy7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULZXCIg4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULZXCIg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788214245; x=1819750245;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=74uWWSroKtUahBYD0O1rtruEN1eXOPLWBDX0MXkOELo=;
  b=ULZXCIg4vli+YwfKZvNMpjYeYgWST9ge9NlmXUNKMiDdq2noFNv6E3sW
   3R/mIjFBiKK97CWywgRPBRmiVwuW/ENKluotIX+g9l42cITria5XAUV1f
   aMoyHEd1ETrh1WoGbYax0e4/3lsMCb+orQgQqmuhbCj3Ph1s8BTOsKZ7p
   b11s45ylnKmfhu2xbI9AdQVl1OPDsFQEwXhFKxF5rrI+53TSh1iAXgxO1
   iEemSLbt+UbQE2wfEQ/WDHNx7eWevlMn+sc6HUdyHCEevrqPFhjpdmUGD
   8MZGO3sO0Uj6/OsloMyhIqSZIV83wO6/8ApvdcrU4rvsW4MDLt8ttqVRM
   w==;
X-CSE-ConnectionGUID: UAuvuKc8QFGYbG2jLUiVxw==
X-CSE-MsgGUID: ZzD3CRRWT1K7JJOLupMnYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88655867"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88655867"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 15:10:42 -0700
X-CSE-ConnectionGUID: oOmRa3boQGqtiDT+CE1A1Q==
X-CSE-MsgGUID: o0d0SNirTICSHrrEFg7Vog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="264622730"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 15:10:40 -0700
Message-ID: <db2436d91e2e04a8a1063553ce64acc74b533f5c.camel@linux.intel.com>
Subject: Re: [PATCH] sched/cache: Fix use-after-free of the mm replaced by
 exec
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, Kees Cook <kees@kernel.org>, 
 Christian Brauner	 <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara	 <jack@suse.cz>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot	 <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Shrikanth Hegde	 <sshegde@linux.ibm.com>,
 Qais Yousef <qyousef@layalina.io>, Aaron Lu	 <ziqianlu@bytedance.com>,
 Srikar Dronamraju <srikar@linux.ibm.com>, Vineeth Remanan Pillai
 <vineethr@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra	 <peterz@infradead.org>, "chen.yu@linux.dev" <chen.yu@linux.dev>
Date: Mon, 31 Aug 2026 15:10:40 -0700
In-Reply-To: <apX1ufR1reYZ9LBc@v4bel>
References: <apPb-Dr4nPYuHQOK@v4bel>
	 <825d9dcc-b052-4367-a9c7-15efc4b354f8@intel.com> <apXV6t-7drLDf-lL@v4bel>
	 <a1a0bc24108e68656041dc17824d6b88b4120058.camel@linux.intel.com>
	 <apX1ufR1reYZ9LBc@v4bel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 06:44 +0900, Hyunwoo Kim wrote:
> On Mon, Aug 31, 2026 at 01:25:06PM -0700, Tim Chen wrote:
> > On Tue, 2026-09-01 at 04:28 +0900, Hyunwoo Kim wrote:
> > > On Mon, Aug 31, 2026 at 12:22:45PM +0800, Chen, Yu C wrote:
> > > > Hi Hyunwoo,
> > > >=20
> > > > On 8/30/2026 3:30 PM, Hyunwoo Kim wrote:
> > > > > When the waker cannot use the wakelist, ttwu_queue() takes the ta=
rget rq
> > > > > lock and goes down into update_curr(). If the target rq belongs t=
o another
> > > > > CPU, the task handed to account_mm_sched() is the one running on =
that CPU,
> > > > > not the task being woken.
> > > > >=20
> > > > > account_mm_sched() reads p->mm and updates mm->sc_stat. Nothing k=
eeps that
> > > > > mm alive. The rq lock and rq->cpu_epoch_lock it holds have nothin=
g to do
> > > > > with the lifetime of the mm.
> > > > >=20
> > > > > If that task happens to be in execve(), exec_mmap() points tsk->m=
m and
> > > > > tsk->active_mm at the new mm, and exec_mm_put_old() from setup_ne=
w_exec()
> > > > > drops the old one. free_bprm() does the same when exec fails. On =
the way
> > > > > from mmput() down to __mmdrop(), mm_destroy_sched() calls free_pe=
rcpu() on
> > > > > sc_stat.pcpu_sched and free_mm() returns the mm_struct.
> > > > >=20
> > > > > Whoever already read the old pointer keeps using it. It adds to r=
untime in
> > > > > the freed per-cpu area and reads sc_stat in the freed mm_struct. =
Depending
> > > > > on the condition it also writes sc_stat.cpu. That is a use-after-=
free.
> > > > >=20
> > > > > Commit 9f23469401b0 ("sched/cache: Fix potential NULL mm pointer =
access")
> > > > > changed the remaining p->mm dereference to the local variable, an=
d said the
> > > > > active_mm reference keeps the structure allocated. That holds for=
 the other
> > > > > paths that detach an mm, since they take an mmgrab_lazy_tlb() ref=
erence.
> > > > > exec reassigns active_mm to the new mm as well, so that reference=
 is gone.
> > > > > What is left is the mm_users reference in bprm->old_mm, and dropp=
ing it is
> > > > > the free.
> > > > >=20
> > > > >               CPU0                                CPU1
> > > > >=20
> > > > >                                        write(pipe)
> > > > >                                        try_to_wake_up()
> > > > >                                          ttwu_queue()      // tak=
es rq0 lock
> > > > >                                            enqueue_task_fair()
> > > > >                                              update_curr()
> > > > >                                                update_se()
> > > > >                                                  account_mm_sched=
()
> > > > >                                                    mm =3D rq0->cu=
rr->mm
> > > > >                                                          // old m=
m
> > > > >    execve()
> > > > >      exec_mmap()                       // tsk->mm =3D new mm
> > > > >      setup_new_exec()
> > > > >        exec_mm_put_old()
> > > > >          mmput() -> ... -> __mmdrop()
> > > > >            mm_destroy_sched()          // free_percpu()
> > > > >            free_mm()
> > > > >                                                    read mm->sc_st=
at.epoch
> > > > >                                                          // use-a=
fter-free
> > > > >=20
> > > >=20
> > > > Ah, thanks for catching this.
> > > >=20
> > > > > ---
> > > > >   fs/exec.c             |  1 +
> > > > >   include/linux/sched.h |  4 ++++
> > > > >   kernel/events/core.c  |  2 ++
> > > > >   kernel/sched/fair.c   | 16 ++++++++++++++++
> > > > >   4 files changed, 23 insertions(+)
> > > > >=20
> > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > index 745f6eb5279e6..6194c38807980 100644
> > > > > --- a/fs/exec.c
> > > > > +++ b/fs/exec.c
> > > > > @@ -916,6 +916,7 @@ static void exec_mm_put_old(struct mm_struct =
*old_mm)
> > > > >   {
> > > > >   	setmax_mm_hiwater_rss(&current->signal->maxrss, old_mm);
> > > > >   	mm_update_next_owner(old_mm);
> > > > > +	sched_cache_exec_done();
> > > > >   	mmput(old_mm);
> > > > >   }
> > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > index 8b3d47a325cca..6ae31bffe049e 100644
> > > > > --- a/include/linux/sched.h
> > > > > +++ b/include/linux/sched.h
> > > > > @@ -2415,10 +2415,14 @@ struct sched_cache_stat {
> > > > >   	int cpu;
> > > > >   } ____cacheline_aligned_in_smp;
> > > > > +void sched_cache_exec_done(void);
> > > > > +
> > > > >   #else
> > > > >   struct sched_cache_stat { };
> > > > > +static inline void sched_cache_exec_done(void) { }
> > > > > +
> > > > >   #endif
> > > > >   #ifndef MODULE
> > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > index a6c8e38a31104..2f29cbccf03f1 100644
> > > > > --- a/kernel/events/core.c
> > > > > +++ b/kernel/events/core.c
> > > > > @@ -5427,6 +5427,8 @@ attach_task_ctx_data(struct task_struct *ta=
sk, struct kmem_cache *ctx_cache,
> > > > >   	if (!cd)
> > > > >   		return -ENOMEM;
> > > > > +	/* @old, loaded by the try_cmpxchg() below, is only stable unde=
r RCU. */
> > > > > +	guard(rcu)();
> > > >=20
> > > > Is this change related to this UAF issue?
> > >=20
> > > Duh.. that one is unrelated. My mistake.
> > >=20
> > > >=20
> > > > > +/* exec() has switched to the new mm and is about to drop the ol=
d one. */
> > > > > +void sched_cache_exec_done(void)
> > > > > +{
> > > > > +	struct rq_flags rf;
> > > > > +	struct rq *rq;
> > > > > +
> > > > > +	/*
> > > > > +	 * account_mm_sched() dereferences rq->curr->mm under this rq's=
 lock,
> > > > > +	 * so a remote CPU can still be using the old mm. The lock cycl=
e waits
> > > > > +	 * for it, and the store to tsk->mm cannot be reordered past th=
e
> > > > > +	 * release, so later acquirers see the new mm.
> > > > > +	 */
> > > > > +	rq =3D this_rq_lock_irq(&rf);
> > > >=20
> > > > A smart fix, learnt! It behaves like a synchronize_rcu() to protect=
 against
> > > > the read in account_mm_sched(). Small open: since the context of in=
voking
> > > > account_mm_sched() is preemption-disabled, I wonder if we can simpl=
y use
> > > > synchronize_rcu() directly instead of this_rq_lock_irq() - just to =
avoid
> > > > contention for rq-lock in heavy system?
> >=20
> > Thanks to Kyunwoo to show this potential use-after-free problem.
>=20
> It is a real, triggerable issue.
>=20

Appreciate if you can check whether the first 2 patches in=20
https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.intel.co=
m/
fixes this issue.

> >=20
> > While synchronize_rcu() avoids rq lock, it could introduce a long delay
> > of a full grace period that will be undesirable.
> >=20
> >=20
> > I think a better fix is to decouple sc_stat from mm and make it its own=
 structure.
> > Then we can do proper refcounting and rcu management on sc_stat itself.
> > We will let task points to sc_stat with proper ref count and change the=
 access
> > as task->sc_stat directly nstead of via task->mm->sc_stat.
> >=20
> > Then we will know sc_stat exists in account_mm_sched() execution
> > as long as a task points to it and do not have to worry that sc_stat is
> > released due to the mm life cycle.
> >=20
> > In the first 2 patches of the prctl control series for cache aware sche=
duling
> > we posted, we introduced the change I described above and should=C2=A0
> > fix this issue without additional rq locking or synchronize_rcu() overh=
ead.
> >  https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.int=
el.com/
> >=20
> > We should probably prioritize to merge the first couple of patches from
> > that series now in light of this issue.  It will make maintenance and f=
uture
> > modification of the cache aware scheduling code easier.
>=20
> That is a fairly large change.=20

However adding rcu synchronization will slow down the launch of a new proce=
ss
too much.  The rq lock solution has less latency in my opinion.  But I
think decoupling sc_stat is the best solution without adding latency in the
exec path.

Wonder what is Peter's opinion?

>=20
> If you add a Reported-by: tag for this UAF to the patch, I am fine with=
=20
> handling it that way.

I'll be happy to do that. If you let us know if those two patches from prct=
l series fixes
the bug you found in KASAN log, I can also add a Tested-by tag in addition =
to Reported-by.

Thanks.

Tim

>=20
>=20
> Best regards,
> Hyunwoo Kim
