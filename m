Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302246985D
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116730; cv=none; b=Co4mnD1m9wFsTsimRpVYnci4YbHfIofu1xBRZuiz9MXyu/A3wtjOVFbiCfOE9ENmlUY0jRPdF4PWIoNrQrD7cKR01AcE8djEdpBHeGizRZPOkRDlw+KiQ3ij3HAqG5dzMAlJySr3Lu1t9JcoVK4/6nbC65HXTGOgJPIo43RiqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116730; c=relaxed/simple;
	bh=n0K80NlVJu9vGet7bT/TQoYBw0ad3M3u86eFQZ5/vL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIyMc8uFINbm8J9ALrcQHRKxgNUwsUH2LDyzBmWGFWBYgN4SaMRSrA9eT71Wu45ZVA7VpthEnEO/1apzNqnTugIcCFyDVI//mtnczg3Er/oSvoWj9fgb96D+89Yd7e8qwR21N/x7hliR54JCJzieYT/9+SoXjjwahw8mQZiBzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o1e1H5S0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lld2fKKz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i51qg33t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kEDUQO/w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o1e1H5S0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lld2fKKz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i51qg33t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kEDUQO/w"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0E431FD88;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6NwH++d24GNIYZv7OKuurKVqtEXzUK7BFcqB+QWevU=;
	b=o1e1H5S0ondTKFIS5WQja6u2CMLt8CzD9k0kQNmAAZ3/D4Pll6a7oXv1DTKF/CcyyFep6c
	XdaZMA26wqEh/SUj7pc3p2atwpnBQZGwpslqDQD3QiOb4KQG6DO1SAX5U0Ixn4RfIlZ13K
	ulnOMj5kHGD/xIL2BQjeLtzl3A6rI3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6NwH++d24GNIYZv7OKuurKVqtEXzUK7BFcqB+QWevU=;
	b=Lld2fKKzVxAWVmEH203fxlwHKaXu/ydQZl375BK0QjEVUC3UTX9SEGb/0+OfEcALd6Nkbr
	s4HY1qIkzA3JtdCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i51qg33t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="kEDUQO/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6NwH++d24GNIYZv7OKuurKVqtEXzUK7BFcqB+QWevU=;
	b=i51qg33tb863XFo671lPhAI97tHtIUQgBWqx/6wuG0HxauurSn27V+Guszkz0Zq8G4o8xA
	lh08OsLUo8ME7SW2tp4AV+9UA6iorukPKPFfNMr53wG4wSY9RnOhRwX3zH2fThAh2lETT1
	L55dyLUHo8DPpNhfK57fgITXjUJDplc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6NwH++d24GNIYZv7OKuurKVqtEXzUK7BFcqB+QWevU=;
	b=kEDUQO/wnt6F9aDVN/HGlgivRDf6CAwe1gfGCyNR6RMMuf5zlHatzQTASDRhBUIEMfmF40
	a4K9JxcYowS0lJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67B7C13794;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nzZRGS7Bo2qyHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 08:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8D7DA13AE; Fri, 11 Sep 2026 10:51:53 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/5] fs: Avoid inode dirtying on last iput
Date: Fri, 11 Sep 2026 10:51:38 +0200
Message-ID: <20260911085142.1774803-7-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>
References: <20260911081309.14137-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=jack@suse.cz; h=from:subject; bh=n0K80NlVJu9vGet7bT/TQoYBw0ad3M3u86eFQZ5/vL4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqo8EfB82a9kvKqXvGvUVhyPyh5lvJT25WMqxbi tTzwgoPI2GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaqPBHwAKCRCcnaoHP2RA 2VDAB/9wQMsi9uWET3Gm3sdzAzNo48twh5uzDf/F6D2dsKfUKSHEPUh7fbH+iaU0LNv+9vE8HLj KGxfgnhhF7pX1VuRFDwypzfolgZvQnaaLTRWwxovX7jrEhaVRWPv3IZXS1sa1yOELku7NXVlggr 40LkZwx/RDXyRDqWftflywW6pMard31o3QUkldDrEHKA0h9yoh5rAx78Wj6Y60uUbbAfYKSJYun 7CBvUNOtEYH1S4ImBKhttEnP1cfS0dwl08yTxu0gW61FTpugqJcChRcDh1tF++BYFBXUtNpsJrE T2F137n/RnoW4TL573PFRqHnqpTuzMzi7T+aqzqcHeZf+HjQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: B0E431FD88
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

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
 fs/fs-writeback.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/inode.c        | 15 +++++++--------
 fs/internal.h     |  1 +
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index bb4546d147dc..762e310e808f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2837,6 +2837,48 @@ void __mark_inode_dirty(struct inode *inode, int flags)
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
+out_wb_lock:
+	spin_unlock(&wb->list_lock);
+}
+
 /*
  * The @s_sync_lock is used to serialise concurrent sync operations
  * to avoid lock contention problems with concurrent wait_sb_inodes() calls.
diff --git a/fs/inode.c b/fs/inode.c
index ba7da39be4a3..5555a513a0a3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2030,7 +2030,6 @@ void iput(struct inode *inode)
 	if (unlikely(!inode))
 		return;
 
-retry:
 	lockdep_assert_not_held(&inode->i_lock);
 	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
 	/*
@@ -2043,14 +2042,14 @@ void iput(struct inode *inode)
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

