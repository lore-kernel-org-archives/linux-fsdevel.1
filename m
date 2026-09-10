Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F7496D32;
	Thu, 10 Sep 2026 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073169; cv=none; b=rNskXs59k3GVOF+mFHgdYm+UwhevKFCogGoDUiX+Lb5pzYe66Hj29KqkwXBWMEX7V69Xo0CTxYPVvTQYkvA10bianw9qLKDT2yNviiC5Fg8pwWrb3eqelXBhd5Ff9gw+0VwZWJEyEGn2hFEmNg07f1uBnXCI8N3pLmDKbGlUcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073169; c=relaxed/simple;
	bh=u95HbUhQ4RS63Z2SF2toUN8QlmyAdZmVTjoX5PdPJQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ixRAl1NEgBrMwlk5r32TD1KWb7n7EbN5etP0Wq7hKJhz55lvfNsBWc/uao96fFCJeddvpi6ftsvpY1Lx/6uXRAV0ZwsDrg95cOOBZ2Pe34YDrBFl0r2KBKNpDIGrDnoucaXbuW8EW6Wvoiy5dZqzbKnJD8ii04QK+beGDaPYCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtQMRz8D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtQMRz8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789073168; x=1820609168;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=u95HbUhQ4RS63Z2SF2toUN8QlmyAdZmVTjoX5PdPJQU=;
  b=PtQMRz8DrE1HIt+Nx/spEHbSld34IjKBywpDi1ZW7oQt/Hrm07+V3Lpr
   Agoh4w+xIQmtjkwFAgk8WjKuM00rj5GxWak+5Dg+u3dzA3Dl+YYCbsbA7
   oem0iUQrpICaST+iGktxts3gOPbjTF4qdznOoqx1RUURONBTVRi6hS/1E
   TOCcsEXMFT62WczpsH1CHDQlkbscsNCmgj6G5oEgr6alVrnzYH24YUonn
   4zfGdiiyefHk1DVxOb6nAOYfyP3E7b/j2xT/fiOeuf/tqczadrh3WiiWr
   BFDJJOPGC0CBAh91zCVib1MlWhVvLgN0s3m3a9r+Mo7e8EckF+Rf3XsuD
   Q==;
X-CSE-ConnectionGUID: gETCCllZSOqfVB+BTi1aHg==
X-CSE-MsgGUID: h7UyDnHLQg6+rYRLhxaejQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="77094750"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="77094750"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 13:46:07 -0700
X-CSE-ConnectionGUID: 3TVrN5bdR8Sn0EcEiUephA==
X-CSE-MsgGUID: uPHYjxBJSainYFU7HApydA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="295219996"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 13:46:06 -0700
Message-ID: <f3b70dd40e29b309ff3449a95a4af4513ad0ef70.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] sched/cache: Keep nr_pref_llc_running in the
 runnable domain
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: brauner@kernel.org, bsegall@google.com, dietmar.eggemann@arm.com, 
	imv4bel@gmail.com, jack@suse.cz, juri.lelli@redhat.com, kees@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, qyousef@layalina.io, 
	ricardo.neri-calderon@linux.intel.com, rostedt@goodmis.org,
 srikar@linux.ibm.com, 	sshegde@linux.ibm.com, vincent.guittot@linaro.org,
 vineethr@linux.ibm.com, 	viro@zeniv.linux.org.uk, vschneid@redhat.com,
 wanglu.priv@gmail.com, 	yi1.lai@intel.com, yu.c.chen@intel.com,
 zhanxusheng1024@gmail.com, 	zhanxusheng@xiaomi.com, ziqianlu@bytedance.com
Date: Thu, 10 Sep 2026 13:46:05 -0700
In-Reply-To: <20260910183301.1208504-1-kayracizmeci@gmail.com>
References: 
	<82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>
	 <20260910183301.1208504-1-kayracizmeci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 21:33 +0300, Kayra Cizmeci wrote:
> Hello :>,
>=20
> > alb_break_llc() decides whether to break LLC preference during active
> > load balance. It does so by testing that every runnable fair task on th=
e
> > source rq prefers its LLC:
> >=20
> > 	env->src_rq->nr_pref_llc_running =3D=3D env->src_rq->cfs.h_nr_runnable
> >=20
> > But the two counters cover different sets. nr_pref_llc_running is updat=
ed
> > in account_llc_enqueue()/account_llc_dequeue(), next to cfs_rq->nr_queu=
ed,
> > so it follows queued tasks. h_nr_runnable is updated in set_delayed()/
> > clear_delayed() and drops delay-dequeued tasks.
>=20
> > So under DELAY_DEQUEUE, a preferring task that goes to sleep stays coun=
ted
> > in nr_pref_llc_running while h_nr_runnable falls. The equality then bre=
aks,
> > alb_break_llc() returns false, and active balance is free to pull a tas=
k
> > off its preferred LLC. Active balance only moves runnable tasks, and th=
is
> > is the only LLC check it consults: once the stopper runs, LBF_ACTIVE_LB
> > skips the per-task test in can_migrate_task(). The runnable set is the =
one
> > we want.
>=20
> > Fix it on the counter side. A task should be counted in
> > nr_pref_llc_running exactly while it is both queued on its preferred LL=
C
> > (pref_llc_queued) and runnable (!sched_delayed). Define that membership
> > once in task_pref_llc_runnable(), and adjust the counter only through
> > pref_llc_running_inc()/pref_llc_running_dec() from the four sites that
> > change either input: account_llc_enqueue(), account_llc_dequeue(),
> > set_delayed() and clear_delayed(). Gating every update on the same
> > predicate keeps the delay, wake and dequeue paths from double-counting
> > or underflowing; see the comments at those sites for the ordering.
>=20
> > nr_llc_running and sd->llc_counts are not touched and stay on queued
> > semantics.
>=20
> I have one question tho, can't we combine the checks with h_nr_runnable? =
On the paper
> if we are updating h_nr_runnable we could check if the nr_pref_llc_runnin=
g can be=20
> updated and update it if the condition is right. Because, every nr_pref_l=
lc_running enters
> h_nr_runnable while not every h_nr_runnable enters nr_pref_llc_running.=
=20
>=20
> Why instead we just check the nr_pref_llc_running's conditions on task_pr=
ef_llc_runnable()
> and call these dec and inc functions after the h_nr_runnable updates. Wou=
ldn't it be clear that way?
> If possible?

Yes, nr_pref_llc_running is a subset of h_nr_runnable.

We have to keep nr_pref_llc_running accounting apart from h_nr_runnable in =
set_delayed().
Note that in set_delayed(), pref_llc_running_dec() has to run while the tas=
k still looks runnable,
that is before se->sched_delayed =3D 1, because task_pref_llc_runnable()
gates on !sched_delayed. h_nr_runnable is decremented after the flag is
set:

        if (entity_is_task(se))
                pref_llc_running_dec(...);      /* sched_delayed still 0 */
        se->sched_delayed =3D 1;
        ...
        for_each_sched_entity(se)
                cfs_rq->h_nr_runnable--;        /* sched_delayed already 1 =
*/

So moving the accounting next to (or after) the h_nr_runnable update
would make task_pref_llc_runnable() return false and skip the
decrement, leaving nr_pref_llc_running too high.

clear_delayed() happens to be safe either way, since it clears
sched_delayed first, but keeping the two symmetric and calling inc/dec
explicitly at each site is what lets the single task_pref_llc_runnable()
predicate stay the one source of truth.

There is also a scope difference: h_nr_runnable is per-cfs_rq and
updated at every level of the hierarchy in the for_each_sched_entity()
loop, while nr_pref_llc_running is a per-rq scalar updated once per
task - which is why the dec sits before the loop, not inside it.

Thanks.

Tim
