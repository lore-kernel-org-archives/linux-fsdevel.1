Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E54E50AA
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169041; cv=none; b=FVQE9HQD7noK+hqDCHPOHgYxTLZdb6BosUF/IuXk40ZPxdZgY7nmLBBA3o6XTITkkIf9/3aW+/Bb0QXt7iTJF0ykEgN4dUpaoj/QBYO8MGB5jd9yEuz1f0Gclnc++7uCqX2DeTjBSNaET/+/BtmNaDQVuZFuc56Bta0ADwMX6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169041; c=relaxed/simple;
	bh=ibFpth8wAFXUrM8GxlJIYQOA9JU+8ZJEHvofbY7B4qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOz/t5WUYKfs6if/top4Ru/R2ffK66o2oS2YDxG4AtMMr5sc+3gy7MHoGFRL/2DiJCXXHxQDnDfSzu938NSgcHNiZycJTQI/O3ogUO0B1q0APFNs5Eplj/oHKveGmwOOpw2R2pPPkjfdDDFhA8rp1ig3WvZgnD1KzIab41DyZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wA1KoVTh; arc=none smtp.client-ip=91.218.175.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wA1KoVTh"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ibFpth8wAFXUrM8GxlJIYQOA9JU+8ZJEHvofbY7B4qw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792169035; v=1; x=1792773835;
 b=wA1KoVThwZwANpLSglG1xln8yZqaaCmlio7fvwINb1cyEBkpfqvlYKZFtTmq4JskLt2RqgD7
 bCxE2xecDMf+cYU+iQ37mQuP+6lIBgREmkETCZMdz5T8+0qKU9DLAFGE1UX+om0Y0aY3VgBJIOf
 xDqss8UTm15BaVmkjvZHaonQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f4f175d3aae833e2;
	Fri, 16 Oct 2026 16:43:54 +0000
X-Mizu-Trace-ID: f4f175d3aae833e2
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <christian@brauner.io>
Cc: Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernfs: allocate inodes and dentry outside kernfs_rwsem
Date: Fri, 16 Oct 2026 09:43:45 -0700
Message-ID: <20261016164345.31618-1-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Meta fleet, on 6.16 with the kernfs changes queued for 7.4
backported, we still see long cgroupfs stalls:

- oomd and below waited 72 seconds in kernfs_fop_readdir() while an out
  of memory container created cgroups.  They resumed when the kernel OOM
  killer killed the container's workload.

- oomd waited 15 minutes in kernfs_iop_lookup().  PID 1 waited for
  kernfs_rwsem in cgroup_rmdir() while holding cgroup_mutex.

- A lock profiler sampling part of the fleet saw kernfs_iop_lookup()
  hold kernfs_rwsem across memcg reclaim on 26 hosts in 29 days, for up
  to 625 ms.

The profiler shows where these stalls come from.  kernfs_iop_lookup()
and the export ops allocate a new inode while holding kernfs_rwsem for
read.  The inode is charged to the caller's memcg.  If that memcg is at
memory.max, the allocation can stay in reclaim for a long time,
sometimes until an OOM kill.  A writer then queues on the lock and every
new reader queues behind it.  On cgroup2 this blocks every cgroupfs user
on the machine.

Such lookups are common in a memcg that is out of memory.  Its reclaim
drops its kernfs dentries fast, and the files of a new cgroup have no
inodes yet.

Allocate the inode with the lock dropped.  kernfs_iget() first looks for
an existing inode.  If there is none, it pins the node, drops the lock,
allocates, takes the lock again, and adds the inode only if the node is
still active.  So __kernfs_remove() still finds every inode it must
clear i_nlink on, as commit dc1a0cc95737 ("kernfs: don't lose
IN_DELETE_SELF when decoding a file handle") needs.

kernfs_get_parent_dentry() also held the lock across d_obtain_alias(),
which allocates a dentry.  Hold it only around kernfs_iget(), as
__kernfs_fh_to_dentry() already does.

Tested on a 176-CPU machine.  A task in a full 256 MB memcg with slow
swap looks up the files of new cgroups.  Worst waits in 60 seconds:

                                  before    after
  oomd, for kernfs_rwsem          577 ms   0.7 ms
  below, for kernfs_rwsem         412 ms   1.0 ms
  systemd, for kernfs_rwsem       449 ms    17 us
  readdir of another directory   1154 ms   3.2 ms

The lookup itself is still slow.  The VFS still holds its directory's
lock, so other work in that one directory still waits.  Cold sysfs and
cgroupfs walks are not slower.

kernfs_fill_super() still allocates the root inode under the lock.  It
runs once per superblock.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- dentry allocation outside kernfs_rwsem (Sashiko).
- Couple of comments updated.

 fs/kernfs/dir.c             | 11 +++---
 fs/kernfs/inode.c           | 69 +++++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  2 ++
 fs/kernfs/mount.c           | 18 +++++-----
 4 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 7e65854a09e4..70c114911063 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -37,7 +37,7 @@ static bool __kernfs_active(struct kernfs_node *kn)
 	return atomic_read(&kn->active) >= 0;
 }
 
-static bool kernfs_active(struct kernfs_node *kn)
+bool kernfs_active(struct kernfs_node *kn)
 {
 	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
 	return __kernfs_active(kn);
@@ -1269,9 +1269,12 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 			up_read(&root->kernfs_rwsem);
 			return NULL;
 		}
-		inode = kernfs_get_inode(dir->i_sb, kn);
-		if (!inode)
-			inode = ERR_PTR(-ENOMEM);
+		inode = kernfs_iget(dir->i_sb, kn);
+		if (!inode) {
+			/* deactivated while kernfs_iget() dropped the lock */
+			up_read(&root->kernfs_rwsem);
+			return NULL;
+		}
 	}
 	/*
 	 * Needed for negative dentry validation.
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 237dcdd73fc2..6c64bff0fc9f 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -256,6 +256,75 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 	return inode;
 }
 
+static int kernfs_iget_test(struct inode *inode, void *data)
+{
+	return inode->i_ino == *(u64 *)data;
+}
+
+static int kernfs_iget_set(struct inode *inode, void *data)
+{
+	inode->i_ino = *(u64 *)data;
+	return 0;
+}
+
+/**
+ * kernfs_iget - get the inode of @kn, allocating it outside kernfs_rwsem
+ * @sb: super block
+ * @kn: kernfs_node to get the inode for
+ *
+ * Unlike kernfs_get_inode(), this never allocates with kernfs_rwsem held.
+ * If @kn has no inode yet, the lock is dropped while allocating one, as
+ * the allocation can stall in memcg reclaim.  The new inode is added only
+ * if @kn is still active when the lock is taken again, so
+ * __kernfs_remove() always finds it to clear i_nlink.
+ *
+ * Only @kn is pinned while the lock is dropped.  Its name and parent can
+ * change in that time.
+ *
+ * Context: May sleep.  Called with kernfs_rwsem held for read.  Returns
+ * with it held, but may have dropped and retaken it.
+ *
+ * Return: the inode, %NULL if @kn is inactive or became inactive while
+ * the lock was dropped, or ERR_PTR(-ENOMEM).
+ */
+struct inode *kernfs_iget(struct super_block *sb, struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+	u64 ino = kernfs_ino(kn);
+	struct inode *inode, *new;
+
+	lockdep_assert_held_read(&root->kernfs_rwsem);
+
+	inode = ilookup(sb, ino);
+	if (inode || !kernfs_active(kn))
+		return inode;
+
+	kernfs_get(kn);
+	up_read(&root->kernfs_rwsem);
+	new = new_inode(sb);
+	down_read(&root->kernfs_rwsem);
+
+	if (!new) {
+		inode = ERR_PTR(-ENOMEM);
+	} else if (!kernfs_active(kn)) {
+		inode = NULL;
+	} else {
+		inode = inode_insert5(new, ino, kernfs_iget_test,
+				      kernfs_iget_set, &ino);
+		if (inode == new) {
+			kernfs_init_inode(kn, inode);
+			new = NULL;
+		} else if (!inode) {
+			inode = ERR_PTR(-ENOMEM);
+		}
+	}
+
+	kernfs_put(kn);
+	if (new)
+		iput(new);
+	return inode;
+}
+
 /*
  * The kernfs_node serves as both an inode and a directory entry for
  * kernfs.  To prevent the kernfs inode numbers from being freed
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 1609c1519698..6cc19c9ef47b 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -186,6 +186,7 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
+struct inode *kernfs_iget(struct super_block *sb, struct kernfs_node *kn);
 
 /*
  * dir.c
@@ -194,6 +195,7 @@ extern const struct dentry_operations kernfs_dops;
 extern const struct file_operations kernfs_dir_fops;
 extern const struct inode_operations kernfs_dir_iops;
 
+bool kernfs_active(struct kernfs_node *kn);
 struct kernfs_node *kernfs_get_active(struct kernfs_node *kn);
 void kernfs_put_active(struct kernfs_node *kn);
 int kernfs_add_one(struct kernfs_node *kn);
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index c15ba6357162..ccb7dc575c7c 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -125,11 +125,9 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
 	}
 
 	/*
-	 * Hold kernfs_rwsem across the lookup as well as kernfs_get_inode().
-	 * __kernfs_remove() deactivates the subtree and clears i_nlink on its
-	 * inodes under the write lock, so under the read lock either
-	 * kernfs_find_and_get_node_by_id() refuses the node, or the inode is
-	 * in the inode hash before the ilookup() pass goes looking for it.
+	 * Hold kernfs_rwsem from the lookup through kernfs_iget().  Then
+	 * __kernfs_remove() either finds the inode to clear i_nlink, or the
+	 * node is already inactive and no inode is created.
 	 */
 	scoped_guard(rwsem_read, &info->root->kernfs_rwsem) {
 		kn = kernfs_find_and_get_node_by_id(info->root, id);
@@ -146,7 +144,7 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
 				return ERR_PTR(-ESTALE);
 		}
 
-		inode = kernfs_get_inode(sb, kn);
+		inode = kernfs_iget(sb, kn);
 		kernfs_put(kn);
 	}
 
@@ -171,9 +169,13 @@ static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
 	struct kernfs_root *root = kernfs_root(kn);
+	struct inode *inode;
+
+	scoped_guard(rwsem_read, &root->kernfs_rwsem) {
+		inode = kernfs_iget(child->d_sb, kernfs_parent(kn));
+	}
 
-	guard(rwsem_read)(&root->kernfs_rwsem);
-	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_parent(kn)));
+	return d_obtain_alias(inode);
 }
 
 static const struct export_operations kernfs_export_ops = {
-- 
2.53.0-Meta

