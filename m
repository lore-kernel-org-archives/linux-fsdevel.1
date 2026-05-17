Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF83BE17F;
	Sun, 17 May 2026 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027757; cv=none; b=Q6BxTQFA64xeynhNdoIOclwY4ocKYgBM9wTZAKjK2s15SFDuflLxZJyxI1HJ9oAse5RuPakGZSVQEbPX1ir2QMEG46SEfJHYUdOpPJHGqyi7XBAnINhpI5Iq8GADQt5tVWy8e6s1ecuxzk6NZc7qDKyTsBMQK6s4aM3A1dQHG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027757; c=relaxed/simple;
	bh=iVqgbsmoUShKzc8sehabHkz/7kiOXcuiLF9YU7dEtZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7+dVxnsKXtUmxCOlszY3zmtTMc2E7IwbTAJ/VjB9zOebZPc3Pmj7LwdBPAtFfWf1j7O1MZ7Z04kuU0yfFGl+RV1nQAXyluQDRSr3TsK79PPg1zb+dgZRVotsD54V8DeKhNsUK0v8xx8mUmrT87NeBtWJd9ZENNMsY9i5fX/+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HoR/2PVr; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HoR/2PVr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779027732; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pEeH7zHkW8IEVUYlNw8sKefpVLWTLyEFqi5D7xTTfZ0=;
	b=HoR/2PVrdJE7Ku1lN6WOTGMpKWhHTKWqhVAT378NGf/d4VB/K/4p4N+7pJp4Ax+S4wNfZHqR4ovIc0yo0+vidrFMo/o1iDpcAFaYlpCDHToLRyAnIWG55zF8D882rVTa47lhUVgXfPcluOSfb5Y8I8haRstd6tJZxurj12nKP2U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X31pQEL_1779027731;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X31pQEL_1779027731 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 May 2026 22:22:12 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
Date: Sun, 17 May 2026 22:21:30 +0800
Message-ID: <20260517142147.3354909-2-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a container exits, the following BUG_ON() is occasionally triggered:

==================================================================
 VFS: Busy inodes after unmount of sdb (ext4)
 ------------[ cut here ]------------
 kernel BUG at fs/super.c:695!
 CPU: 3 PID: 6 Comm: containerd-shim Tainted: G OE K 6.6 #1
 pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : generic_shutdown_super+0xf0/0x100
 lr : generic_shutdown_super+0xf0/0x100
 Call trace:
  generic_shutdown_super+0xf0/0x100
  kill_block_super+0x20/0x48
  ext4_kill_sb+0x28/0x60
  deactivate_locked_super+0x54/0x130
  deactivate_super+0x84/0xa0
  cleanup_mnt+0xa4/0x140
  __cleanup_mnt+0x18/0x28
  task_work_run+0x78/0xe0
  do_notify_resume+0x204/0x240
==================================================================

The root cause is a race between cgroup_writeback_umount() and
inode_switch_wbs()/cleanup_offline_cgwb(). There is a window between
inode_prepare_wbs_switch() returning true and the subsequent
wb_queue_isw() call. Following is the process that triggers the issue:

      CPU A (umount)           |          CPU B (writeback)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                 inode_switch_wbs/cleanup_offline_cgwb
                                  atomic_inc(&isw_nr_in_flight)
                                  inode_prepare_wbs_switch
                                   -> passes SB_ACTIVE check
                                   __iget(inode)
 generic_shutdown_super
  sb->s_flags &= ~SB_ACTIVE
  cgroup_writeback_umount(sb)
   smp_mb()
   atomic_read(&isw_nr_in_flight)
   rcu_barrier()
    -> no pending RCU callbacks
   flush_workqueue(isw_wq)
    -> nothing queued, returns
  evict_inodes(sb)
   -> Inode skipped as isw still holds a ref.
  sop->put_super(sb)
   /* destroys percpu counters */
  -> VFS: Busy inodes after unmount!
                                  wb_queue_isw()
                                   queue_work(isw_wq, ...)
                                  /* later in work function */
                                  inode_switch_wbs_work_fn
                                   process_inode_switch_wbs
                                    iput() -> evict
                                     percpu_counter_dec() // UAF!

Fix this by extending the RCU read-side critical section in
inode_switch_wbs() and cleanup_offline_cgwb() to cover from
inode_prepare_wbs_switch() through wb_queue_isw().  Since there is
no sleep in this window, rcu_read_lock() can be used.  Then add a
synchronize_rcu() in cgroup_writeback_umount() before the existing
rcu_barrier(), so that all in-flight switchers that have passed the
SB_ACTIVE check have completed queue_work() before flush_workqueue()
is called.

Fixes: a1a0e23e4903 ("writeback: flush inode cgroup wb switches instead of pinning super_block")
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/all/mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fs-writeback.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a65694cbfe68..1f95ddcee363 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -665,7 +665,6 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
 	if (memcg_css && !css_tryget(memcg_css))
 		memcg_css = NULL;
-	rcu_read_unlock();
 	if (!memcg_css)
 		goto out_free;
 
@@ -680,10 +679,18 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	isw->inodes[0] = inode;
 
 	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
+	 * Holding rcu_read_lock across wb_queue_isw() ensures
+	 * synchronize_rcu() cannot return until the work is queued, so
+	 * the subsequent flush_workqueue() will wait for the switch.
+	 */
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 	return;
 
 out_free:
+	rcu_read_unlock();
 	atomic_dec(&isw_nr_in_flight);
 	if (new_wb)
 		wb_put(new_wb);
@@ -741,6 +748,14 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
+	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
+	 * and wb_queue_isw() ensures synchronize_rcu() cannot return until
+	 * the work is queued, so the subsequent flush_workqueue() will wait
+	 * for the switch.
+	 */
+	rcu_read_lock();
 	spin_lock(&wb->list_lock);
 	/*
 	 * In addition to the inodes that have completed writeback, also switch
@@ -758,6 +773,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
+		rcu_read_unlock();
 		atomic_dec(&isw_nr_in_flight);
 		wb_put(new_wb);
 		kfree(isw);
@@ -766,6 +782,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	trace_inode_switch_wbs_queue(wb, new_wb, nr);
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 
 	return restart;
 }
@@ -1221,6 +1238,14 @@ void cgroup_writeback_umount(struct super_block *sb)
 	smp_mb();
 
 	if (atomic_read(&isw_nr_in_flight)) {
+		/*
+		 * Paired with rcu_read_lock() in inode_switch_wbs() and
+		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
+		 * in-flight switcher that already passed the SB_ACTIVE check
+		 * to finish queueing its work, so flush_workqueue() below
+		 * will then drain it.
+		 */
+		synchronize_rcu();
 		/*
 		 * Use rcu_barrier() to wait for all pending callbacks to
 		 * ensure that all in-flight wb switches are in the workqueue.
-- 
2.43.7

