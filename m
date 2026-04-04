Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640F2DB7BF
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289860; cv=none; b=kFP4nuthKoHj0DwxOD97hNSFZNWg9uqUkODOdQf41kyJpvX7REzQsS1QB5xqL3UgiXaHNqg2MsdgsdqdpGdeFJtBg6MyV05XMK76SyelCuGDf2jGEDvvc7ZdtfSj4RVWPcK9cJfvkdL800oFoY6ZpEbFisfBISv7xQXVtY8HTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289860; c=relaxed/simple;
	bh=XlpGoDCbm/Y9UliYoFT9PzvOIEcxYXBR32Wm5i5+wu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTU2+Hk1uiv/PHp9tT7zkzN834uAaLSUplPquRHRnUTZIpGyhmNhDrCND1JlTAtZ3RJm0dwNWS2Ar5+9AXOqp2RkuLclXqDz2AUZhDYyhd4nUyCiu3y14GC/9fTXb9pHqKiB82xZ/2+nFCJR8H+S9S2eoAKS2KhOtCMUcwhdIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SDQ3VqYl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SDQ3VqYl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0zwfpgHcn8ACltj81MuRofq/lj5BksMeVFzyOK6DGLY=; b=SDQ3VqYlsM7u9ePuqeTPRYrahc
	HKVQFSJovi/Vu/6SOMvyO+rfav6Iad4V0ltZxQvxlxWFcbQy89nGHMplk1W6VwU2f/+PGhRmGepJF
	PyVmr+3OrHaP5N5CvI7BrNSaEIzfoN7CPIa3oIRG2/r6rA7jmcdk3k6gECeJVB7yQHY+sSTe0Yosq
	Y0v2LJSC8K+Q+UmfVQbgTa2oyIkaYL6RuTC3DvbBGz34YGdrSdjsWVyA9YyS5hiT59Nx7alr+tjAI
	pwRSGFA8Ie2YuWIOy/EaWn+kX5rgcCMa7BO1fR32+UX5flS2vzrhcRiJpv1dVOCzJx/7QJoZsg9LS
	8M1qFlKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8w2q-0000000AbO9-035p;
	Sat, 04 Apr 2026 08:07:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH v3 2/4] struct dentry: make ->d_u anonymous
Date: Sat,  4 Apr 2026 09:07:49 +0100
Message-ID: <20260404080751.2526990-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Making ->d_rcu and (then) ->d_child overlapping dates back to
2006; anon unions support had been added to gcc only in 4.6
(2011) and the minimal gcc version hadn't been bumped to that
until 4.19 (2018).

These days there's no reason not to keep that union named.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/mds_client.c   |  2 +-
 fs/dcache.c            | 48 +++++++++++++++++++++---------------------
 fs/inode.c             |  2 +-
 fs/nfs/dir.c           |  2 +-
 fs/nfs/getroot.c       |  2 +-
 include/linux/dcache.h |  4 ++--
 6 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f839109fb66f..a5eb99c3c36b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4608,7 +4608,7 @@ static struct dentry* d_find_primary(struct inode *inode)
 		goto out_unlock;
 
 	if (S_ISDIR(inode->i_mode)) {
-		alias = hlist_entry(inode->i_dentry.first, struct dentry, d_u.d_alias);
+		alias = hlist_entry(inode->i_dentry.first, struct dentry, d_alias);
 		if (!IS_ROOT(alias))
 			dn = dget(alias);
 		goto out_unlock;
diff --git a/fs/dcache.c b/fs/dcache.c
index e069b6ec4ec0..4378eb8a00bb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -40,7 +40,7 @@
 /*
  * Usage:
  * dcache->d_inode->i_lock protects:
- *   - i_dentry, d_u.d_alias, d_inode of aliases
+ *   - i_dentry, d_alias, d_inode of aliases
  * dcache_hash_bucket lock protects:
  *   - the dcache hash table
  * s_roots bl list spinlock protects:
@@ -55,7 +55,7 @@
  *   - d_unhashed()
  *   - d_parent and d_chilren
  *   - childrens' d_sib and d_parent
- *   - d_u.d_alias, d_inode
+ *   - d_alias, d_inode
  *
  * Ordering:
  * dentry->d_inode->i_lock
@@ -341,14 +341,14 @@ static inline struct external_name *external_name(struct dentry *dentry)
 
 static void __d_free(struct rcu_head *head)
 {
-	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
+	struct dentry *dentry = container_of(head, struct dentry, d_rcu);
 
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
 static void __d_free_external(struct rcu_head *head)
 {
-	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
+	struct dentry *dentry = container_of(head, struct dentry, d_rcu);
 	kfree(external_name(dentry));
 	kmem_cache_free(dentry_cache, dentry);
 }
@@ -428,19 +428,19 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 
 static void dentry_free(struct dentry *dentry)
 {
-	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
+	WARN_ON(!hlist_unhashed(&dentry->d_alias));
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
 		if (likely(atomic_dec_and_test(&p->count))) {
-			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
+			call_rcu(&dentry->d_rcu, __d_free_external);
 			return;
 		}
 	}
 	/* if dentry was never visible to RCU, immediate free is OK */
 	if (dentry->d_flags & DCACHE_NORCU)
-		__d_free(&dentry->d_u.d_rcu);
+		__d_free(&dentry->d_rcu);
 	else
-		call_rcu(&dentry->d_u.d_rcu, __d_free);
+		call_rcu(&dentry->d_rcu, __d_free);
 }
 
 /*
@@ -455,7 +455,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
 
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
-	hlist_del_init(&dentry->d_u.d_alias);
+	hlist_del_init(&dentry->d_alias);
 	raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
@@ -1010,7 +1010,7 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 
 	if (hlist_empty(&inode->i_dentry))
 		return NULL;
-	alias = hlist_entry(inode->i_dentry.first, struct dentry, d_u.d_alias);
+	alias = hlist_entry(inode->i_dentry.first, struct dentry, d_alias);
 	lockref_get(&alias->d_lockref);
 	return alias;
 }
@@ -1093,9 +1093,9 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	// used without having I_FREEING set, which means no aliases left
 	if (likely(!(inode_state_read(inode) & I_FREEING) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
-			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
+			de = hlist_entry(l->first, struct dentry, d_alias);
 		} else {
-			hlist_for_each_entry(de, l, d_u.d_alias)
+			hlist_for_each_entry(de, l, d_alias)
 				if (!d_unhashed(de))
 					break;
 		}
@@ -1787,7 +1787,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	INIT_HLIST_BL_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_HLIST_HEAD(&dentry->d_children);
-	INIT_HLIST_NODE(&dentry->d_u.d_alias);
+	INIT_HLIST_NODE(&dentry->d_alias);
 	INIT_HLIST_NODE(&dentry->d_sib);
 
 	if (dentry->d_op && dentry->d_op->d_init) {
@@ -1980,7 +1980,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	if ((dentry->d_flags &
 	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_dec(nr_dentry_negative);
-	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
+	hlist_add_head(&dentry->d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
 	raw_write_seqcount_end(&dentry->d_seq);
@@ -2004,7 +2004,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
-	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
+	BUG_ON(!hlist_unhashed(&entry->d_alias));
 	if (inode) {
 		security_d_instantiate(entry, inode);
 		spin_lock(&inode->i_lock);
@@ -2024,7 +2024,7 @@ EXPORT_SYMBOL(d_instantiate);
  */
 void d_instantiate_new(struct dentry *entry, struct inode *inode)
 {
-	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
+	BUG_ON(!hlist_unhashed(&entry->d_alias));
 	BUG_ON(!inode);
 	lockdep_annotate_inode_mutex_key(inode);
 	security_d_instantiate(entry, inode);
@@ -2087,7 +2087,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 
 		spin_lock(&new->d_lock);
 		__d_set_inode_and_type(new, inode, add_flags);
-		hlist_add_head(&new->d_u.d_alias, &inode->i_dentry);
+		hlist_add_head(&new->d_alias, &inode->i_dentry);
 		if (!disconnected) {
 			hlist_bl_lock(&sb->s_roots);
 			hlist_bl_add_head(&new->d_hash, &sb->s_roots);
@@ -2658,7 +2658,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	 * we unlock the chain.  All fields are stable in everything
 	 * we encounter.
 	 */
-	hlist_bl_for_each_entry(dentry, node, b, d_u.d_in_lookup_hash) {
+	hlist_bl_for_each_entry(dentry, node, b, d_in_lookup_hash) {
 		if (dentry->d_name.hash != hash)
 			continue;
 		if (dentry->d_parent != parent)
@@ -2700,7 +2700,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	}
 	rcu_read_unlock();
 	new->d_wait = wq;
-	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
+	hlist_bl_add_head(&new->d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
 mismatch:
@@ -2725,11 +2725,11 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 	b = in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
-	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
+	__hlist_bl_del(&dentry->d_in_lookup_hash);
 	d_wait = dentry->d_wait;
 	dentry->d_wait = NULL;
 	hlist_bl_unlock(b);
-	INIT_HLIST_NODE(&dentry->d_u.d_alias);
+	INIT_HLIST_NODE(&dentry->d_alias);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	return d_wait;
 }
@@ -2760,7 +2760,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		d_set_d_op(dentry, ops);
 	if (inode) {
 		unsigned add_flags = d_flags_for_inode(inode);
-		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
+		hlist_add_head(&dentry->d_alias, &inode->i_dentry);
 		raw_write_seqcount_begin(&dentry->d_seq);
 		__d_set_inode_and_type(dentry, inode, add_flags);
 		raw_write_seqcount_end(&dentry->d_seq);
@@ -2795,7 +2795,7 @@ EXPORT_SYMBOL(d_add);
 
 struct dentry *d_make_persistent(struct dentry *dentry, struct inode *inode)
 {
-	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
+	WARN_ON(!hlist_unhashed(&dentry->d_alias));
 	WARN_ON(!inode);
 	security_d_instantiate(dentry, inode);
 	spin_lock(&inode->i_lock);
@@ -3185,7 +3185,7 @@ void d_mark_tmpfile(struct file *file, struct inode *inode)
 	struct dentry *dentry = file->f_path.dentry;
 
 	BUG_ON(dname_external(dentry) ||
-		!hlist_unhashed(&dentry->d_u.d_alias) ||
+		!hlist_unhashed(&dentry->d_alias) ||
 		!d_unlinked(dentry));
 	spin_lock(&dentry->d_parent->d_lock);
 	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
diff --git a/fs/inode.c b/fs/inode.c
index cc12b68e021b..9e1ab333d382 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -754,7 +754,7 @@ void dump_mapping(const struct address_space *mapping)
 		return;
 	}
 
-	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
+	dentry_ptr = container_of(dentry_first, struct dentry, d_alias);
 	if (get_kernel_nofault(dentry, dentry_ptr) ||
 	    !dentry.d_parent || !dentry.d_name.name) {
 		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5a0bd8113e3a..f2f1b036f2f1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1490,7 +1490,7 @@ static void nfs_clear_verifier_directory(struct inode *dir)
 	if (hlist_empty(&dir->i_dentry))
 		return;
 	this_parent =
-		hlist_entry(dir->i_dentry.first, struct dentry, d_u.d_alias);
+		hlist_entry(dir->i_dentry.first, struct dentry, d_alias);
 
 	spin_lock(&this_parent->d_lock);
 	nfs_unset_verifier_delegated(&this_parent->d_time);
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index f13d25d95b85..eef0736beb67 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -54,7 +54,7 @@ static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *i
 		 */
 		spin_lock(&d_inode(sb->s_root)->i_lock);
 		spin_lock(&sb->s_root->d_lock);
-		hlist_del_init(&sb->s_root->d_u.d_alias);
+		hlist_del_init(&sb->s_root->d_alias);
 		spin_unlock(&sb->s_root->d_lock);
 		spin_unlock(&d_inode(sb->s_root)->i_lock);
 	}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 7f1dbc7121d7..f939d2ed10a3 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -128,7 +128,7 @@ struct dentry {
 		struct hlist_node d_alias;	/* inode alias list */
 		struct hlist_bl_node d_in_lookup_hash;	/* only for in-lookup ones */
 	 	struct rcu_head d_rcu;
-	} d_u;
+	};
 };
 
 /*
@@ -617,6 +617,6 @@ void d_make_discardable(struct dentry *dentry);
 
 /* inode->i_lock must be held over that */
 #define for_each_alias(dentry, inode) \
-	hlist_for_each_entry(dentry, &(inode)->i_dentry, d_u.d_alias)
+	hlist_for_each_entry(dentry, &(inode)->i_dentry, d_alias)
 
 #endif	/* __LINUX_DCACHE_H */
-- 
2.47.3

