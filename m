Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4E269CE7;
	Sun, 17 May 2026 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999147; cv=none; b=PH+gEtgIH+vy/WQc1pK5WsQBpMTa8iEHYSJ8biu0zH2FqcvFXnc1I9S2EFgEObHCqWpQ9DOOWXmgC9fxy5qxlcs8LGZfPJx6KCvAA73szBhx5LVyCaB8FYjP+9cwr0fXxcMj769+fh2bzK8MqTobcIJWfE6myVRqc9/lYhs0yC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999147; c=relaxed/simple;
	bh=T+Nrx3jHlnBBymlDKEuLQS4V6m//F17Y01O6FS/MccU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIoezVx2SD8gm0vjDkQMf3bRHu4jvjycsFsQKdu5UKhPG0JeIRMHZm2XabCVJFP4Tr+K3XcyF0sP86h7A3c8+B6hQoAzUFFw2weh2mF003DniXwI5dq3izjnhOJIiLEbg/qjIFhpsx1eMkT0276Ho0FbrZaCD0XiW3Wh2msI35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EnowK34I; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EnowK34I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778999124; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Mk/Q97BEN9DTEMnW/yOcCCf2XefsaXKLO1fBs+w0JKE=;
	b=EnowK34IyOTNxcWAcc+dSmn0U3/m7TkpOTD2nsKTG/9m2vy8CLG4EVgFgiFjKbvxGWvrBJ5gU8+MxLRuN3iJB+8vxhtKU8rQnJFm8EItwV4JThj4IT08bwLooFKktKCpgkcq8k5T09r45Fk9Ok1y8ZXTg4QZNkikxuv8UnQsi3w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X31CJe9_1778999123;
Received: from 30.170.87.193(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X31CJe9_1778999123 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 May 2026 14:25:24 +0800
Message-ID: <4fb6a683-7197-46c9-8afd-8c2ddc3eaa10@linux.alibaba.com>
Date: Sun, 17 May 2026 14:25:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] writeback: fix race between cgroup_writeback_umount() and
 inode_switch_wbs()
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-kernel@vger.kernel.org
References: <20260513094829.867648-1-libaokun@linux.alibaba.com>
 <22cda97d61cc9d540d4e7116d5f3f08a@kernel.org>
 <a7f260f7-63a6-4e6f-99aa-0a4be29f740f@linux.alibaba.com>
 <mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/5/14 21:09, Jan Kara 写道:
> On Thu 14-05-26 10:55:03, Baokun Li wrote:
>> 在 2026/5/14 04:36, Tejun Heo 写道:
>>> Hello,
>>>
>>> Resending - earlier send dropped the Cc list. Sorry for the noise.
>>>
>>> How rcu_barrier() got out of sync, as best I can reconstruct:
>>>
>>> - ec084de929e4 ("fs/writeback.c: use rcu_barrier() to wait for inflight
>>>   wb switches going into workqueue when umount", 2019) put the inc
>>>   after call_rcu(); rcu_barrier() worked from then.
>>>
>>> - 8826ee4fe750 ("writeback, cgroup: increment isw_nr_in_flight before
>>>   grabbing an inode", 2021) moved the inc back ahead to cover the prep
>>>   window, apparently reopening this gap.
>>>
>>> - e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
>>>   switching inodes", 2025) replaced call_rcu() with llist_add() +
>>>   queue_work(); rcu_barrier() looks like a no-op for this path since.
>>>
>>> Could SRCU work instead? srcu_read_lock around the publish (atomic_inc
>>> through wb_queue_isw), with cgroup_writeback_umount() keeping the
>>> counter gate but swapping rcu_barrier() for synchronize_srcu():
>>>
>>>   if (atomic_read(&isw_nr_in_flight)) {
>>>           synchronize_srcu(&isw_srcu);
>>>           flush_workqueue(isw_wq);
>>>   }
>>>
>>> Thoughts?
>> Thanks for the detailed analysis on how rcu_barrier() got out of sync,
>> that matches my understanding as well.
>>
>> Regarding the SRCU idea: I considered it, but it has a key drawback.
>> synchronize_srcu() waits for all read-side critical sections globally
>> -- it cannot distinguish which superblock a given switcher is working
>> on. So if sb A is being unmounted while unrelated switchers for sb B/C/D
>> hold srcu_read_lock(), umount of A gets blocked unnecessarily. The
>> global isw_nr_in_flight gate makes this worse: any non-zero count from
>> any sb triggers synchronize_srcu(), even when the target sb has no
>> in-flight switches at all.
>>
>> This is especially problematic in high-density container environments,
>> where many containers with separate filesystems are being created and
>> destroyed concurrently. Frequent cgroup migrations across multiple
>> superblocks keep the global isw_nr_in_flight perpetually non-zero,
>> causing every single umount to pay the synchronize_srcu() cost even
>> when the target sb has zero in-flight switches.
>>
>> The per-sb counter avoids this entirely -- cgroup_writeback_umount()
>> only waits for switches belonging to its own superblock to drain, and
>> returns immediately when s_isw_nr_in_flight is zero. The global counter
>> is retained solely for throttling (WB_FRN_MAX_IN_FLIGHT).
>>
>> The other trade-offs are roughly comparable: both need pairing on all
>> paths, but the per-sb atomic_t gets zero-initialized by kzalloc for
>> free, while SRCU needs init/cleanup lifecycle management. The per-cpu
>> read lock advantage doesn't matter here since wb switching is
>> infrequent.
>>
>> So I went with the per-sb counter for its precision and simplicity.
>> That said, if you prefer the SRCU approach, I'm happy to spin a new
>> version using it.
> So I don't think we need a new SRCU. What really needs protection is this
> snippet as you correctly identified in your changelog:
>
>         if (!inode_prepare_wbs_switch(inode, new_wb))
>                 goto out_free;
>
>         isw->inodes[0] = inode;
>
>         trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
>         wb_queue_isw(new_wb, isw);
>
> So between we __iget() the inode and we queue work. The rest gets solved
> either by SB_ACTIVE check in inode_prepare_wbs_switch() or
> flush_workqueue() in cgroup_writeback_umount(). Since there's no sleep in
> this part, we can just wrap it within rcu_read_lock() (with appropriate
> comment what's protected) and that fixes the race. We could even downgrade
> rcu_barrier() in cgroup_writeback_umount() to synchronize_rcu() and it
> would still work. So I'd prefer to fix the race like this (also to ease
> backporting to older kernels).
>
> Now the performance optimization to make isw_nr_in_flight per
> superblock makes sense and I'm open to it as well. But it should be a
> separate commit with proper justification and ideally some numbers backing
> it showing the benefit.
>
> 								Honza


Thanks, that makes sense.  I'll send a v2 split into three patches:

  1) Quick race fix using rcu_read_lock() around the
     [inode_prepare_wbs_switch() ... wb_queue_isw()] window, plus a
     synchronize_rcu() in cgroup_writeback_umount().  rcu_barrier() is
     intentionally kept in this patch so it can be backported unchanged
     to older trees (5.10.y, 6.6.y, ...) that still queue the switch via
     queue_rcu_work() and rely on rcu_barrier() to drain those
     callbacks.  Cc: stable@vger.kernel.org.

  2) Mainline-only cleanup that drops the now-unnecessary rcu_barrier(),
     with Fixes: e1b849cfa6b6 ("writeback: Avoid contention on
     wb->list_lock when switching inodes") since that's the commit that
     turned it into a no-op.

  3) Reverts the rcu_read_lock() extension from (1) and switches to a
     per-sb s_isw_nr_in_flight counter as a separate optimization.

Performance numbers for (3), full breakdown will be in the v2 cover
letter.  An idle target sb is mounted/umounted in a loop while 4
unrelated sbs run a "create memcg -> dd 1 MiB to a shared file ->
rmdir memcg" churner that keeps the global isw_nr_in_flight non-zero.
N=100 iterations:

  Idle target umount under cross-sb cgwb-switch pressure:
                              p50      p95      p99      max
    (1)+(2) synchronize_rcu  64.4 ms  95.8 ms 101.4 ms 110.5 ms
    (3) per-sb counter        5.3 ms   6.9 ms   7.4 ms   7.7 ms
    no-pressure baseline      5.2 ms   5.9 ms   6.0 ms   6.1 ms

  8 concurrent umounts of idle sbs under the same pressure:
                              p50      p95      max
    (1)+(2) synchronize_rcu  57.9 ms  82.1 ms  90.0 ms
    (3) per-sb counter        7.5 ms   7.8 ms   8.0 ms

  In-kernel cgroup_writeback_umount() time over 286 calls (bpftrace):
    (1)+(2)  8717 ms total (~30 ms / call)
    (3)         1.16 ms total (~4 us / call)


Cheers,
Baokun

