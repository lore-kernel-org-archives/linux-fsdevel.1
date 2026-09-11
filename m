Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161A375ADE
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116731; cv=none; b=k4GL48vsHjpDaPlS8yNsiNmKqulDveJAibW0rgHFT5z7lVwQLG7L8Abi2QgNbxyJ41pzJ/IfIkk/1rPmDb0DU4QwD3fCU2i67mlrmnrqEfuF0s84UNDNroMPPXtpDD/Ra1NADQyhwHr88O1IqYrK15Umbyva6FhJh4/XU4Cesj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116731; c=relaxed/simple;
	bh=gaJyYRc4jbZuCHQwf5HfRLLVMMHEtE+8bZFVg0KNgeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQuPf5KRhQNuP0CcbeMMC37QNkUY+1vC9HTjduqhTSC3S6cd5WjwR+QkpEttrmJs4ugUsC86rJG2rRts9lrSrVkAfNakqr8ktwIZZi2xbqVHXDRYvoTv/IUW2/8uoBx4zlLjXS6xHPM9t9j12qm1j9YEwNtYc5O0cNlW5fJ+GLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rnyz5KPE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+ccnzOs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYNWQhaC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9pWjwxRG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rnyz5KPE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+ccnzOs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYNWQhaC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9pWjwxRG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D03DB21D4C;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjuQtsJpIjBeJ3TlhKpCCEqwHmPbIMsafiE0EFoiXv8=;
	b=rnyz5KPEHaH3uk5XH6KA7BvOI+5uPQFmmYZQeauigGTDLb83Jwb4k3pdA1Qxh1eAftLb8x
	hB50NKdtPCEmWPJxO908dCnAKzW/pUqDpDVsTsqcBXE5DKtXC0YbmbXmHxqPEKWu4OFllV
	EngKXTbIz6ECWYwcZL2U2AR6fkRpSpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjuQtsJpIjBeJ3TlhKpCCEqwHmPbIMsafiE0EFoiXv8=;
	b=f+ccnzOsq64IWZK7lADGGLzbgQHMv6oV/lVBo+ZasTkItLn1gnU2w1mfrm97yJZSnlXUi4
	eOlniLYhc+nwmaCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjuQtsJpIjBeJ3TlhKpCCEqwHmPbIMsafiE0EFoiXv8=;
	b=OYNWQhaCoYdRsc9hkvLXNQWwY3OwcevCZv1hNIVRfnLMr9L8RyaT+fprXKZq+rGKmYyDqR
	xLikVM8Htgh409in05y7C5MCBxKBCf+kY9JAQKR/MFcUl+LIeeJh6xujYtL9rCGq7UFZnO
	oec6tGDr0lph1l7y/7CRYxWLpQ2GyHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjuQtsJpIjBeJ3TlhKpCCEqwHmPbIMsafiE0EFoiXv8=;
	b=9pWjwxRGttCLz1r88nc6/speHlXmn//gGEZgpt6Wllc9CcK5OSzyDbIDM/Q19CDkNmJedr
	g6IYERDgJNXMo/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93188137CA;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VCXoIy7Bo2q0HwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 08:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CDF78A13AF; Fri, 11 Sep 2026 10:51:53 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 3/5] fs: Basic infrastructure for offloading inode reclaim
Date: Fri, 11 Sep 2026 10:51:39 +0200
Message-ID: <20260911085142.1774803-8-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>
References: <20260911081309.14137-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11336; i=jack@suse.cz; h=from:subject; bh=gaJyYRc4jbZuCHQwf5HfRLLVMMHEtE+8bZFVg0KNgeQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqo8Ega+/haIYhZvOWFI31BuQPJxKwSM1ykd8KJ J5won/WJkeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaqPBIAAKCRCcnaoHP2RA 2UCjB/0dWU3pTsowaP8c9hlgCOKwWpnqg410miTlfQ3BWbD+YClGnF5SW8i9TpxCX0WOiHdjkCM hsHrmEEef2kcukTlbdbXpd2ac0dImREeJw1oMe2T2+duFDt75pqGBX/x7x08dS14lMGnh3CHyyw UHQ8enEmjgMKj/y9GP2sdGKoo5cB7xbbQNe3rT+DJhM1cnkVKciURBevzt5iukNUT69SsvSmu6N KoUiijrGciI2n2VgA7XxdQ0U6H4q/JEOB6DUzKp94lV4VLVkJZgbbq7XaVX3Bej1eAn0/dKVz4T AedXZJpHyljPjr5FXP9CwTYtKZvJraP/dqx5QQQqp6v1y5P9
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
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,deferred_reclaim.work:url,suse.cz:email,suse.cz:mid]

Reclaim of some inodes is rather complex requiring running transactions
or doing other IO. Consequently filesystems end up doing GFP_NOFAIL
allocations from kswapd or even direct reclaim which is problematic
because forward progress of these allocations isn't guaranteed. Add
infrastructure for marking inodes whose reclaim is difficult and offload
reclaim of such inodes into a workqueue to not block kswapd with
difficult inode reclaim. The processing of the queued inodes happens in
parallel from several work items so that the reclaim has higher chances
of keeping up with the inflow of inodes if reclaim of some inodes
progresses slowly.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                       | 197 ++++++++++++++++++++++++++++++-
 fs/super.c                       |   2 +
 include/linux/fs.h               |   3 +
 include/linux/fs/super_types.h   |   3 +
 include/trace/events/writeback.h |   3 +-
 5 files changed, 201 insertions(+), 7 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5555a513a0a3..e902095cf39b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -74,6 +74,25 @@ static DEFINE_PER_CPU(unsigned long, nr_unused);
 
 static struct kmem_cache *inode_cachep __ro_after_init;
 
+struct deferred_reclaim_queue {
+	struct list_head list;
+	spinlock_t lock;
+};
+
+/* Inodes for deferred reclaim */
+struct inode_deferred_reclaim {
+	int workers;			/* Number of parallel workers */
+	struct workqueue_struct *wq;	/* Workqueue for workers */
+	struct work_struct *work;	/* Workers */
+	/*
+	 * Queue of deferred inodes. The number of queues is the same number
+	 * as the number of workers
+	 */
+	struct deferred_reclaim_queue *queues;
+};
+
+static struct inode_deferred_reclaim deferred_reclaim;
+
 static long get_nr_inodes(void)
 {
 	int i;
@@ -919,6 +938,12 @@ void evict_inodes(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
+struct inodes_to_prune {
+	struct list_head freeable;
+	struct list_head deferred;
+	unsigned int deferred_count;
+};
+
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
  *
@@ -933,7 +958,7 @@ EXPORT_SYMBOL_GPL(evict_inodes);
 static enum lru_status inode_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, void *arg)
 {
-	struct list_head *freeable = arg;
+	struct inodes_to_prune *lists = arg;
 	struct inode	*inode = container_of(item, struct inode, i_lru);
 
 	/*
@@ -950,7 +975,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * sync, or the last page cache deletion will requeue them.
 	 */
 	if (icount_read(inode) ||
-	    (inode_state_read(inode) & ~I_REFERENCED) ||
+	    inode_state_read(inode) & ~(I_REFERENCED | I_DEFER_RECLAIM) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
 		spin_unlock(&inode->i_lock);
@@ -988,13 +1013,27 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 
 	WARN_ON(inode_state_read(inode) & I_NEW);
 	inode_state_set(inode, I_FREEING);
-	list_lru_isolate_move(lru, &inode->i_lru, freeable);
+	/* Inode will take long time to cleanup. Offload that to worker. */
+	if (inode_state_read(inode) & I_DEFER_RECLAIM) {
+		list_lru_isolate_move(lru, &inode->i_lru, &lists->deferred);
+		lists->deferred_count++;
+	} else {
+		list_lru_isolate_move(lru, &inode->i_lru, &lists->freeable);
+	}
 	spin_unlock(&inode->i_lock);
 
 	this_cpu_dec(nr_unused);
 	return LRU_REMOVED;
 }
 
+/* Number of inodes to process in one reclaim batch */
+#define INODE_RECLAIM_BATCH_SIZE 16
+
+static int get_deferred_sb_id(struct super_block *sb)
+{
+	return hash_ptr(sb, 32) % deferred_reclaim.workers;
+}
+
 /*
  * Walk the superblock inode LRU for freeable inodes and attempt to free them.
  * This is called from the superblock shrinker function with a number of inodes
@@ -1003,15 +1042,158 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
  */
 long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 {
-	LIST_HEAD(freeable);
+	struct inodes_to_prune lists = {
+		.freeable = LIST_HEAD_INIT(lists.freeable),
+		.deferred = LIST_HEAD_INIT(lists.deferred),
+	};
 	long freed;
 
 	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
-				     inode_lru_isolate, &freeable);
-	dispose_list(&freeable);
+				     inode_lru_isolate, &lists);
+	dispose_list(&lists.freeable);
+	if (!list_empty(&lists.deferred)) {
+		int id = get_deferred_sb_id(sb);
+		int i, wake_count;
+
+		spin_lock(&deferred_reclaim.queues[id].lock);
+		list_splice_tail(&lists.deferred,
+				 &deferred_reclaim.queues[id].list);
+		atomic_add(lists.deferred_count, &sb->s_deferred_reclaim_count);
+		spin_unlock(&deferred_reclaim.queues[id].lock);
+
+		/* Queue works to process inodes we've added to the list */
+		wake_count = (lists.deferred_count + INODE_RECLAIM_BATCH_SIZE)
+						/ INODE_RECLAIM_BATCH_SIZE;
+		if (wake_count > deferred_reclaim.workers)
+			wake_count = deferred_reclaim.workers;
+		for (i = 0; i < wake_count; i++) {
+			queue_work(deferred_reclaim.wq,
+				   &deferred_reclaim.work[id]);
+			id = (id + 1) % deferred_reclaim.workers;
+		}
+	}
 	return freed;
 }
 
+static void __get_inode_reclaim_batch(int *start, int end,
+				      struct list_head *list, int *count)
+{
+	int i;
+
+	for (i = *start; i < end; i++) {
+		if (list_empty_careful(&deferred_reclaim.queues[i].list))
+			continue;
+		spin_lock(&deferred_reclaim.queues[i].lock);
+		while (*count < INODE_RECLAIM_BATCH_SIZE &&
+		       !list_empty(&deferred_reclaim.queues[i].list)) {
+			list_move(deferred_reclaim.queues[i].list.next, list);
+			(*count)++;
+		}
+		spin_unlock(&deferred_reclaim.queues[i].lock);
+		if (*count >= INODE_RECLAIM_BATCH_SIZE)
+			break;
+	}
+	*start = i;
+}
+
+/* Move a batch of inodes from queued lists to our private list */
+static int get_inode_reclaim_batch(int *id, struct list_head *list)
+{
+	int count = 0;
+	int orig_id = *id;
+
+	__get_inode_reclaim_batch(id, deferred_reclaim.workers, list, &count);
+	if (count >= INODE_RECLAIM_BATCH_SIZE)
+		return count;
+	/* Wrap around */
+	if (orig_id > 0) {
+		*id = 0;
+		__get_inode_reclaim_batch(id, orig_id, list, &count);
+	}
+	return count;
+}
+
+
+static void inode_reclaim_deferred(struct work_struct *work)
+{
+	struct inode *inode;
+	LIST_HEAD(inode_batch);
+	/*
+	 * We start with the list corresponding to the work but rolling a dice
+	 * would work as well
+	 */
+	int id = work - deferred_reclaim.work;
+
+	while (1) {
+		if (!get_inode_reclaim_batch(&id, &inode_batch))
+			break;
+		while (!list_empty(&inode_batch)) {
+			struct super_block *sb;
+
+			/*
+			 * inode_batch list is private and I_FREEING flags
+			 * protect us from anybody else trying to remove the
+			 * inode from the LRU list. No locking needed.
+			 */
+			inode = list_first_entry(&inode_batch, struct inode,
+						 i_lru);
+			list_del_init(&inode->i_lru);
+			sb = inode->i_sb;
+			evict(inode);
+			/*
+			 * The elevated s_deferred_reclaim_count keeps sb alive
+			 * until we drop it
+			 */
+			if (atomic_dec_and_test(&sb->s_deferred_reclaim_count))
+				wake_up_var(&sb->s_deferred_reclaim_count);
+			cond_resched();
+		}
+	}
+}
+
+/* Maximum number of inode reclaim workers */
+#define MAX_RECLAIM_WORKERS 16
+
+static void __init deferred_reclaim_init(void)
+{
+	int workers = MAX_RECLAIM_WORKERS;
+	int i;
+
+	/* Scale down the number of workers for small systems */
+	if (workers > num_possible_cpus())
+		workers = num_possible_cpus();
+
+	deferred_reclaim.workers = workers;
+	deferred_reclaim.work = kmalloc_objs(struct work_struct, workers);
+	deferred_reclaim.queues =
+			kmalloc_objs(struct deferred_reclaim_queue, workers);
+	if (!deferred_reclaim.work || !deferred_reclaim.queues)
+		panic("Failed to allocate deferred inode queues");
+
+	deferred_reclaim.wq = alloc_workqueue("deferred-inodegc",
+			WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_UNBOUND,
+			workers);
+	if (!deferred_reclaim.wq)
+		panic("Failed to allocate deferred inode reclaim workqueue");
+
+	for (i = 0; i < workers; i++) {
+		INIT_WORK(&deferred_reclaim.work[i], inode_reclaim_deferred);
+		spin_lock_init(&deferred_reclaim.queues[i].lock);
+		INIT_LIST_HEAD(&deferred_reclaim.queues[i].list);
+	}
+}
+
+void mark_inode_reclaim_deferred(struct inode *inode)
+{
+	if (inode_state_read_once(inode) & I_DEFER_RECLAIM)
+		return;
+
+	spin_lock(&inode->i_lock);
+	inode_state_set(inode, I_DEFER_RECLAIM);
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL_GPL(mark_inode_reclaim_deferred);
+
 static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
 static bool igrab_from_hash(struct inode *inode);
 
@@ -2659,6 +2841,9 @@ void __init inode_init(void)
 					 SLAB_ACCOUNT),
 					 init_once);
 
+	/* Deferred inode reclaim infrastructure */
+	deferred_reclaim_init();
+
 	/* Hash may have been set up in inode_init_early */
 	if (!hashdist)
 		return;
diff --git a/fs/super.c b/fs/super.c
index 05e443173038..0852a40b2635 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -600,6 +600,8 @@ void deactivate_locked_super(struct super_block *s)
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
 		shrinker_free(s->s_shrink);
+		wait_var_event(&s->s_deferred_reclaim_count,
+			       !atomic_read(&s->s_deferred_reclaim_count));
 		fs->kill_sb(s);
 
 		kill_super_notify(s);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..a289402563f8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -741,6 +741,7 @@ enum inode_state_flags_enum {
 	I_SYNC_QUEUED		= (1U << 17),
 	I_PINNING_NETFS_WB	= (1U << 18),
 	I_METADATA_WRITEBACK	= (1U << 19),
+	I_DEFER_RECLAIM		= (1U << 20),
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
@@ -2218,6 +2219,8 @@ static inline void set_inode_metadata_writeback(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+void mark_inode_reclaim_deferred(struct inode *inode);
+
 /*
  * returns the refcount on the inode. it can change arbitrarily.
  */
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee..a41bd57fc2e6 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -232,6 +232,9 @@ struct super_block {
 
 	struct shrinker				*s_shrink;	/* per-sb shrinker handle */
 
+	/* Number of inodes queued for deferred reclaim */
+	atomic_t				s_deferred_reclaim_count;
+
 	/* Number of inodes with nlink == 0 but still referenced */
 	atomic_long_t				s_remove_count;
 
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076ccd16..4a9cfe458820 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -28,7 +28,8 @@
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
+		{I_DEFER_RECLAIM,	"I_DEFER_RECLAIM"}	\
 	)
 
 /* enums need to be exported to user space */
-- 
2.51.0

