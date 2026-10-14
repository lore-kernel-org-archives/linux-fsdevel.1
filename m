Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154337CD45
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962255; cv=none; b=n0wvVa46YukxFf+slybkCBuxZ8R0bqzXP/t4O4+E1G6PCj6oYSvhT/zLlyvMqPUjvaAjoxjkpvTPWYlQo7Q9gxNuv95sCwe5bxFtFgGRI+NLGRbK+JGZpP22p3+8h73PGIXCz45EMgUa/L1MdM765Y6JTbbbRVncxP9ZsFO+LH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962255; c=relaxed/simple;
	bh=Lyxb/ljVUGIYv53EwfhnyLAOTSAWk4dwq+OTLRvT/mQ=;
	h=Message-Id:To:From:Subject:Content-Type:References:Date:Cc:
	 Mime-Version:In-Reply-To; b=RTQC93krp0UXhbJ7wn8ZUf6d4mX8LGOY3580z2D1c6FiA5IltjMkW31m78Z8VTfKUyw+WKNhV3vapxUIJwndfpksoAsYNHCqqf59gycDbVorEPO81ieHyCRGvb0c1tBzw40FpdERBdqjvXhSDbKXMKMCi9VVlfViz+Xn/TsRHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=mtUFaRzc; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="mtUFaRzc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791962242; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=E+A3WkN+ZYsZ0u7Ki+dXZ6v5fK9tVuvIxVUW7XWhzyQ=;
 b=mtUFaRzciqyOFkuGODvmy0yuwO8iC62nVZ6kcuA4PgUiSSJcSF61iPnpY5k3S8jrAEnABI
 YBvfBL8V8aRK0bjq6+ewf2saotcbwlWhtEujLoe9XkLeJMUHpoCp5B9lWi8x7VLF6rQbKT
 1ktNxQxS4i1ZTNBQY8RTLmv/xRjzZPJWGLJ4uKBrsicEDmTCY65t61HHMw9icqEAjJoLa1
 qm2DFfchhjEHL2sRlpNQjlJOzXkakENnMMJJpRBef2GiEXD4va+kXFiJY9mNgUsT+IvQmf
 qqkSR088ZKWyK5Sbnf+J7vWUCS9IXd61hW4qsEdyxpqGVNR0PzYCxyiN8LWfaw==
Message-Id: <27125190-b343-42c5-889f-c7377084f5d8@bytedance.com>
User-Agent: Mozilla Thunderbird
To: "Yafang Shao" <laoar.shao@gmail.com>, "Chen Yu" <yu.c.chen@intel.com>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, <ljs@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing control
Content-Type: text/plain; charset=UTF-8
References: <20260908122446.56708-1-lizhe.67@bytedance.com> <as3gQ8jfa_6eBf15@chenyu-dev> <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Wed, 14 Oct 2026 15:16:54 +0800
X-Lms-Return-Path: <lba+26acf2c80+9da95d+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Cc: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>, 
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>, 
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>, 
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>, 
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<linux-doc@vger.kernel.org>, <tim.c.chen@intel.com>, <mkoutny@suse.com>, 
	<tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>

On 10/13/26 5:31 PM, Yafang Shao wrote:
> On Tue, Oct 13, 2026 at 3:52=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wro=
te:
>> On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
>>> Automatic NUMA balancing is controlled globally through the
>>> kernel.numa_balancing sysctl and can be influenced indirectly through
>>> memory policy. That works well as a system default, but it is too coars=
e
>>> for workloads where a launcher wants most processes to use the default
>>> policy while a selected process opts out because it already manages NUM=
A
>>> placement or cannot afford the sampling overhead.
>>>
>>> A recent per-cgroup proposal tried to address this by adding a
>>> cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode where
>>> balancing was disabled by default and then enabled for selected cgroups
>>> [1]. The discussion also noted that automatic NUMA balancing already
>>> operates at task/process granularity, that the knob is not a resource
>>> control attribute, and that task/process controls such as sched_setattr=
()
>>> or prctl() may be a better fit while cgroups and cpusets continue to
>>> describe workload grouping and placement domains.
>>>
>>> There is also prior art from 2023 prctl() proposals [2][3]. Those
>>> versions used a per-mm mode with disabled/enabled/default states, added
>>> NumaB_mode to /proc/<pid>/status, and changed the global static key
>>> handling so a per-process enable could override the global sysctl.
>>>
>>> This series takes a more conservative variant to preserve existing
>>> administrator and workload expectations. Keeping the global sysctl as a
>>> hard off switch means an administrator can still disable all automatic
>>> NUMA balancing activity with one knob. Using a weak two-state
>>> per-process opt-out/allow ABI avoids exposing a "default" state whose
>>> meaning depends on global policy and is therefore easy to misinterpret.
>>> Storing the configured mode in signal_struct gives the control explicit
>>> thread-group semantics and avoids making unrelated non-thread CLONE_VM
>>> users share the policy merely because they share an mm.
>>>
>>> The series implements a per-process interface: a thread group may use
>>> prctl() to set or get its configured automatic NUMA balancing mode. A
>>> process can opt out of new periodic NUMA scan scheduling and NUMA
>>> scheduler accounting, or opt back in. Existing hinting faults and queue=
d
>>> work are allowed to drain naturally as the disabled state takes effect.
>>> When kernel.numa_balancing is 0, a process-local enable request does no=
t
>>> override it.
>>>
>>> A separate task_struct scheduler snapshot is used by enqueue/dequeue
>>> accounting so the scheduler can consistently account the state that was
>>> in effect when a task entered the runqueue. This avoids changing
>>> historical task accounting while still allowing a process mode change t=
o
>>> take effect through the normal dequeue/update/enqueue path.
>>>
>>> The series also exposes the process NUMA balancing mode in
>>> /proc/<pid>/status and documents the new prctl() ABI and its interactio=
n
>>> with the global sysctl.
>>>
>> Can the global key be extended to tri-state, like the THP settings?
> IIUC, a BPF-based THP policy is yet to be developed as prctl() doesn't
> fit some use cases, especially mTHP.
>
>> To keep it backward-compatible, echoing 0 and 1 remains the same effect.
>> The user can also echo always, advise, or never to it.
>> We have a similar proposal here for cache-aware scheduling[1]
> We are also experimenting with the LLC-aware scheduler on production
> servers, and we want to enable it per cgroup rather than globally
> there as well.  Given the lessons we have learned from THP, what
> about implementing it as a BPF-based feature from the beginning, so
> that the semantics can still change when new use cases show up?


For our use case, Kubernetes or the container runtime would set the NUMA
balancing attribute via prctl(), and child processes would inherit this
setting. A per-cgroup approach would also work for us. If maintainers
prefer per-cgroup control, I am happy to help review your series.

Thanks,
Zhe

>
>> In this way, the user does not have to disable NUMA balancing one by one
>> across the whole system.
>>
>> Yafang Shao has a bpf-cgroup based NUMA balancing proposal[2].
>> Overall I support fine-grained control of NUMA balancing, and I'm curiou=
s
>> what the possible setting would be in the production environment, would
>> something like Kubernetes be responsible for setting the NUMA
>> balancing attribute via prctl, or as Yafang proposed, leverage cgroup
>> interface?
>>
>> [1] https://lore.kernel.org/lkml/fd341106e7e6cbd2f047656650f43ee87c6633c=
1.1787955777.git.tim.c.chen@linux.intel.com/
>> [2] https://lore.kernel.org/lkml/20261012120438.52849-1-laoar.shao@gmail=
.com/
>
