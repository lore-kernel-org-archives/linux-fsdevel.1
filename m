Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD43414435
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116735; cv=none; b=UYRdgSgVyIp+aD5OIPO7i2V4jawaLIv/77tfj8W816H9g1+FiCOaI4Jk+QL3MW17nlvk5HLF9uICGPc1XBj7Mm0Osi2jgTg+6YMPisQYKG4vsr423PnRxiWvSWWx5B7r0cDF7aatZjU1HyAc4w4joHdtJRnnRZEZcCYRr8ktphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116735; c=relaxed/simple;
	bh=nD2yHzd9rrfz+6A8vWYBVWn86hUooAQeeGgTPFndC1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0xqGYf6ah/bTvhXxsLRRiEH1MC11ya5TiuaQ9SrlE5Jyho79jOmVB3sKUlvm60iQJNcKD5EF2LfwhO0u98Nt4bRm/gnp0Wz5xrZSb/34UZqfp12hzU1unk5ZCmC6M4W+kqfizSxiVOgzIz+iPeKHz5XDHBIRDXfvDHu/sNMZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GAk8hEHa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3gSdYmG3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Gr/ahqS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAP0FqxC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GAk8hEHa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3gSdYmG3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Gr/ahqS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAP0FqxC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7C2C21B8B;
	Fri, 11 Sep 2026 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEjVr3VqOsgw2/6xz7pzlUq656yoK+pHIhRM+5iKwcc=;
	b=GAk8hEHaX6uRqvvjj9LAN0Xi9siOtOTW1hvF15VUt2ZdR58fTrfxu1z8EYsXbqfn2sKhGD
	1pKxTF2fw4YCHReRJZQB4HL58HzlhapyMn1WJ57RXlGumgao4eT0WTqES5J8TptCUo+Tsm
	KJrIo35ugRE0Mnb48NkbKT9BtWG9E+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEjVr3VqOsgw2/6xz7pzlUq656yoK+pHIhRM+5iKwcc=;
	b=3gSdYmG3s0Ft4Ct8cqEsPYFabItr37j+88E0i+yMhIGOPiEawE0cvKZ7AA5JrszfKN+jO2
	852EwAEkfbi003Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEjVr3VqOsgw2/6xz7pzlUq656yoK+pHIhRM+5iKwcc=;
	b=2Gr/ahqSq9yEOaPV4hdG5/XFZP0sQtZALrvdx9a38U8p7ifiAIGzdcK9qsBRNYqO7zrRoE
	a6JvthhLSuJPN5WgYuX/sOhdqJAQT0peu10rZ2Z1D0SlAs6bdlZ5wu1KBmhEbS6xn4ZhAW
	m3nkFW16ezdpb9saZEE1r8vz2m8M3Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEjVr3VqOsgw2/6xz7pzlUq656yoK+pHIhRM+5iKwcc=;
	b=LAP0FqxC/uWh0Qwg2qjue/d3ZUDMjzMEAyciL8XrcKUhSDxNVHmzV7/Tj7P2rox3GUdTh+
	AEvVvqqpD/W3oICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B36CF137DE;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rWvMKy7Bo2q3HwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 08:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D37CCA13B7; Fri, 11 Sep 2026 10:51:53 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 4/5] fs: Add throttling to deferred inode reclaim
Date: Fri, 11 Sep 2026 10:51:40 +0200
Message-ID: <20260911085142.1774803-9-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>
References: <20260911081309.14137-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7558; i=jack@suse.cz; h=from:subject; bh=nD2yHzd9rrfz+6A8vWYBVWn86hUooAQeeGgTPFndC1o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqo8Ehzakv637PI+5cECPIrkAikJItnBL6W/XwU mCGCaNO8KmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaqPBIQAKCRCcnaoHP2RA 2UahB/9ouRJWwI11u5NkcNGdGIx/f45t2/DkKJ+TIdXZ1tN9zJ8f/hRU54+12oqs4wkSl4YdtHv XmnxiTQcNCxIPyxPNl+gt2pAztZytvW3EBBg5bdKMBlWQ+/hQSSytbMn1/rtGUS0xXNJOe0Zae4 4jUkdmH+Oozj/wDaviMrRhGb+zyX2215Mpeffm1+4olNE+fubM4Vy0wKse3WKq0a98FSZBM6DXD 33njSPpxMTAaVLtXmTpKTHL4poQhJQexH7aLc4pzP+8oEqmiu4D+BX/rheFsao4iy7qyuPXS8hM qjhvUkGcWDY7tUNHjFqseG5WwwA8Vsu00QPg/X0oDr9nWgSm
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]

Deferring difficult inode reclaim from prune_icache_sb() to a workqueue
removes the natural feedback loop of blocking tasks in direct reclaim
until they make space for new allocations. This can result in the list
of deferred inodes to grow beyond any bounds and possibly push the
machine to a reclaim storm or OOM.

Add a throttling mechanism slowing down tasks in
mark_inode_reclaim_deferred() if the number of deferred inodes to
reclaim for a superblock grows over limit. We measure average time it
takes to reclaim inode on deferred list for a superblock and block tasks
proportionally to that.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                       | 102 +++++++++++++++++++++++++++----
 include/linux/fs/super_types.h   |   2 +
 include/trace/events/writeback.h |  51 ++++++++++++++++
 3 files changed, 144 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e902095cf39b..0491300c5ccb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1113,23 +1113,53 @@ static int get_inode_reclaim_batch(int *id, struct list_head *list)
 	return count;
 }
 
+static void inode_reclaim_update_stat(struct super_block *sb, unsigned int n,
+				      u64 start)
+{
+	u64 delay;
+
+	if (!sb)
+		return;
+
+	delay = div_u64(ktime_get_ns() - start, n);
+	/*
+	 * Smooth delay updates with exponential moving average. Updates can
+	 * get lost if workers race but we don't really care.
+	 */
+	WRITE_ONCE(sb->s_deferred_reclaim_delay,
+		   (63 * READ_ONCE(sb->s_deferred_reclaim_delay) + delay) / 64);
+
+	trace_inode_reclaim_update_stat(sb, n, delay,
+				READ_ONCE(sb->s_deferred_reclaim_delay));
+
+	/*
+	 * The elevated s_deferred_reclaim_count keeps sb alive until we drop
+	 * it
+	 */
+	if (!atomic_sub_return(n, &sb->s_deferred_reclaim_count))
+		wake_up_var(&sb->s_deferred_reclaim_count);
+}
 
 static void inode_reclaim_deferred(struct work_struct *work)
 {
 	struct inode *inode;
 	LIST_HEAD(inode_batch);
+	u64 start;
+	int id, count;
+	struct super_block *sb;
+
 	/*
 	 * We start with the list corresponding to the work but rolling a dice
 	 * would work as well
 	 */
-	int id = work - deferred_reclaim.work;
+	id = work - deferred_reclaim.work;
 
 	while (1) {
 		if (!get_inode_reclaim_batch(&id, &inode_batch))
 			break;
-		while (!list_empty(&inode_batch)) {
-			struct super_block *sb;
+		sb = NULL;
 
+		while (!list_empty(&inode_batch)) {
 			/*
 			 * inode_batch list is private and I_FREEING flags
 			 * protect us from anybody else trying to remove the
@@ -1137,17 +1167,20 @@ static void inode_reclaim_deferred(struct work_struct *work)
 			 */
 			inode = list_first_entry(&inode_batch, struct inode,
 						 i_lru);
+			if (inode->i_sb != sb) {
+				inode_reclaim_update_stat(sb, count, start);
+
+				sb = inode->i_sb;
+				count = 0;
+				start = ktime_get_ns();
+			}
+			count++;
 			list_del_init(&inode->i_lru);
-			sb = inode->i_sb;
 			evict(inode);
-			/*
-			 * The elevated s_deferred_reclaim_count keeps sb alive
-			 * until we drop it
-			 */
-			if (atomic_dec_and_test(&sb->s_deferred_reclaim_count))
-				wake_up_var(&sb->s_deferred_reclaim_count);
 			cond_resched();
 		}
+
+		inode_reclaim_update_stat(sb, count, start);
 	}
 }
 
@@ -1183,14 +1216,61 @@ static void __init deferred_reclaim_init(void)
 	}
 }
 
+/*
+ * Size of deferred reclaim list from which we start throttling tasks creating
+ * inodes marked for deferred reclaim.
+ */
+#define INODE_DEFERRED_RECLAIM_LIMIT 8192
+
+static void throttle_inode_deferred_reclaim(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int len;
+
+	/*
+	 * If inodes with deferred reclaim are accumulating too much, slow down
+	 * tasks creating them. This doesn't provide any kind of guarantee on
+	 * the length of the deferred list since lots of inodes with
+	 * I_DEFER_RECLAIM can be already present in the inode cache and we
+	 * have no control when they reach the deferred list. But if the
+	 * pressure on the deferred list is sustained, the balance should
+	 * eventually be established.
+	 */
+	len = atomic_read(&sb->s_deferred_reclaim_count);
+	if (len > INODE_DEFERRED_RECLAIM_LIMIT) {
+		u64 delay = READ_ONCE(sb->s_deferred_reclaim_delay);
+
+		if (!delay)
+			return;
+		/*
+		 * Scale the delay based on how much we exceed the limit. Wait
+		 * at most 4x as long as estimated time to reclaim the inode.
+		 */
+		len = min(len, 5 * INODE_DEFERRED_RECLAIM_LIMIT);
+		delay = div_u64(delay * (len - INODE_DEFERRED_RECLAIM_LIMIT),
+				INODE_DEFERRED_RECLAIM_LIMIT);
+		trace_mark_inode_reclaim_deferred_throttle(inode, len, delay);
+
+		schedule_timeout_killable(nsecs_to_jiffies(delay));
+	}
+}
+
 void mark_inode_reclaim_deferred(struct inode *inode)
 {
+	bool throttle = false;
+
 	if (inode_state_read_once(inode) & I_DEFER_RECLAIM)
 		return;
 
 	spin_lock(&inode->i_lock);
-	inode_state_set(inode, I_DEFER_RECLAIM);
+	if (!(inode_state_read(inode) & I_DEFER_RECLAIM)) {
+		inode_state_set(inode, I_DEFER_RECLAIM);
+		throttle = true;
+	}
 	spin_unlock(&inode->i_lock);
+
+	if (throttle)
+		throttle_inode_deferred_reclaim(inode);
 }
 EXPORT_SYMBOL_GPL(mark_inode_reclaim_deferred);
 
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index a41bd57fc2e6..6db5df6fd35f 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -234,6 +234,8 @@ struct super_block {
 
 	/* Number of inodes queued for deferred reclaim */
 	atomic_t				s_deferred_reclaim_count;
+	/* Average time to reclaim one deferred inode */
+	u64					s_deferred_reclaim_delay;
 
 	/* Number of inodes with nlink == 0 but still referenced */
 	atomic_long_t				s_remove_count;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 4a9cfe458820..aec38eaeb10e 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -881,6 +881,57 @@ DEFINE_EVENT(writeback_inode_template, sb_clear_inode_writeback,
 	TP_ARGS(inode)
 );
 
+TRACE_EVENT(inode_reclaim_update_stat,
+	TP_PROTO(
+		struct super_block *sb,
+		unsigned int n,
+		u64 batch_delay,
+		u64 avg_delay
+	),
+	TP_ARGS(sb, n, batch_delay, avg_delay),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(unsigned int,	n)
+		__field(u64,		batch_delay)
+		__field(u64,		avg_delay)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->n = n;
+		__entry->batch_delay = batch_delay;
+		__entry->avg_delay = avg_delay;
+	),
+
+	TP_printk("dev %d,%d batch size %u batch delay %llu ns avg delay %llu ns",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->n,
+		  __entry->batch_delay, __entry->avg_delay)
+);
+
+TRACE_EVENT(mark_inode_reclaim_deferred_throttle,
+	TP_PROTO(struct inode *inode, unsigned int len, u64 delay),
+	TP_ARGS(inode, len, delay),
+
+	TP_STRUCT__entry(
+		__field(u64,		ino)
+		__field(dev_t,		dev)
+		__field(unsigned int,	len)
+		__field(u64,		delay)
+	),
+
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->len = len;
+		__entry->delay = delay;
+	),
+
+	TP_printk("dev %d,%d ino %llu deferred list len %u delay %llu ns",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->len, __entry->delay)
+);
+
 #endif /* _TRACE_WRITEBACK_H */
 
 /* This part must be outside protection */
-- 
2.51.0

