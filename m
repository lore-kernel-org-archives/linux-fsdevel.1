Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3F2ED16D;
	Sun, 20 Sep 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889550; cv=none; b=NuUBRVyv2Wv+BDZvsNAGuYBMabjV/sYsPnyh3JglUtQboUCmhmwmhC5SD7h9yRvunbf/mq/f/sF8+rPB3T42cuiagO3t5xuhG0NHEIiGeEtq7mN6NtXofvPgbSaCcogNG0ehKGUfXl67hNr0p11GIspEWjGlYP8Xwj1socEtjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889550; c=relaxed/simple;
	bh=Kkiek51qVj9DW5/fqAOQNt+g1cLwVAN6yPf5s5V4MCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmeqEtevODYoIGr9s5uf+QdVPyDn1IlYTd5snqOo4ryZXNXpuSUnaxsUxpd6ou7O7oti5fjKFGTn0HbWkB6sv1y74Q/LuswOsl/vwJXpCuRJmd46jzLQx4+Oxs3MZsjyxLDpPKBygAvPSFYy8TbPOmtynJ2J+MmY9m2vVQ2sm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNV1L6QzTSdp;
	Sun, 20 Sep 2026 15:32:10 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNR2HQDzTSdm;
	Sun, 20 Sep 2026 15:32:07 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 102D7156D;
	Sun, 20 Sep 2026 15:32:06 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 20 Sep 2026 15:32:04 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <dev.jain@arm.com>, <ljs@kernel.org>, <adobriyan@gmail.com>,
	<akpm@linux-foundation.org>, <hpa@zytor.com>, <ryan.roberts@arm.com>,
	<mjguzik@gmail.com>, <joel.granados@kernel.org>, <jannh@google.com>,
	<oleg@redhat.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<kees@kernel.org>, <joannelkoong@gmail.com>, <tj@kernel.org>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <sandeen@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [RFC PATCH v2 3/3] fs/proc: split the inode list
Date: Sun, 20 Sep 2026 15:28:11 +0800
Message-ID: <20260920072811.2064247-4-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920072811.2064247-1-huangsj@hygon.cn>
References: <20260920072811.2064247-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

The global s_inode_list_lock is heavily contended in procfs
on a 384-CPU, 12-NUMA-node Hygon machine running Hadoop TestDFSIO:
  #hadoop jar xxxx.jar TestDFSIO -read -nrFiles 1000 -size 100MB

The perf shows it consuming ~90% of the lock hotspot.
The lock is hit from both directions:
   -- inode creation (~49%) :
           getdents64 ->
              proc_readfd_common ->
	         new_inode ->
		   inode_sb_list_add()

   -- inode eviction (~41%)
           process exit ->
	      release_task ->
	         proc_invalidate_siblings_dcache ->
		     evict ->
		        inode_sb_list_del()

This patch spreads the inode list across per-shard locks for procfs:
   --- Add three fields in super_block:
        shards   : the pointer for the array of inode_shard.
        nr_shards: the size of the array
	s_inode_list_sharded: whether or not to use a sharded inode list

        struct inode_shard is cacheline-aligned to avoid false
        sharing between shard locks on different NUMA nodes.

   --- Add inode_list_add()/inode_list_del() callbacks to super_operations;
       procfs implements them to round-robin inodes
       onto nr_shards = DIV_ROUND_UP(num_possible_cpus(), 32)
       shards allocated at mount time, each protected by its own spinlock.

   --- For procfs, the "unmount" will call evict_inodes(),
       generic_shutdown_super() and hook_sb_delete() which will
       iterate the shards when the super_block inode list is sharded.
       Change these functions to work with the sharded inode list.

This reduces the s_inode_list_lock hotspot from ~90% to ~1% in TestDFSIO.
And we can improve the hadoop performance over 50%.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/inode.c                     |  79 ++++++++++------
 fs/proc/inode.c                |  53 +++++++++++
 fs/proc/internal.h             |   2 +
 fs/proc/root.c                 |   6 ++
 fs/super.c                     |  40 ++++++--
 include/linux/fs/super_types.h |  16 ++++
 include/linux/proc_fs.h        |   1 +
 security/landlock/fs.c         | 162 ++++++++++++++++++---------------
 8 files changed, 250 insertions(+), 109 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ba7da39be4a3..80acb9113487 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -635,6 +635,10 @@ void inode_sb_list_add(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	if (sb->s_inode_list_sharded && sb->s_op->inode_list_add) {
+		sb->s_op->inode_list_add(sb, inode);
+		return;
+	}
 	spin_lock(&sb->s_inode_list_lock);
 	list_add(&inode->i_sb_list, &sb->s_inodes);
 	spin_unlock(&sb->s_inode_list_lock);
@@ -646,6 +650,10 @@ static inline void inode_sb_list_del(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 
 	if (!list_empty(&inode->i_sb_list)) {
+		if (sb->s_inode_list_sharded && sb->s_op->inode_list_del) {
+			sb->s_op->inode_list_del(sb, inode);
+			return;
+		}
 		spin_lock(&sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
@@ -879,41 +887,56 @@ void evict_inodes(struct super_block *sb)
 {
 	struct inode *inode;
 	LIST_HEAD(dispose);
+	struct list_head *head;
+	spinlock_t *lock;
+	unsigned int nr, i;
+	const bool sharded = sb->s_inode_list_sharded;
 
+	nr = sharded ? sb->nr_shards : 1;
 again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read_once(inode))
-			continue;
-
-		spin_lock(&inode->i_lock);
-		if (icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			spin_unlock(&inode->i_lock);
-			continue;
+	for (i = 0; i < nr; i++) {
+		if (sharded) {
+			head = &sb->shards[i].list;
+			lock = &sb->shards[i].lock;
+		} else {
+			head = &sb->s_inodes;
+			lock = &sb->s_inode_list_lock;
 		}
 
-		inode_state_set(inode, I_FREEING);
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-		list_add(&inode->i_lru, &dispose);
+		spin_lock(lock);
+		list_for_each_entry(inode, head, i_sb_list) {
+			if (icount_read_once(inode))
+				continue;
 
-		/*
-		 * We can have a ton of inodes to evict at unmount time given
-		 * enough memory, check to see if we need to go to sleep for a
-		 * bit so we don't livelock.
-		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			goto again;
+			spin_lock(&inode->i_lock);
+			if (icount_read(inode)) {
+				spin_unlock(&inode->i_lock);
+				continue;
+			}
+			if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
+				spin_unlock(&inode->i_lock);
+				continue;
+			}
+
+			inode_state_set(inode, I_FREEING);
+			inode_lru_list_del(inode);
+			spin_unlock(&inode->i_lock);
+			list_add(&inode->i_lru, &dispose);
+
+			/*
+			 * We can have a ton of inodes to evict at unmount time given
+			 * enough memory, check to see if we need to go to sleep for a
+			 * bit so we don't livelock.
+			 */
+			if (need_resched()) {
+				spin_unlock(lock);
+				cond_resched();
+				dispose_list(&dispose);
+				goto again;
+			}
 		}
+		spin_unlock(lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
 }
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b7634f975d98..aeaf2e94e7ba 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -65,6 +65,7 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 	ei->sysctl_entry = NULL;
 	INIT_HLIST_NODE(&ei->sibling_inodes);
 	ei->ns_ops = NULL;
+	ei->shard_idx = 0;
 	return &ei->vfs_inode;
 }
 
@@ -80,6 +81,56 @@ static void proc_free_inode(struct inode *inode)
 	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
 }
 
+static void proc_inode_list_add(struct super_block *sb, struct inode *inode)
+{
+	struct proc_fs_info *fs_info = proc_sb_info(sb);
+	struct proc_inode *ei = PROC_I(inode);
+	struct inode_shard *shard;
+	unsigned int idx, seq;
+
+	seq = atomic_fetch_inc(&fs_info->shard_seq);
+	idx = seq % sb->nr_shards;
+	ei->shard_idx = idx;
+	shard = &sb->shards[idx];
+
+	spin_lock(&shard->lock);
+	list_add(&inode->i_sb_list, &shard->list);
+	spin_unlock(&shard->lock);
+}
+
+static void proc_inode_list_del(struct super_block *sb, struct inode *inode)
+{
+	struct proc_inode *ei = PROC_I(inode);
+	struct inode_shard *shard = &sb->shards[ei->shard_idx];
+
+	spin_lock(&shard->lock);
+	list_del_init(&inode->i_sb_list);
+	spin_unlock(&shard->lock);
+}
+
+#define PROC_LIST_ALIGN	32
+int proc_init_inode_shards(struct super_block *sb)
+{
+	struct inode_shard *shards;
+	unsigned int nr;
+	int i;
+
+	nr = DIV_ROUND_UP(num_possible_cpus(), PROC_LIST_ALIGN);
+	shards = kcalloc(nr, sizeof(*shards), GFP_KERNEL);
+	if (!shards)
+		return -ENOMEM;
+
+	for (i = 0; i < nr; i++) {
+		INIT_LIST_HEAD(&shards[i].list);
+		spin_lock_init(&shards[i].lock);
+	}
+
+	sb->shards = shards;
+	sb->nr_shards = nr;
+	sb->s_inode_list_sharded = true;
+	return 0;
+}
+
 static void init_once(void *foo)
 {
 	struct proc_inode *ei = (struct proc_inode *) foo;
@@ -191,6 +242,8 @@ const struct super_operations proc_sops = {
 	.evict_inode	= proc_evict_inode,
 	.statfs		= simple_statfs,
 	.show_options	= proc_show_options,
+	.inode_list_add	= proc_inode_list_add,
+	.inode_list_del	= proc_inode_list_del,
 };
 
 enum {BIAS = -1U<<31};
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 04bd6c9e65a7..edbe357263c2 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -127,6 +127,7 @@ struct proc_inode {
 	struct hlist_node sibling_inodes;
 	const struct proc_ns_operations *ns_ops;
 	struct inode vfs_inode;
+	unsigned int shard_idx;
 } __randomize_layout;
 
 /*
@@ -317,6 +318,7 @@ void proc_init_kmemcache(void);
 void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock);
 void set_proc_pid_nlink(void);
 extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry *);
+extern int proc_init_inode_shards(struct super_block *);
 extern void proc_entry_rundown(struct proc_dir_entry *);
 
 /*
diff --git a/fs/proc/root.c b/fs/proc/root.c
index d45f5af5ab53..fb5d68da85f4 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -275,6 +275,10 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_gran = 1;
 	s->s_fs_info = fs_info;
 
+	ret = proc_init_inode_shards(s);
+	if (ret)
+		return ret;
+
 	if (fs_info->pidonly == PROC_PIDONLY_ON)
 		s->s_iflags |= SB_I_RESTRICTED_VARIANT;
 
@@ -359,6 +363,8 @@ static void proc_kill_sb(struct super_block *sb)
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
 	kill_anon_super(sb);
+	if (sb->s_inode_list_sharded)
+		kfree(sb->shards);
 	if (fs_info) {
 		put_pid_ns(fs_info->pid_ns);
 		put_cred(fs_info->mounter_cred);
diff --git a/fs/super.c b/fs/super.c
index e25ded0bc9a2..e44db4505238 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -712,7 +712,16 @@ EXPORT_SYMBOL(retire_super);
 
 static bool sb_inodes_empty(struct super_block *sb)
 {
-	return list_empty(&sb->s_inodes);
+	unsigned int i;
+
+	if (!sb->s_inode_list_sharded)
+		return list_empty(&sb->s_inodes);
+
+	for (i = 0; i < sb->nr_shards; i++)
+		if (!list_empty(&sb->shards[i].list))
+			return false;
+
+	return true;
 }
 
 /**
@@ -774,14 +783,29 @@ void generic_shutdown_super(struct super_block *sb)
 			 * iput_final() or such crashes cleanly.
 			 */
 			struct inode *inode;
-
-			spin_lock(&sb->s_inode_list_lock);
-			list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-				inode->i_op = VFS_PTR_POISON;
-				inode->i_sb = VFS_PTR_POISON;
-				inode->i_mapping = VFS_PTR_POISON;
+			struct list_head *head;
+			spinlock_t *lock;
+			unsigned int nr, i;
+			const bool sharded = sb->s_inode_list_sharded;
+
+			nr = sharded ? sb->nr_shards : 1;
+			for (i = 0; i < nr; i++) {
+				if (sharded) {
+					head = &sb->shards[i].list;
+					lock = &sb->shards[i].lock;
+				} else {
+					head = &sb->s_inodes;
+					lock = &sb->s_inode_list_lock;
+				}
+
+				spin_lock(lock);
+				list_for_each_entry(inode, head, i_sb_list) {
+					inode->i_op = VFS_PTR_POISON;
+					inode->i_sb = VFS_PTR_POISON;
+					inode->i_mapping = VFS_PTR_POISON;
+				}
+				spin_unlock(lock);
 			}
-			spin_unlock(&sb->s_inode_list_lock);
 		}
 	}
 	/*
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 1a596caf58a8..f06f293b46be 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -130,8 +130,20 @@ struct super_operations {
 
 	/* Report a filesystem error */
 	void (*report_error)(const struct fserror_event *event);
+
+	void (*inode_list_add)(struct super_block *sb, struct inode *inode);
+	void (*inode_list_del)(struct super_block *sb, struct inode *inode);
 };
 
+/*
+ * Sharded inode list which is used to spread s_inode_list_lock contention
+ * across per-shard locks.
+ */
+struct inode_shard {
+	struct list_head	list;
+	spinlock_t		lock;
+} ____cacheline_aligned_in_smp;
+
 struct super_block {
 	struct list_head			s_list;		/* Keep this first */
 	dev_t					s_dev;		/* search index; _not_ kdev_t */
@@ -269,6 +281,10 @@ struct super_block {
 	 */
 	int s_stack_depth;
 
+	bool					s_inode_list_sharded;
+	struct inode_shard			*shards;
+	unsigned int				nr_shards;
+
 	/* s_inode_list_lock protects s_inodes */
 	spinlock_t				s_inode_list_lock ____cacheline_aligned_in_smp;
 	struct list_head			s_inodes;	/* all inodes */
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 47d7deaeed8f..37eed34f3a93 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -70,6 +70,7 @@ struct proc_fs_info {
 	const struct cred *mounter_cred;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
+	atomic_t shard_seq;
 	struct rcu_head rcu;
 };
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 330a1871bf94..8360a6a8a3ad 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1383,98 +1383,114 @@ static void hook_inode_free_security_rcu(void *inode_security)
 static void hook_sb_delete(struct super_block *const sb)
 {
 	struct inode *inode, *prev_inode = NULL;
+	unsigned int nr, i;
 
 	if (!landlock_initialized)
 		return;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	nr = sb->s_inode_list_sharded ? sb->nr_shards : 1;
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
+	for (i = 0; i < nr; i++) {
+		struct list_head *head;
+		spinlock_t *lock;
 
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
-		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
+		if (sb->s_inode_list_sharded) {
+			head = &sb->shards[i].list;
+			lock = &sb->shards[i].lock;
+		} else {
+			head = &sb->s_inodes;
+			lock = &sb->s_inode_list_lock;
 		}
 
-		rcu_read_lock();
-		object = rcu_dereference(landlock_inode(inode)->object);
-		if (!object) {
-			rcu_read_unlock();
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
+		spin_lock(lock);
+		list_for_each_entry(inode, head, i_sb_list) {
+			struct landlock_object *object;
 
-		/*
-		 * If there is no concurrent release_inode() ongoing, then we
-		 * are in charge of calling iput() on this inode, otherwise we
-		 * will just wait for it to finish.
-		 */
-		spin_lock(&object->lock);
-		if (object->underobj == inode) {
-			object->underobj = NULL;
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
+			/* Only handles referenced inodes. */
+			if (!icount_read_once(inode))
+				continue;
 
 			/*
-			 * Because object->underobj was not NULL,
-			 * release_inode() and get_inode_object() guarantee
-			 * that it is safe to reset
-			 * landlock_inode(inode)->object while it is not NULL.
-			 * It is therefore not necessary to lock inode->i_lock.
+			 * Protects against concurrent modification of inode (e.g.
+			 * from get_inode_object()).
 			 */
-			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
+			spin_lock(&inode->i_lock);
 			/*
-			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore there are at least two references
-			 * on the inode.
+			 * Checks I_FREEING and I_WILL_FREE  to protect against a race
+			 * condition when release_inode() just called iput(), which
+			 * could lead to a NULL dereference of inode->security or a
+			 * second call to iput() for the same Landlock object.  Also
+			 * checks I_NEW because such inode cannot be tied to an object.
 			 */
-			iput_not_last(inode);
-		} else {
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
-		}
+			if (inode_state_read(inode) &
+			    (I_FREEING | I_WILL_FREE | I_NEW)) {
+				spin_unlock(&inode->i_lock);
+				continue;
+			}
+
+			rcu_read_lock();
+			object = rcu_dereference(landlock_inode(inode)->object);
+			if (!object) {
+				rcu_read_unlock();
+				spin_unlock(&inode->i_lock);
+				continue;
+			}
+			/* Keeps a reference to this inode until the next loop walk. */
+			__iget(inode);
+			spin_unlock(&inode->i_lock);
 
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
 			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
+			 * If there is no concurrent release_inode() ongoing, then we
+			 * are in charge of calling iput() on this inode, otherwise we
+			 * will just wait for it to finish.
 			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
+			spin_lock(&object->lock);
+			if (object->underobj == inode) {
+				object->underobj = NULL;
+				spin_unlock(&object->lock);
+				rcu_read_unlock();
+
+				/*
+				 * Because object->underobj was not NULL,
+				 * release_inode() and get_inode_object() guarantee
+				 * that it is safe to reset
+				 * landlock_inode(inode)->object while it is not NULL.
+				 * It is therefore not necessary to lock inode->i_lock.
+				 */
+				rcu_assign_pointer(landlock_inode(inode)->object, NULL);
+				/*
+				 * At this point, we own the ihold() reference that was
+				 * originally set up by get_inode_object() and the
+				 * __iget() reference that we just set in this loop
+				 * walk.  Therefore there are at least two references
+				 * on the inode.
+				 */
+				iput_not_last(inode);
+			} else {
+				spin_unlock(&object->lock);
+				rcu_read_unlock();
+			}
+
+			if (prev_inode) {
+				/*
+				 * At this point, we still own the __iget() reference
+				 * that we just set in this loop walk.  Therefore we
+				 * can drop the list lock and know that the inode won't
+				 * disappear from under us until the next loop walk.
+				 */
+				spin_unlock(lock);
+				/*
+				 * We can now actually put the inode reference from the
+				 * previous loop walk, which is not needed anymore.
+				 */
+				iput(prev_inode);
+				cond_resched();
+				spin_lock(lock);
+			}
+			prev_inode = inode;
 		}
-		prev_inode = inode;
+		spin_unlock(lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	/* Puts the inode reference from the last loop walk, if any. */
 	if (prev_inode)
-- 
2.53.0


