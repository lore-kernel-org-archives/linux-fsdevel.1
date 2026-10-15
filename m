Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C846EF93;
	Thu, 15 Oct 2026 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094304; cv=none; b=bR6SHFvarDHJAUzV4fTyi/ZdlunOVI0dTVDfETPOOaeiQtbLNnm54kjW5rjfIOytA3fNaIaXUojMVmGy8MlgGgCW9fG0nkiRT0EABC9Kw6HRqMz6Aj+3FwOoU0bXTsrDakcwM6jFI8uv5vNg1K+MObuRTwIU8bXP31DeCtAUerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094304; c=relaxed/simple;
	bh=4JQ4FqbdpI3MwSUoWdEE76cU0QpDYkzKLrUSTSZvtPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7gWy71COy2Fm13n/wORDlxI//PWgXSZKTQ4coXia3s34Rp/xVP3KcZX6teLQxrFgpuiEnex+3ILB8xv5BplfnNj/RkrK2dt1RFDxzcZgOUuP9Eyq3WFF9S5z1P5r4Y2IuHbr1YYnMZmt7paj+T/NDzlBUaW27FDXp1cxuYQz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEpOUl+a; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEpOUl+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792094302; x=1823630302;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4JQ4FqbdpI3MwSUoWdEE76cU0QpDYkzKLrUSTSZvtPU=;
  b=jEpOUl+a1jtBBya72Fz09pdkS6hHL1pNBbSf+ebuOAm8m8PA3dtRuSge
   rqtXL9aBthqAOsjLkkaMujX/qL/eYmqd8G05F+EKEV5Z+DMl3uswgw0vh
   mh6T++E7kWsAtnAuLDOFA5RlwbcTpIPtfrc5GRP0s3a4OQDANPgsrn7Wn
   B51EhHyzyQq+WZqLZriKsKdQHS9lMo5sv0tIGfS2V4BPdCEQZaxkmg4eM
   JvtXubpq2b9kHYgURB7nvYCIlsoGuLo55mWDmhaegQX//vnexetQQES7j
   IXX6kzmIEDm3VUovrpfA/2aCmuD/VoGHCz/n7bo4/6zuYE/Iqs4v8PyLS
   Q==;
X-CSE-ConnectionGUID: 9FLmVZMrQR278YtcZAuvSw==
X-CSE-MsgGUID: z9TunxW2TJWlOp0Rt2rvng==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="759094"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="759094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:58:21 -0700
X-CSE-ConnectionGUID: eSw31gJ8Q628BMhKq26DRw==
X-CSE-MsgGUID: PJM9UxMdSkeWW1lzMZnORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1743045"
Received: from unknown (HELO [10.241.242.105]) ([10.241.242.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:58:21 -0700
Message-ID: <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA
 balancing control
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, Chen Yu <yu.c.chen@intel.com>, 
 "David Hildenbrand (Red Hat)"
	 <david@kernel.org>, ljs@kernel.org
Cc: Li Zhe <lizhe.67@bytedance.com>, mingo@redhat.com, peterz@infradead.org,
 	juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, 	rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, 	kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, tim.c.chen@intel.com, 	mkoutny@suse.com,
 tj@kernel.org
Date: Thu, 15 Oct 2026 12:58:20 -0700
In-Reply-To: <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
		 <as3gQ8jfa_6eBf15@chenyu-dev>
	 <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-13 at 17:31 +0800, Yafang Shao wrote:
> On Tue, Oct 13, 2026 at 3:52=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wro=
te:
> >=20
> > On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
> > > Automatic NUMA balancing is controlled globally through the
> > > kernel.numa_balancing sysctl and can be influenced indirectly through
> > > memory policy. That works well as a system default, but it is too coa=
rse
> > > for workloads where a launcher wants most processes to use the defaul=
t
> > > policy while a selected process opts out because it already manages N=
UMA
> > > placement or cannot afford the sampling overhead.
> > >=20
> > > A recent per-cgroup proposal tried to address this by adding a
> > > cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode where
> > > balancing was disabled by default and then enabled for selected cgrou=
ps
> > > [1]. The discussion also noted that automatic NUMA balancing already
> > > operates at task/process granularity, that the knob is not a resource
> > > control attribute, and that task/process controls such as sched_setat=
tr()
> > > or prctl() may be a better fit while cgroups and cpusets continue to
> > > describe workload grouping and placement domains.
> > >=20
> > > There is also prior art from 2023 prctl() proposals [2][3]. Those
> > > versions used a per-mm mode with disabled/enabled/default states, add=
ed
> > > NumaB_mode to /proc/<pid>/status, and changed the global static key
> > > handling so a per-process enable could override the global sysctl.
> > >=20
> > > This series takes a more conservative variant to preserve existing
> > > administrator and workload expectations. Keeping the global sysctl as=
 a
> > > hard off switch means an administrator can still disable all automati=
c
> > > NUMA balancing activity with one knob. Using a weak two-state
> > > per-process opt-out/allow ABI avoids exposing a "default" state whose
> > > meaning depends on global policy and is therefore easy to misinterpre=
t.
> > > Storing the configured mode in signal_struct gives the control explic=
it
> > > thread-group semantics and avoids making unrelated non-thread CLONE_V=
M
> > > users share the policy merely because they share an mm.
> > >=20
> > > The series implements a per-process interface: a thread group may use
> > > prctl() to set or get its configured automatic NUMA balancing mode. A
> > > process can opt out of new periodic NUMA scan scheduling and NUMA
> > > scheduler accounting, or opt back in. Existing hinting faults and que=
ued
> > > work are allowed to drain naturally as the disabled state takes effec=
t.
> > > When kernel.numa_balancing is 0, a process-local enable request does =
not
> > > override it.
> > >=20
> > > A separate task_struct scheduler snapshot is used by enqueue/dequeue
> > > accounting so the scheduler can consistently account the state that w=
as
> > > in effect when a task entered the runqueue. This avoids changing
> > > historical task accounting while still allowing a process mode change=
 to
> > > take effect through the normal dequeue/update/enqueue path.
> > >=20
> > > The series also exposes the process NUMA balancing mode in
> > > /proc/<pid>/status and documents the new prctl() ABI and its interact=
ion
> > > with the global sysctl.
> > >=20
> >=20
> > Can the global key be extended to tri-state, like the THP settings?
>=20
> IIUC, a BPF-based THP policy is yet to be developed as prctl() doesn't
> fit some use cases, especially mTHP.
>=20
> > To keep it backward-compatible, echoing 0 and 1 remains the same effect=
.
> > The user can also echo always, advise, or never to it.
> > We have a similar proposal here for cache-aware scheduling[1]
>=20
> We are also experimenting with the LLC-aware scheduler on production
> servers, and we want to enable it per cgroup rather than globally
> there as well.  Given the lessons we have learned from THP, what
> about implementing it as a BPF-based feature from the beginning, so
> that the semantics can still change when new use cases show up?

Some questions about per-cgroup based cache aware scheduling:

1) What should be done if you want to group specific processes in different=
 cgroups?
It may not be desirable to put them together in the same cgroup for other r=
easons
like IO or memory resource policies.

2) What is the inheritance rule for cache grouping of tasks in a cgroup
with child cgroups?
There may be too many tasks in parent to try to fit them all in a LLC when
there are only certain subset of tasks sharing data that should be grouped
together cache wise.

With prctl, we can be precise in grouping only tasks that we truly
want to be together.  If we want to bunch tasks in a cgroup cache wise,
it is easy to write a daemon to put tasks in a cgroup into the same
cache group.

Thanks.

Tim


>=20
> > In this way, the user does not have to disable NUMA balancing one by on=
e
> > across the whole system.
> >=20
> > Yafang Shao has a bpf-cgroup based NUMA balancing proposal[2].
> > Overall I support fine-grained control of NUMA balancing, and I'm curio=
us
> > what the possible setting would be in the production environment, would
> > something like Kubernetes be responsible for setting the NUMA
> > balancing attribute via prctl, or as Yafang proposed, leverage cgroup
> > interface?
> >=20
> > [1] https://lore.kernel.org/lkml/fd341106e7e6cbd2f047656650f43ee87c6633=
c1.1787955777.git.tim.c.chen@linux.intel.com/
> > [2] https://lore.kernel.org/lkml/20261012120438.52849-1-laoar.shao@gmai=
l.com/
>=20
