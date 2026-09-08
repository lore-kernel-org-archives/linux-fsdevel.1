Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAD23D283
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837911; cv=none; b=ombuCx5Gs6Z3Odhp8rqyhzCMmFjKytmHOBt516BULtLq4mXgijyXzQV39/zgHzG+zQIW2zJQoirfQlZf6D82JdAFLD9Kz64tcFRDCqUe07XJjnvsSuYm7WSIkAIRfPDSUkiOvKNhuKE6eOwPWOtRpauSCJGnJuSlis28MfoxxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837911; c=relaxed/simple;
	bh=EeOHWA/uz2on4QaoEb543EhpLFsgPbddAgUp7QPAoV4=;
	h=To:Cc:Date:Message-Id:References:From:Subject:In-Reply-To:
	 Content-Type:Mime-Version; b=laS12Rb1rtk5hxxmE6i3ZsSg0OrMQ0B6UKfuXifkgGa3GWfCcxeVq+sIIEo0RwrjKdd6Vvc7J2N4cNqgSui1HIuPpcNfsXC80R0na4le0+EegMc+QvrlEE/J/mpbErT9zBLBxYCmXbyrJ3zf7HvEvTV9OkxxTrMaKuyQdRr2Jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jcPGHiyz; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jcPGHiyz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788837905; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4BEbrlj73U5B9IMw8FD0WKET6Y4SVezy7GRLjv6u1WQ=;
 b=jcPGHiyz2eV2SqDS+BmH2K+Tm8P5QuKR8vHqmVpMgKH5ldyaHrTediVZDw0YYnC1zrWI+l
 blVfsZCfy/DnLjJvTmR1GZlc8Kwc3xClWVnvJQG3nQZIYIZ3Y2zmyjFDksMHvIQBO9JWAv
 aBxWJTHva5YGUr9EAQkPAJwyQ+2QokFctB54lLbG9JFxqRC1PK3hZgTjXQOI99wzMSG9S2
 nrruLkouHwmHVb9RjvIA8MhRG0UHGu0yyzldHAAW+S/iRktC2YRi8MUvX6BuwpRlMnGIk7
 6rsHj07fr5HPAJH6zG2IiBgEdqZgUz8Vp8Hv9FQTUGUQ7qoq/0aigCUKwX6ayg==
X-Mailer: git-send-email 2.20.1
To: "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Cc: "Tejun Heo" <tj@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Xin Yin" <yinxin.x@bytedance.com>
Date: Tue,  8 Sep 2026 11:23:52 +0800
Message-Id: <dce170b76e9501d555b0af70cc8c45c248577400.1788836830.git.yinxin.x@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <cover.1788836830.git.yinxin.x@bytedance.com>
From: "Xin Yin" <yinxin.x@bytedance.com>
Subject: [PATCH v1 2/2] writeback: snapshot foreign flush pages
X-Lms-Return-Path: <lba+26a9f800f+992ea9+vger.kernel.org+yinxin.x@bytedance.com>
In-Reply-To: <cover.1788836830.git.yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Yin <yinxin.x@bytedance.com>

WB_REASON_FOREIGN_FLUSH is best-effort writeback for foreign dirtying. It
should write pages that are already visible to the target wb, but should
not keep extending the same work with pages dirtied while the work is
running.

Make foreign flushes use tagged writeback while preserving WB_SYNC_NONE
semantics. Use the remaining work budget as the per-inode chunk, so a
tagged pass is not truncated to the normal periodic chunk and a large
inode still cannot exceed the finite work budget.

Queue b_dirty only once for each foreign-flush work. Later passes only
retry b_more_io inodes skipped due to I_SYNC, and the work exits once
b_io and b_more_io are drained. If the budget is consumed, redirty the
inode instead of requeueing it to b_more_io so the same work cannot loop
on a continuously dirtied inode.

Do not refresh dirtied_when for foreign flushes; later dirtying should be
handled by later foreign, kupdate, or background writeback.

Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/fs-writeback.c         | 57 ++++++++++++++++++++++++++++++---------
 include/linux/writeback.h |  1 +
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7c2340a5dead..6c5d1c85b6f8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -40,6 +40,7 @@ struct wb_writeback_work {
 	struct super_block *sb;
 	enum writeback_sync_modes sync_mode;
 	unsigned int tagged_writepages:1;
+	unsigned int for_foreign_flush:1;
 	unsigned int for_kupdate:1;
 	unsigned int range_cyclic:1;
 	unsigned int for_background:1;
@@ -1174,6 +1175,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	if (work) {
 		work->nr_pages = dirty;
 		work->sync_mode = WB_SYNC_NONE;
+		/*
+		 * Foreign flushes should write a snapshot of dirty pages without
+		 * chasing concurrent dirtiers, but still honor the finite target
+		 * wb budget calculated above.
+		 */
+		work->for_foreign_flush = 1;
 		work->range_cyclic = 1;
 		work->reason = reason;
 		work->done = done;
@@ -1553,18 +1560,21 @@ static int move_expired_inodes(struct list_head *delaying_queue,
  *                                           +--> dequeue for IO
  */
 static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work,
-		     unsigned long dirtied_before)
+		     unsigned long dirtied_before, bool queue_dirty)
 {
-	int moved;
+	int moved = 0;
 	unsigned long time_expire_jif = dirtied_before;
 
 	assert_spin_locked(&wb->list_lock);
 	list_splice_init(&wb->b_more_io, &wb->b_io);
-	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, dirtied_before);
-	if (!work->for_sync)
-		time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
-	moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
-				     time_expire_jif);
+	if (queue_dirty) {
+		moved = move_expired_inodes(&wb->b_dirty, &wb->b_io,
+					    dirtied_before);
+		if (!work->for_sync)
+			time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
+		moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
+					     time_expire_jif);
+	}
 	if (moved)
 		wb_io_lists_populated(wb);
 	trace_writeback_queue_io(wb, work, dirtied_before, moved);
@@ -1651,11 +1661,13 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 
 	/*
 	 * Sync livelock prevention. Each inode is tagged and synced in one
-	 * shot. If still dirty, it will be redirty_tail()'ed below.  Update
-	 * the dirty time to prevent enqueue and sync it again.
+	 * shot for WB_SYNC_ALL or unbudgeted tagged writeback. If still dirty,
+	 * it will be redirty_tail()'ed below. Update the dirty time to prevent
+	 * enqueue and sync it again.
 	 */
 	if ((inode_state_read(inode) & I_DIRTY) &&
-	    (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages))
+	    (wbc->sync_mode == WB_SYNC_ALL ||
+	     (wbc->tagged_writepages && !wbc->for_foreign_flush)))
 		inode->dirtied_when = jiffies;
 
 	if (wbc->pages_skipped) {
@@ -1678,6 +1690,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * sometimes bales out without doing anything.
 		 */
 		if (wbc->nr_to_write <= 0 &&
+		    !wbc->for_foreign_flush &&
 		    !inode_dirtied_after(inode, dirtied_before)) {
 			/* Slice used up. Queue for next turn. */
 			requeue_io(inode, wb);
@@ -1918,6 +1931,8 @@ static long writeback_chunk_size(struct super_block *sb,
 	 *                   (quickly) tag currently dirty pages
 	 *                   (maybe slowly) sync all tagged pages
 	 */
+	if (work->for_foreign_flush)
+		return work->nr_pages;
 	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
 		return LONG_MAX;
 
@@ -1943,7 +1958,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 {
 	struct writeback_control wbc = {
 		.sync_mode		= work->sync_mode,
-		.tagged_writepages	= work->tagged_writepages,
+		.tagged_writepages	= work->tagged_writepages ||
+					  work->for_foreign_flush,
+		.for_foreign_flush	= work->for_foreign_flush,
 		.for_kupdate		= work->for_kupdate,
 		.for_background		= work->for_background,
 		.for_sync		= work->for_sync,
@@ -2141,7 +2158,7 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
 	blk_start_plug(&plug);
 	spin_lock(&wb->list_lock);
 	if (list_empty(&wb->b_io))
-		queue_io(wb, &work, jiffies);
+		queue_io(wb, &work, jiffies, true);
 	__writeback_inodes_wb(wb, &work);
 	spin_unlock(&wb->list_lock);
 	blk_finish_plug(&plug);
@@ -2202,6 +2219,13 @@ static long wb_writeback(struct bdi_writeback *wb,
 
 		spin_lock(&wb->list_lock);
 
+		if (queued && work->for_foreign_flush &&
+		    list_empty(&wb->b_io) &&
+		    list_empty(&wb->b_more_io)) {
+			spin_unlock(&wb->list_lock);
+			break;
+		}
+
 		trace_writeback_start(wb, work);
 		if (list_empty(&wb->b_io)) {
 			/*
@@ -2217,7 +2241,14 @@ static long wb_writeback(struct bdi_writeback *wb,
 			} else if (work->for_background)
 				dirtied_before = jiffies;
 
-			queue_io(wb, work, dirtied_before);
+			/*
+			 * After the initial queue_io() pass, a foreign flush may
+			 * still have I_SYNC-skipped inodes on b_more_io.  Move
+			 * those back to b_io without selecting another batch from
+			 * b_dirty.
+			 */
+			queue_io(wb, work, dirtied_before,
+				 !work->for_foreign_flush || !queued);
 			queued = true;
 		}
 		if (work->sb)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index e530112c4b3a..096f0963d104 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -59,6 +59,7 @@ struct writeback_control {
 	unsigned for_kupdate:1;		/* A kupdate writeback */
 	unsigned for_background:1;	/* A background writeback */
 	unsigned tagged_writepages:1;	/* tag-and-write to avoid livelock */
+	unsigned for_foreign_flush:1;	/* foreign dirty flushing */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned unpinned_netfs_wb:1;	/* Cleared I_PINNING_NETFS_WB */
-- 
2.20.1
