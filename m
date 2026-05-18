Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389915665C;
	Mon, 18 May 2026 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102907; cv=none; b=CGc24MtVjaErhJLUkl3FLOR7HoUFh936I9BdKGpMxiE9CFTLihwL7AFF88yEHsFgoInEGKL30gAY+1u194/62aHGvwz/hFYGotHG8HnGERjqAp6JoZk8D+gTvuMLXzHpmOstR8ZzDbuc32FN7YVxp1YDbKLzQHoBPd013k5BpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102907; c=relaxed/simple;
	bh=KhNpJbVIUlx21LEZGn3F96IditzuTXLx3ECJUvpCKf4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bD/jnfwk9Y28AbdyzE6f/q4iVFjvom5SuSyrgnVFMot6pBmyTCbUT4KA0J+7p0dr3ybmcVuHKk4V2jiyum4qWbKIBltwi3ktHOmT6O1mpdtVmA4L+UFwq4HKIv6pzOosYYns5BAshhJMHu8o0HT7ozjFLm3uhEkzEEgFsTwpxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VgXlocFJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VgXlocFJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779102884; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=R/4+8CHsIFQEAoNMVUEWELSlUHr6tUOtFVDHvmNzzWE=;
	b=VgXlocFJ38m059jjTzH2J8DhCa41FiEJ3FB3VwI4ZePE8/b52v3a70EXFHsbWgeuhKj53b5ScxGG27/V1NmtJWrl2ipimTtlr20klsK9fkL87x6VqIgxEYsNSJRLpBlUiuqLJcnyl58vr177ze1ANTLG1HHjVcb5HqJ2rYqJK60=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X37czye_1779102883;
Received: from 30.221.131.155(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X37czye_1779102883 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 19:14:43 +0800
Message-ID: <a427d5a6-fff8-40b7-8d93-455c66e3d8c1@linux.alibaba.com>
Date: Mon, 18 May 2026 19:14:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] writeback: use a per-sb counter to drain inode wb
 switches at umount
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
 <20260517142147.3354909-4-libaokun@linux.alibaba.com>
In-Reply-To: <20260517142147.3354909-4-libaokun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please ignore this patch; sashiko found some issues, and I will use
wait_var_event() / wake_up_var() in the next version.

https://sashiko.dev/#/patchset/20260517142147.3354909-1-libaokun%40linux.alibaba.com

Sorry for the noise.


Regards,
Baokun

在 2026/5/17 22:21, Baokun Li 写道:
> Tracking in-flight inode wb switches with a single global counter
> (isw_nr_in_flight) plus a synchronize_rcu() based wait in
> cgroup_writeback_umount() forces every umount to take a global hit
> whenever any other superblock on the system has wb switches in flight,
> even if the superblock being unmounted has none of its own.
>
> Replace the global synchronize_rcu()/flush_workqueue() pair with a
> per-sb counter, s_isw_nr_in_flight:
>
>   - inode_prepare_wbs_switch() increments before checking SB_ACTIVE
>     and grabbing the inode; failure paths decrement before returning.
>   - process_inode_switch_wbs() decrements after the matching iput().
>   - cgroup_writeback_umount() waits for the per-sb counter to reach zero.
>
> The smp_mb() pair between inode_prepare_wbs_switch() and
> cgroup_writeback_umount() keeps the SB_ACTIVE / counter ordering:
> either the umounter sees a non-zero counter and waits, or the switcher
> sees SB_ACTIVE cleared and aborts before grabbing the inode.
>
> The existing global isw_nr_in_flight is left in place, since it is
> still used to throttle in-flight switches via WB_FRN_MAX_IN_FLIGHT.
>
> The rcu_read_lock() extension in inode_switch_wbs() and
> cleanup_offline_cgwb() introduced by the race fix is no longer
> needed and is reverted.  The synchronize_rcu() in
> cgroup_writeback_umount() is dropped as well.
>
> inode_prepare_wbs_switch() also gains a lockless SB_ACTIVE check at
> the top to skip the atomic_inc/smp_mb cost for inodes whose sb is
> already being torn down.
>
> The following numbers were measured with 4 background superblocks
> each churning "create memcg -> write 1 MiB -> rmdir memcg" to keep
> the global isw_nr_in_flight non-zero.  A separate idle target sb is
> mounted and umounted in a loop (N=100); only its umount latency is
> measured.
>
> Idle target umount latency under cross-sb cgwb-switch pressure:
>
>                               p50      p95      p99      max
>   global synchronize_rcu()  64.4 ms  95.8 ms 101.4 ms 110.5 ms
>   per-sb counter (this)      5.3 ms   6.9 ms   7.4 ms   7.7 ms
>   no-pressure baseline       5.2 ms   5.9 ms   6.0 ms   6.1 ms
>
> 8 concurrent umounts of idle sbs under the same pressure:
>
>                               p50      p95      max
>   global synchronize_rcu()  57.9 ms  82.1 ms  90.0 ms
>   per-sb counter (this)      7.5 ms   7.8 ms   8.0 ms
>
> In-kernel cgroup_writeback_umount() time over 286 calls (bpftrace):
>
>   global synchronize_rcu()     8717 ms total (~30 ms / call)
>   per-sb counter (this)        1.16 ms total (~4 us / call)
>
> When s_isw_nr_in_flight is zero the loop body is never entered.
>
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/fs-writeback.c              | 74 ++++++++++++++--------------------
>  include/linux/fs/super_types.h |  8 ++++
>  2 files changed, 38 insertions(+), 44 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 9ae290547eb2..4282fcfe027b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -554,8 +554,12 @@ static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
>  		wb_put_many(old_wb, nr_switched);
>  	}
>  
> -	for (inodep = isw->inodes; *inodep; inodep++)
> +	for (inodep = isw->inodes; *inodep; inodep++) {
> +		struct super_block *sb = (*inodep)->i_sb;
> +
>  		iput(*inodep);
> +		atomic_dec(&sb->s_isw_nr_in_flight);
> +	}
>  	wb_put(new_wb);
>  	kfree(isw);
>  	atomic_dec(&isw_nr_in_flight);
> @@ -598,16 +602,19 @@ void inode_switch_wbs_work_fn(struct work_struct *work)
>  static bool inode_prepare_wbs_switch(struct inode *inode,
>  				     struct bdi_writeback *new_wb)
>  {
> +	/* Avoid the atomic_inc/smp_mb dance once SB_ACTIVE is gone. */
> +	if (!(inode->i_sb->s_flags & SB_ACTIVE))
> +		return false;
> +
>  	/*
> -	 * Paired with smp_mb() in cgroup_writeback_umount().
> -	 * isw_nr_in_flight must be increased before checking SB_ACTIVE and
> -	 * grabbing an inode, otherwise isw_nr_in_flight can be observed as 0
> -	 * in cgroup_writeback_umount() and the isw_wq will be not flushed.
> +	 * Pairs with smp_mb() in cgroup_writeback_umount(): the umounter either
> +	 * sees a non-zero counter and waits, or we see SB_ACTIVE clear below.
>  	 */
> +	atomic_inc(&inode->i_sb->s_isw_nr_in_flight);
>  	smp_mb();
>  
>  	if (IS_DAX(inode))
> -		return false;
> +		goto out_dec;
>  
>  	/* while holding I_WB_SWITCH, no one else can update the association */
>  	spin_lock(&inode->i_lock);
> @@ -615,13 +622,17 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
>  	    inode_state_read(inode) & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
>  	    inode_to_wb(inode) == new_wb) {
>  		spin_unlock(&inode->i_lock);
> -		return false;
> +		goto out_dec;
>  	}
>  	inode_state_set(inode, I_WB_SWITCH);
>  	__iget(inode);
>  	spin_unlock(&inode->i_lock);
>  
>  	return true;
> +
> +out_dec:
> +	atomic_dec(&inode->i_sb->s_isw_nr_in_flight);
> +	return false;
>  }
>  
>  static void wb_queue_isw(struct bdi_writeback *wb,
> @@ -665,6 +676,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
>  	if (memcg_css && !css_tryget(memcg_css))
>  		memcg_css = NULL;
> +	rcu_read_unlock();
>  	if (!memcg_css)
>  		goto out_free;
>  
> @@ -679,18 +691,10 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	isw->inodes[0] = inode;
>  
>  	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
> -	/*
> -	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
> -	 * Holding rcu_read_lock across wb_queue_isw() ensures
> -	 * synchronize_rcu() cannot return until the work is queued, so
> -	 * the subsequent flush_workqueue() will wait for the switch.
> -	 */
>  	wb_queue_isw(new_wb, isw);
> -	rcu_read_unlock();
>  	return;
>  
>  out_free:
> -	rcu_read_unlock();
>  	atomic_dec(&isw_nr_in_flight);
>  	if (new_wb)
>  		wb_put(new_wb);
> @@ -748,14 +752,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
>  
>  	nr = 0;
> -	/*
> -	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
> -	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
> -	 * and wb_queue_isw() ensures synchronize_rcu() cannot return until
> -	 * the work is queued, so the subsequent flush_workqueue() will wait
> -	 * for the switch.
> -	 */
> -	rcu_read_lock();
>  	spin_lock(&wb->list_lock);
>  	/*
>  	 * In addition to the inodes that have completed writeback, also switch
> @@ -773,7 +769,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  
>  	/* no attached inodes? bail out */
>  	if (nr == 0) {
> -		rcu_read_unlock();
>  		atomic_dec(&isw_nr_in_flight);
>  		wb_put(new_wb);
>  		kfree(isw);
> @@ -782,7 +777,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  
>  	trace_inode_switch_wbs_queue(wb, new_wb, nr);
>  	wb_queue_isw(new_wb, isw);
> -	rcu_read_unlock();
>  
>  	return restart;
>  }
> @@ -1215,38 +1209,30 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  }
>  
>  /**
> - * cgroup_writeback_umount - flush inode wb switches for umount
> + * cgroup_writeback_umount - wait for in-flight inode wb switches on @sb
>   * @sb: target super_block
>   *
> - * This function is called when a super_block is about to be destroyed and
> - * flushes in-flight inode wb switches.  An inode wb switch goes through
> - * RCU and then workqueue, so the two need to be flushed in order to ensure
> - * that all previously scheduled switches are finished.  As wb switches are
> - * rare occurrences and synchronize_rcu() can take a while, perform
> - * flushing iff wb switches are in flight.
> + * Wait until every inode wb switch that already passed the SB_ACTIVE
> + * check on this superblock has been completed by the worker.  Since
> + * SB_ACTIVE is cleared before this is called, no new switches can start
> + * for @sb, so s_isw_nr_in_flight will monotonically drop to zero.
>   */
>  void cgroup_writeback_umount(struct super_block *sb)
>  {
> -
>  	if (!(sb->s_bdi->capabilities & BDI_CAP_WRITEBACK))
>  		return;
>  
>  	/*
> -	 * SB_ACTIVE should be reliably cleared before checking
> -	 * isw_nr_in_flight, see generic_shutdown_super().
> +	 * Pairs with smp_mb() in inode_prepare_wbs_switch(): we either observe
> +	 * a non-zero counter and wait, or the switcher sees SB_ACTIVE clear
> +	 * (cleared by generic_shutdown_super()) and bails before grabbing the
> +	 * inode.
>  	 */
>  	smp_mb();
>  
> -	if (atomic_read(&isw_nr_in_flight)) {
> -		/*
> -		 * Paired with rcu_read_lock() in inode_switch_wbs() and
> -		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
> -		 * in-flight switcher that already passed the SB_ACTIVE check
> -		 * to finish queueing its work, so flush_workqueue() below
> -		 * will then drain it.
> -		 */
> -		synchronize_rcu();
> +	while (atomic_read(&sb->s_isw_nr_in_flight)) {
>  		flush_workqueue(isw_wq);
> +		cond_resched();
>  	}
>  }
>  
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index 383050e7fdf5..1ab4e2265129 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -274,6 +274,14 @@ struct super_block {
>  
>  	/* number of fserrors that are being sent to fsnotify/filesystems */
>  	refcount_t				s_pending_errors;
> +
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +	/*
> +	 * Number of in-flight inode wb switches for this sb.  Drained by
> +	 * cgroup_writeback_umount() before tear-down.
> +	 */
> +	atomic_t				s_isw_nr_in_flight;
> +#endif
>  } __randomize_layout;
>  
>  /*


