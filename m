Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD65D288505;
	Tue,  1 Sep 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295772; cv=none; b=Wjk/AJvjwKHqKnKJLzPW7BpASZVGadZQq/IT5fzlQ9X+tGfj4rBwoSIZQLhcFRCOVpf3ODSD3aJmzy6+dSKOmJ5u3HjJXqnVaGsAbqLIYnZrnkCbaX+/yR9EeJLJ2sIKhRvFA8VVqET9I0sIruF3gTGHbCiTZcswik5kfNLSdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295772; c=relaxed/simple;
	bh=b1lfp27dRUw6lA2IESdgIZCHySDmes3STZlmXmvTcf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayqGyqJEybgYaRaX4ZJUlicC87Ow95Vyi+I0HO6aqRKQteoDgBvTaGVEWYwc0ZuEcy7qMxk6c34knjAE43J1l9j+zWSpom+4G0G+jfJ7tm43V+dBwWpmnFIC4bl4XcKcjp7qmibjQWz6Ypwf6BKRGKxmqIdvvG+FyQ9xiFfaB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrJRF9fD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrJRF9fD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788295771; x=1819831771;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=b1lfp27dRUw6lA2IESdgIZCHySDmes3STZlmXmvTcf0=;
  b=lrJRF9fDovIMTyYV0cZxxKSXVRjm7sBp6C/ZYbAOpBo6QymSZdSmjQ1Y
   FUXv/Wng25+4yrp0v8vL1ksxJB8iW4xrPAE1f2FJroi9xxPt3mt7NTgwR
   I3LZX0tmSpC4iALMrhK14hHodxbrufhXKFs8KSibUgtULp0X5zKVF7KI1
   CoSYY8PbtHKZViTOf3k9gzePBXiTGi7DHl0GFpFBzm2hrTrJtSpODoDyR
   KpRpfbwAj40w2r8jjbsMyaVST3Eqn/srQNpwl+aE2+0GEgeoJkNBt1/k1
   LfCi9Fi/qTm07erwwBRkjx2opmG9t1/INBKJ18prQsW4nGHvGkxeECtmS
   g==;
X-CSE-ConnectionGUID: r+6A53tvSoSd1qdBaSaIAg==
X-CSE-MsgGUID: XEdYkocWS3CehOq+uzjeyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92612548"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="92612548"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 13:49:30 -0700
X-CSE-ConnectionGUID: NhaGJ78DRnCyx+pDWKNomQ==
X-CSE-MsgGUID: UiHCEyvRSAyIavxS4UlTLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267435304"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 13:49:30 -0700
Message-ID: <17afb1540240d267023aba1706bd7659d1a50197.camel@linux.intel.com>
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
Date: Tue, 01 Sep 2026 13:49:29 -0700
In-Reply-To: <apasjygjnsg1n6em@v4bel>
References: <apPb-Dr4nPYuHQOK@v4bel>
	 <825d9dcc-b052-4367-a9c7-15efc4b354f8@intel.com> <apXV6t-7drLDf-lL@v4bel>
	 <a1a0bc24108e68656041dc17824d6b88b4120058.camel@linux.intel.com>
	 <apX1ufR1reYZ9LBc@v4bel>
	 <db2436d91e2e04a8a1063553ce64acc74b533f5c.camel@linux.intel.com>
	 <apasjygjnsg1n6em@v4bel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 19:44 +0900, Hyunwoo Kim wrote:
> On Mon, Aug 31, 2026 at 03:10:40PM -0700, Tim Chen wrote:
> > On Tue, 2026-09-01 at 06:44 +0900, Hyunwoo Kim wrote:
> > > On Mon, Aug 31, 2026 at 01:25:06PM -0700, Tim Chen wrote:
> > > > On Tue, 2026-09-01 at 04:28 +0900, Hyunwoo Kim wrote:
> > > > > On Mon, Aug 31, 2026 at 12:22:45PM +0800, Chen, Yu C wrote:
> > > > > > Hi Hyunwoo,
> > > > > >=20
> > > > > > On 8/30/2026 3:30 PM, Hyunwoo Kim wrote:
> > > > > > > When the waker cannot use the wakelist, ttwu_queue() takes th=
e target rq
> > > > > > > lock and goes down into update_curr(). If the target rq belon=
gs to another
> > > > > > > CPU, the task handed to account_mm_sched() is the one running=
 on that CPU,
> > > > > > > not the task being woken.
> > > > > > >=20
> > > > > > > account_mm_sched() reads p->mm and updates mm->sc_stat. Nothi=
ng keeps that
> > > > > > > mm alive. The rq lock and rq->cpu_epoch_lock it holds have no=
thing to do
> > > > > > > with the lifetime of the mm.
> > > > > > >=20
> > > > > > > If that task happens to be in execve(), exec_mmap() points ts=
k->mm and
> > > > > > > tsk->active_mm at the new mm, and exec_mm_put_old() from setu=
p_new_exec()
> > > > > > > drops the old one. free_bprm() does the same when exec fails.=
 On the way
> > > > > > > from mmput() down to __mmdrop(), mm_destroy_sched() calls fre=
e_percpu() on
> > > > > > > sc_stat.pcpu_sched and free_mm() returns the mm_struct.
> > > > > > >=20
> > > > > > > Whoever already read the old pointer keeps using it. It adds =
to runtime in
> > > > > > > the freed per-cpu area and reads sc_stat in the freed mm_stru=
ct. Depending
> > > > > > > on the condition it also writes sc_stat.cpu. That is a use-af=
ter-free.
> > > > > > >=20
> > > > > > > Commit 9f23469401b0 ("sched/cache: Fix potential NULL mm poin=
ter access")
> > > > > > > changed the remaining p->mm dereference to the local variable=
, and said the
> > > > > > > active_mm reference keeps the structure allocated. That holds=
 for the other
> > > > > > > paths that detach an mm, since they take an mmgrab_lazy_tlb()=
 reference.
> > > > > > > exec reassigns active_mm to the new mm as well, so that refer=
ence is gone.
> > > > > > > What is left is the mm_users reference in bprm->old_mm, and d=
ropping it is
> > > > > > > the free.
> > > > > > >=20
> > > > > > >               CPU0                                CPU1
> > > > > > >=20
> > > > > > >                                        write(pipe)
> > > > > > >                                        try_to_wake_up()
> > > > > > >                                          ttwu_queue()      //=
 takes rq0 lock
> > > > > > >                                            enqueue_task_fair(=
)
> > > > > > >                                              update_curr()
> > > > > > >                                                update_se()
> > > > > > >                                                  account_mm_s=
ched()
> > > > > > >                                                    mm =3D rq0=
->curr->mm
> > > > > > >                                                          // o=
ld mm
> > > > > > >    execve()
> > > > > > >      exec_mmap()                       // tsk->mm =3D new mm
> > > > > > >      setup_new_exec()
> > > > > > >        exec_mm_put_old()
> > > > > > >          mmput() -> ... -> __mmdrop()
> > > > > > >            mm_destroy_sched()          // free_percpu()
> > > > > > >            free_mm()
> > > > > > >                                                    read mm->s=
c_stat.epoch
> > > > > > >                                                          // u=
se-after-free
> > > > > > >=20
> > > > > >=20
> > > > > > Ah, thanks for catching this.
> > > > > >=20
> > > > > > > ---
> > > > > > >   fs/exec.c             |  1 +
> > > > > > >   include/linux/sched.h |  4 ++++
> > > > > > >   kernel/events/core.c  |  2 ++
> > > > > > >   kernel/sched/fair.c   | 16 ++++++++++++++++
> > > > > > >   4 files changed, 23 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > > > index 745f6eb5279e6..6194c38807980 100644
> > > > > > > --- a/fs/exec.c
> > > > > > > +++ b/fs/exec.c
> > > > > > > @@ -916,6 +916,7 @@ static void exec_mm_put_old(struct mm_str=
uct *old_mm)
> > > > > > >   {
> > > > > > >   	setmax_mm_hiwater_rss(&current->signal->maxrss, old_mm);
> > > > > > >   	mm_update_next_owner(old_mm);
> > > > > > > +	sched_cache_exec_done();
> > > > > > >   	mmput(old_mm);
> > > > > > >   }
> > > > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > > > index 8b3d47a325cca..6ae31bffe049e 100644
> > > > > > > --- a/include/linux/sched.h
> > > > > > > +++ b/include/linux/sched.h
> > > > > > > @@ -2415,10 +2415,14 @@ struct sched_cache_stat {
> > > > > > >   	int cpu;
> > > > > > >   } ____cacheline_aligned_in_smp;
> > > > > > > +void sched_cache_exec_done(void);
> > > > > > > +
> > > > > > >   #else
> > > > > > >   struct sched_cache_stat { };
> > > > > > > +static inline void sched_cache_exec_done(void) { }
> > > > > > > +
> > > > > > >   #endif
> > > > > > >   #ifndef MODULE
> > > > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > > > index a6c8e38a31104..2f29cbccf03f1 100644
> > > > > > > --- a/kernel/events/core.c
> > > > > > > +++ b/kernel/events/core.c
> > > > > > > @@ -5427,6 +5427,8 @@ attach_task_ctx_data(struct task_struct=
 *task, struct kmem_cache *ctx_cache,
> > > > > > >   	if (!cd)
> > > > > > >   		return -ENOMEM;
> > > > > > > +	/* @old, loaded by the try_cmpxchg() below, is only stable =
under RCU. */
> > > > > > > +	guard(rcu)();
> > > > > >=20
> > > > > > Is this change related to this UAF issue?
> > > > >=20
> > > > > Duh.. that one is unrelated. My mistake.
> > > > >=20
> > > > > >=20
> > > > > > > +/* exec() has switched to the new mm and is about to drop th=
e old one. */
> > > > > > > +void sched_cache_exec_done(void)
> > > > > > > +{
> > > > > > > +	struct rq_flags rf;
> > > > > > > +	struct rq *rq;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * account_mm_sched() dereferences rq->curr->mm under this =
rq's lock,
> > > > > > > +	 * so a remote CPU can still be using the old mm. The lock =
cycle waits
> > > > > > > +	 * for it, and the store to tsk->mm cannot be reordered pas=
t the
> > > > > > > +	 * release, so later acquirers see the new mm.
> > > > > > > +	 */
> > > > > > > +	rq =3D this_rq_lock_irq(&rf);
> > > > > >=20
> > > > > > A smart fix, learnt! It behaves like a synchronize_rcu() to pro=
tect against
> > > > > > the read in account_mm_sched(). Small open: since the context o=
f invoking
> > > > > > account_mm_sched() is preemption-disabled, I wonder if we can s=
imply use
> > > > > > synchronize_rcu() directly instead of this_rq_lock_irq() - just=
 to avoid
> > > > > > contention for rq-lock in heavy system?
> > > >=20
> > > > Thanks to Kyunwoo to show this potential use-after-free problem.
> > >=20
> > > It is a real, triggerable issue.
> > >=20
> >=20
> > Appreciate if you can check whether the first 2 patches in=20
> > https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.inte=
l.com/
> > fixes this issue.
> >=20
> > > >=20
> > > > While synchronize_rcu() avoids rq lock, it could introduce a long d=
elay
> > > > of a full grace period that will be undesirable.
> > > >=20
> > > >=20
> > > > I think a better fix is to decouple sc_stat from mm and make it its=
 own structure.
> > > > Then we can do proper refcounting and rcu management on sc_stat its=
elf.
> > > > We will let task points to sc_stat with proper ref count and change=
 the access
> > > > as task->sc_stat directly nstead of via task->mm->sc_stat.
> > > >=20
> > > > Then we will know sc_stat exists in account_mm_sched() execution
> > > > as long as a task points to it and do not have to worry that sc_sta=
t is
> > > > released due to the mm life cycle.
> > > >=20
> > > > In the first 2 patches of the prctl control series for cache aware =
scheduling
> > > > we posted, we introduced the change I described above and should=C2=
=A0
> > > > fix this issue without additional rq locking or synchronize_rcu() o=
verhead.
> > > >  https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux=
.intel.com/
> > > >=20
> > > > We should probably prioritize to merge the first couple of patches =
from
> > > > that series now in light of this issue.  It will make maintenance a=
nd future
> > > > modification of the cache aware scheduling code easier.
> > >=20
> > > That is a fairly large change.=20
> >=20
> > However adding rcu synchronization will slow down the launch of a new p=
rocess
> > too much.  The rq lock solution has less latency in my opinion.  But I
> > think decoupling sc_stat is the best solution without adding latency in=
 the
> > exec path.
> >=20
> > Wonder what is Peter's opinion?
> >=20
> > >=20
> > > If you add a Reported-by: tag for this UAF to the patch, I am fine wi=
th=20
> > > handling it that way.
> >=20
> > I'll be happy to do that. If you let us know if those two patches from =
prctl series fixes
> > the bug you found in KASAN log, I can also add a Tested-by tag in addit=
ion to Reported-by.
>=20
> I confirmed that patches 1 and 2 of your series prevent this UAF.
>=20

Thanks for confirming that patches 1 and 2 in prctl series fix this use aft=
er free issue.
I will post those two patches separately and update the commit log
with reference to this UAF problem. We will try to expedite getting those t=
wo patches merged.

Tim

>=20
> Best regards,
> Hyunwoo Kim
