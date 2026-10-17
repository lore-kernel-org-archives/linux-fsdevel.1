Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0D38F658
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202382; cv=pass; b=AeqS0XsBMp4MJjLIdyYXEdeft4JGpk/Oh1FlqsymSsrW2H/6Gmbh8ADEcaunsxOS5nZp3KzKA+I1V8LLy/+anfd0FCWUtCt5D8PLnkc/09S1Zrjf0DBqDXF9tXCg8lh54RdSaCPtbHYFFsTMufuIjgf1DQALQBLZIJG6FCfJWas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202382; c=relaxed/simple;
	bh=lluafLLQeeo2AuTO+6C62Oie8+3t2kap/gM/nsFIWHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qreq9mUfhfjik5EB53O6Vmo17Cwm/2Iak4pKG2iQMa/6VKAQp2bE9vLQYDG9CDcJ/Q/AStynaOGC5FymBgPW4vG6XgsgjmN5qAC78uk3kokKsFKcvoOU7gMueHNLqx06r1gY7uDYd1YrSsyBK3davY6+HcYP/tB0/Q2Qf9r5PhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPZGLQM9; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPZGLQM9"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67489c8202cso494919d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 18:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792202379; cv=none;
        d=google.com; s=arc-20260327;
        b=IBju9DtDzQX+bpH45xvDbtKJZXuH6OjVm4dVKDvZMeGHsopum7ghbjLWUBukH5Irrn
         Y7DPAXrNJs2kPGkux/VOHUQvzItCFw+Gc+OGINpz1ZWspdcBnISbG6uTaZv53jka8N0K
         brEyX/ER/fU2toN3/+TsTQGfkPJfsnhqQxIVA+ktM4Dou+UtQ2xPPZHDPEAj8ICSrX/I
         qbzVBYOFcRVUEAH8beFJ88Tg5NvtL7w2omiqW+5fvmYUuZStK81XF4yd4FIZLNpbAgIY
         ajjCzeOYI39g0I8JTd/1BApIG4lTdN8f2oSeczXpECYlwG1g9knv4kKxntmLIfN5IkKk
         5vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cG9ATYqMl/y18XgW8djL6SHSrSp+vtak/e3H6LudwE4=;
        fh=VHk6XtdLQi8Rq7RAuGoWWyaSuWmi9BsKqHjxjyYh62o=;
        b=NkxZsh/4T4BMr813n4Q/k+DgzW8kD8JBdlS+E5ZZEVxIITO0nWS1/IB4Qw9LDcwHPv
         NDpA1PIZF5Wsrfk+v5FGAZnEdeT/2KdnZ8TKCU0XVL/j3IcvshVYoPVhxEN0ORLvx7Jn
         TY5pd/6IzTO58scBCPU+QKLgMc2A+Fai+FHDdG5/XT/UuBdHxBmvp8ajGpgmShQEVQbj
         b0Q2I2PhfpBzRZReKeDGH/o16ogfy+TZLQXdjZ3XporcoVheas0ouFzwBYdEkmnOG0uX
         dQJL7p7JOLjrQLPqTQyD6tX7R6dNUh4/pk3XOs/VAg3DHKUjpGEPqO61PFluGdzdKVKt
         q2rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792202379; x=1792807179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cG9ATYqMl/y18XgW8djL6SHSrSp+vtak/e3H6LudwE4=;
        b=YPZGLQM9LKK/sxC85q17uyigRrGtvxhPcpSLKIAly4iq+NQE1ZodPwjHZYI1nQK9+P
         +2bKE8HTE27u2O2gCIEqH1K3/U/Sqnos4GDnIyods0zlBdT8IXuP2zdvdPPBfyS/EjMW
         mtBAj5gleW1uDAmJ/PGyjtzMyRO/Z2chB9V1U+vrOPdHYMNRwrbcJ7jq4XxAg7rf7Q95
         p9ALwuShLefRlAgk0dLN0nrxXkSm0yRLSPlO75N9Mo9lsj+AMitjaZElI/oCtQtToUYH
         I6aKZe4fsOpFgljzH7Rct4sdYmll6UVXKmbX10IdWSXkksd12knxvKALHKuMJkNJJyUp
         rdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792202379; x=1792807179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cG9ATYqMl/y18XgW8djL6SHSrSp+vtak/e3H6LudwE4=;
        b=I0452CYYFjPHNEu1zGVonm+nWKGRF5NFi0paMZ/YC8gXbYCYrcQIcFQdSW/JmklmpL
         K1d6wz0J8kbxsVsM9Ri4L427W9WqFoJcDaHa+Mu7+7WcsMRng2FCxeG0HsyaH3l2cxEu
         WGvCnm587cig4T/5YXtNzrRIe4OG58KzZPb13Mxn5tdPdDhpoFzbb3j25coOU07pEeCt
         qPK1CUkn6rVK7RjA5SJrX+tYyf/dQqut/ovhclcpcgvibRxFHb89frrFDobgu9jPW2GU
         cWYwQQ+Yq49y9LmpzFZGyWMTGl3B7MazFXnEi6qA8JRj3p4glInV3YlQu5ykcnRexd33
         I/FQ==
X-Forwarded-Encrypted: i=1; AKwUvBze1eo5XtyCoPj3fwSWQ7SB60uWrZoLocNnklbzKVBK7kgqavN6pIsSiOBf2RL8HfqXJv2fbBYYlxlSmus7@vger.kernel.org
X-Gm-Message-State: AFq9FYKXN7wdTXCQB7iLfE/3Y4+TWrrJoYcaxh5OZGiqh4nIlvpJmje3
	nbTB+oOhRR7vUhDDzc/wJcGHUGuWb6ty6kj50PG9vlhP6/lpTqQOYwOOwkAUz2KwglKXRYSY3xM
	HQWGNUzGr7/ILKWdO3mxkG7h8rOF40pA=
X-Gm-Gg: AYBFou3tS2lPd9mkkA2HorAAYhZy+J/u4Ju9ovwc3CGxcT6En4XymoJ/GyYNRnmkkZq
	y4y1ziBetekxEZKT7w0/g3M+F9jBaSvSePcbSn3JhaNs1n0zgUz0NC/1ljUjwb9IUhZew65PZj0
	8DT9pckz2MFcB3CYVk8eheLv3XulNHzfmDGyui+RlssANsImZykb2c97Z8MRS7pMmsOLWKSAEZJ
	HS7iJhVPQ/whdtV3e8SSgnU5E93zJpPyvbN8WSc/fhOcYDeygpXRSKUK9j8eamqjWEEmm/w3R6I
	HoWVQtuKEwqd5xuCvRLeLSZ9APAPuPWr8X/DwqyuhhzIA4S1xuyayUOdr+aOiZJim6jhAPEID7Q
	A8jAq8vrn0g==
X-Received: by 2002:a05:690e:dcb:b0:674:a7b:a07e with SMTP id
 956f58d0204a3-679ca744120mr424310d50.29.1792202378667; Fri, 16 Oct 2026
 18:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
 <as3gQ8jfa_6eBf15@chenyu-dev> <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
 <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
 <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com>
 <atG4VXk4t-m8VubY@chenyu-dev> <CALOAHbDY6zLcEc4kGhC9GSFsOsREadkWN7Q4CmZuR_m_BMHAyg@mail.gmail.com>
 <bcabbe25-5b2c-464a-a22d-5375a342f938@intel.com> <CALOAHbALpHebACLUmvet_tFH_w-iK3TWpY52OhYTUVoLzoGKkg@mail.gmail.com>
 <8d1997019d00fad3f250c4df3f18c53dff25e054.camel@linux.intel.com>
In-Reply-To: <8d1997019d00fad3f250c4df3f18c53dff25e054.camel@linux.intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Oct 2026 09:59:02 +0800
X-Gm-Features: AclHuK-nWLmy9xCqiE3rlEx99gEKF6vkNm0ULanpBQ42g6oWCUWpeUa-WtIJ04A
Message-ID: <CALOAHbDGx-2MfHiUs2S5cWT9yWiKp_22kg-OFL4gtuGG4aCUAw@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing control
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>, ljs@kernel.org, 
	Li Zhe <lizhe.67@bytedance.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	tim.c.chen@intel.com, mkoutny@suse.com, tj@kernel.org, chen.yu@linux.dev, 
	Vern Hao <vernhao@tencent.com>, Vern Hao <haoxing990@gmail.com>, 
	Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 4:32=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Fri, 2026-10-16 at 16:18 +0800, Yafang Shao wrote:
> > On Fri, Oct 16, 2026 at 4:01=E2=80=AFPM Chen, Yu C <yu.c.chen@intel.com=
> wrote:
> > >
> > > On 10/16/2026 3:38 PM, Yafang Shao wrote:
> > > > On Fri, Oct 16, 2026 at 1:51=E2=80=AFPM Chen Yu <yu.c.chen@intel.co=
m> wrote:
> > > > > A more complex scenario is when cgroup A and cgroup B become thre=
aded domains:
> > > > >
> > > > >                           root
> > > > >                          /    \
> > > > >                         X      Y
> > > > >                         |      |
> > > > >                         A      B          A, B: threaded domains =
(thread roots)
> > > > >                        / \    / \         separate memory.max / i=
o.max
> > > > >                      A1   A2 B1  B2       threaded cgroups
> > > > >                      ^        ^
> > > > >                      |        |
> > > > >                      +--------+
> > > > >                    want to share one cache group
> > > > >
> > > > > In the above case, we might need to change the deployed cgroup hi=
erarchy.
> > > >
> > > > I think we can enable LLC-aware scheduling for both A1 and A2 =E2=
=80=94 does
> > > > that sound right?
> > > >
> > >
> > > Here A1 wants to share data with B1, but A2 does not want to share da=
ta
> > > with B2 nor B1 nor A1. Enabling cache-aware for A1 and A2 might not h=
elp
> > > in this case.
> >
> > I'm not sure whether this is a real use case or merely a theoretical
> > one. I'd suggest we not focus too much on purely theoretical scenarios
> > unless someone can demonstrate a practical need.
>
> In our discussions with Vern Hao from Tencent, they have use cases where
> A1 and B1 are dealing with data compressions while A2 and B2 are dealing
> with databases.  So data are mostly shared between A1 and B1, A2 and B2
> due to functionality.  We may put the parent A or B in the same sched gro=
up,
> but the sched group may contain too many threads to fix in a LLC.

Good to know. While I'm not sure why it's deployed that way, I
understand that real-world use cases are often complex.

>
> The tricky thing is if there are scenarios where
> we want to do grouping one way when we consider resource
> usage but another way when we consider data sharing.
>
> >
> > >
> > > > >
> > > > > Suppose threads in A1 and threads in A2 belong to the same proces=
s Pa,
> > > > > this reminds me of the cgroup bpf NUMA balancing case: after enab=
ling
> > > > > NUMA balancing for A1 but not setting it for A2, what would be th=
e final
> > > > > NUMA balancing decision for process Pa, is it enabled or disabled=
?
> > > > > The NUMA balancing scan/invalid seems to be per process, so if we=
 change
> > > > > the setting of its threads, the whole process will be impacted. O=
r maybe
> > > > > we should not enable NUMA balancing for threaded cgroups? Anyway =
I haven't
> > > > > digged into your cgroup bpf patch set yet, let me try to look at =
it.
> > > >
> > > > cgroup NUMAB works the same way: the setting is per cgroup and opt-=
in.
> > > > For Pa in your example, since its threads spread across A1 and A2, =
you
> > > > would enable it on both =E2=80=94 enabling it on only one of them i=
s not
> > > > meaningful.
> > > >
> > >
> > > I see. I haven't yet digged into your code, is there a per cgroup fla=
g
> > > cgroup.numab.enabled?
> >
> > Right. I will introduce a cgroup::numab_mode field, but without a
> > cgroupfs interface file; it will be written through a BPF program.
> >
> > > Would there be a logic in the kernel, when
> > > A1.numab.enabled
> > > is written to true, the kernel detects all the other cgroups {X} that
> > > contains threads
> > > share the same mm_struct as A1's threads/tasks, and then update {X}'s
> > > numab.enabled
> > > to the same value as A1, to keep consistency?
> >
> > We have no plan to support threaded cgroups for now. If a real need
> > arises, the BPF program can be extended to handle it, which would just
> > require more kfuncs.
> >
> > > In summary, if threads are
> > > spread
> > > cross different cgroups, when you set the enable flag for 1 cgroup, w=
ill the
> > > kernel iterates all the other cgroups to update their flags as well? =
Or
> > > leverage userspace to do that?
> >
> > I believe this should be implemented in userspace, not automatically
> > in the kernel. Use cases are always complex, and flexibility is
> > important here.
>
> I think there is a misunderstanding that using prctl necessarily mean
> we have to modify the user programs.
>
> With the prctl that Chen Yu and I proposed for cache aware scheduling
> [1], the application does not have to change at all. The prctl can be
> issued by an orchestrator daemon on other tasks:
> the caller passes a target pid and a pid_type (thread,
> thread group or process group), and the permission check is
> ptrace_may_access(), as in core scheduling. So a daemon run by the
> platform team can put the application's threads into the right cache
> group from outside:
>
>   prctl(PR_SCHED_CACHE, PR_SCHED_CACHE_CREATE, leader, 0, PIDTYPE_TGID);
>   prctl(PR_SCHED_CACHE, PR_SCHED_CACHE_SHARE_FROM, tid, leader, PIDTYPE_P=
ID);
>
> The daemon can take its policy from wherever is convenient: cgroup
> membership, the pod spec, process names, or a config file. Changing
> the policy means changing the daemon, which the same team owns. That
> is the same round-trip as changing a BPF program, and no application
> team is involved. This is how schedqos already uses the core
> scheduling prctl.
>
> That said, we may start with a per cgroup control of
> cache aware scheduling that sit next to the prctl [1]
> without either one replacing the other.  A lot of the
> code in [1] can be reused with per cgroup control
> of cache aware scheduling.
>
> It starts small, in the form Tejun suggested for NUMA balancing
> in your series [2], and grows only when a real need shows up.

That's great.

>
> The rule for every step with a BPF based cgroup interface:
> the per-task p->sched_cache_grp from [1]
> is the only thing the scheduler reads. Each interface is just
> another way to set it, so the scheduler side never changes.
>
> Step 1: a per-cgroup setting
> ----------------------------
>
>   - struct cgroup gets a sched_cache_grp pointer and a mode:
>     inherit (default), off, or "this subtree is one group".
>   - One kfunc sets the mode by cgroup id. No cgroupfs file for now.
>   - The kernel puts tasks in the cgroup's group:
>       - when the mode is set: allocate the group, publish it, then
>         walk the cgroup's tasks
>       - at fork: in sched_post_fork(), right after cgroup_post_fork()
>       - at exec: exec_mmap() installs the cgroup's group instead of the
>         mm's one
>       - on migration: in cgroup_migrate_execute(), next to the
>         ss->attach() calls
>   - A task that was grouped explicitly (by the prctl, or later by BPF)
>     keeps its group. Cgroup changes do not override it.
>   - In the "advise" mode the cgroup's group is created enabled, since
>     a new group starts disabled there.
>
> This reuses most of [1]: the refcounted sched_cache_group (patches
> 1-3), __sched_cache_set() with the pi_lock swap and the footprint
> transfer (patch 4), the fork and exec handling (patches 2 and 4), the
> per-group enabled flag (patch 5) and the always/advise/never mode
> (patch 6). Only the prctl UAPI itself is not needed.
>
> This covers the the case where the sched groups match well with
> cgroups: cache aware scheduling can be turned on for group A
> only. The other part, a footprint threshold for A that differs from
> the global llc_aggr_tolerance, would need a per-group tolerance that
> the per-cgroup setting can carry.
>
> Step 2: BPF picks the group
> ---------------------------
>
> Add kfuncs to create, read, set and reset a group (thin wrappers around
> the same code), and one that stores a BPF-chosen group in a cgroup.
> The kernel still installs tasks at fork, exec and migration as in step
> 1. The difference is that two cgroups can now share one group, for
> example A1 and B1 in one sched group in the above example.
>
> Step 3: BPF decides per task
> ----------------------------
>
> Only if someone needs it: programs on the fork, exec and cgroup-attach
> hooks that set a task's group directly, for example to split a cgroup
> that is too big for one LLC, or to group only some of its tasks. The
> set kfunc takes pi_lock, so it needs a context filter that allows it
> only in sleepable programs and those hooks.
>
> Each step stands on its own. If step 1 is all anyone ever needs, we
> stop there. The prctl stays for users who do not run cgroups or schedqos.
>
> Does step 1 match what you have in mind for the LLC-aware scheduler
> on your servers?

Thanks for the detailed explanation.  It works for me.

My original idea was a simpler cgroup-field-only scheme: store the
mode on the cgroup and derive each task's group from its cgroup at
lookup time, which would avoid the fork/exec/migration hooks. On a
closer look that does not hold up for LLC: the prctl can set a
task's group explicitly and that has to keep precedence, and the
footprint estimate has to move between groups on a membership
change. Since most of the infrastructure is reused from the
prctl()-based series, I'm fine with implementing it that way.

Please Cc me when you post it.

>
> [1] https://lore.kernel.org/lkml/cover.1787955777.git.tim.c.chen@linux.in=
tel.com/
> [2] https://lore.kernel.org/lkml/20261012120438.52849-1-laoar.shao@gmail.=
com/
>
> Thanks.
>
> Tim


--
Regards
Yafang
