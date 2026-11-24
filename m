Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521550;
	b=JFAz1KUiHxVmQdzVa1Uxd5Pwl8QDc2S5e4MzxW9aesthUWsNPbjyJ4TtLQKf6G8qdnfz
	 ZPK6dr5LvmAu/HtNtG29rSexNwJaqm2fU8l6vqtgXaGH8lLTDMiFw7MVF4ARAf4aXTnCe
	 XpfJovTBJu/P0tYG1LSvjwLtPbzVbth8mu+TqjXg7W8QPjHXJ7s1OP/MrBKXTdsYpxzL0
	 i7+xGgjRua073MM2QkEt6jZfZC2ZHt46TkPXDc3Tp63MdCfFr0O9DZc97w3BytgDC3U1b
	 IUxuB7vKR2wyrqfjH4QcTNzIE7RBIX87uwiU3Kd0xW96sIQoUMMj5UgEG5fGhgOeZlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521550;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=vM/IZQhk0I+YZrMUMyvaUdkXXS5Qyxy+JD9srcvw/l8=;
	b=OYsRdTyIjfvc2TajS8A9ocWAGdVeRPzqZJlaZLRpYvkHBVnQgwqZw6ilnsKCKMhdbWgw
	 fT9Zdm5movprYmJo8b50k7T2b4hYdbrZ/E2Zw1bXqe3FCmOh2ev1bYy0pHkWa3mM+o8dI
	 TJerw5I7cQuPNSQNebQvPBhhSZUqsJ9vxAfAjGqUzteS/FTaB3Lvjhufo8iXtFkaZRwsC
	 V7X+pG9khxUZpGJKWVMukG5dw+SjiMAKEpWY7UKi0FPe5eN7RqJwdRgA7T4fweeS+J11W
	 ftTCLQ3cEzNFed8ehmYlthJj08yGndjDPs/x28sUwvn9mE87SYdXr6HbkPfHpyA5Y2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xzBzklWi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ABUp6gT1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xzBzklWi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ABUp6gT1;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE1606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFE1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xzBzklWi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ABUp6gT1;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xzBzklWi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ABUp6gT1
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8DDD22255;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM/IZQhk0I+YZrMUMyvaUdkXXS5Qyxy+JD9srcvw/l8=;
	b=xzBzklWikUFrHyyxarAbaVaM1ixid7UGQee9dZIpfOquCWAIS4DqT7m0/n8844DPu8/C7X
	3AD0LbSCJpR8M/VlEOv33T7qHI0618jVbcDZePzpo6g/5ZK4zbDLA6i4WyGnYWd/eQuiho
	7vBSDEBd1fA1rz4wMDgwoju/jApKCXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM/IZQhk0I+YZrMUMyvaUdkXXS5Qyxy+JD9srcvw/l8=;
	b=ABUp6gT1zeRrZtdyU9+dA5xaAKygtGXDYpchyhcTCh/Zx9JH2L+dY3XOMpL1+MxYheDYdh
	um4IZrPml26WbGBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM/IZQhk0I+YZrMUMyvaUdkXXS5Qyxy+JD9srcvw/l8=;
	b=xzBzklWikUFrHyyxarAbaVaM1ixid7UGQee9dZIpfOquCWAIS4DqT7m0/n8844DPu8/C7X
	3AD0LbSCJpR8M/VlEOv33T7qHI0618jVbcDZePzpo6g/5ZK4zbDLA6i4WyGnYWd/eQuiho
	7vBSDEBd1fA1rz4wMDgwoju/jApKCXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vM/IZQhk0I+YZrMUMyvaUdkXXS5Qyxy+JD9srcvw/l8=;
	b=ABUp6gT1zeRrZtdyU9+dA5xaAKygtGXDYpchyhcTCh/Zx9JH2L+dY3XOMpL1+MxYheDYdh
	um4IZrPml26WbGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B75B1373A;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s/CNBQt8BWtQZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:07 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id EB5B127851; Tue, 24 Nov 2026 12:59:01 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 6/8] fs: Add throttling to deferred inode reclaim
Date: Tue, 24 Nov 2026 12:58:50 +0100
Message-ID: <20261124115850.3512-14-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9860; i=jack@suse.cz; h=from:subject; bh=uiFPVSGt+pZY7CCJrKKcK5xITFvp6UojKi3Mz5LMqiw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXv+puIjXvsKOncuDhdUgFlbeatGwb52fgTQB oUVsYgdrGmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV7/gAKCRCcnaoHP2RA 2drfCACkCSQMSib1xWK5pawEXr7y/Z0Q1YTLBIOwBHI6MMC8/fhKHgHcDDyqkbZIjgEzgMEZVCv xeWKxfpEa5BNZ/OVRtWDHAnkYtOqCvjcoQ++OHN5Jgv+m7QpuhPGBABwUCBT2qkiNu6W1aZoMmk n9qFR/Tnv5zdSLBFR+Q6QGDx6JOWzumD0qF2IrWOtn/UJ5WUrQ53KPm0UTgsrl6+N0p4LmiQvAH /F5McKZcf/CWm/vcMdmC+gJqYGSbnfXX78+rr/r46TPPLzmLWqsz2j0RX+T7hUbk2+pi5Aiando H6VztlwQpL7h2V8fwrZvd0qSbwvTMM97sLgDVrErO1+GQAjx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLk67xqw3wspya9juy7b5dtonf)];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

Deferring difficult inode reclaim from prune_icache_sb() to a workqueue
removes the natural feedback loop of blocking tasks in direct reclaim
until they make space for new allocations. This can result in the list
of deferred inodes to grow beyond any bounds and possibly push the
machine to a reclaim storm or OOM.

Add a throttling mechanism that makes tasks calling
mark_inode_reclaim_deferred() wait on exit to userspace if the number of
deferred inodes to reclaim for a superblock grows over limit. We measure
average time it takes to reclaim inode on deferred list for a superblock
and block tasks proportionally to that.

The mechanism to block tasks on exit to userspace is a bit simplistic
but I don't expect more than one inode to be deferred per syscall and I
expect throttling to be rare so it should be fine. If we wanted
something more advanced, we could store the delay in task_struct and
just wait for it when returning to userspace similarly as blkcg
throttling does it but so far I consider the space in task_struct a
waste for this purpose.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                       | 150 ++++++++++++++++++++++++++++---
 include/linux/fs/super_types.h   |   2 +
 include/trace/events/writeback.h |  51 +++++++++++
 3 files changed, 189 insertions(+), 14 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 760c730f4a9f..b6fa2965f4e8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/rw_hint.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/task_work.h>
 #include <trace/events/writeback.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/timestamp.h>
@@ -1142,23 +1143,55 @@ static int get_inode_reclaim_batch(int *id, struct list_head *list)
 	return count;
 }
 
+static void inode_reclaim_update_stat(struct super_block *sb, unsigned int n,
+				      u64 start)
+{
+	u64 delay;
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
+}
+
+static void sb_deferred_reclaim_put(struct super_block *sb, int n)
+{
+	/*
+	 * The elevated s_deferred_reclaim_count keeps sb alive until we drop
+	 * it. Use RCU to make sure sb isn't freed before the wakeup.
+	 */
+	rcu_read_lock();
+	if (!atomic_sub_return(n, &sb->s_deferred_reclaim_count))
+		wake_up_var(&sb->s_deferred_reclaim_count);
+	rcu_read_unlock();
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
@@ -1166,20 +1199,27 @@ static void inode_reclaim_deferred(struct work_struct *work)
 			 */
 			inode = list_first_entry(&inode_batch, struct inode,
 						 i_lru);
+			if (inode->i_sb != sb) {
+				if (sb) {
+					inode_reclaim_update_stat(sb, count,
+								  start);
+					sb_deferred_reclaim_put(sb, count);
+				}
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
-			 * until we drop it. Use RCU to keep sb alive until
-			 * the wakeup is done.
-			 */
-			rcu_read_lock();
-			if (atomic_dec_and_test(&sb->s_deferred_reclaim_count))
-				wake_up_var(&sb->s_deferred_reclaim_count);
-			rcu_read_unlock();
 			cond_resched();
 		}
+
+		if (sb) {
+			inode_reclaim_update_stat(sb, count, start);
+			sb_deferred_reclaim_put(sb, count);
+		}
 	}
 }
 
@@ -1215,6 +1255,80 @@ static void __init deferred_reclaim_init(void)
 	}
 }
 
+struct deferred_reclaim_delay {
+	struct callback_head task_work;
+	u64 delay;
+};
+
+static void deferred_delay_work(struct callback_head *work)
+{
+	struct deferred_reclaim_delay *dd =
+		container_of(work, struct deferred_reclaim_delay, task_work);
+
+	schedule_timeout_killable(nsecs_to_jiffies(dd->delay));
+	kfree(dd);
+}
+
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
+	 * Don't throttle kthreads. They are doing work for somebody else
+ 	 * anyway so throttling is counterproductive.
+	 */
+	if (current->flags & PF_KTHREAD)
+		return;
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
+		struct deferred_reclaim_delay *dd;
+
+		if (!delay)
+			return;
+
+		dd = kmalloc_obj(*dd, GFP_NOFS | __GFP_NORETRY);
+		/*
+		 * If the allocation failed, don't bother. Throttling is
+		 * approximate anyway and next time we'll throttle more.
+		 */
+		if (!dd)
+			return;
+
+		/*
+		 * Scale the delay based on how much we exceed the limit. Wait
+		 * at most 4x as long as estimated time to reclaim the inode.
+		 */
+		len = min(len, 5 * INODE_DEFERRED_RECLAIM_LIMIT);
+		delay = div_u64(delay * (len - INODE_DEFERRED_RECLAIM_LIMIT),
+				INODE_DEFERRED_RECLAIM_LIMIT);
+		trace_mark_inode_reclaim_deferred_throttle(inode, len, delay);
+
+		dd->delay = delay;
+		init_task_work(&dd->task_work, deferred_delay_work);
+		/* This shouldn't fail. If it does, just cleanly bail. */
+		if (task_work_add(current, &dd->task_work, TWA_RESUME) < 0)
+			kfree(dd);
+	}
+}
+
 /*
  * Mark inode for deferred reclaim. When slab reclaim path will be freeing the
  * inode, it will not call evict() directly but rather offload it to a worker
@@ -1231,12 +1345,20 @@ static void __init deferred_reclaim_init(void)
  */
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
index fc8f7f2261e2..fe952ef02b96 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -241,6 +241,8 @@ struct super_block {
 
 	/* Number of inodes queued for deferred reclaim */
 	atomic_t				s_deferred_reclaim_count;
+	/* Average time to reclaim one deferred inode */
+	u64					s_deferred_reclaim_delay;
 
 	/* Number of inodes with nlink == 0 but still referenced */
 	atomic_long_t				s_remove_count;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index c2a5b492a71a..d371d1112843 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -885,6 +885,57 @@ DEFINE_EVENT(writeback_inode_template, sb_clear_inode_writeback,
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
2.53.0

