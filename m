Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83147ECF0
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961573; cv=none; b=lJhddZ4KQVFsp24vIbbcD1esBKkjwlx0SeGpzJBD+NT4mw12FVJ+327dRnnLwfs9/5JDSXtezb5oldkWXaxAbut/hVJBQNRXafcUu5aCkKBTPZgBuvqK3WUHh0zD61OBzKEQQEPFb7olOcKw35UAAj9JHVZIEj5kfLp7HpBn9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961573; c=relaxed/simple;
	bh=VQrXm4GB+8ax5cOdddpF4esrQmNaanITzlIWjk0oXAE=;
	h=To:Mime-Version:Content-Type:References:Cc:Subject:From:
	 Message-Id:In-Reply-To:Date; b=SUlfxV40QvhrXzhfPG1bGnYb6vTyJgxhK/nu6wlue1RvrLFHg0OgWcDU/72jfIuhxYK0XlC8sOpzBxG3y39KgiEQ1+oQ7mc52CqwFm5NvzsBbt0394Y9OHyNnnSDMNEk412Nvx/PdWAi7by8glsBfAlecTw+KGY/edbv9NlggKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=l1MQQ70U; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="l1MQQ70U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791961562; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=AmY4dPyqQykotqM+kN48z0R7XzUceAJIO537k4Ko2W8=;
 b=l1MQQ70UOnvW1MObWFpTiOz4M3Lq5XFwDHQ+7RnObj4PO66jSwYIc6kNI+3bMiABi126Dm
 gYUjpPHE8K8QMGKgaA0Uz4qVI+PRpYSLNBQhXC0Bm16Z3f9kbeY0RxTm7q0UpReAQCf/Sq
 SxNivQY9IFHPdnLxt1Ux5PfG3Q9asuwPYTKZRg2CA4HCWmolJPxy+M/ZovbTXNUn1kfFDk
 RzLX5qCmIlkULjg69gHYb8ctHNFAtRs4x+/4axQD/fQQutoMdHUIcreJkQSr05YxqwEzVa
 x9dgSV8eBVx7R6q1BTgJDvyjFGnbKi7/CdNVmdvG1ZIjSK4IN3nO7xlAtBB8aA==
To: "Chen Yu" <yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
References: <20260908122446.56708-1-lizhe.67@bytedance.com> <as3gQ8jfa_6eBf15@chenyu-dev>
Cc: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>, 
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>, 
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>, 
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>, 
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<linux-doc@vger.kernel.org>, <laoar.shao@gmail.com>, 
	<tim.c.chen@intel.com>, <mkoutny@suse.com>, <david@kernel.org>, 
	<tj@kernel.org>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing control
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26acf29d8+c6e990+vger.kernel.org+lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <53b6cafb-ed85-410b-b7df-10897205630c@bytedance.com>
In-Reply-To: <as3gQ8jfa_6eBf15@chenyu-dev>
Date: Wed, 14 Oct 2026 15:05:30 +0800
Content-Transfer-Encoding: 7bit

On 10/13/26 3:39 PM, Chen Yu wrote:
> On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
>> Automatic NUMA balancing is controlled globally through the
>> kernel.numa_balancing sysctl and can be influenced indirectly through
>> memory policy. That works well as a system default, but it is too coarse
>> for workloads where a launcher wants most processes to use the default
>> policy while a selected process opts out because it already manages NUMA
>> placement or cannot afford the sampling overhead.
>>
>> A recent per-cgroup proposal tried to address this by adding a
>> cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode where
>> balancing was disabled by default and then enabled for selected cgroups
>> [1]. The discussion also noted that automatic NUMA balancing already
>> operates at task/process granularity, that the knob is not a resource
>> control attribute, and that task/process controls such as sched_setattr()
>> or prctl() may be a better fit while cgroups and cpusets continue to
>> describe workload grouping and placement domains.
>>
>> There is also prior art from 2023 prctl() proposals [2][3]. Those
>> versions used a per-mm mode with disabled/enabled/default states, added
>> NumaB_mode to /proc/<pid>/status, and changed the global static key
>> handling so a per-process enable could override the global sysctl.
>>
>> This series takes a more conservative variant to preserve existing
>> administrator and workload expectations. Keeping the global sysctl as a
>> hard off switch means an administrator can still disable all automatic
>> NUMA balancing activity with one knob. Using a weak two-state
>> per-process opt-out/allow ABI avoids exposing a "default" state whose
>> meaning depends on global policy and is therefore easy to misinterpret.
>> Storing the configured mode in signal_struct gives the control explicit
>> thread-group semantics and avoids making unrelated non-thread CLONE_VM
>> users share the policy merely because they share an mm.
>>
>> The series implements a per-process interface: a thread group may use
>> prctl() to set or get its configured automatic NUMA balancing mode. A
>> process can opt out of new periodic NUMA scan scheduling and NUMA
>> scheduler accounting, or opt back in. Existing hinting faults and queued
>> work are allowed to drain naturally as the disabled state takes effect.
>> When kernel.numa_balancing is 0, a process-local enable request does not
>> override it.
>>
>> A separate task_struct scheduler snapshot is used by enqueue/dequeue
>> accounting so the scheduler can consistently account the state that was
>> in effect when a task entered the runqueue. This avoids changing
>> historical task accounting while still allowing a process mode change to
>> take effect through the normal dequeue/update/enqueue path.
>>
>> The series also exposes the process NUMA balancing mode in
>> /proc/<pid>/status and documents the new prctl() ABI and its interaction
>> with the global sysctl.
>>
> Can the global key be extended to tri-state, like the THP settings?
> To keep it backward-compatible, echoing 0 and 1 remains the same effect.
> The user can also echo always, advise, or never to it.
> We have a similar proposal here for cache-aware scheduling[1]
> In this way, the user does not have to disable NUMA balancing one by one
> across the whole system.
>
> Yafang Shao has a bpf-cgroup based NUMA balancing proposal[2].
> Overall I support fine-grained control of NUMA balancing, and I'm curious
> what the possible setting would be in the production environment, would
> something like Kubernetes be responsible for setting the NUMA
> balancing attribute via prctl, or as Yafang proposed, leverage cgroup
> interface?
>
> [1] https://lore.kernel.org/lkml/fd341106e7e6cbd2f047656650f43ee87c6633c1.1787955777.git.tim.c.chen@linux.intel.com/
> [2] https://lore.kernel.org/lkml/20261012120438.52849-1-laoar.shao@gmail.com/


Thanks for taking a look and sharing the information.

A tri-state global knob sounds possible to me.

For our use case, Kubernetes or the container runtime would set the NUMA
balancing attribute via prctl(). Yafang's per-cgroup approach would also
work for us. If maintainers prefer per-cgroup control, I am happy to help
review Yafang's series.

Thanks,
Zhe

>
> thanks,
> Chenyu
>
>> [1]: https://lore.kernel.org/all/20250625102337.3128193-1-yu.c.chen@intel.com/
>> [2]: https://lore.kernel.org/all/20230412140701.58337-1-ligang.bdlg@bytedance.com/
>> [3]: https://lore.kernel.org/all/20230412141127.59741-1-ligang.bdlg@bytedance.com/
>>
>> Li Zhe (4):
>>    sched/numa: Track per-process automatic NUMA balancing mode
>>    sched/numa: Add prctl controls for process mode
>>    proc: Report process NUMA balancing mode
>>    Documentation: Describe per-process NUMA balancing control
>>
>>   Documentation/admin-guide/sysctl/kernel.rst | 16 ++++++++
>>   Documentation/filesystems/proc.rst          |  6 +++
>>   fs/proc/array.c                             | 16 ++++++++
>>   include/linux/sched.h                       |  6 +++
>>   include/linux/sched/numa_balancing.h        | 42 +++++++++++++++++++++
>>   include/linux/sched/signal.h                |  8 ++++
>>   include/uapi/linux/prctl.h                  |  6 +++
>>   init/init_task.c                            |  4 ++
>>   kernel/fork.c                               |  8 ++++
>>   kernel/sched/core.c                         | 39 +++++++++++++++++++
>>   kernel/sched/fair.c                         | 36 ++++++++++++++++--
>>   kernel/sys.c                                | 18 +++++++++
>>   12 files changed, 201 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.20.1
