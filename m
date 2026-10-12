Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD945561F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793462; cv=none; b=EcDY+gXdtGZiJMN4mP51UrgQAW/lMnj8zi7c261SsOeHe5MFDa+pRYtUt7qznQsPzLr2HTLSM4D0jElXKB/1f0XGJ5Zf+4fyAeiCCj8U2WiKP0n36oQZQplPL9Y1xReYe8AzxjQIgQ+6hzINHxYVth2u2X0OzjlHbZz97JdiYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793462; c=relaxed/simple;
	bh=d6RTrZqOsmBiZSZBOPWADpBUu0F0HDD/dqVc8x8OZsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4qA4CKhRuEr6hrUNnL73N/X1mJiati5tox9UmIuREHKYnvqq4Xn6DJkdDYg9KQOz5hZita0P7/LfyoWgf3+KCsGj0Lk41MpcRdO6aiz9JBoYwkY9kUa5AsMWjW5FGiL0wPrV/Nfbrf7knz91zBN5vDr63/tWriWGW1JISWoSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qvDVF15N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vSr5ozHQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pysYaX8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHD6COSv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qvDVF15N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vSr5ozHQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pysYaX8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHD6COSv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E87421E42;
	Mon, 12 Oct 2026 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHWbgu64pLD0+xvhyv4KhWKAJx188AU2QWrTMPK7LuY=;
	b=qvDVF15NXIQ8G55kRk6DSQcgciYQDNmn7zIEqo7MKzUdpr1UT5EPr1qfdTRtdHedTMpadv
	RYl7VKWkjM6KwTpFWFH9JOkKLli4hQMZGUlT58D+i3KASEvPXgGa3j5E+WRwt8AaMHvQlR
	RKwwdLtHn/fvj9f+A7ey2n+W85dAmF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHWbgu64pLD0+xvhyv4KhWKAJx188AU2QWrTMPK7LuY=;
	b=vSr5ozHQVOWN7fE2pyqnsMkKlPvjbaAoeNIjWSbLL2TNdBH22+F1e/HVQxZmbFCPeXOPmY
	8Ac5voqrKaIr+mDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHWbgu64pLD0+xvhyv4KhWKAJx188AU2QWrTMPK7LuY=;
	b=pysYaX8MLaN8LbiceERPwzei89iXF4Bc32asLKfzGrk9Mdaj3eCanh6pIKvEAD7Xz3C/cG
	y905oRTXh2uoNNMnmIyq52EjbjuRxqb8p+CAi3oLQ/Y3Iq1xNcnxwb/PYK6h8uurGSAZU2
	AmjTmJZ51UUWryDdS7ulHl+/DyY7RbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHWbgu64pLD0+xvhyv4KhWKAJx188AU2QWrTMPK7LuY=;
	b=vHD6COSvjtAwd+4IpaWKPcgT807gGZWWIKaOO/wzuuJ9yJGgw/lhH+6Pq8Nwd8NmSNdEmz
	P4K3bfEN5a9DFiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA3FE139B0;
	Mon, 12 Oct 2026 08:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 99zuKSuZzGoaHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 08:24:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AB75FA140E; Mon, 12 Oct 2026 10:24:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6/7] fs: Protect deferred inode reclaim from freezing
Date: Mon, 12 Oct 2026 10:23:44 +0200
Message-ID: <20261012082356.3121725-13-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009133253.20102-1-jack@suse.cz>
References: <20261009133253.20102-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8054; i=jack@suse.cz; h=from:subject; bh=d6RTrZqOsmBiZSZBOPWADpBUu0F0HDD/dqVc8x8OZsM=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGLLOzFQUYOcyZTwp717/blc4r7P/vAmf1jJbvuDg9mVfb aAub3u6k9GYhYGRg0FWTJFldeRF7WvzjLq2hmrIwAxiZQKZwsDFKQAT2cjK/k+lw3miq9J5ySb/ yt39hoskJikeumXRvk/BxrBGNu5YX8OGCYc4Q6fGhYklGKyJbSy7Mll3+letvfs3H+nav73qe56 9kulNhcdbRB702jjJu6xuXjat0GbJ+V/lVkYr9x+vPHRqheid4qITJSva5fr9bE70xcYUddblsM jpM/0vcdz79+UVK/MLrnOzDpvskHFTdpFR8ZY3v+6gIC918/e5KZ5X5rRu4Egsj95Rz+QlY3xV4 MOPesN+u5ULvio98Vsrl2q0xc1SsPbco7XWOwp57i2bZ35t3nt/nZbiWbc9pl7/Jj/B3P2R60Lu 53Os7+042lXn1rJjDquW9X1h+S8pffluBu0VYtUBbeelAQ==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

Sometimes inode reclaim needs writing to the filesystem. One prominent
case is when inode is unlinked and we are deleting it, another case is
when XFS needs to trim its speculative block preallocation. When inode
reclaim runs on frozen filesystem, this will block the deferred inode
reclaim worker so eventually all deferred inode reclaim could be stalled
in the system because all workers are waiting for some filesystem to
thaw.

Avoid this problem by protecting running deferred inode reclaim from
filesystem freezing (the SB_FREEZE_INTWRITE level) and by just skipping
starting new deferred inode reclaim for inodes on frozen filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                     | 89 ++++++++++++++++++++++++++++------
 fs/super.c                     | 14 ++++++
 include/linux/fs/super.h       |  1 +
 include/linux/fs/super_types.h |  2 +
 4 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2d2fc3ce518c..558af042a913 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1022,20 +1022,11 @@ static int get_deferred_sb_id(struct super_block *sb)
 	return hash_ptr(sb, 32) % deferred_reclaim.workers;
 }
 
-static void queue_deferred_reclaim(struct super_block *sb, int count,
-				   struct list_head *list)
+void wake_deferred_reclaim_workers(struct super_block *sb, int count)
 {
 	int id = get_deferred_sb_id(sb);
-	struct deferred_reclaim_queue *queue =
-					&deferred_reclaim.queues[id];
 	int i, wake_count;
 
-	spin_lock(&queue->lock);
-	list_splice_tail(list, &queue->list);
-	atomic_add(count, &sb->s_deferred_reclaim_count);
-	spin_unlock(&queue->lock);
-
-	/* Queue works to process inodes we've added to the list */
 	wake_count = DIV_ROUND_UP(count, INODE_RECLAIM_BATCH_SIZE);
 	if (wake_count > deferred_reclaim.workers)
 		wake_count = deferred_reclaim.workers;
@@ -1046,6 +1037,28 @@ static void queue_deferred_reclaim(struct super_block *sb, int count,
 	}
 }
 
+static void queue_deferred_reclaim(struct super_block *sb, int count,
+				   struct list_head *list)
+{
+	int id = get_deferred_sb_id(sb);
+	struct deferred_reclaim_queue *queue =
+					&deferred_reclaim.queues[id];
+
+	spin_lock(&queue->lock);
+	list_splice_tail(list, &queue->list);
+	atomic_add(count, &sb->s_deferred_reclaim_count);
+	spin_unlock(&queue->lock);
+
+	/*
+	 * Skip waking up workers for frozen filesystem. They'd skip the inodes
+	 * anyway.
+	 */
+	if (atomic_read(&sb->s_deferred_reclaim_running) < 0)
+		return;
+
+	wake_deferred_reclaim_workers(sb, count);
+}
+
 /*
  * Walk the superblock inode LRU for freeable inodes and attempt to free them.
  * This is called from the superblock shrinker function with a number of inodes
@@ -1084,18 +1097,24 @@ static void __get_inode_reclaim_batch(int *start, int end,
 	for (i = *start; i < end; i++) {
 		struct deferred_reclaim_queue *queue =
 						&deferred_reclaim.queues[i];
-		struct list_head *entry, tmp;
+		struct inode *inode, *next;
 
 		if (list_empty_careful(&queue->list))
 			continue;
 		spin_lock(&queue->lock);
-		list_for_each(entry, &queue->list) {
-			if (*count >= INODE_RECLAIM_BATCH_SIZE)
+		list_for_each_entry_safe(inode, next, &queue->list, i_lru) {
+			/*
+			 * Skip inodes on frozen fs as we'd likely block. We
+			 * always accept inodes from read-only fs as there
+			 * eviction cannot require writing.
+			 */
+			if (!sb_rdonly(inode->i_sb) &&
+			    inode->i_sb->s_writers.frozen != SB_UNFROZEN)
+				continue;
+			list_move_tail(&inode->i_lru, list);
+			if (++(*count) >= INODE_RECLAIM_BATCH_SIZE)
 				break;
-			(*count)++;
 		}
-		list_cut_before(&tmp, &queue->list, entry);
-		list_splice_tail(&tmp, list);
 		spin_unlock(&queue->lock);
 		if (*count >= INODE_RECLAIM_BATCH_SIZE)
 			break;
@@ -1147,6 +1166,35 @@ static void inode_reclaim_update_stat(struct super_block *sb, unsigned int n,
 		wake_up_var(&sb->s_deferred_reclaim_count);
 }
 
+/* Put inodes from sb back to reclaim queue */
+static void inode_reclaim_skip_inodes(struct list_head *list,
+				      struct super_block *sb)
+{
+	struct inode *inode;
+	struct deferred_reclaim_queue *queue;
+	struct list_head tmp;
+
+	queue = &deferred_reclaim.queues[get_deferred_sb_id(sb)];
+	list_for_each_entry(inode, list, i_lru)
+		if (inode->i_sb != sb)
+			break;
+	list_cut_before(&tmp, list, &inode->i_lru);
+	spin_lock(&queue->lock);
+	list_splice_tail(&tmp, &queue->list);
+	spin_unlock(&queue->lock);
+}
+
+static bool sb_deferred_reclaim_get(struct super_block *sb)
+{
+	return atomic_inc_unless_negative(&sb->s_deferred_reclaim_running);
+}
+
+static void sb_deferred_reclaim_put(struct super_block *sb)
+{
+	if (sb && atomic_dec_and_test(&sb->s_deferred_reclaim_running))
+		wake_up_var(&sb->s_deferred_reclaim_running);
+}
+
 static void inode_reclaim_deferred(struct work_struct *work)
 {
 	struct inode *inode;
@@ -1176,10 +1224,18 @@ static void inode_reclaim_deferred(struct work_struct *work)
 						 i_lru);
 			if (inode->i_sb != sb) {
 				inode_reclaim_update_stat(sb, count, start);
+				sb_deferred_reclaim_put(sb);
 
 				sb = inode->i_sb;
 				count = 0;
 				start = ktime_get_ns();
+				/* Protect us from filesystem freezing */
+				if (!sb_deferred_reclaim_get(sb)) {
+					inode_reclaim_skip_inodes(&inode_batch,
+								  sb);
+					sb = NULL;
+					continue;
+				}
 			}
 			count++;
 			list_del_init(&inode->i_lru);
@@ -1188,6 +1244,7 @@ static void inode_reclaim_deferred(struct work_struct *work)
 		}
 
 		inode_reclaim_update_stat(sb, count, start);
+		sb_deferred_reclaim_put(sb);
 	}
 }
 
diff --git a/fs/super.c b/fs/super.c
index fc845079b3df..319a20bad45e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2308,6 +2308,16 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 		return ret;
 	}
 
+	/*
+	 * Block deferred reclaim so that workers don't hang on frozen fs. We
+	 * wait for outstanding deferred reclaim here. Because the filesystem
+	 * is already partially frozen, workers will not start new deferred
+	 * reclaim for this sb.
+	 */
+	while (atomic_cmpxchg(&sb->s_deferred_reclaim_running, 0, -1))
+		wait_var_event(&sb->s_deferred_reclaim_running,
+			atomic_read(&sb->s_deferred_reclaim_running) == 0);
+
 	/* Now wait for internal filesystem counter */
 	sb->s_writers.frozen = SB_FREEZE_FS;
 	sb_wait_write(sb, SB_FREEZE_FS);
@@ -2388,6 +2398,10 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 	sb->s_writers.freeze_owner = NULL;
 	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
+	/* Unblock deferred inode reclaim and wake workers */
+	atomic_set(&sb->s_deferred_reclaim_running, 0);
+	wake_deferred_reclaim_workers(sb,
+		atomic_read(&sb->s_deferred_reclaim_count));
 out_deactivate:
 	deactivate_locked_super(sb);
 	return 0;
diff --git a/include/linux/fs/super.h b/include/linux/fs/super.h
index 733d439f01ed..b4aabcf203f8 100644
--- a/include/linux/fs/super.h
+++ b/include/linux/fs/super.h
@@ -235,6 +235,7 @@ int freeze_super(struct super_block *super, enum freeze_holder who,
 int thaw_super(struct super_block *super, enum freeze_holder who,
 	       const void *freeze_owner);
 
+void wake_deferred_reclaim_workers(struct super_block *sb, int count);
 int sb_init_dio_done_wq(struct super_block *sb);
 
 struct file;
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 6db5df6fd35f..f92ddf8397a6 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -234,6 +234,8 @@ struct super_block {
 
 	/* Number of inodes queued for deferred reclaim */
 	atomic_t				s_deferred_reclaim_count;
+	/* Number of inodes currently undergoing direct reclaim */
+	atomic_t				s_deferred_reclaim_running;
 	/* Average time to reclaim one deferred inode */
 	u64					s_deferred_reclaim_delay;
 
-- 
2.51.0

