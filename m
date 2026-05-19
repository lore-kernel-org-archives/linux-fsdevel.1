Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A441DD877;
	Tue, 19 May 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172411; cv=none; b=aj2pPRi412KX/f2ZnQl5IXTSXCj0lqvsqWUqoZckmVouvg2VHFJKYmSUwXkYjOIVG2fQ1g3IlKkWforz9dlRY3TYPlWbjmywv4G2hf2an5TDLoXu1XeOaYqN2zqd/kBMWhJeFX6NPtaVyvWDHjj3RhnUtuQyVwU80StWj8CjU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172411; c=relaxed/simple;
	bh=6CUgQj3y2qR30UKz1mrl2MpLvMVX9JQhCFCTnTdLzik=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J9FL3hUuYU8Lizjkdu/kNlJAwDmdER756z82OU13Shhi/z47JGNjgbEsHJWLSn836fGE8kGe/P6kaj++vX6z5PEX9EqETVsqPptlbODTagvr+6mV9nJZXSp11zeps2tcPg4R2U8I4+WIXYGDwvQ0vyZXnyIXuJ9bfhj/9QfF17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qwj/F+04; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qwj/F+04"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779172398; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=tuGeYJn5JPpwLCyrkrmZKvODb16bs3XCOjGTVAPoWhI=;
	b=Qwj/F+04YWBqgxNKwUEq6vFl8///APVS2Jt0T4Oa3BjK71hoP/gRoajUPhySCH/UtW2MSvQ0m40gTNQeexMZVZEpUkkHauJ/Hp0sm1DtdSdcQHOGL4AIXKzxWp7SrrB7gWp4DqIqNeprvCK8npZCsALDg9/NlsL870sWGbVrPgo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3ElH3Z_1779172397;
Received: from 30.221.134.159(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3ElH3Z_1779172397 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 14:33:17 +0800
Message-ID: <c767c485-5afe-412f-8f03-fe3e44518696@linux.alibaba.com>
Date: Tue, 19 May 2026 14:33:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] writeback: use a per-sb counter to drain inode wb
 switches at umount
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260518135349.1187628-1-libaokun@linux.alibaba.com>
 <20260518135349.1187628-4-libaokun@linux.alibaba.com>
In-Reply-To: <20260518135349.1187628-4-libaokun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sashiko[1] flagged a stale comment in patch 3 — the rcu_read_lock()

comment still describes the old synchronize_rcu()/flush_workqueue()
scheme which no longer exists after this patch.

I'll fold the following fixup into the next version:

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -688,16 +688,8 @@ static void inode_switch_wbs(struct inode *inode,
int new_wb_id)
 
        atomic_inc(&isw_nr_in_flight);
 
-       /*
-        * Paired with synchronize_rcu() in cgroup_writeback_umount():
-        * holding rcu_read_lock across inode_prepare_wbs_switch()
-        * (covering the SB_ACTIVE check and the inode grab) and
-        * wb_queue_isw() ensures synchronize_rcu() cannot return until
-        * the work is queued, so the subsequent flush_workqueue() will
-        * wait for the switch.
-        */
-       rcu_read_lock();
        /* find and pin the new wb */
+       rcu_read_lock();
        memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
        if (memcg_css && !css_tryget(memcg_css))
                memcg_css = NULL;

In no hurry to resend — further review is welcome.

[1]
https://sashiko.dev/#/patchset/20260518135349.1187628-1-libaokun%40linux.alibaba.com


Thanks,
Baokun

On 2026/5/18 21:53, Baokun Li wrote:
> Tracking in-flight inode wb switches with a single global counter
> (isw_nr_in_flight) plus a synchronize_rcu() based wait in
> cgroup_writeback_umount() forces every umount to take a global hit
> whenever any other superblock on the system has wb switches in flight,
> even if the superblock being unmounted has none of its own.
>
> Replace the global synchronize_rcu()/flush_workqueue() pair with a
> per-sb counter, s_isw_nr_in_flight, plus three small helpers:
>
>   - cgroup_writeback_pin(sb)   - increment counter
>   - cgroup_writeback_unpin(sb) - decrement and wake drainer if last
>   - cgroup_writeback_drain(sb) - wait for counter to reach zero
>
> The wiring is:
>
>   - inode_prepare_wbs_switch() pins before checking SB_ACTIVE and
>     grabbing the inode; failure paths unpin before returning.  A
>     lockless SB_ACTIVE check at the top of the function lets us skip
>     the atomic_inc/smp_mb dance once SB_ACTIVE has been cleared (it
>     is monotonic and never set back).
>   - process_inode_switch_wbs() unpins after the matching iput().
>   - cgroup_writeback_umount() drains the per-sb counter via
>     wait_var_event().
>
> The smp_mb() pair between inode_prepare_wbs_switch() and
> cgroup_writeback_umount() keeps the SB_ACTIVE / counter ordering:
> either the umounter sees a non-zero counter and waits, or the
> switcher sees SB_ACTIVE cleared and aborts before grabbing the
> inode.
>
> The global isw_nr_in_flight is left in place, since it is still used
> to throttle in-flight switches via WB_FRN_MAX_IN_FLIGHT.
>
> The rcu_read_lock() extension in inode_switch_wbs() and
> cleanup_offline_cgwb() that the race fix added is no longer needed
> and is reverted; the synchronize_rcu() that the race fix added to
> cgroup_writeback_umount() is dropped as well.
>
> The following numbers were measured on a 16 vCPU QEMU guest with 4
> background superblocks each churning "create memcg -> write 1 MiB ->
> rmdir memcg" to keep the global isw_nr_in_flight non-zero.  Latencies
> are wall-clock around umount(8); only the target sb's umount is
> measured.
>
> Target sb runs its own cgwb churn:
>
>                               p50      p95      p99      max
>   global synchronize_rcu()   67.6 ms  88.3 ms  88.3 ms  96.8 ms
>   per-sb counter (this)       7.9 ms  10.0 ms  10.0 ms  10.1 ms
>
> Idle target umount latency under cross-sb cgwb-switch pressure:
>
>                               p50      p95      p99      max
>   global synchronize_rcu()   62.7 ms  95.4 ms 108.1 ms 108.6 ms
>   per-sb counter (this)       5.3 ms   6.9 ms   7.4 ms   7.4 ms
>   no-pressure baseline        4.9 ms   5.9 ms   6.3 ms   6.7 ms
>
> 8 concurrent umounts of idle sbs under the same pressure:
>
>                               p50      p95      max
>   global synchronize_rcu()   61.3 ms  99.5 ms 113.7 ms
>   per-sb counter (this)       8.1 ms   9.1 ms   9.5 ms
>
> In-kernel cgroup_writeback_umount() time across the same run
> (bpftrace, ~340 calls covering all scenarios):
>
>   global synchronize_rcu()    12371 ms total (~36 ms / call)
>   per-sb counter (this)        1.37 ms total ( ~4 us / call)
>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/177910456953.488929.2169908940676707307.b4-review@b4
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/fs-writeback.c              | 87 ++++++++++++++++++----------------
>  include/linux/fs/super_types.h |  8 ++++
>  2 files changed, 54 insertions(+), 41 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 325a30cc35bf..32fec4b9094e 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -497,6 +497,23 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	return switched;
>  }
>  
> +static inline void cgroup_writeback_pin(struct super_block *sb)
> +{
> +	atomic_inc(&sb->s_isw_nr_in_flight);
> +}
> +
> +static inline void cgroup_writeback_unpin(struct super_block *sb)
> +{
> +	if (atomic_dec_and_test(&sb->s_isw_nr_in_flight))
> +		wake_up_var(&sb->s_isw_nr_in_flight);
> +}
> +
> +static inline void cgroup_writeback_drain(struct super_block *sb)
> +{
> +	wait_var_event(&sb->s_isw_nr_in_flight,
> +		       !atomic_read(&sb->s_isw_nr_in_flight));
> +}
> +
>  static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
>  				     struct inode_switch_wbs_context *isw)
>  {
> @@ -554,8 +571,12 @@ static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
>  		wb_put_many(old_wb, nr_switched);
>  	}
>  
> -	for (inodep = isw->inodes; *inodep; inodep++)
> +	for (inodep = isw->inodes; *inodep; inodep++) {
> +		struct super_block *sb = (*inodep)->i_sb;
> +
>  		iput(*inodep);
> +		cgroup_writeback_unpin(sb);
> +	}
>  	wb_put(new_wb);
>  	kfree(isw);
>  	atomic_dec(&isw_nr_in_flight);
> @@ -598,16 +619,19 @@ void inode_switch_wbs_work_fn(struct work_struct *work)
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
> +	cgroup_writeback_pin(inode->i_sb);
>  	smp_mb();
>  
>  	if (IS_DAX(inode))
> -		return false;
> +		goto out_dec;
>  
>  	/* while holding I_WB_SWITCH, no one else can update the association */
>  	spin_lock(&inode->i_lock);
> @@ -615,13 +639,17 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
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
> +	cgroup_writeback_unpin(inode->i_sb);
> +	return false;
>  }
>  
>  static void wb_queue_isw(struct bdi_writeback *wb,
> @@ -673,6 +701,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
>  	if (memcg_css && !css_tryget(memcg_css))
>  		memcg_css = NULL;
> +	rcu_read_unlock();
>  	if (!memcg_css)
>  		goto out_free;
>  
> @@ -688,11 +717,9 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  
>  	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
>  	wb_queue_isw(new_wb, isw);
> -	rcu_read_unlock();
>  	return;
>  
>  out_free:
> -	rcu_read_unlock();
>  	atomic_dec(&isw_nr_in_flight);
>  	if (new_wb)
>  		wb_put(new_wb);
> @@ -750,14 +777,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
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
> @@ -775,7 +794,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  
>  	/* no attached inodes? bail out */
>  	if (nr == 0) {
> -		rcu_read_unlock();
>  		atomic_dec(&isw_nr_in_flight);
>  		wb_put(new_wb);
>  		kfree(isw);
> @@ -784,7 +802,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  
>  	trace_inode_switch_wbs_queue(wb, new_wb, nr);
>  	wb_queue_isw(new_wb, isw);
> -	rcu_read_unlock();
>  
>  	return restart;
>  }
> @@ -1217,39 +1234,27 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
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
> -
> -	if (atomic_read(&isw_nr_in_flight)) {
> -		/*
> -		 * Paired with rcu_read_lock() in inode_switch_wbs() and
> -		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
> -		 * in-flight switcher that already passed the SB_ACTIVE check
> -		 * to finish queueing its work, so flush_workqueue() below
> -		 * will then drain it.
> -		 */
> -		synchronize_rcu();
> -		flush_workqueue(isw_wq);
> -	}
> +	cgroup_writeback_drain(sb);
>  }
>  
>  static int __init cgroup_writeback_init(void)
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


