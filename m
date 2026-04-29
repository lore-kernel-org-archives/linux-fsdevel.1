Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB7381AE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485682; cv=none; b=cNtX3ZbJ4Mtgh/5g0aEORZMuH98vFi7M3AIee1x9CMmDbTukdkGi7KjYLd+miAOL/ZSqfyX7i3Pt0szYAIwMg7TfgpIRrxwVe8vIBaRHAPilF+gSqaGTGELpHP7VhKZasaH2awPxMkVAcpSjv+3u13umKzuqCYwiW3WU08SXyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485682; c=relaxed/simple;
	bh=g0wnob1KuQZ/adin+dNbM79jIM7EYE2kBfuf6I584HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE6OLN7qoWXPPgJ50z26qdR3kzRsZIrb9+zbAbTNuwFEsERIgYoPZxt+X/51nL16EJV9xur+HRnr6vzBnEgeUxhBCQDHevTHQCmerjWy7LIXX06LjDGXVC3lyLxiC/4mfnVJdWG+TQPvwhu337WOnnrOe0QVatzrObzrowlF7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YAD0End/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kyU+LTo6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YAD0End/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kyU+LTo6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YAD0End/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kyU+LTo6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YAD0End/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kyU+LTo6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20E3B6A80B;
	Wed, 29 Apr 2026 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777485673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqErut8BEcDHW3YmEh+o9vWKuTwa4oQV8phTe3aCsi4=;
	b=YAD0End/pRrF1SbJbrBpWbdczmZuwI3vvui6IGgh2TCnZVVHtYsmbk9w1uCpvcJUW31QDt
	zgRZBYQiaH++9enivVCE7EejP7UujoD1qO26+fXeNMeEA7D426wTdZZMVcrp4GJleC3JC/
	4z3abEuz+db5w7SmfMJ5/AZjLz7JkpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777485673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqErut8BEcDHW3YmEh+o9vWKuTwa4oQV8phTe3aCsi4=;
	b=kyU+LTo6RMyJIIgj+NEPQImEIR06JpeCjJVJck6nf7mbb3ULlffuplLdjdl6bPAzHAqEBF
	zYt+WiYJfp1DioBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777485673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqErut8BEcDHW3YmEh+o9vWKuTwa4oQV8phTe3aCsi4=;
	b=YAD0End/pRrF1SbJbrBpWbdczmZuwI3vvui6IGgh2TCnZVVHtYsmbk9w1uCpvcJUW31QDt
	zgRZBYQiaH++9enivVCE7EejP7UujoD1qO26+fXeNMeEA7D426wTdZZMVcrp4GJleC3JC/
	4z3abEuz+db5w7SmfMJ5/AZjLz7JkpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777485673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqErut8BEcDHW3YmEh+o9vWKuTwa4oQV8phTe3aCsi4=;
	b=kyU+LTo6RMyJIIgj+NEPQImEIR06JpeCjJVJck6nf7mbb3ULlffuplLdjdl6bPAzHAqEBF
	zYt+WiYJfp1DioBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B958593B1;
	Wed, 29 Apr 2026 18:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AXbQAmlH8mnXOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 Apr 2026 18:01:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BBF8EA0B75; Wed, 29 Apr 2026 20:01:04 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/4] fs: Basic infrastructure for offloading inode reclaim
Date: Wed, 29 Apr 2026 20:00:52 +0200
Message-ID: <20260429180056.29598-6-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429174850.18223-1-jack@suse.cz>
References: <20260429174850.18223-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7089; i=jack@suse.cz; h=from:subject; bh=g0wnob1KuQZ/adin+dNbM79jIM7EYE2kBfuf6I584HQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBp8kdZEsl6TIDYeVCy4Z03jyBSlMsOYdoT9fOV/ 4JQltZEkJ+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCafJHWQAKCRCcnaoHP2RA 2T9fCAC3qgI677UNFqbGz9vdp2WfJK8o1AwSi1NU8E1NtrWZ5ScpRFT8wihUcRfDC3G4Wgdf2Ed CikUAGUn8LE00oj8HynYWf9sp2l/ZVI7kDG10g8qLkfYtwESKOpLR6zzJTsUeDp1tQjiSiP0D8t fRfQBDChIonFpJzA07A0aVA2lqZ4IMcYp+UydHWRx0JNustYxmYZQbJcXPiXyJlLoFsIKiRSvzT Gx1r5rc2zyOSjP5jk/6KdjzI3zU4Oy/tighOZj50giEC9Bx3R+p5o7pPaVIkRClQ1Ls+X9FG1RW nUB6kZ+VDmvLR/nunFHMKxJHlQyuR5S3p1O4KiBx9lKj/1hw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

Reclaim of some inodes is rather complex requiring running transactions
or doing other IO. Consequently filesystems end up doing GFP_NOFAIL
allocations from kswapd or even direct reclaim which is problematic
because forward progress of these allocations isn't guaranteed. Add
infrastructure for marking inodes whose reclaim is difficult and offload
reclaim of such inodes into a workqueue to not block kswapd with
difficult inode reclaim.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                     | 89 +++++++++++++++++++++++++++++++---
 fs/super.c                     |  5 ++
 include/linux/fs.h             |  5 +-
 include/linux/fs/super_types.h |  7 +++
 4 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 276debcd3e20..448e3d7ee48e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -938,6 +938,11 @@ void evict_inodes(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
+struct inodes_to_prune {
+	struct list_head freeable;
+	struct list_head deferred;
+};
+
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
  *
@@ -952,7 +957,7 @@ EXPORT_SYMBOL_GPL(evict_inodes);
 static enum lru_status inode_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, void *arg)
 {
-	struct list_head *freeable = arg;
+	struct inodes_to_prune *lists = arg;
 	struct inode	*inode = container_of(item, struct inode, i_lru);
 
 	/*
@@ -969,7 +974,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * sync, or the last page cache deletion will requeue them.
 	 */
 	if (icount_read(inode) ||
-	    (inode_state_read(inode) & ~I_REFERENCED) ||
+	    inode_state_read(inode) & ~(I_REFERENCED | I_DEFER_RECLAIM) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
 		spin_unlock(&inode->i_lock);
@@ -1007,7 +1012,11 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 
 	WARN_ON(inode_state_read(inode) & I_NEW);
 	inode_state_set(inode, I_FREEING);
-	list_lru_isolate_move(lru, &inode->i_lru, freeable);
+	/* Inode will take long time to cleanup. Offload that to worker. */
+	if (inode_state_read(inode) & I_DEFER_RECLAIM)
+		list_lru_isolate_move(lru, &inode->i_lru, &lists->deferred);
+	else
+		list_lru_isolate_move(lru, &inode->i_lru, &lists->freeable);
 	spin_unlock(&inode->i_lock);
 
 	this_cpu_dec(nr_unused);
@@ -1022,15 +1031,83 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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
+		struct inode_deferred_reclaim *reclaim =
+						READ_ONCE(sb->s_inode_reclaim);
+
+		if (WARN_ON_ONCE(!reclaim)) {
+			dispose_list(&lists.deferred);
+			return freed;
+		}
+		spin_lock(&reclaim->lock);
+		if (list_empty(&reclaim->list))
+			queue_work(system_dfl_wq, &reclaim->work);
+		list_splice_tail(&lists.deferred, &reclaim->list);
+		spin_unlock(&reclaim->lock);
+	}
 	return freed;
 }
 
+static void inode_reclaim_deferred(struct work_struct *work)
+{
+	struct inode_deferred_reclaim *reclaim =
+		container_of(work, struct inode_deferred_reclaim, work);
+	struct inode *inode;
+
+	spin_lock(&reclaim->lock);
+	while (!list_empty(&reclaim->list)) {
+		inode = list_first_entry(&reclaim->list, struct inode, i_lru);
+		list_del_init(&inode->i_lru);
+		spin_unlock(&reclaim->lock);
+		evict(inode);
+		cond_resched();
+		spin_lock(&reclaim->lock);
+	}
+	spin_unlock(&reclaim->lock);
+}
+
+static struct inode_deferred_reclaim *inode_deferred_reclaim_alloc(
+							struct super_block *sb)
+{
+	struct inode_deferred_reclaim *reclaim;
+
+	reclaim = kzalloc_obj(*reclaim, GFP_KERNEL | __GFP_NOFAIL);
+	INIT_LIST_HEAD(&reclaim->list);
+	INIT_WORK(&reclaim->work, inode_reclaim_deferred);
+	spin_lock_init(&reclaim->lock);
+	/* Someone installed new struct before us? */
+	if (cmpxchg(&sb->s_inode_reclaim, NULL, reclaim))
+		kfree(reclaim);
+
+	return sb->s_inode_reclaim;
+}
+
+void mark_inode_reclaim_deferred(struct inode *inode)
+{
+	struct inode_deferred_reclaim *reclaim;
+
+	if (inode_state_read_once(inode) & I_DEFER_RECLAIM)
+		return;
+
+	reclaim = READ_ONCE(inode->i_sb->s_inode_reclaim);
+	if (!reclaim)
+		reclaim = inode_deferred_reclaim_alloc(inode->i_sb);
+
+	spin_lock(&inode->i_lock);
+	inode_state_set(inode, I_DEFER_RECLAIM);
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL_GPL(mark_inode_reclaim_deferred);
+
 static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
 
 /*
diff --git a/fs/super.c b/fs/super.c
index 378e81efe643..c35bfb3f7785 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -645,6 +645,11 @@ void generic_shutdown_super(struct super_block *sb)
 		if (sop->put_super)
 			sop->put_super(sb);
 
+		if (sb->s_inode_reclaim) {
+			cancel_work_sync(&sb->s_inode_reclaim->work);
+			kfree(sb->s_inode_reclaim);
+		}
+
 		/*
 		 * Now that all potentially-encrypted inodes have been evicted,
 		 * the fscrypt keyring can be destroyed.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11559c513dfb..2a20cbffc87c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -745,7 +745,8 @@ enum inode_state_flags_enum {
 	I_CREATING		= (1U << 15),
 	I_DONTCACHE		= (1U << 16),
 	I_SYNC_QUEUED		= (1U << 17),
-	I_PINNING_NETFS_WB	= (1U << 18)
+	I_PINNING_NETFS_WB	= (1U << 18),
+	I_DEFER_RECLAIM		= (1U << 19),
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
@@ -2218,6 +2219,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+void mark_inode_reclaim_deferred(struct inode *inode);
+
 static inline int icount_read(const struct inode *inode)
 {
 	return atomic_read(&inode->i_count);
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 383050e7fdf5..00744ae5be18 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -129,6 +129,12 @@ struct super_operations {
 	void (*report_error)(const struct fserror_event *event);
 };
 
+struct inode_deferred_reclaim {
+	struct list_head	list;
+	struct work_struct	work;
+	spinlock_t		lock;
+};
+
 struct super_block {
 	struct list_head			s_list;		/* Keep this first */
 	dev_t					s_dev;		/* search index; _not_ kdev_t */
@@ -254,6 +260,7 @@ struct super_block {
 	 */
 	struct list_lru				s_dentry_lru;
 	struct list_lru				s_inode_lru;
+	struct inode_deferred_reclaim		*s_inode_reclaim;
 	struct rcu_head				rcu;
 	struct work_struct			destroy_work;
 
-- 
2.51.0

