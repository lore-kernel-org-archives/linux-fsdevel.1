Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521550;
	b=MPGxm3tFQqEXGU7XJjxwvf8hVNq82tuq+CwwJMuQ2gzIpg4ScmuHIs9Q7whaMwDcZUKG
	 ZtOMplWic1vj3AwdiFkc4kfCqorDAzDOvBH62DmE1/0VMrZW5e/+RffEEypFPqBoKq/ED
	 TMNUDQsK6kRRjNm+OwM8th2LvcCAi9BjU8uPODccOHSVmMPD0oPGAJwYJ1rJjTeeV6sUk
	 VNFbVloZRY/pE5BFjx9ROv9zPFOA9D6aSSWucbWST38pwbiCpBXBOnB++oBldnmJvWGpO
	 b6P58rI7Ter1M66Ep7SEvpueN+Qnfo6Hmuv7xbooMuXtzNT1FanwHyJngzxD8e8iAQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521550;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=okfebPlBTlU1o3HpteZYdromYWCBxsPgWE+lWJFWceA=;
	b=bgul1qOrv/m2XKOhVfOszZIx64P/c0Y0xRGh7+cXGkbe6i01t2dejUS4qrhQozHI1082
	 bMezGc2lrHGiq/1/pmCVJlQ5XPgWhNLfwaEX8+qHigVDrYRNDqsH12nPoi7aK5otnHRXy
	 0/0bvD2jGy4gau72eX3DitDWcuw91RqaFGlJs6Slc1OsKPqHaONAXqIURBGIteLa5lrBk
	 WV+ntKY+6yhfE6h8LNypYOgI3TxhWLXjlHjAui/h0K4pJ/faO26Jm8hTkf1D2Oxn0fkhr
	 VEHQSktdnF0Lbh/ZHGa9qFs99aQ9hSupSx+M7gF8Z7BDRrf2DExnaQwsB9Ib2w5W1iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=chs5z7qc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=huW88pd0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=chs5z7qc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=huW88pd0;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C512606A32D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C512606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=chs5z7qc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=huW88pd0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=chs5z7qc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=huW88pd0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A92981F7A0;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okfebPlBTlU1o3HpteZYdromYWCBxsPgWE+lWJFWceA=;
	b=chs5z7qcYFkut2lneizTR21VDoSRk5dAjHB6hUAc5AQ+20F183+bhBD/B2pMSy5v3FPLjC
	YC7dIa420LiBZuL+r7dmp0IRhVIz1+PfhSDrs3Cf4gGWu7GNuObAdYdw4O9WJfPfrW8BkC
	Dyda48OQI/wBvYsHeEgpVSs/KNe9Xgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okfebPlBTlU1o3HpteZYdromYWCBxsPgWE+lWJFWceA=;
	b=huW88pd0QxsB0Lfzg3B45n4d9S1peI74IQiYcCaMor1vLmXJ+gNXbbOQLRSCdUwGRrVb4B
	Hz030OcFVTR2PpBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okfebPlBTlU1o3HpteZYdromYWCBxsPgWE+lWJFWceA=;
	b=chs5z7qcYFkut2lneizTR21VDoSRk5dAjHB6hUAc5AQ+20F183+bhBD/B2pMSy5v3FPLjC
	YC7dIa420LiBZuL+r7dmp0IRhVIz1+PfhSDrs3Cf4gGWu7GNuObAdYdw4O9WJfPfrW8BkC
	Dyda48OQI/wBvYsHeEgpVSs/KNe9Xgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okfebPlBTlU1o3HpteZYdromYWCBxsPgWE+lWJFWceA=;
	b=huW88pd0QxsB0Lfzg3B45n4d9S1peI74IQiYcCaMor1vLmXJ+gNXbbOQLRSCdUwGRrVb4B
	Hz030OcFVTR2PpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4391613763;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OxZzCQt8BWtSZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:07 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id F101C27853; Tue, 24 Nov 2026 12:59:01 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 7/8] fs: Protect deferred inode reclaim from freezing
Date: Tue, 24 Nov 2026 12:58:51 +0100
Message-ID: <20261124115850.3512-15-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9157; i=jack@suse.cz; h=from:subject; bh=GhguULg2VJtISQ/4zq4DysAyz8WH840l64psi/AwLGw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXv/fc1gmaKJ8EvJVldKI2uDDB2YO759P57ok OGaqQWeZ9iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV7/wAKCRCcnaoHP2RA 2X8PB/4q7mb4yvP6V8BKV571CNxu13NE2rbGiVdC7IbY9Gaa0P63CRy2Nh+t/eYHBaTsRpsUlID mitIp/LXfc5OdLa+BqBoNxLujR4AQyW1ACWXGq8wJVM2yIDYLf8l1eSUeH/FBp6Ny2zm0YIzo51 04RPQfBXzLWcViPiezTJAmXiXbAiKnb0SreqqYdF4X2Z+dAkWJ0XdG4zxULSZtgsvmi9o1GcHtk LauMqYr9mk68XncTt0FtOkq/g5YiuExax7OKPX51c++YCTCmP+uTOcKcyesaw3gmAwzJHPxn34G owiMpBsk0aJvTr1nSGOUoiUY0nyPbhKU2cD5YjmDcvC7AhQN
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
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLk67xqw3wspya9juy7b5dtonf)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

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
 fs/super.c                     | 31 ++++++++++++
 include/linux/fs/super.h       |  1 +
 include/linux/fs/super_types.h |  2 +
 4 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index b6fa2965f4e8..25508c122e27 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1044,20 +1044,11 @@ static int get_deferred_sb_id(struct super_block *sb)
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
@@ -1068,6 +1059,33 @@ static void queue_deferred_reclaim(struct super_block *sb, int count,
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
+	/*
+	 * Make sure queued inodes are visible before we check whether deferred
+	 * reclaim is blocked. Pairs with the barrier in thaw_super_locked().
+	 */
+	smp_mb__after_atomic();
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
@@ -1107,18 +1125,24 @@ static void __get_inode_reclaim_batch(int *start, int end,
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
@@ -1160,8 +1184,34 @@ static void inode_reclaim_update_stat(struct super_block *sb, unsigned int n,
 				READ_ONCE(sb->s_deferred_reclaim_delay));
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
 static void sb_deferred_reclaim_put(struct super_block *sb, int n)
 {
+	if (atomic_dec_and_test(&sb->s_deferred_reclaim_running))
+		wake_up_var(&sb->s_deferred_reclaim_running);
+
 	/*
 	 * The elevated s_deferred_reclaim_count keeps sb alive until we drop
 	 * it. Use RCU to make sure sb isn't freed before the wakeup.
@@ -1209,6 +1259,13 @@ static void inode_reclaim_deferred(struct work_struct *work)
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
diff --git a/fs/super.c b/fs/super.c
index fa345d5027bf..77e6ab6383b8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2435,6 +2435,19 @@ static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
 	return false;
 }
 
+/* Unblock deferred inode reclaim and wake workers */
+static void sb_unblock_deferred_reclaim(struct super_block *sb)
+{
+	atomic_set(&sb->s_deferred_reclaim_running, 0);
+	/*
+	 * Make sure we see all queued inodes added while deferred reclaim was
+	 * blocked. Pairs with the barrier in queue_deferred_reclaim()
+	 */
+	smp_mb();
+	wake_deferred_reclaim_workers(sb,
+		atomic_read(&sb->s_deferred_reclaim_count));
+}
+
 /**
  * freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
@@ -2561,10 +2574,26 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
 		sb_freeze_wake(sb);
+		/*
+		 * Deferred reclaim of some inodes could have been skipped
+		 * while sb->s_writers.frozen was set. Requeue work now.
+		 */
+		wake_deferred_reclaim_workers(sb,
+			atomic_read(&sb->s_deferred_reclaim_count));
 		deactivate_locked_super(sb);
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
@@ -2577,6 +2606,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			sb_freeze_wake(sb);
+			sb_unblock_deferred_reclaim(sb);
 			deactivate_locked_super(sb);
 			return ret;
 		}
@@ -2648,6 +2678,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 	sb->s_writers.freeze_owner = NULL;
 	sb_freeze_wake(sb);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
+	sb_unblock_deferred_reclaim(sb);
 out_deactivate:
 	deactivate_locked_super(sb);
 	return 0;
diff --git a/include/linux/fs/super.h b/include/linux/fs/super.h
index 1f063769ff5c..ad102dc5a461 100644
--- a/include/linux/fs/super.h
+++ b/include/linux/fs/super.h
@@ -258,6 +258,7 @@ int freeze_super(struct super_block *super, enum freeze_holder who,
 int thaw_super(struct super_block *super, enum freeze_holder who,
 	       const void *freeze_owner);
 
+void wake_deferred_reclaim_workers(struct super_block *sb, int count);
 int sb_init_dio_done_wq(struct super_block *sb);
 
 struct file;
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index fe952ef02b96..ec0ff6a504d4 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -241,6 +241,8 @@ struct super_block {
 
 	/* Number of inodes queued for deferred reclaim */
 	atomic_t				s_deferred_reclaim_count;
+	/* Number of workers processing deferred reclaim on this sb */
+	atomic_t				s_deferred_reclaim_running;
 	/* Average time to reclaim one deferred inode */
 	u64					s_deferred_reclaim_delay;
 
-- 
2.53.0

