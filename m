Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641232E54D3;
	Thu, 14 May 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778727311; cv=none; b=Pm2v8KaTPbp/c6gVWc93li7/fy5Hhso7dnrlk8IWRN2SlFDKPK3TC3VQOuOgA1gZpjFjjUS+KLeod7ktrZHlT2pwEMgUDMlYJJkVAINGhzutqRJ8O2xn+0gZ4O8i7L4Yhh49Wy4Q2QvBp0mdj6Mbm854bh281PMsMWp+DEh3n+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778727311; c=relaxed/simple;
	bh=UNo72HqhYnatz0FGSRKG2T8UllilstCRRev7/LoOo70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk97U3Wqone23gPOaCI9ch9/AM6eDQV3RosxltE2qHzgDIt1PFnFLNOf1giu1ytd7DdL5ykSlYYhb+tQDzOjw9VL0QsdSucl2UiIiJLmeCwwc7fJN6xSsCMFoZvTizuQ0HUHZcUGQmnkT5H2oya+L57bAkHH6ucAKLNTcOecFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jh5yBwWw; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jh5yBwWw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778727305; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OaEJAx53nxLzrylKyOUQ3xEbRu4QwHlxhzwX5s59jCQ=;
	b=Jh5yBwWwldGgzV5P8BoPxXp4+JNj6sbAa5Ah7CMYdJZfoTRM0hSIXiXcTeOwXUI5+e0yiFH/NvUtA67qjSEBJnR6UaU0lcdptttk8LQ+qZ+uk5XjU0LQ0pwPkwTvydO1+q17zsGwrxY3bi+Mz1EspwLlzVrjPqpESIZUb7wxJKs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X2vLEwD_1778727304;
Received: from 30.221.131.84(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X2vLEwD_1778727304 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 10:55:04 +0800
Message-ID: <a7f260f7-63a6-4e6f-99aa-0a4be29f740f@linux.alibaba.com>
Date: Thu, 14 May 2026 10:55:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] writeback: fix race between cgroup_writeback_umount() and
 inode_switch_wbs()
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
 libaokun@linux.alibaba.com
References: <20260513094829.867648-1-libaokun@linux.alibaba.com>
 <22cda97d61cc9d540d4e7116d5f3f08a@kernel.org>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <22cda97d61cc9d540d4e7116d5f3f08a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/5/14 04:36, Tejun Heo 写道:
> Hello,
>
> Resending - earlier send dropped the Cc list. Sorry for the noise.
>
> How rcu_barrier() got out of sync, as best I can reconstruct:
>
> - ec084de929e4 ("fs/writeback.c: use rcu_barrier() to wait for inflight
>   wb switches going into workqueue when umount", 2019) put the inc
>   after call_rcu(); rcu_barrier() worked from then.
>
> - 8826ee4fe750 ("writeback, cgroup: increment isw_nr_in_flight before
>   grabbing an inode", 2021) moved the inc back ahead to cover the prep
>   window, apparently reopening this gap.
>
> - e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
>   switching inodes", 2025) replaced call_rcu() with llist_add() +
>   queue_work(); rcu_barrier() looks like a no-op for this path since.
>
> Could SRCU work instead? srcu_read_lock around the publish (atomic_inc
> through wb_queue_isw), with cgroup_writeback_umount() keeping the
> counter gate but swapping rcu_barrier() for synchronize_srcu():
>
>   if (atomic_read(&isw_nr_in_flight)) {
>           synchronize_srcu(&isw_srcu);
>           flush_workqueue(isw_wq);
>   }
>
> Thoughts?

Thanks for the detailed analysis on how rcu_barrier() got out of sync,
that matches my understanding as well.

Regarding the SRCU idea: I considered it, but it has a key drawback.
synchronize_srcu() waits for all read-side critical sections globally
-- it cannot distinguish which superblock a given switcher is working
on. So if sb A is being unmounted while unrelated switchers for sb B/C/D
hold srcu_read_lock(), umount of A gets blocked unnecessarily. The
global isw_nr_in_flight gate makes this worse: any non-zero count from
any sb triggers synchronize_srcu(), even when the target sb has no
in-flight switches at all.

This is especially problematic in high-density container environments,
where many containers with separate filesystems are being created and
destroyed concurrently. Frequent cgroup migrations across multiple
superblocks keep the global isw_nr_in_flight perpetually non-zero,
causing every single umount to pay the synchronize_srcu() cost even
when the target sb has zero in-flight switches.

The per-sb counter avoids this entirely -- cgroup_writeback_umount()
only waits for switches belonging to its own superblock to drain, and
returns immediately when s_isw_nr_in_flight is zero. The global counter
is retained solely for throttling (WB_FRN_MAX_IN_FLIGHT).

The other trade-offs are roughly comparable: both need pairing on all
paths, but the per-sb atomic_t gets zero-initialized by kzalloc for
free, while SRCU needs init/cleanup lifecycle management. The per-cpu
read lock advantage doesn't matter here since wb switching is
infrequent.

So I went with the per-sb counter for its precision and simplicity.
That said, if you prefer the SRCU approach, I'm happy to spin a new
version using it.


Cheers,
Baokun

