Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327335B137;
	Fri, 16 Oct 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792182748; cv=none; b=nwn9e3NvRRGReB0eBGzuKcPKQa5YY6U+HWsX7CHBdULr5OAPRq8Ir6/uqJONRfC/qsYaTFyrykp/DxLuBtf7WADdiC6uBjygyYveiJkdMYh0AQtjYsxoPeu9o/bg6pKMcPSEbTvuEXGaBSDeLMIEvQ0nCmHV/6v5GIlC0JAkblA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792182748; c=relaxed/simple;
	bh=d95wB2P3vIwny0rfuJdp7OjALDCyPSSLkR7Bq9zYu9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPAc994w2bdbbISVaUtIgkrDWoF7OcNTahsVsfQOFbmcpwNG2bhGp+mYDy0vHIwr7GF9z8O25vp2UURdQzfl/wkNgKEnywAwD+bRNfeRGn9WXuR/ahQfAPYowkFCnUoQkmiOgWDBaEAggxR7RH1pwtw8QpAIq8EXgNdl5uP61z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZnQEfeB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZnQEfeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792182745; x=1823718745;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=d95wB2P3vIwny0rfuJdp7OjALDCyPSSLkR7Bq9zYu9w=;
  b=XZnQEfeBLcBtruJe0XxYcXv350mXdgWW/LrFa/p5S6U9wm70AlFlTS/7
   x3/zWKxNP0nSSkSdHZeaAVGTb+UHojeY1p55I4LXJrEyOqTTbShl6IuuJ
   QCdnNgWoXG4E/8lx+2SS2/iZf9yIL2EbpPhVciZzgORjHwVXSqlg7VZBQ
   uQTbqPpnkSqhNg3GzNuAC7QdG+syXsp4Yt9TuEfLbONtUH9eeli5yTrNN
   Qe40j+2kbzLklkRHMa6oEshXA8fEJJpP++CBsBDULCPQlrm8PbvbBULIa
   rIn6RcTIcRrcVHyP5gPVDb69ZtZa3Kaxpf7mjtcR4AYGZjKV7vDu0iwy+
   A==;
X-CSE-ConnectionGUID: WnCXO7RzTq6yZeWh6rK4Eg==
X-CSE-MsgGUID: 2fNtQynmRKOtzsjDQVm2kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="852932"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="852932"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 13:32:24 -0700
X-CSE-ConnectionGUID: 0lWe9QFISVexDKKmldjkeg==
X-CSE-MsgGUID: ZxvaYP6eQiOBncO/WyLNjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2013833"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.110.175]) ([10.125.110.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 13:32:24 -0700
Message-ID: <8d1997019d00fad3f250c4df3f18c53dff25e054.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA
 balancing control
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, ljs@kernel.org, Li Zhe
	 <lizhe.67@bytedance.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, 	rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, 	kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, tim.c.chen@intel.com, 	mkoutny@suse.com,
 tj@kernel.org, chen.yu@linux.dev, Vern Hao <vernhao@tencent.com>,  Vern Hao
 <haoxing990@gmail.com>, Qais Yousef <qyousef@layalina.io>
Date: Fri, 16 Oct 2026 13:32:23 -0700
In-Reply-To: <CALOAHbALpHebACLUmvet_tFH_w-iK3TWpY52OhYTUVoLzoGKkg@mail.gmail.com>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
	 <as3gQ8jfa_6eBf15@chenyu-dev>
	 <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
	 <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
	 <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com>
	 <atG4VXk4t-m8VubY@chenyu-dev>
	 <CALOAHbDY6zLcEc4kGhC9GSFsOsREadkWN7Q4CmZuR_m_BMHAyg@mail.gmail.com>
	 <bcabbe25-5b2c-464a-a22d-5375a342f938@intel.com>
	 <CALOAHbALpHebACLUmvet_tFH_w-iK3TWpY52OhYTUVoLzoGKkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-16 at 16:18 +0800, Yafang Shao wrote:
> On Fri, Oct 16, 2026 at 4:01=E2=80=AFPM Chen, Yu C <yu.c.chen@intel.com> =
wrote:
> >=20
> > On 10/16/2026 3:38 PM, Yafang Shao wrote:
> > > On Fri, Oct 16, 2026 at 1:51=E2=80=AFPM Chen Yu <yu.c.chen@intel.com>=
 wrote:
> > > > A more complex scenario is when cgroup A and cgroup B become thread=
ed domains:
> > > >=20
> > > >                           root
> > > >                          /    \
> > > >                         X      Y
> > > >                         |      |
> > > >                         A      B          A, B: threaded domains (t=
hread roots)
> > > >                        / \    / \         separate memory.max / io.=
max
> > > >                      A1   A2 B1  B2       threaded cgroups
> > > >                      ^        ^
> > > >                      |        |
> > > >                      +--------+
> > > >                    want to share one cache group
> > > >=20
> > > > In the above case, we might need to change the deployed cgroup hier=
archy.
> > >=20
> > > I think we can enable LLC-aware scheduling for both A1 and A2 =E2=80=
=94 does
> > > that sound right?
> > >=20
> >=20
> > Here A1 wants to share data with B1, but A2 does not want to share data
> > with B2 nor B1 nor A1. Enabling cache-aware for A1 and A2 might not hel=
p
> > in this case.
>=20
> I'm not sure whether this is a real use case or merely a theoretical
> one. I'd suggest we not focus too much on purely theoretical scenarios
> unless someone can demonstrate a practical need.

In our discussions with Vern Hao from Tencent, they have use cases where
A1 and B1 are dealing with data compressions while A2 and B2 are dealing
with databases.  So data are mostly shared between A1 and B1, A2 and B2
due to functionality.  We may put the parent A or B in the same sched group=
,
but the sched group may contain too many threads to fix in a LLC.

The tricky thing is if there are scenarios where
we want to do grouping one way when we consider resource
usage but another way when we consider data sharing.
=20
>=20
> >=20
> > > >=20
> > > > Suppose threads in A1 and threads in A2 belong to the same process =
Pa,
> > > > this reminds me of the cgroup bpf NUMA balancing case: after enabli=
ng
> > > > NUMA balancing for A1 but not setting it for A2, what would be the =
final
> > > > NUMA balancing decision for process Pa, is it enabled or disabled?
> > > > The NUMA balancing scan/invalid seems to be per process, so if we c=
hange
> > > > the setting of its threads, the whole process will be impacted. Or =
maybe
> > > > we should not enable NUMA balancing for threaded cgroups? Anyway I =
haven't
> > > > digged into your cgroup bpf patch set yet, let me try to look at it=
.
> > >=20
> > > cgroup NUMAB works the same way: the setting is per cgroup and opt-in=
.
> > > For Pa in your example, since its threads spread across A1 and A2, yo=
u
> > > would enable it on both =E2=80=94 enabling it on only one of them is =
not
> > > meaningful.
> > >=20
> >=20
> > I see. I haven't yet digged into your code, is there a per cgroup flag
> > cgroup.numab.enabled?
>=20
> Right. I will introduce a cgroup::numab_mode field, but without a
> cgroupfs interface file; it will be written through a BPF program.
>=20
> > Would there be a logic in the kernel, when
> > A1.numab.enabled
> > is written to true, the kernel detects all the other cgroups {X} that
> > contains threads
> > share the same mm_struct as A1's threads/tasks, and then update {X}'s
> > numab.enabled
> > to the same value as A1, to keep consistency?
>=20
> We have no plan to support threaded cgroups for now. If a real need
> arises, the BPF program can be extended to handle it, which would just
> require more kfuncs.
>=20
> > In summary, if threads are
> > spread
> > cross different cgroups, when you set the enable flag for 1 cgroup, wil=
l the
> > kernel iterates all the other cgroups to update their flags as well? Or
> > leverage userspace to do that?
>=20
> I believe this should be implemented in userspace, not automatically
> in the kernel. Use cases are always complex, and flexibility is
> important here.

I think there is a misunderstanding that using prctl necessarily mean
we have to modify the user programs.

With the prctl that Chen Yu and I proposed for cache aware scheduling
[1], the application does not have to change at all. The prctl can be
issued by an orchestrator daemon on other tasks:
the caller passes a target pid and a pid_type (thread,
thread group or process group), and the permission check is      =20
ptrace_may_access(), as in core scheduling. So a daemon run by the =20
platform team can put the application's threads into the right cache       =
                  =20
group from outside:                           =20
                                                                           =
                 =20
  prctl(PR_SCHED_CACHE, PR_SCHED_CACHE_CREATE, leader, 0, PIDTYPE_TGID);   =
 =20
  prctl(PR_SCHED_CACHE, PR_SCHED_CACHE_SHARE_FROM, tid, leader, PIDTYPE_PID=
);                =20
                                                                           =
                                                                           =
                                                                =20
The daemon can take its policy from wherever is convenient: cgroup=20
membership, the pod spec, process names, or a config file. Changing=20
the policy means changing the daemon, which the same team owns. That
is the same round-trip as changing a BPF program, and no application
team is involved. This is how schedqos already uses the core               =
                  =20
scheduling prctl.                             =20

That said, we may start with a per cgroup control of
cache aware scheduling that sit next to the prctl [1]
without either one replacing the other.  A lot of the
code in [1] can be reused with per cgroup control
of cache aware scheduling.

It starts small, in the form Tejun suggested for NUMA balancing
in your series [2], and grows only when a real need shows up.

The rule for every step with a BPF based cgroup interface:
the per-task p->sched_cache_grp from [1]=20
is the only thing the scheduler reads. Each interface is just
another way to set it, so the scheduler side never changes.

Step 1: a per-cgroup setting
----------------------------

  - struct cgroup gets a sched_cache_grp pointer and a mode:
    inherit (default), off, or "this subtree is one group".
  - One kfunc sets the mode by cgroup id. No cgroupfs file for now.
  - The kernel puts tasks in the cgroup's group:
      - when the mode is set: allocate the group, publish it, then
        walk the cgroup's tasks
      - at fork: in sched_post_fork(), right after cgroup_post_fork()
      - at exec: exec_mmap() installs the cgroup's group instead of the
        mm's one
      - on migration: in cgroup_migrate_execute(), next to the
        ss->attach() calls
  - A task that was grouped explicitly (by the prctl, or later by BPF)
    keeps its group. Cgroup changes do not override it.
  - In the "advise" mode the cgroup's group is created enabled, since
    a new group starts disabled there.

This reuses most of [1]: the refcounted sched_cache_group (patches
1-3), __sched_cache_set() with the pi_lock swap and the footprint
transfer (patch 4), the fork and exec handling (patches 2 and 4), the
per-group enabled flag (patch 5) and the always/advise/never mode
(patch 6). Only the prctl UAPI itself is not needed.

This covers the the case where the sched groups match well with
cgroups: cache aware scheduling can be turned on for group A
only. The other part, a footprint threshold for A that differs from
the global llc_aggr_tolerance, would need a per-group tolerance that
the per-cgroup setting can carry.

Step 2: BPF picks the group
---------------------------

Add kfuncs to create, read, set and reset a group (thin wrappers around
the same code), and one that stores a BPF-chosen group in a cgroup.
The kernel still installs tasks at fork, exec and migration as in step
1. The difference is that two cgroups can now share one group, for
example A1 and B1 in one sched group in the above example.

Step 3: BPF decides per task
----------------------------

Only if someone needs it: programs on the fork, exec and cgroup-attach
hooks that set a task's group directly, for example to split a cgroup
that is too big for one LLC, or to group only some of its tasks. The
set kfunc takes pi_lock, so it needs a context filter that allows it
only in sleepable programs and those hooks.

Each step stands on its own. If step 1 is all anyone ever needs, we
stop there. The prctl stays for users who do not run cgroups or schedqos.

Does step 1 match what you have in mind for the LLC-aware scheduler
on your servers?

[1] https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.inte=
l.com/
[2] https://lore.kernel.org/lkml/20261012120438.52849-1-laoar.shao@gmail.co=
m/

Thanks.

Tim
