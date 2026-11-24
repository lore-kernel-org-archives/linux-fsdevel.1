Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521549;
	b=pFA4QMrJAG2Hk/r4Xol6q71TjDlu0xqx3pVwIN98yRbIHo0TSQo2YT3mwuH2Zaju23He
	 HgSowmd2kzakJ3eC806yN2xmX8pGpGoHAww3n2o22Q1Z+Ql4V6eKXrWnbHMmOrGOzD4G2
	 qNDkn5YE9Uu5LMHjJ1/FtaNAm0EGJiV038RqmbdHG1irtMqOHbpH46e+tr2X18sBtZ+Sh
	 eXE0e61bikT4S/UY4/Av11xlpZMN7iS+t3rRLnz84b9ntlrtyQ6zTz8ERZko9qdD1DWFm
	 CPEY/pnJJrzAYIOrfwBxcj/qOmmCn13B2XyQGG9Uy+nrBHqG+KqZkc1/0E9VqpgTToA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521549;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=vYHnw9tGxuEPK6F+WFQINmt7VNk0t4nwX8NpSgV0BEA=;
	b=Y4jW5GTpyHWGoJ8mg4VBXt8XHQ2UG6fM24O9YzZmU+s19tu0qdWFafQ0Z7aOoqAEdJBk
	 DzHvBD5w2F1PiT4Y6sVQImCEWYJx53C+chbV4xlv9eGz5IPz+AIfSSghASj23sZsxOUdW
	 kJxIGH4a72E3wSzMjFvhBYpKeaiTNcQQBFiH8uLoWBenvXtCB37yPFN8SfPwN4B7u9lbX
	 CeEwSjLu1eq12yWW0udFneMW8Bhnx3tUayAaZB2tyw97svkARJGPXNoPK0fE1J93gaEHi
	 BuUe0RxA2F8hgSZ0pM34PFsBS7dX0pwrEFSe9LdAJsFMP6bWdpMdyaQopgwvv0BTzHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="KJ/vP7Lx";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mPbTJv4u;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="KJ/vP7Lx";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mPbTJv4u;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABB606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7ABB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KJ/vP7Lx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mPbTJv4u;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KJ/vP7Lx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mPbTJv4u
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47A9122247;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYHnw9tGxuEPK6F+WFQINmt7VNk0t4nwX8NpSgV0BEA=;
	b=KJ/vP7LxtrAupmKT5GbnZ89CWSrjGthEucX3RfdODmk78u6LrhgnAPMRv+L48wADSAvEql
	hf5TpkovOb+aUlsyXd4+gQaeuuZ8EXdJQUpzuVY8aq/SXbD/pxguWttrkgaLIc+a1TfR9H
	1XDjMXEk6cW/sHjNlC1HhrNO1oxHrRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYHnw9tGxuEPK6F+WFQINmt7VNk0t4nwX8NpSgV0BEA=;
	b=mPbTJv4uTKRs8NZUkkuVDnnikY4HQDMJo4YiRH3E31VRqkEdmhxlnfpY8M49LiiPOoVq1B
	K089PfAFdAn1O1Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYHnw9tGxuEPK6F+WFQINmt7VNk0t4nwX8NpSgV0BEA=;
	b=KJ/vP7LxtrAupmKT5GbnZ89CWSrjGthEucX3RfdODmk78u6LrhgnAPMRv+L48wADSAvEql
	hf5TpkovOb+aUlsyXd4+gQaeuuZ8EXdJQUpzuVY8aq/SXbD/pxguWttrkgaLIc+a1TfR9H
	1XDjMXEk6cW/sHjNlC1HhrNO1oxHrRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYHnw9tGxuEPK6F+WFQINmt7VNk0t4nwX8NpSgV0BEA=;
	b=mPbTJv4uTKRs8NZUkkuVDnnikY4HQDMJo4YiRH3E31VRqkEdmhxlnfpY8M49LiiPOoVq1B
	K089PfAFdAn1O1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0EC9136E4;
	Tue, 24 Nov 2026 11:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mryAJwp8BWtGZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:06 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id D4D2F27849; Tue, 24 Nov 2026 12:59:01 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/8] fs: Avoid inode dirtying on last iput
Date: Tue, 24 Nov 2026 12:58:46 +0100
Message-ID: <20261124115850.3512-10-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124113450.3451-1-jack@suse.cz>
References: <20261124113450.3451-1-jack@suse.cz>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6511; i=jack@suse.cz; h=from:subject; bh=0QkLj+jtrIZe+C+nYlkxx4jpOFXGc/i8sEgTt/qMK3M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXv7OoWtYpVenKb/Ai36hmUuV99WTmpBoR5yw bVT2rLOCRaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV7+wAKCRCcnaoHP2RA 2eZ7CACnq8E261KwpqY6XTtpzCKQIMy5wNYusfndpdo3R1yWEPejAWXdk9bz9bJsAO6jDM51F/y Yj4D4L4FL5sem7w8/AAOgAAyOewjfbl8EHPbeh2u2QQab99/6A3GKcWmj1SbXpIY3c1nWzrY//w 4wZxtS9ET65QU/u95TDbLIvbV5m7BCS0vE5p4uFagkFdCgJ4ObIMPgfS1YVhIt80lSqt5/Iimi5 oNHf41zK1nMcmGF+2YZFMXAszwb2hsR/6k5Bp2ykvjgSMz7/ILObvsctPi/lOGGUyuyVK/ewy+Z kRxK6RfHT2fLMJ9BtONpd13tpWLlGXzRuBgBMFvY7Nv6DYFw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

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
 fs/fs-writeback.c | 86 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/inode.c        | 15 ++++-----
 fs/internal.h     |  1 +
 3 files changed, 90 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 65b1af2879e8..0332a2edef93 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1583,6 +1583,42 @@ static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
 	spin_unlock(&inode->i_lock);
 }
 
+static void inode_add_dirtytime_head(struct inode *inode,
+				      struct bdi_writeback *wb)
+{
+	unsigned long new_time;
+
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
+}
+
+static void move_to_dirtytime_locked(struct inode *inode,
+				     struct bdi_writeback *wb)
+{
+	/* If the inode is used, move it to the tail of b_dirty_time list */
+	if (icount_read(inode)) {
+		inode->dirtied_when = jiffies;
+		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+		return;
+	}
+
+	/*
+	 * Inode is not used. Expedite writeback by moving it to the head
+	 * of b_dirty_time list so that it can enter LRU and be evicted.
+	 */
+	inode_add_dirtytime_head(inode, wb);
+	wb_io_lists_depopulated(wb);
+}
+
 /*
  * requeue inode for re-scanning after bdi->b_io list is exhausted.
  */
@@ -1830,8 +1866,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 */
 		redirty_tail_locked(inode, wb);
 	} else if (inode_state_read(inode) & I_DIRTY_TIME) {
-		inode->dirtied_when = jiffies;
-		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+		move_to_dirtytime_locked(inode, wb);
 		inode_state_clear(inode, I_SYNC_QUEUED);
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
@@ -2072,8 +2107,7 @@ static int writeback_single_inode(struct inode *inode,
 			inode_cgwb_move_to_attached(inode, wb);
 		else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)) {
 			WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
-			inode->dirtied_when = jiffies;
-			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+			move_to_dirtytime_locked(inode, wb);
 		}
 	}
 
@@ -2962,6 +2996,50 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 }
 EXPORT_SYMBOL(__mark_inode_dirty);
 
+/*
+ * If inode has dirty timestamps to write out, make sure flush worker writes
+ * them out during its next periodic writeback writeout.
+ */
+void queue_dirtytime_writeback(struct inode *inode)
+{
+	struct bdi_writeback *wb;
+	unsigned int i_state;
+
+	lockdep_assert_held(&inode->i_lock);
+
+	wb = locked_inode_to_wb_and_lock_list(inode);
+	spin_lock(&inode->i_lock);
+	i_state = inode_state_read(inode);
+	/* Written back while we dropped i_lock? */
+	if (!(i_state & I_DIRTY_TIME))
+		goto out_wb_lock;
+
+	/*
+	 * If the inode is dirty, next writeback will come soon so we don't
+	 * need to do anything. If it is under writeback, we cannot touch dirty
+	 * lists now so we handle moving the inode after writeback is complete.
+	 */
+	if (i_state & (I_SYNC_QUEUED | I_SYNC | I_DIRTY)) {
+		/*
+		 * Clobber dirtied_time_when so that timestamps get synced on
+		 * next inode writeback.
+		 */
+		inode->dirtied_time_when = jiffies -
+						dirtytime_expire_interval * HZ;
+		goto out_wb_lock;
+	}
+
+	/*
+	 * Move inode to the beginning of dirty queue so that it gets written
+	 * out during the next periodic writeback.
+	 */
+	inode_add_dirtytime_head(inode, wb);
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
index bf9403c32188..a9f757fba23b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2051,7 +2051,6 @@ void iput(struct inode *inode)
 	if (unlikely(!inode))
 		return;
 
-retry:
 	lockdep_assert_not_held(&inode->i_lock);
 	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
 	/*
@@ -2064,14 +2063,14 @@ void iput(struct inode *inode)
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
index 9580afef293e..855a80f4b879 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -222,6 +222,7 @@ bool in_group_or_capable(const struct mnt_idmap *idmap,
  */
 long get_nr_dirty_inodes(void);
 bool sync_lazytime(struct inode *inode);
+void queue_dirtytime_writeback(struct inode *inode);
 
 /*
  * dcache.c
-- 
2.53.0

