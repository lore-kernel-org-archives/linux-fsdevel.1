Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AE453A34
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793464; cv=none; b=MQRgyuPJRHK34FKruidREaccvu39CV8x338nsghF68xWwshGmhiIX7JJCJiJ5Big4lcfsnmkqMt8dRPKsjHFLwlh67deHUM4GilHDSmY6xaIK7BvOwTE5ryOeEG6tUxdeBc+ECctAzbldvKAhLnmsFBAhLhoML46VgaSa9cWDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793464; c=relaxed/simple;
	bh=mN6+LZ2gdI6BA2Woogl/LRUCfZMYtRtQjXIydTfQo94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcFpl7fGWYtKLfiGUB0VCGsrEIGcVsZQpX6pIXgFAdDWuQ+m/eJW1jucmMRUvKkoQTMTEhB3v2j32eycJJ3Rb4IfIiKcv1LEcWTQTv5i8d68IEPifvk8HE0LXIRJ+k7ZqQmpZktsuJd57AKB1d1d+02+JoQx0QM1NaCOMG7w9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E45921E5D;
	Mon, 12 Oct 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA6C139AF;
	Mon, 12 Oct 2026 08:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +OlEBy+ZzGorHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 08:24:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 962DCA1409; Mon, 12 Oct 2026 10:24:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/7] fs: Avoid inode dirtying on last iput
Date: Mon, 12 Oct 2026 10:23:40 +0200
Message-ID: <20261012082356.3121725-9-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009133253.20102-1-jack@suse.cz>
References: <20261009133253.20102-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4455; i=jack@suse.cz; h=from:subject; bh=mN6+LZ2gdI6BA2Woogl/LRUCfZMYtRtQjXIydTfQo94=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqzJkdCCO3AAJS09xXaYP2rhj+O/DJgaVQfhdCw AQfOsLy4jSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCasyZHQAKCRCcnaoHP2RA 2UxvB/4rbDCNaOhesIyBlx/dXNJe9UYncnqOAkOL2GgkWRvHgOIEauu0EOa35PV5sAomz5vheR4 jNMvFPGBPYsr4sU2jwSJZsvK5Pz9tR0M31+3umwn8jh3fw8I3VwccLj8rsHQjOwkeFs9tqfDqqx xsCC7ZjdRzT9FMYDevNwZL7A7QTUOZq4vr3Nn3UYo/nK6H9T53kw2kHtI43Z8vbOD38Ar5nqGDS AXCYZVW68IuGdBgOjZ11qNrThbWQeHguzxTTMhtLKfIoTAD65WiASCIbG7sMVmJ8TBjvvJFSXfQ zEKmmZ0PatEgDFmHl7qUlnlCKnZ2s4qa3Wsv06VbbxY5bW/Q
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5E45921E5D
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated

When inode has dirtied timestamps, we currently call sync_lazytime() on
last iput. This is done because inode with any dirty bit set is not
inserted into LRU and dirty timestamps expire only after many (12 by
default) hours so these inodes would be sitting outside of LRU aging for
a really long time. However this can result in doing IO and consequently
GFP_NOFAIL allocations from dentry reclaim making MM complain. Sample
trace for ext4 is:

prune_dcache_sb
shrink_dentry_list
__dentry_kill
iput
sync_lazytime
__mark_inode_dirty
ext4_dirty_inode
__ext4_mark_inode_dirty
ext4_reserve_inode_write
ext4_get_inode_loc
bdev_getblk
__filemap_get_folio_mpol

Avoid this dirtying on last iput by reshuffling unused inodes to the
beginning of b_dirty_time list and clobbering dirtied_time_when instead
so that they get written during next periodic writeback.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/inode.c        | 15 +++++++--------
 fs/internal.h     |  1 +
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f6fe797a41b4..68c65a74a330 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2852,6 +2852,50 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 }
 EXPORT_SYMBOL(__mark_inode_dirty);
 
+/*
+ * If inode has dirty timestamps to write out, make sure flush worker writes
+ * them out during its next periodic writeback writeout.
+ */
+void queue_dirtytime_writeback(struct inode *inode)
+{
+	struct bdi_writeback *wb;
+	unsigned long new_time;
+
+	lockdep_assert_held(&inode->i_lock);
+
+	wb = locked_inode_to_wb_and_lock_list(inode);
+	spin_lock(&inode->i_lock);
+	/*
+	 * If inode writeback is already queued or inode got dirty, we have
+	 * nothing to do and we mustn't touch writeback lists anyway.
+	 */
+	if (inode_state_read(inode) & (I_SYNC_QUEUED | I_DIRTY))
+		goto out_wb_lock;
+	/* Written back while we dropped i_lock? */
+	if (!(inode_state_read(inode) & I_DIRTY_TIME))
+		goto out_wb_lock;
+
+	/*
+	 * Move inode to the beginning of dirty queue and clobber dirtied time
+	 * so that it gets written out during the next periodic writeback.
+	 */
+	new_time = jiffies - dirtytime_expire_interval * HZ;
+	if (!list_empty(&wb->b_dirty_time)) {
+		struct inode *first = wb_inode(wb->b_dirty_time.prev);
+		unsigned long first_time = READ_ONCE(first->dirtied_time_when);
+
+		if (time_before(first_time, new_time))
+			new_time = first_time;
+	}
+	inode->dirtied_when = new_time;
+	inode->dirtied_time_when = new_time;
+	list_move_tail(&inode->i_io_list, &wb->b_dirty_time);
+	/* Wake up flush worker to ensure timely flush of the inode */
+	wb_wakeup_delayed(wb);
+out_wb_lock:
+	spin_unlock(&wb->list_lock);
+}
+
 /*
  * The @s_sync_lock is used to serialise concurrent sync operations
  * to avoid lock contention problems with concurrent wait_sb_inodes() calls.
diff --git a/fs/inode.c b/fs/inode.c
index a9d37be390a1..43f3b2cb1ebb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2029,7 +2029,6 @@ void iput(struct inode *inode)
 	if (unlikely(!inode))
 		return;
 
-retry:
 	lockdep_assert_not_held(&inode->i_lock);
 	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
 	/*
@@ -2042,14 +2041,14 @@ void iput(struct inode *inode)
 	if (atomic_add_unless(&inode->i_count, -1, 1))
 		return;
 
-	if (inode->i_nlink && sync_lazytime(inode))
-		goto retry;
-
 	spin_lock(&inode->i_lock);
-	if (unlikely((inode_state_read(inode) & I_DIRTY_TIME) && inode->i_nlink)) {
-		spin_unlock(&inode->i_lock);
-		goto retry;
-	}
+	/*
+	 * If inode has timestamp updates pending, queue flushing them now as
+	 * otherwise the dirtiness could be preventing the inode from entering
+	 * LRU for hours.
+	 */
+	if (inode->i_nlink && inode_state_read(inode) & I_DIRTY_TIME)
+		queue_dirtytime_writeback(inode);
 
 	if (!atomic_dec_and_test(&inode->i_count)) {
 		spin_unlock(&inode->i_lock);
diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..eae0e2bb5d1c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -219,6 +219,7 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
  */
 long get_nr_dirty_inodes(void);
 bool sync_lazytime(struct inode *inode);
+void queue_dirtytime_writeback(struct inode *inode);
 
 /*
  * dcache.c
-- 
2.51.0

