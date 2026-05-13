Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F23E9C28;
	Wed, 13 May 2026 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665733; cv=none; b=owt3fULcz0syBi0e7ft3tvo23cCpt9VYfZ1j/cToqkR92c6ZyJP7aRtUL2nJFtR9WwM8xRgzKtHs6PG1m1zv447zdURIxFWbuutxekmhcXxIoKXqfvHu/20nVIyIVG12sTOzZnyisH+hStgtQP+dUnrxaSSmL9pm9BEm1w7O6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665733; c=relaxed/simple;
	bh=bPZIbSSSan9io5w6ejdZJ2gLDOTt7m0tY9FMn9jP1Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQ7hmayUCxlMqwXSx9c5GF2YKZhThO4Ukfj5WU4xaaMhX1wVkT+xHwxNPhZAiS26taxaLmQ08nsk0QeJ4lXS4z1n5CdhF2LOCLLlPFI01GQsNtJWtMQQ+wzKzUQlJZd8TTeDyZZ1xvO9ABOiaH1gfcmJqK2C+DrUUsDQOyj4Xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qz9X4gV0; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qz9X4gV0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778665725; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=z88s8tnfo0giRHF0Q1K4V8aXjEJmDaAln4yzcS1vhm8=;
	b=qz9X4gV03U1ojk43Hj2npXHTCkoV9HCDlNZj3CM3P9uWLwcr4gHkq8zd4OxeORwQEoQQVC0ZuSnRAjQFBnHURy/wY7iwKoh+id2f2gYtig+vwrFV63TjfjzPzBgKihIwhGJbops0NQZj9um/sQ2fhNVotXt9caBNVpDxCFntwsU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X2tbXx._1778665712;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X2tbXx._1778665712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 17:48:45 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Baokun Li <libaokun@linux.alibaba.com>
Subject: [PATCH] writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
Date: Wed, 13 May 2026 17:48:29 +0800
Message-ID: <20260513094829.867648-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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

A simple approach to synchronize is to have cgroup_writeback_umount()
wait for the isw_nr_in_flight count of the current superblock to drop
to zero, since no new increments can occur after SB_ACTIVE is cleared.
However, isw_nr_in_flight is global, so introduce a new per-sb counter
s_isw_nr_in_flight for this purpose, while retaining the global counter
for throttling.

Fixes: a1a0e23e4903 ("writeback: flush inode cgroup wb switches instead of pinning super_block")
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fs-writeback.c              | 44 +++++++++++++++++++---------------
 include/linux/fs/super_types.h |  3 +++
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 71b7fd036e97..7924cf3484fa 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -556,8 +556,12 @@ static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
 		wb_put_many(old_wb, nr_switched);
 	}
 
-	for (inodep = isw->inodes; *inodep; inodep++)
+	for (inodep = isw->inodes; *inodep; inodep++) {
+		struct super_block *sb = (*inodep)->i_sb;
+
 		iput(*inodep);
+		atomic_dec(&sb->s_isw_nr_in_flight);
+	}
 	wb_put(new_wb);
 	kfree(isw);
 	atomic_dec(&isw_nr_in_flight);
@@ -602,14 +606,15 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 {
 	/*
 	 * Paired with smp_mb() in cgroup_writeback_umount().
-	 * isw_nr_in_flight must be increased before checking SB_ACTIVE and
-	 * grabbing an inode, otherwise isw_nr_in_flight can be observed as 0
-	 * in cgroup_writeback_umount() and the isw_wq will be not flushed.
+	 * s_isw_nr_in_flight must be increased before checking SB_ACTIVE and
+	 * grabbing an inode, otherwise s_isw_nr_in_flight can be observed as
+	 * 0 in cgroup_writeback_umount() and the isw_wq will be not flushed.
 	 */
+	atomic_inc(&inode->i_sb->s_isw_nr_in_flight);
 	smp_mb();
 
 	if (IS_DAX(inode))
-		return false;
+		goto out_dec;
 
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
@@ -617,13 +622,17 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	    inode_state_read(inode) & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
 	    inode_to_wb(inode) == new_wb) {
 		spin_unlock(&inode->i_lock);
-		return false;
+		goto out_dec;
 	}
 	inode_state_set(inode, I_WB_SWITCH);
 	__iget(inode);
 	spin_unlock(&inode->i_lock);
 
 	return true;
+
+out_dec:
+	atomic_dec(&inode->i_sb->s_isw_nr_in_flight);
+	return false;
 }
 
 static void wb_queue_isw(struct bdi_writeback *wb,
@@ -1212,31 +1221,28 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
  * @sb: target super_block
  *
  * This function is called when a super_block is about to be destroyed and
- * flushes in-flight inode wb switches.  An inode wb switch goes through
- * RCU and then workqueue, so the two need to be flushed in order to ensure
- * that all previously scheduled switches are finished.  As wb switches are
- * rare occurrences and synchronize_rcu() can take a while, perform
- * flushing iff wb switches are in flight.
+ * waits for all in-flight inode wb switches on this sb to complete.  Since
+ * SB_ACTIVE is cleared before this is called, no new switches can start,
+ * so the per-sb counter will monotonically decrease to zero.
  */
 void cgroup_writeback_umount(struct super_block *sb)
 {
-
 	if (!(sb->s_bdi->capabilities & BDI_CAP_WRITEBACK))
 		return;
 
 	/*
 	 * SB_ACTIVE should be reliably cleared before checking
-	 * isw_nr_in_flight, see generic_shutdown_super().
+	 * s_isw_nr_in_flight, see generic_shutdown_super().
+	 *
+	 * Paired with smp_mb() in inode_prepare_wbs_switch(), which ensures
+	 * that either we see the incremented counter, or the switcher sees
+	 * SB_ACTIVE cleared and aborts.
 	 */
 	smp_mb();
 
-	if (atomic_read(&isw_nr_in_flight)) {
-		/*
-		 * Use rcu_barrier() to wait for all pending callbacks to
-		 * ensure that all in-flight wb switches are in the workqueue.
-		 */
-		rcu_barrier();
+	while (atomic_read(&sb->s_isw_nr_in_flight)) {
 		flush_workqueue(isw_wq);
+		cond_resched();
 	}
 }
 
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 383050e7fdf5..8030c873016d 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -274,6 +274,9 @@ struct super_block {
 
 	/* number of fserrors that are being sent to fsnotify/filesystems */
 	refcount_t				s_pending_errors;
+
+	/* number of in-flight inode writeback switches on this sb */
+	atomic_t				s_isw_nr_in_flight;
 } __randomize_layout;
 
 /*
-- 
2.43.7

