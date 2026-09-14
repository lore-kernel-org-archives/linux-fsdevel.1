Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21792FE057;
	Mon, 14 Sep 2026 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424709; cv=none; b=EZazaEvdHaG/35RzAkpROMAl76uFadaV2ENBX1IawKtbdveXbKTiDk3n+BZtMc9Z3Q9ii8FUBPg897d5KVMFfZJogNn8gX0g1VM/t7Ec3M4OppiWsgyH0Y/RZrjW5NIvMUC3R2NH8oGrXDx4WWi8+N+lb9Ouks0EZ++bIF5ofyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424709; c=relaxed/simple;
	bh=lRwyLDKclG5PTkKiaCP0WfETw35RY2cC30b8ggFxCpg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wlg9lGHUjSkJxhkjebnTRkuUb0SaSyyEL3e4bWCTSYO8dl322qE+XpCAlB0Hy3xjpJaToU4OeNj2b1R8PW2Zc1INzHs8NTp8XP/ToBsE3BbQiROMgB+9wnOlFS6L2RBc5StJnsuV6MUAUqWm6Y2A83SnU3TI4Njl1PAFLbYATvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epD2xGM4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epD2xGM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789424707; x=1820960707;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lRwyLDKclG5PTkKiaCP0WfETw35RY2cC30b8ggFxCpg=;
  b=epD2xGM4map3pLIvRr4pMWmFo6pSUfdMkFf7VCNOvqVn/QghRUJZG2Qb
   3zBZWtX7+952kDxdneVxadKUMFNTgFrGkCzybitWCBZdD/DJukNgsEvnD
   74EhJpKvOLws4Ifu2e7MfeW5oKFTao805Wl+D6GcCZvzs8CXx7oAGsAs+
   FZqy9jDgU71JhL7lmndfv4GV5lP6eMe/NtuYApyxSw6cuJKyvkiB++Pv6
   Px85fM7L12G9l+HeuxIayVSNxWuzd5E/nHk7Rj//2OpFRY2CNjq6Tjw79
   5rVe83syKtAzxDIXu1HsJ7ciTkm7f5/t0/6uSkE7jIbm/2iMwB5FYGQ+K
   w==;
X-CSE-ConnectionGUID: fu6d7j+YTnuzUs3sPa7UwA==
X-CSE-MsgGUID: 3TvUinnZQSe5ckL0IlbwMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93608054"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93608054"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:25:06 -0700
X-CSE-ConnectionGUID: o6rW3JWLR0yDEFjVHAANFA==
X-CSE-MsgGUID: AxBYWUm+TPqDVSYWsw29zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="274710260"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:25:05 -0700
Message-ID: <025bdcdef34170b1ffcc673c6b59cb51abc8fef5.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] sched/cache: Keep nr_pref_llc_running in the
 runnable domain
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chen Yu <yu.c.chen@intel.com>, Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: brauner@kernel.org, bsegall@google.com, dietmar.eggemann@arm.com, 
	imv4bel@gmail.com, jack@suse.cz, juri.lelli@redhat.com, kees@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, qyousef@layalina.io, 
	ricardo.neri-calderon@linux.intel.com, rostedt@goodmis.org,
 srikar@linux.ibm.com, 	sshegde@linux.ibm.com, vincent.guittot@linaro.org,
 vineethr@linux.ibm.com, 	viro@zeniv.linux.org.uk, vschneid@redhat.com,
 wanglu.priv@gmail.com, 	yi1.lai@intel.com, zhanxusheng1024@gmail.com,
 zhanxusheng@xiaomi.com, 	ziqianlu@bytedance.com, chen.yu@linux.dev
Date: Mon, 14 Sep 2026 15:25:05 -0700
In-Reply-To: <aqdVpO66OfmHvvqB@chenyu-dev>
References: <f3b70dd40e29b309ff3449a95a4af4513ad0ef70.camel@linux.intel.com>
	 <20260910220331.1209469-1-kayracizmeci@gmail.com>
	 <aqdVpO66OfmHvvqB@chenyu-dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 10:02 +0800, Chen Yu wrote:
> Hi Kayra,
>=20
> On Fri, Sep 11, 2026 at 01:03:30AM +0300, Kayra Cizmeci wrote:
> > Hello Tim,
> >=20
> > > So moving the accounting next to (or after) the h_nr_runnable update
> > > would make task_pref_llc_runnable() return false and skip the
> > > decrement, leaving nr_pref_llc_running too high.
> >=20
> > What I really wanted wasn't getting the accounting next to or after the=
 h_nr_runnable.=20
> > If we are updating h_nr_runnable in some way that means we don't need
> > its check since it's already getting updated. And if it's getting updat=
ed
> > that means on that branch we know how our check should behave since we=
=20
> > are a subset of it. We can skip the delayed check on that way since we =
are
> > trying to behave as h_nr_runnable's subset.
> >=20
> > >        if (entity_is_task(se))
> > >                pref_llc_running_dec(...);      /* sched_delayed still=
 0 */
> > >        se->sched_delayed =3D 1;
> > >        ...
> > >        for_each_sched_entity(se)
> > >                cfs_rq->h_nr_runnable--;        /* sched_delayed alrea=
dy 1 */
> >=20
> > For example:
> >=20
> > In this code the h_nr_runnable is updated the same way regarding what i=
s sched_delayed.
> > That means if we want to behave as a subset of it, we don't need the ch=
eck delayed,
> > since we check the delayed to be a subset but if h_nr_runnable is decre=
asing/increasing
> > we should look into our checks.
> >=20
>=20
> I had a try according to your suggestion. It seems that the code becomes =
more complex
> and brings more headache :-( due to several corner cases. The current ver=
sion is a simpler
> version with less code IMO. But I agree it looks a little hard to catch u=
p with, so I added
> some comments around account_llc_dequeue() and adjusted the code sequence=
 of clear_delayed()
> to make it easier to understand. Tim, could you please help check if this=
 makes sense?
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e64d9ad7a108..89311bbadfac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1609,8 +1609,58 @@ static void account_llc_dequeue(struct rq *rq, str=
uct task_struct *p)
>  	if (p->pref_llc_queued) {
>  		/*
>  		 * Skipped if still delayed (set_delayed() already removed it);
> -		 * clearing pref_llc_queued below also stops clear_delayed()
> -		 * from re-adding it.
> +		 *
> +		 * The nr_pref_llc_running varies with h_nr_runnable, it involves
> +		 * set_delayed(), clear_delayed(), account_llc_enqueued() and account_=
llc_dequeue().
> +		 * The following shows two typical cases of how nr_pref_llc_running is=
 maintained
> +		 * during enqueue/dequeue.
> +		 *
> +		 * case 1 - wakeup a delayed task

I assume both CPU0 and CPU1 in preferred LLC, and task woken on
CPU1.  Should say so.

> +		 *
> +		 * CPU0                                       CPU1
> +		 * __dequeue_task [fake dequeue]
> +		 *   set_delayed
> +		 *     rq0->nr_pref_llc_running--
> +		 *     p->se.sched_delayed =3D 1
> +		 *
> +		 *                                     try_to_wake_up(p)
> +		 *                                       enqueue_task_fair
> +		 *                                         requeue_delayed_entity
> +		 *                                           clear_delayed
> +		 *                                             rq0->nr_pref_llc_runnin=
g++

							       rq1->nr_pref_llc_running++
> +		 *
> +		 *
> +		 * case 2 - LB for delayed task

LB for delayed task from a preferred LLC to a non-preferred LLC.

> +		 *
> +		 * CPU0                                       CPU1
> +		 * __dequeue_task [fake dequeue]
> +		 *   set_delayed
> +		 *     rq0->nr_pref_llc_running--
> +		 *     p->se.sched_delayed =3D 1
> +		 *
> +		 *
> +		 *                                     --------- load balance --------=
-
> +		 *                                     detach_task(p, rq0, migrate_loa=
d)
> +		 *                                       account_llc_dequeue
> +		 *                                         ** DO-NOT-DECREASE **
> +		 *                                         rq0->nr_pref_llc_running

						The above block should be under CPU 0

> +		 *
> +		 *                                     attach_task(p, rq1)
> +		 *                                       account_llc_enqueue
> +		 *                                         ** DO-NOT-INCREASE **
> +		 *                                         rq1->nr_pref_llc_running
> +		 *
> +		 *                                     pick_eevdf
> +		 *                                       __dequeue_task  [real dequeue=
]
> +		 *                                         account_llc_dequeue(DEQUEUE=
_DELAYED)
> +		 *                                           ** DO-NOT-DECREASE **
> +		 *                                           rq1->nr_pref_llc_running
> +		 *                                           p->pref_llc_queued =3D 0;
> +		 *
> +		 *                                         clear_delayed
> +		 *                                           p->se.sched_delayed =3D 0=
;
> +		 *                                           ** DO-NOT-INCREASE as pre=
f_llc_queued=3D0 **
> +		 *                                           rq1->nr_pref_llc_running
>  		 */


Thanks for describing the operation scenario.
However the above cases are not comprehensive and a bit long for comment.


>  		pref_llc_running_dec(rq, p);
>  		/*
> @@ -6415,23 +6465,18 @@ static __always_inline void return_cfs_rq_runtime=
(struct cfs_rq *cfs_rq);
> =20
>  static void set_delayed(struct sched_entity *se)
>  {
> -	/*
> -	 * Drop a task leaving the runnable set. Must run before sched_delayed
> -	 * is set, or task_pref_llc_runnable() would already exclude it;
> -	 * clear_delayed() mirrors this after clearing the flag.
> -	 */
> -	if (entity_is_task(se))
> -		pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
> -
> -	se->sched_delayed =3D 1;
> -
>  	/*
>  	 * Delayed se of cfs_rq have no tasks queued on them.
>  	 * Do not adjust h_nr_runnable since __dequeue_task()
>  	 * will account it for blocked tasks.
>  	 */
> -	if (!entity_is_task(se))
> +	if (!entity_is_task(se)) {
> +		se->sched_delayed =3D 1;
>  		return;
> +	}
> +
> +	pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
> +	se->sched_delayed =3D 1;

This change looks good and make the code cleaner.

Tim

> =20
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
