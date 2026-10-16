Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870A42467C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136366; cv=pass; b=lwso0kjsQ4SvR83krwluME9jHP0R8kaSmcK9dsbmBnfb21GH7nc6vK4sHMk+nSEJIAAINwLEHT/9XdIakIVa8WaE0cGQzcO8lzCy5V+CVcUT2Vt/aMb7D/6SanUh3ddJKpCae09837sV0Z6sk/qDvBc/sD1TkKJL35Cstj4YSA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136366; c=relaxed/simple;
	bh=5U73rr9sf2Vf/AY5m/BZoHWAKZGP+xInuHRX+dX+CPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riFzpqyCEdqFDibt7NcBL2QzNfRnv/z2tI8O3XHOTxnY+nKDaExD4CrxCNq6L2QztESHI+G4QlXB81F0GbglBNxB1jo6s9eMZg9F1ae5Kd/nkA0Idz2luMGOfT7KXZynkED63k3vvQ3K0k0lB8IlSbq9ZnJ/WX6NxO+sTFLgai0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnRvXkKO; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnRvXkKO"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8acda240937so49755977b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 00:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792136363; cv=none;
        d=google.com; s=arc-20260327;
        b=pEaX1+Vi5XyZwHKbCyId7Nn9XvMiZvtDdgM+4qgpf7PG2H+BgyGC4WY5bk4hRyT3IV
         kDohIU4FfxlqQVv5utQm9LxnVh/Za2TfFDScDOVhdBmvDVGbV9T1MJVyuPCik1Hc2+qN
         QkaRUpA3uG/X3MtyRTqo44WpUwdgbOAjjLQ3o3ANZIUdTmCePtZcrK0JNU9/a+JIul6b
         vdJ7fBWHP/t3rRvm/lFEvDE/O/XO4SAP638k44MaNsUq+f2cuAvBWaCAnFGGKEb9bk3O
         T7hXS0t0fLSPii2/HP3hd7WYxD2oLy4Stgp7TAzkym7M9nTmXoVAYvjKvCr1/EPyZbqt
         FD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Q+JD4cCc17ecbqzQFbNtgZQCDVQmV0Gk8J5DPqRIwc=;
        fh=bE+0ja59x8DnJX6eJ9zWStiXI/bFqhaqZXnt58y91vg=;
        b=GQ014SIcwdzgOdPQkdzFRqNkK15o7PB0DeQ/IERaFnUZlhRB5K6iOaTrhbALs/U1a8
         9CbjZZ8rZbzZNMSFzXTWxqEQpjnItKRkL4dUxj70TLd5gjAKTlDwBsjTx0cOybtChsxA
         TX3oR5uQaijkbC//ZuBgu5k4+RIPI48MFefHjsyFS1eEKyZSovGIHZBdUEAzppIYH7he
         m1CjWd9iXL/jiX+QMEmykWFCBAsdApLnD8cmn40tYvLeKbl3Uz8b9LgSNh4SnKYbwm58
         5Z/NrlGgUAtZ//hSTZSHlPKQClHd1GJTFsU4134H6uVtsnphFNMMQBP7goN4xBk4nQyM
         2IPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792136363; x=1792741163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Q+JD4cCc17ecbqzQFbNtgZQCDVQmV0Gk8J5DPqRIwc=;
        b=VnRvXkKOE8YXsp+tsPBy2T28WtZ0Yk4i+bmW/pdXBUWLuTEdxzcnpXjv7/tvxGA3zq
         ju9mruVrKx0+5fRXGojPlLsAP0X3hCHdORbha5Tp0HRP15th9uzLpDn8RpeRltNMpbkB
         3shFFyroslHPAgMcJ4FzP1zj4Kr8M+0bTcWkCloKuNYswVMMpXQ0XCg5naxyOm602J+v
         hbzXDgCbZKq+Pc2utr+CLubzc1ey1FqJNKSSfgz/fBpyACPnpvX9+ciiR87ooL++3+6S
         m18whRMOIWiR8aQDpTwDryVlY0d2b6oRaIDcZH/8Ow3I+5zHl23mJuH+NUSdLbAmEpwi
         VZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792136363; x=1792741163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Q+JD4cCc17ecbqzQFbNtgZQCDVQmV0Gk8J5DPqRIwc=;
        b=LElx+w4DZxctQKJwS9CVwQ9dt6nCPchonHaepDHEf2uzyy+82H1122BFw/qexDQ/AE
         zW9F0U32pXU9NZAg7Zujdj9Q3qAKEtbtN1QWogmPlRCi/cdGnDN6bpm0vCZWMpkrGu9+
         fb6OjjR1MG2n8gV5GNThm/XPxnuZsBoNexCT1QzpHm6FbjesLSljpE69wjflHsdvlh9q
         VokS419vwM7Vcth+I0zTYVmRZ82eGxZKsuueNpo9lJL5je2HrbPe3w0oFol8k85Is/yd
         ZVW9ZrCVdHIa3R38yV9skRrW5jdOBvaM2nHL8N4Rfg7XwZqYEs6c7FgrOcMia/6614KZ
         QFUg==
X-Forwarded-Encrypted: i=1; AKwUvBxMkP/5hRQJClXoynfH3OUdJVsyE+qVOGPhIi4nW8CMi1u0brAv9/DJfqTJPemRE5ONJDoXA5HhjMEG2w2X@vger.kernel.org
X-Gm-Message-State: AFq9FYKMvCpLUvBJQmpKUF2IUTCHUgtPUIaXYsDSQjtasbvBTEaytcAb
	oP6G5Hi+g2/7QG2Lamei5tdOLndtEtZm7maFeorWYLeIWfSC27XmslNVJYpguwNhYS5bfbh3Wsv
	4FpvbIHyVAGXn/hSRC8LvYOIWYFp3B8M=
X-Gm-Gg: AYBFou0tepEbc3wD/5/wqIaigKrI3k4NevciOcrulxcRYAB35pgP752mHQLPDKS0X7P
	v8fR+1n6f2ZQgHv6VxjqxnKSK32v7UoXCA4unn8B5cqmSnZ3mPbzjtLDt18DEYeoXzDZxX3El6+
	oSzKRyq6ToEAteNKqHfINmtbriqnkCvXq8I+05krtM/BYR04mMx+IlCidRqSIliHNHDF3acIObW
	bCvFnm1OxBzr4NA4J7UW6YMOHkmz879eyfyACSqbLQPej4icAMkZjHmheLSAuhswNFd3h8uqOPc
	P3vUdnleFGNqXhsyzePTwlwgByIirE3WMQapRcqWacRqPLNBbtPEjgxe4QfykXgQdkH19iu/j/q
	uPocl5XN+Dg==
X-Received: by 2002:a53:d009:0:b0:677:d251:ccc6 with SMTP id
 956f58d0204a3-6793605dda7mr4654300d50.71.1792136362980; Fri, 16 Oct 2026
 00:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
 <as3gQ8jfa_6eBf15@chenyu-dev> <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
 <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
 <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com> <atG4VXk4t-m8VubY@chenyu-dev>
In-Reply-To: <atG4VXk4t-m8VubY@chenyu-dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 16 Oct 2026 15:38:39 +0800
X-Gm-Features: AclHuK_wXpq3Lf7WsZdWi1-5HCj6GkVfntrB1p_kAXzYzhwNrdQc9sTzTGN5xWA
Message-ID: <CALOAHbDY6zLcEc4kGhC9GSFsOsREadkWN7Q4CmZuR_m_BMHAyg@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing control
To: Chen Yu <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, ljs@kernel.org, Li Zhe <lizhe.67@bytedance.com>, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	tim.c.chen@intel.com, mkoutny@suse.com, tj@kernel.org, chen.yu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:51=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> On Fri, Oct 16, 2026 at 10:53:43AM +0800, Yafang Shao wrote:
> > On Fri, Oct 16, 2026 at 3:58=E2=80=AFAM Tim Chen <tim.c.chen@linux.inte=
l.com> wrote:
> > >
> > > On Tue, 2026-10-13 at 17:31 +0800, Yafang Shao wrote:
> > > > On Tue, Oct 13, 2026 at 3:52=E2=80=AFPM Chen Yu <yu.c.chen@intel.co=
m> wrote:
> > > > >
> > > > > On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
> > > > > > Automatic NUMA balancing is controlled globally through the
> > > > > > kernel.numa_balancing sysctl and can be influenced indirectly t=
hrough
> > > > > > memory policy. That works well as a system default, but it is t=
oo coarse
> > > > > > for workloads where a launcher wants most processes to use the =
default
> > > > > > policy while a selected process opts out because it already man=
ages NUMA
> > > > > > placement or cannot afford the sampling overhead.
> > > > > >
> > > > > > A recent per-cgroup proposal tried to address this by adding a
> > > > > > cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode wher=
e
> > > > > > balancing was disabled by default and then enabled for selected=
 cgroups
> > > > > > [1]. The discussion also noted that automatic NUMA balancing al=
ready
> > > > > > operates at task/process granularity, that the knob is not a re=
source
> > > > > > control attribute, and that task/process controls such as sched=
_setattr()
> > > > > > or prctl() may be a better fit while cgroups and cpusets contin=
ue to
> > > > > > describe workload grouping and placement domains.
> > > > > >
> > > > > > There is also prior art from 2023 prctl() proposals [2][3]. Tho=
se
> > > > > > versions used a per-mm mode with disabled/enabled/default state=
s, added
> > > > > > NumaB_mode to /proc/<pid>/status, and changed the global static=
 key
> > > > > > handling so a per-process enable could override the global sysc=
tl.
> > > > > >
> > > > > > This series takes a more conservative variant to preserve exist=
ing
> > > > > > administrator and workload expectations. Keeping the global sys=
ctl as a
> > > > > > hard off switch means an administrator can still disable all au=
tomatic
> > > > > > NUMA balancing activity with one knob. Using a weak two-state
> > > > > > per-process opt-out/allow ABI avoids exposing a "default" state=
 whose
> > > > > > meaning depends on global policy and is therefore easy to misin=
terpret.
> > > > > > Storing the configured mode in signal_struct gives the control =
explicit
> > > > > > thread-group semantics and avoids making unrelated non-thread C=
LONE_VM
> > > > > > users share the policy merely because they share an mm.
> > > > > >
> > > > > > The series implements a per-process interface: a thread group m=
ay use
> > > > > > prctl() to set or get its configured automatic NUMA balancing m=
ode. A
> > > > > > process can opt out of new periodic NUMA scan scheduling and NU=
MA
> > > > > > scheduler accounting, or opt back in. Existing hinting faults a=
nd queued
> > > > > > work are allowed to drain naturally as the disabled state takes=
 effect.
> > > > > > When kernel.numa_balancing is 0, a process-local enable request=
 does not
> > > > > > override it.
> > > > > >
> > > > > > A separate task_struct scheduler snapshot is used by enqueue/de=
queue
> > > > > > accounting so the scheduler can consistently account the state =
that was
> > > > > > in effect when a task entered the runqueue. This avoids changin=
g
> > > > > > historical task accounting while still allowing a process mode =
change to
> > > > > > take effect through the normal dequeue/update/enqueue path.
> > > > > >
> > > > > > The series also exposes the process NUMA balancing mode in
> > > > > > /proc/<pid>/status and documents the new prctl() ABI and its in=
teraction
> > > > > > with the global sysctl.
> > > > > >
> > > > >
> > > > > Can the global key be extended to tri-state, like the THP setting=
s?
> > > >
> > > > IIUC, a BPF-based THP policy is yet to be developed as prctl() does=
n't
> > > > fit some use cases, especially mTHP.
> > > >
> > > > > To keep it backward-compatible, echoing 0 and 1 remains the same =
effect.
> > > > > The user can also echo always, advise, or never to it.
> > > > > We have a similar proposal here for cache-aware scheduling[1]
> > > >
> > > > We are also experimenting with the LLC-aware scheduler on productio=
n
> > > > servers, and we want to enable it per cgroup rather than globally
> > > > there as well.  Given the lessons we have learned from THP, what
> > > > about implementing it as a BPF-based feature from the beginning, so
> > > > that the semantics can still change when new use cases show up?
> > >
> > > Some questions about per-cgroup based cache aware scheduling:
> > >
> > > 1) What should be done if you want to group specific processes in dif=
ferent cgroups?
> > > It may not be desirable to put them together in the same cgroup for o=
ther reasons
> > > like IO or memory resource policies.
> >
> > Do you mean a multi-container pod? The policy can be applied at either
> > the pod level or the container level.
> >
> >               Pod            <- policy applied at the pod level
> >           /              \
> >   containerA  containerB   <- or at the container level
> >
> > This is essentially a cgroup hierarchy: the pod is the parent cgroup
> > and each container is a child cgroup, so policies (IO/memory) can be
> > enforced at either level.
> >
>
> My understanding is that Tim was talking about a case where A and B do
> not belong to the same parent (arbitrary hierarchy). Say, process T1, T2:
> T1 belongs to cgroup A, T2 belongs to cgroup B, T1 has threads t1.1, t1.2=
,
> T2 has threads t2.1, t2.2, and t1.1 and t2.1 want to be aggregated togeth=
er
> because they have shared data.

Thanks for the clarification.

>
> A more complex scenario is when cgroup A and cgroup B become threaded dom=
ains:
>
>                          root
>                         /    \
>                        X      Y
>                        |      |
>                        A      B          A, B: threaded domains (thread r=
oots)
>                       / \    / \         separate memory.max / io.max
>                     A1   A2 B1  B2       threaded cgroups
>                     ^        ^
>                     |        |
>                     +--------+
>                   want to share one cache group
>
> In the above case, we might need to change the deployed cgroup hierarchy.

I think we can enable LLC-aware scheduling for both A1 and A2 =E2=80=94 doe=
s
that sound right?

>
> Suppose threads in A1 and threads in A2 belong to the same process Pa,
> this reminds me of the cgroup bpf NUMA balancing case: after enabling
> NUMA balancing for A1 but not setting it for A2, what would be the final
> NUMA balancing decision for process Pa, is it enabled or disabled?
> The NUMA balancing scan/invalid seems to be per process, so if we change
> the setting of its threads, the whole process will be impacted. Or maybe
> we should not enable NUMA balancing for threaded cgroups? Anyway I haven'=
t
> digged into your cgroup bpf patch set yet, let me try to look at it.

cgroup NUMAB works the same way: the setting is per cgroup and opt-in.
For Pa in your example, since its threads spread across A1 and A2, you
would enable it on both =E2=80=94 enabling it on only one of them is not
meaningful.

>
> > >
> > > 2) What is the inheritance rule for cache grouping of tasks in a cgro=
up
> > > with child cgroups?
> > > There may be too many tasks in parent to try to fit them all in a LLC=
 when
> > > there are only certain subset of tasks sharing data that should be gr=
ouped
> > > together cache wise.
> >
> > Generally, a cgroup contains only a single main process in most use
> > cases. If multiple tasks have to share a cgroup, they are either
> > identical tasks or tasks with different priorities =E2=80=94 in which c=
ase you
> > only need to focus on the high-priority ones. That's how it works in
> > practice.
> >
>
> IIUC, what Tim mentioned is about the inheritance relationship: if cgroup=
 A
> has cache-aware enabled, will all its child cgroups enable cache-aware
> recursively? (I think the answer is yes, while for NUMA balancing it depe=
nds.)

Right. The cgroup NUMA balancing also works that way =E2=80=94 it is inheri=
ted
recursively as well.

>
> > >
> > > With prctl, we can be precise in grouping only tasks that we truly
> > > want to be together.  If we want to bunch tasks in a cgroup cache wis=
e,
> > > it is easy to write a daemon to put tasks in a cgroup into the same
> > > cache group.
> >
> > I'm not a big fan of the prctl() approach in practice. Deploying a
> > policy that way requires coordinating with other teams, and the policy
> > may well need to be adjusted later =E2=80=94 every adjustment would mea=
n
> > asking another team to make changes, which is a painful round-trip.
> > With BPF, on the other hand, all the work stays within the kernel
> > team, and it's completely transparent to users.
> >
>
> I agree that prctl has limitations, but it provides fine-grained control
> per task/thread. Besides, there might also be other users that do not
> deploy cgroups, so in such use cases, per-task settings like prctl or
> sched_setattr() could be another choice. For example, the schedqos tool
> in Google's usecase, and DeepSeek's reinforcement learning infra[1], have
> leveraged prctl to deploy core-scheduling to avoid noisy neighbours. That
> is to say, I don't think the cgroup-based BPF interface and prctl/sched_s=
etattr
> are mutually exclusive, they can be complementary to each other, IMO.

Thanks for the use cases =E2=80=94 they're helpful. I'm not opposed to the
prctl() approach.

--=20
Regards
Yafang
