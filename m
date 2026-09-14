Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C51F3B777C;
	Mon, 14 Sep 2026 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366555; cv=none; b=ddwZVD7wq2gWrTWPeSjrPZa3RtwrKxbgBX61UUQ/4DLPoIL7Zy/Pf5VagQkySYrPO4ZieRGTyzdnB09Ow0pdm3IwpKprxFIqdnahQW41XT3IG417Zf8uWr/0WYo/av+lywmlTQm1QX2vyQcajJc2CW3OVaQj4dfo2V8OlYbSaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366555; c=relaxed/simple;
	bh=C63JGwt3r2MzGq97jEKhLYlX+zaKnfqtHMCYCSMOg64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1WHxBCkhG2q1R8twv2v100Pxj12ZuW4CPzAeY7IwqWLqVSw5uaxbakY1KbhLlYj2AFqMB7XTL6Ly4ElkxGVlX+L5bdtm1ZEWd1dnNG3lthc7tsCqqumyFc1QUeTIb4fS5jUK4458ovynOAHd8hQVEO/4oAatKYiKuMbgMj069M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hjvyv6rgLz2CZLy;
	Mon, 14 Sep 2026 14:15:35 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hjvyv6W5Tz2CZLy;
	Mon, 14 Sep 2026 14:15:35 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id E9145310BECC;
	Mon, 14 Sep 2026 14:11:21 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 14 Sep 2026 14:15:34 +0800
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
Subject: [RFC PATCH 3/3] fs/proc: split the inode list
Date: Mon, 14 Sep 2026 14:14:49 +0800
Message-ID: <20260914061449.4024632-4-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914061449.4024632-1-huangsj@hygon.cn>
References: <20260914061449.4024632-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

The global s_inode_list_lock is heavily contended in procfs
on a 384-CPU, 12-NUMA-node Hygon machine running Hadoop TestDFSIO:
  #hadoop jar xxxx.jar TestDFSIO -read -nrFiles 1000 -size 100MB

The hadoop will create lot of threads during the test.
The perf shows it consuming ~90% of the lock hotspot in procfs.
The lock is hit from both directions:
   -- inode creation (~49%) :
           getdents64 ->
              proc_readfd_common ->
	         new_inode ->
		   inode_sb_list_add()

   -- inode eviction (~41%):
           process exit ->
	      release_task ->
	         proc_invalidate_siblings_dcache ->
		     evict ->
		        inode_sb_list_del()

This patch spreads the inode list across per-shard locks for procfs:
   --- Add "shards" pointer shares a union with s_inodes.
       Guard all shard accesses with an explicit s_inode_list_sharded
       field in super_block.

   --- Add inode_list_add()/inode_list_del() callbacks to super_operations;
       procfs implements them to round-robin inodes
       onto nr_shards = DIV_ROUND_UP(num_possible_cpus(), 32)
       shards allocated at mount time, each protected by its own spinlock.

   --- evict_inodes(), generic_shutdown_super()
       iterate the shards when the super_block inode list is sharded.
       struct inode_shard is cacheline-aligned to avoid false
       sharing between shard locks on different NUMA nodes.

This reduces the s_inode_list_lock hotspot from ~90% to ~1% in above
TestDFSIO. And we can improve the hadoop exec performance over 50%.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/inode.c                     | 80 ++++++++++++++++++++++------------
 fs/proc/inode.c                | 53 ++++++++++++++++++++++
 fs/proc/internal.h             |  2 +
 fs/proc/root.c                 |  6 +++
 fs/super.c                     | 40 +++++++++++++----
 include/linux/fs/super_types.h | 22 +++++++++-
 include/linux/proc_fs.h        |  1 +
 7 files changed, 167 insertions(+), 37 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ba7da39be4a3..687c2e299258 100644
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
@@ -879,41 +887,57 @@ void evict_inodes(struct super_block *sb)
 {
 	struct inode *inode;
 	LIST_HEAD(dispose);
+	struct list_head *head;
+	spinlock_t *lock;
+	unsigned int nr, i;
+	const bool sharded = sb->s_inode_list_sharded;
 
-again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read_once(inode))
-			continue;
+	nr = sharded ? sb->nr_shards : 1;
 
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
+again:
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
index b7634f975d98..d412018b73d9 100644
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
+	unsigned int nr_shards;
+	int i;
+
+	nr_shards = DIV_ROUND_UP(num_possible_cpus(), PROC_LIST_ALIGN);
+	shards = kcalloc(nr_shards, sizeof(*shards), GFP_KERNEL);
+	if (!shards)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_shards; i++) {
+		INIT_LIST_HEAD(&shards[i].list);
+		spin_lock_init(&shards[i].lock);
+	}
+
+	sb->shards = shards;
+	sb->nr_shards = nr_shards;
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
index 99adddfeb4a4..4bd916b88cdf 100644
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
index 4b1314545522..38a452e78ca2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -726,7 +726,16 @@ EXPORT_SYMBOL(retire_super);
 
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
@@ -788,14 +797,29 @@ void generic_shutdown_super(struct super_block *sb)
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
index ecd96aeb1cee..6d6aae2d1fbc 100644
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
+ * Sharded inode list used by procfs to spread s_inode_list_lock contention
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
@@ -269,9 +281,17 @@ struct super_block {
 	 */
 	int s_stack_depth;
 
+	bool					s_inode_list_sharded;
+
 	/* s_inode_list_lock protects s_inodes */
 	spinlock_t				s_inode_list_lock ____cacheline_aligned_in_smp;
-	struct list_head			s_inodes;	/* all inodes */
+	union {
+		struct list_head			s_inodes;	/* all inodes */
+		struct {
+			struct inode_shard		*shards;	/* used by procfs */
+			unsigned int			nr_shards;
+		};
+	};
 
 	spinlock_t				s_inode_wblist_lock;
 	struct list_head			s_inodes_wb;	/* writeback inodes */
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
 
-- 
2.53.0


