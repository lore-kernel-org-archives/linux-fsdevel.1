Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDD145B3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119263; cv=pass; b=YRaUSshRhfP5BA0D7iuQAI1VmFPVpVYAH/Vp16COPawCNlHaMFhFMQAsqSeZjpCSd+vF925JMY6MOaREtpTEWHDvDvfB8OKrYc/muDXVnjoTf6RRS/IdSAOETMZMnE1TwS5KCCixY9F3t324ubsbQKWraaDJKvt0mXTNnwRy/Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119263; c=relaxed/simple;
	bh=us/11YAXNZAJTaNhyo9E62+zmvvW7qcD47cClAcfiSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wyca7d7wXOZk3l/LriOvfExV1tTvhyCkCsKVOZGq476tJmefbOcEwe8E3/KcDnzln0OLkNei8kJc81QwakxH8ceEqEfWlM78SSWyGJfWBlk4Q1YHNr8m5lCywRAeeZhlseNCwIoM4ygHQj1lFm4tE9HFV6jC41axttIN9bdxWjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOAASw0F; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOAASw0F"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6768403e9bbso5300866d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 19:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792119261; cv=none;
        d=google.com; s=arc-20260327;
        b=eJNYB3gU3LBHhXJU6zyRxUFbhhk4FzNTy+r48h58odxbiH4Fi/cxai4EwkpsZI/yFX
         Pw8H0VPjzueKN02ABSiP9QvEepyVd2nJG56eleqBVMrskVK2V/zMI3hSF+YzkOiLoBxs
         ZVJYE305yJR0QKAAZbwzJTDnPVrwbML7dE+/87O87ipSamOPGzX8QLVzneVPHUDqcb03
         lLzUDzmmFC2g+txjDRDWm3oHm/ji/L3s6zy0HLWel3XXa+KW/V2+3BFZ8X4fm0uo7oXx
         mJcsILvafSeKfIDgklt2AH1iuMxXwEUoe7aWZ8eyD6t2dEpxno1Sm3G2xF/Dmuff/xCj
         vPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JyIFEq0u7TVUkNhoCer0bct9PHOlpUfGx4eaHSe+U3s=;
        fh=U3vla0BllXlGYqqezvUyonHOCbyJQ3YLBbXnUTm/C3w=;
        b=GsidFA4JyVyG8LM6JuZZhS8Vk204HFY5obVb2xeTXUuw5uSULAQbYMOGFPMUlPBHt6
         r4HpXEfaEGjD2zcQx4HFJylzaUIP1ib/aFoBWDTY0WetOfisLdUIaXhuEDvuE+Qo6/C/
         Hk0YP9TD2Y/O5kphbZDIrQop9dRNo/6jrtvd++MyGOilgksjWALizKJNi070pFFc4cU0
         vk9UVib+7+TrNITzb4lLvXtncujUlGxkKov8pjYXNw/p6z40Vh/8pSIoNEATqpWizPLJ
         CFStzBrgmtlaEoZPYF4bBpCMXvnILBLdg0U/gGZG053OTQSQxvbKV4mTAbGLfZe1/gtZ
         K2hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119261; x=1792724061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JyIFEq0u7TVUkNhoCer0bct9PHOlpUfGx4eaHSe+U3s=;
        b=VOAASw0F/ltYp0O7Z/4NwzoZtg3+BBxiQywkf3+3ReUBuA5nD1Mw5tQDgtzgoc5GVP
         zVKb1RF/I9SP0eS5jGg8GJnYr3+59GosM/DPnuBgTt0DK4x2LYG6Y9ykqxFIwuEj6UBH
         4in/US3aY7xmS1Fbya/FZcnWfkbkrnt/f4PO57sWkV+tc0kQ3Ru/vQLQWcwFID5G98jc
         NSAxy+xiPqC2eq2ZhJLHNPx7xctj1VzFjU7lfn1hzK9KusNga8PQnvmfzpXMw718jfPr
         UfUZI/54FCExS8paKX0oWTSCJ6gX84LjxeHuSq9IAjeRw695Hixvh7R1x+DLFpV3d+Vx
         x4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119261; x=1792724061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyIFEq0u7TVUkNhoCer0bct9PHOlpUfGx4eaHSe+U3s=;
        b=pUWKWzKG/TCAbh0ajHcUWwDWTtjVWU9AdCgLL7SGJq2Cal7r8YAZdDemaPwSU6Q20x
         5Fejrypp+KUoHPkIjSpgf8UlaEPN04M5WrdRa+VS5o/QpdZ2vEQ81XV+EukBoyQPYsKI
         Rvz9Iwj4hBmRq5HSujXo3eEut3pKq5Bsd653LUKW2S7h6hxC3tq9J0Z7Pvah+bCXXZ4y
         KMhFmX8b0y917pUsZ4ht+gbFu20DcWMkTb4YbKxvPbqTxFDDmCJGwPsuE74q1DNxoYei
         pZjl6bxLNDhV6Nz/hrEe0vsTGwNAFvhZWqWAKqDiSR7MtcGxy+K9VmlPuXMKU5yjaPOk
         f6+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTYJiQ1h5ArtJajMwJJ8udynaOz9GUwmGaupxoYjtJXRKD1P7mNfIRVJXAnoFC86gHXeYI/q2+YmZFSj1q@vger.kernel.org
X-Gm-Message-State: AFq9FYK3CgDkonO6gd+JJeGl8ltWXgQFjGv9VzCx13oxyZQ6VijgN53+
	UP3VBN9NeUEFEYiRHfuUbLgsEErFhTtkKUUiktLke08GPfYB9u7qOUJd8XKSYv9GY21OoP/Y66Y
	XDJHbSxjiQsETSWDnkrY/zqjBRQ5UhFM=
X-Gm-Gg: AYBFou0+yZE5eLYmFUCbKyc2h4Gok9Xi3oYWwslFezV26Mud6np6LFqmsoYRJtRJlSf
	fpUJzTc+/yaV6U9SkQ1Z6j3xUlwNBeJrO3nGhOTrQxvUVBopjKDNiBsReRROwDfUt8BKftLTmRy
	iWrvbCkupy8X2n31Unr/RBv9R9+bnrTCVxmcbFOuJRKgG4oTvTHxLOTZ29wcwaaFCYk17iRIZFV
	2/EJ3/mWGx4fIdvFS7VslsRtBRlqGp7W0iBVyq/GFVilhjN/r45jhWvVK9pMN0P0J9d0ZPWcqYJ
	8xxDZgOtC7O3TVfaoE3PC8RjgtEbt+TMSK9S2a68TBKcJjOAlwQEcvsyvHX/dulQtwSvF+zvBJ8
	Yb6urtepAwg==
X-Received: by 2002:a05:690e:4391:b0:675:7425:2524 with SMTP id
 956f58d0204a3-67936aa3dbamr5234450d50.81.1792119260762; Thu, 15 Oct 2026
 19:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
 <as3gQ8jfa_6eBf15@chenyu-dev> <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
 <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
In-Reply-To: <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 16 Oct 2026 10:53:43 +0800
X-Gm-Features: AclHuK9NvOmDvMmMhzfhk4kvGNPZ2SAyeDlPkOeYdYrkbV0ocflHS9n1Sl7gAjU
Message-ID: <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing control
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>, ljs@kernel.org, 
	Li Zhe <lizhe.67@bytedance.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	tim.c.chen@intel.com, mkoutny@suse.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:58=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Tue, 2026-10-13 at 17:31 +0800, Yafang Shao wrote:
> > On Tue, Oct 13, 2026 at 3:52=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> w=
rote:
> > >
> > > On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
> > > > Automatic NUMA balancing is controlled globally through the
> > > > kernel.numa_balancing sysctl and can be influenced indirectly throu=
gh
> > > > memory policy. That works well as a system default, but it is too c=
oarse
> > > > for workloads where a launcher wants most processes to use the defa=
ult
> > > > policy while a selected process opts out because it already manages=
 NUMA
> > > > placement or cannot afford the sampling overhead.
> > > >
> > > > A recent per-cgroup proposal tried to address this by adding a
> > > > cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode where
> > > > balancing was disabled by default and then enabled for selected cgr=
oups
> > > > [1]. The discussion also noted that automatic NUMA balancing alread=
y
> > > > operates at task/process granularity, that the knob is not a resour=
ce
> > > > control attribute, and that task/process controls such as sched_set=
attr()
> > > > or prctl() may be a better fit while cgroups and cpusets continue t=
o
> > > > describe workload grouping and placement domains.
> > > >
> > > > There is also prior art from 2023 prctl() proposals [2][3]. Those
> > > > versions used a per-mm mode with disabled/enabled/default states, a=
dded
> > > > NumaB_mode to /proc/<pid>/status, and changed the global static key
> > > > handling so a per-process enable could override the global sysctl.
> > > >
> > > > This series takes a more conservative variant to preserve existing
> > > > administrator and workload expectations. Keeping the global sysctl =
as a
> > > > hard off switch means an administrator can still disable all automa=
tic
> > > > NUMA balancing activity with one knob. Using a weak two-state
> > > > per-process opt-out/allow ABI avoids exposing a "default" state who=
se
> > > > meaning depends on global policy and is therefore easy to misinterp=
ret.
> > > > Storing the configured mode in signal_struct gives the control expl=
icit
> > > > thread-group semantics and avoids making unrelated non-thread CLONE=
_VM
> > > > users share the policy merely because they share an mm.
> > > >
> > > > The series implements a per-process interface: a thread group may u=
se
> > > > prctl() to set or get its configured automatic NUMA balancing mode.=
 A
> > > > process can opt out of new periodic NUMA scan scheduling and NUMA
> > > > scheduler accounting, or opt back in. Existing hinting faults and q=
ueued
> > > > work are allowed to drain naturally as the disabled state takes eff=
ect.
> > > > When kernel.numa_balancing is 0, a process-local enable request doe=
s not
> > > > override it.
> > > >
> > > > A separate task_struct scheduler snapshot is used by enqueue/dequeu=
e
> > > > accounting so the scheduler can consistently account the state that=
 was
> > > > in effect when a task entered the runqueue. This avoids changing
> > > > historical task accounting while still allowing a process mode chan=
ge to
> > > > take effect through the normal dequeue/update/enqueue path.
> > > >
> > > > The series also exposes the process NUMA balancing mode in
> > > > /proc/<pid>/status and documents the new prctl() ABI and its intera=
ction
> > > > with the global sysctl.
> > > >
> > >
> > > Can the global key be extended to tri-state, like the THP settings?
> >
> > IIUC, a BPF-based THP policy is yet to be developed as prctl() doesn't
> > fit some use cases, especially mTHP.
> >
> > > To keep it backward-compatible, echoing 0 and 1 remains the same effe=
ct.
> > > The user can also echo always, advise, or never to it.
> > > We have a similar proposal here for cache-aware scheduling[1]
> >
> > We are also experimenting with the LLC-aware scheduler on production
> > servers, and we want to enable it per cgroup rather than globally
> > there as well.  Given the lessons we have learned from THP, what
> > about implementing it as a BPF-based feature from the beginning, so
> > that the semantics can still change when new use cases show up?
>
> Some questions about per-cgroup based cache aware scheduling:
>
> 1) What should be done if you want to group specific processes in differe=
nt cgroups?
> It may not be desirable to put them together in the same cgroup for other=
 reasons
> like IO or memory resource policies.

Do you mean a multi-container pod? The policy can be applied at either
the pod level or the container level.

              Pod            <- policy applied at the pod level
          /              \
  containerA  containerB   <- or at the container level

This is essentially a cgroup hierarchy: the pod is the parent cgroup
and each container is a child cgroup, so policies (IO/memory) can be
enforced at either level.

>
> 2) What is the inheritance rule for cache grouping of tasks in a cgroup
> with child cgroups?
> There may be too many tasks in parent to try to fit them all in a LLC whe=
n
> there are only certain subset of tasks sharing data that should be groupe=
d
> together cache wise.

Generally, a cgroup contains only a single main process in most use
cases. If multiple tasks have to share a cgroup, they are either
identical tasks or tasks with different priorities =E2=80=94 in which case =
you
only need to focus on the high-priority ones. That's how it works in
practice.

>
> With prctl, we can be precise in grouping only tasks that we truly
> want to be together.  If we want to bunch tasks in a cgroup cache wise,
> it is easy to write a daemon to put tasks in a cgroup into the same
> cache group.

I'm not a big fan of the prctl() approach in practice. Deploying a
policy that way requires coordinating with other teams, and the policy
may well need to be adjusted later =E2=80=94 every adjustment would mean
asking another team to make changes, which is a painful round-trip.
With BPF, on the other hand, all the work stays within the kernel
team, and it's completely transparent to users.

--=20
Regards
Yafang
