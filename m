Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F744065E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289360; cv=none; b=V04g5bGlA5CaPzucQEkj6fUj7yde7Osi6HoBlQuxVXebWnI1HVsOsGIWdH3vaVBqYkJbpXQdJE4dIvEPEqdDsOOgeYSeau1IQlANT/c7jv6+V9TyVHcByP/G974TT+mPmcyofS/IgjYKXNtu41rlv8bX2wWpTh1uwXOslJGPyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289360; c=relaxed/simple;
	bh=MfSG7qc3M6ZgBkMNtuKsWCBleP+YObXNc+zx8XFPQrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiTD4JBRtTMJwSHoaGUm/f+cBwlyktVsSWE3NOYBPPe3uKirG4BDC5EJYr+/ckl3dm2xXorTNHxt6BCBYGLqImO4Q9viTyb+3AVxGVasX3q8gW47ec7tkpKNMiIPmWIhfBiiuQZZEbhVOnMizilUi69q2oBtB3qXMdL9geeTMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSDu36Sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSDu36Sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A171F000FF;
	Thu, 24 Sep 2026 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289358;
	bh=nm0y8WbHKhprcycar2EMr2d3Qpat0fBAvzUxMc5QyeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lSDu36SlcXOnB30e13qFdC7vDAg9dIcxht0+G4l4VPKvCsj5nk90gk1aFR6FjFlgV
	 Ibxv6j93jD3dDRgbbGtrdh9tmadke3QMO8nSeeScoGXrzfIs2DCT6IeTH3yUQnQxY7
	 PW3a9862zmiePOS5qnlqQPFxoo6jT6y3V+SD9fyuDqiEpJUNnBth94iElQwYAeSGrO
	 V0b8grnfMR+0QNk/moC2QG3UlzxDmAgjiZtHx959FvVGvjmWrgMbahj3YMrUFbWJeD
	 WMT+LWL/eWBYfMMZ4AXoYxZlminf2cO86A9f+LntkuJB/ecp+6yoJ0gsHsfJ0wkeJj
	 z3VQfzhO3aPuQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Sep 2026 00:35:45 +0200
Subject: [PATCH RFC v2 5/8] namespace: prevent UMOUNT_CONNECTED reference
 count cycles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-work-mount-knullfs-v2-5-c4aebaa186e9@kernel.org>
References: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
In-Reply-To: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=16896; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MfSG7qc3M6ZgBkMNtuKsWCBleP+YObXNc+zx8XFPQrs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtXXog6Oi13yKiHuw/sl7Y+3s5s/B/P7jDaZbIi/ilU
 8P5jjtZdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzknwfD/6grkeWPvLpZZyoK
 fjrMty13c43fTa4jxdxVUQ16hdI+5Qx/Jes3BVjNaZNbJOj2f+e8hxZcp44mBx1oao69n3yc6XU
 0LwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Have barf bags ready, please. UMOUNT_CONNECTED as implemented allows for
the creation of reference count cycles. Here's a simple example

  mkdir /x; mkfifo /ready /go
  unshare -m sh -c 'mount -t tmpfs tmpfs /x
                    truncate -s 8M /x/img; mkfs.ext4 -q /x/img
                    dev=$(losetup -f --show /x/img)
                    mkdir /x/mp; mount $dev /x/mp
                    echo $dev > /ready; read r < /go' &
  read dev < /ready
  rmdir /x
  echo > /go
  wait
  losetup -d $dev
  losetup -a

Take a directory /x on the host, create a new mount namespace, mount a
tmpfs on /x, use a file on that tmpfs as the backing file for a loop
device, mount that loop device on that tmpfs. Now rmdir /x on the host.
This will lazily unmount the mount on top of /x in the container with
UMOUNT_CONNECTED. Once the namespace exists nothing references the mount
anymore. Now the tmpfs is pinned by the backing file of the loop device
and the loop mount is owned by the tmpfs superblock.

Fun fact, such cycles can be formed by at least the following
subsystems and I have added reproducers for all of them:

(1) a loop mount P from an image on a tmpfs next to it, so that P's
    death shows as the loop device giving up its backing file

(2) autofs with a FIFO on P as its pipe, zram with a device node on P as
    its writeback device, both on a minix image since vfat has neither

(3) ecryptfs with its lower directory on P, under a passphrase token
    added to the session keyring

(4) binfmt_misc in a new user namespace with an 'F' interpreter on P

(5) a fuse server that answers FUSE_INIT with passthrough on and
    registers a file on P as a backing file

(6) zloop with its zone files in a directory on P

(7) a mass storage gadget on the dummy UDC with its LUN file on P,
    mounted from the SCSI disk the gadget shows up as

(8) md with a RAID1 of one loop device and its bitmap file on P, which
    skips while SET_BITMAP_FILE has no way to succeed

(9) rmdir of P's mountpoint from the parent, then the child exits, then
    the device must be free and LOOP_CLR_FD must release the file

The underlying mechanism is UMOUNT_CONNECTED (MNT_LOCKED falls into the
same class). With UMOUNT_CONNECTED an unmounted mount stays attached to
its parent. This is used to protect revealing the underlying mount and
is a non-negotiable security mechanism. So now the parent owns that
mount and is put on the parent's final mntput(). That moves it to
mnt_stuck_children and ultimately it's cleaned up by cleanup_mnt().

The fact that ownership of the child mount gets transferred to the
parent turns every reference from a child's superblock back to one of
its ancestors into a cycle.

Don't let the parent own the children. A mount that stays attached
keeps its own reference. namespace_unlock() drops it parents first.

A subtree that nobody refers to now also collapses exactly like a
disconnected one.

So, the problematic case was always a mount that loses its last
reference while it is still attached. That can reveal the covered
directory and that's caused fun exploits. UMOUNT_CONNECTED was always a
sucky mechanism imho.

Instead of that, when a mount loses its last reference but is still
attached to its parent we know that it is a UMOUNT_CONNECTED or
MNT_LOCKED case. Don't take it out of the hash. Instead make it a nullfs
mount. It's an immutable directory that is part of no namespace. Let
that nullfs mount be owned by the parent and put by the parent's final
mntput() the way locked mounts always were.

Ownership can't form a cycle anymore. A vacant mount is pointing at
knullfs. That's nullfs instance that can't go away and doesn't have any
child mounts whatsoever. Nothing leads from a vacant mount back to any
other mount.

Any lookup that still reaches the parent now finds an empty read-only
directory at the mountpoint. Creating anything in it fails with ENOENT,
like every lookup in nullfs does.

The only visible change is for a locked mount under a lazily unmounted
one. It used to stay alive and traversable for as long as something held
the parent. Now it is released with the umount when it isn't referenced
anymore and an empty directory takes its place. What it covered stays
covered either way.

Link: https://gist.github.com/mvo5/63ef46482349f3b1c3957d463a0c9c6f
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/mount.h     |  13 ++++-
 fs/namei.c     |   4 ++
 fs/namespace.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 162 insertions(+), 32 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 94fcc306d21e..90c32d097673 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -6,6 +6,7 @@
 #include <linux/fs_pin.h>
 
 extern struct file_system_type nullfs_fs_type;
+extern struct vfsmount *knullfs;
 extern struct list_head notify_list;
 
 struct mnt_namespace {
@@ -50,8 +51,14 @@ struct mount {
 	struct vfsmount mnt;
 	union {
 		struct rb_node mnt_node; /* node in the ns->mounts rbtree */
-		struct rcu_head mnt_rcu;
-		struct llist_node mnt_llist;
+		struct {		 /* once it has left its namespace */
+			union {
+				struct rcu_head mnt_rcu;
+				struct llist_node mnt_llist;
+			};
+			/* what a vacant mount stands in for, NULL once released */
+			struct dentry *mnt_old_root;
+		};
 	};
 #ifdef CONFIG_SMP
 	struct mnt_pcp __percpu *mnt_pcp;
@@ -84,7 +91,7 @@ struct mount {
 	struct mountpoint *mnt_mp;	/* where is it mounted */
 	union {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
-		struct hlist_node mnt_umount;
+		struct hlist_node mnt_umount;	/* in the parent's mnt_stuck_children */
 	};
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
diff --git a/fs/namei.c b/fs/namei.c
index 20a6534ea3ef..aca50e2bc42d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -816,6 +816,10 @@ static bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct super_block *sb = mnt->mnt_sb;
 
+	/* @mnt was vacated after an RCU walk found @dentry on it */
+	if (unlikely(dentry->d_sb != sb))
+		return false;
+
 	/* Bind mounts can have disconnected paths */
 	if (mnt->mnt_root == sb->s_root)
 		return true;
diff --git a/fs/namespace.c b/fs/namespace.c
index 4ff3cebe6c31..aefa4b00d676 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -80,8 +80,9 @@ static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
 static struct kmem_cache *mnt_cache __ro_after_init;
+struct vfsmount *knullfs __ro_after_init;	/* private nullfs instance */
 static DECLARE_RWSEM(namespace_sem);
-static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
+static LIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static struct mnt_namespace *emptied_ns; /* protected by namespace_sem */
 
@@ -227,6 +228,17 @@ static void mnt_free_id(struct mount *mnt)
 	xa_erase(&mnt_id_xa, mnt->mnt_id);
 }
 
+/* mnt_id_ctr is protected by the lock of mnt_id_xa, see mnt_alloc_id(). */
+static u64 mnt_alloc_unique_id(void)
+{
+	u64 id;
+
+	xa_lock(&mnt_id_xa);
+	id = ++mnt_id_ctr;
+	xa_unlock(&mnt_id_xa);
+	return id;
+}
+
 /*
  * Allocate a new peer group ID
  */
@@ -1294,8 +1306,57 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	return ERR_PTR(err);
 }
 
+/* What it stood in for is gone already and it holds nothing on knullfs. */
+static void free_vacant_mount(struct mount *mnt)
+{
+	if (!mnt)
+		return;
+
+	VFS_WARN_ON_ONCE(mnt->mnt_pins.first);
+	VFS_WARN_ON_ONCE(!hlist_empty(&mnt->mnt_stuck_children));
+#ifdef CONFIG_FSNOTIFY
+	VFS_WARN_ON_ONCE(rcu_access_pointer(mnt->mnt_fsnotify_marks));
+#endif
+	mnt_free_id(mnt);
+	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
+}
+
+/* The release is done. Whoever comes second, this or the last put, frees it. */
+static inline void vacant_mount_released(struct mount *mnt)
+{
+	scoped_guard(mount_locked_reader) {
+		mnt->mnt_old_root = NULL;
+		if (!(mnt->mnt.mnt_flags & MNT_DOOMED))
+			mnt = NULL;
+	}
+	free_vacant_mount(mnt);
+}
+
+/* The last put is done. Whoever comes second, this or the release, frees it. */
+static inline struct mount *vacant_mount_put(struct mount *mnt)
+{
+	VFS_WARN_ON_ONCE(mnt_has_parent(mnt));
+	mnt->mnt.mnt_flags |= MNT_DOOMED;
+	mnt_del_instance(mnt);
+	if (mnt->mnt_old_root)
+		return NULL;
+	return mnt;
+}
+
+/*
+ * The only mounts of knullfs' superblock that are ever attached are
+ * vacant mounts.
+ */
+static inline bool is_vacant(const struct mount *mnt)
+{
+	return mnt->mnt.mnt_sb == knullfs->mnt_sb;
+}
+
 static void cleanup_mnt(struct mount *mnt)
 {
+	bool release = is_vacant(mnt);
+	struct dentry *root = release ? mnt->mnt_old_root : mnt->mnt.mnt_root;
+	struct super_block *sb = root->d_sb;
 	struct hlist_node *p;
 	struct mount *m;
 	/*
@@ -1303,9 +1364,10 @@ static void cleanup_mnt(struct mount *mnt)
 	 * up a mnt_want/drop_write() pair.  If this happens, the
 	 * filesystem was probably unable to make r/w->r/o transitions.
 	 * The locking used to deal with mnt_count decrement provides barriers,
-	 * so mnt_get_writers() below is safe.
+	 * so mnt_get_writers() below is safe. A vacant mount is still reachable
+	 * and a failing mnt_want_write() on it bumps the count for a moment.
 	 */
-	WARN_ON(mnt_get_writers(mnt));
+	WARN_ON(!release && mnt_get_writers(mnt));
 	if (unlikely(mnt->mnt_pins.first))
 		mnt_pin_kill(mnt);
 	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
@@ -1313,10 +1375,35 @@ static void cleanup_mnt(struct mount *mnt)
 		mntput(&m->mnt);
 	}
 	fsnotify_vfsmount_delete(&mnt->mnt);
-	dput(mnt->mnt.mnt_root);
-	deactivate_super(mnt->mnt.mnt_sb);
-	mnt_free_id(mnt);
-	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
+	dput(root);
+	deactivate_super(sb);
+
+	if (unlikely(release)) {
+		vacant_mount_released(mnt);
+	} else {
+		mnt_free_id(mnt);
+		call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
+	}
+}
+
+/*
+ * @mnt lost its last reference while still attached. Don't reveal what's
+ * beneath so mount knullfs over it.
+ */
+static void vacate_mount(struct mount *mnt)
+{
+	/* a vacant mount is put only after it has been unhashed */
+	VFS_WARN_ON_ONCE(is_vacant(mnt));
+	mnt->mnt_old_root = mnt->mnt.mnt_root;
+	/* knullfs never goes away, a vacant mount holds nothing on it */
+	mnt->mnt.mnt_sb = knullfs->mnt_sb;
+	mnt->mnt.mnt_root = knullfs->mnt_root;
+	mnt_add_instance(mnt, knullfs->mnt_sb);
+	mnt->mnt.mnt_flags |= MNT_READONLY;
+	/* It's a new mount so give it its own mount id. */
+	mnt->mnt_id_unique = mnt_alloc_unique_id();
+	/* One reference for the parent, the release is pending until it's done. */
+	mnt_add_count(mnt, 1);
 }
 
 static void __cleanup_mnt(struct rcu_head *head)
@@ -1338,6 +1425,7 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 {
 	LIST_HEAD(list);
+	bool connected = false;
 	int count;
 
 	VFS_BUG_ON(mnt->mnt_ns);
@@ -1360,7 +1448,19 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 		unlock_mount_hash();
 		return;
 	}
-	mnt->mnt.mnt_flags |= MNT_DOOMED;
+	/* The last put of a vacant mount. */
+	if (unlikely(is_vacant(mnt))) {
+		mnt = vacant_mount_put(mnt);
+		rcu_read_unlock();
+		unlock_mount_hash();
+		free_vacant_mount(mnt);
+		return;
+	}
+	/* Still attached, so it held its own reference: keep the slot filled. */
+	if (unlikely(mnt_has_parent(mnt)))
+		connected = true;
+	else
+		mnt->mnt.mnt_flags |= MNT_DOOMED;
 	rcu_read_unlock();
 
 	mnt_del_instance(mnt);
@@ -1371,9 +1471,13 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 		struct mount *p, *tmp;
 		list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
 			__umount_mnt(p, &list);
-			hlist_add_head(&p->mnt_umount, &mnt->mnt_stuck_children);
+			/* only a vacant mount is owned by its parent */
+			if (is_vacant(p))
+				hlist_add_head(&p->mnt_umount, &mnt->mnt_stuck_children);
 		}
 	}
+	if (unlikely(connected))
+		vacate_mount(mnt);
 	unlock_mount_hash();
 	shrink_dentry_list(&list);
 
@@ -1688,13 +1792,12 @@ static bool need_notify_mnt_list(void)
 static void free_mnt_ns(struct mnt_namespace *);
 static void namespace_unlock(void)
 {
-	struct hlist_head head;
-	struct hlist_node *p;
-	struct mount *m;
+	struct mount *m, *n;
 	struct mnt_namespace *ns = emptied_ns;
+	LIST_HEAD(head);
 	LIST_HEAD(list);
 
-	hlist_move_list(&unmounted, &head);
+	list_splice_init(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 	emptied_ns = NULL;
 
@@ -1718,13 +1821,14 @@ static void namespace_unlock(void)
 
 	shrink_dentry_list(&list);
 
-	if (likely(hlist_empty(&head)))
+	if (likely(list_empty(&head)))
 		return;
 
 	synchronize_rcu_expedited();
 
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
+	/* In tree order, so a subtree nobody holds goes without vacant mounts. */
+	list_for_each_entry_safe(m, n, &head, mnt_list) {
+		list_del_init(&m->mnt_list);
 		mntput(&m->mnt);
 	}
 }
@@ -1740,6 +1844,19 @@ enum umount_tree_flags {
 	UMOUNT_CONNECTED = 4,
 };
 
+/*
+ * An unmounted mount that stays attached to its unmounted parent:
+ *
+ *  - is hashed and on the parent's list of children, so a walk on the
+ *    parent finds it and never ends up in what it covered
+ *  - is unreachable from any namespace root
+ *  - holds its own reference, dropped by namespace_unlock(); the parent's
+ *    final mntput() unhashes it without putting it, so a child whose
+ *    superblock pins an ancestor can still shut down
+ *  - is vacated if it loses its last reference while attached
+ *    it releases the filesystem it carried and a knullfs mount is placed on
+ *    the parent which is owned by it
+ */
 static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
 {
 	/* Leaving mounts connected is only valid for lazy umounts */
@@ -1750,10 +1867,7 @@ static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
 	if (!mnt_has_parent(mnt))
 		return true;
 
-	/* Because the reference counting rules change when mounts are
-	 * unmounted and connected, umounted mounts may not be
-	 * connected to mounted mounts.
-	 */
+	/* An unmounted mount may only stay attached to an unmounted parent */
 	if (!(mnt->mnt_parent->mnt.mnt_flags & MNT_UMOUNT))
 		return true;
 
@@ -1824,8 +1938,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 				umount_mnt(p);
 			}
 		}
-		if (disconnect)
-			hlist_add_head(&p->mnt_umount, &unmounted);
+		/* attached or not, it holds its own reference */
+		list_add_tail(&p->mnt_list, &unmounted);
 
 		/*
 		 * At this point p->mnt_ns is NULL, notification will be queued
@@ -1994,9 +2108,12 @@ void __detach_mounts(struct dentry *dentry)
 		mnt = hlist_entry(mp.node.next, struct mount, mnt_mp_list);
 		if (mnt->mnt.mnt_flags & MNT_UMOUNT) {
 			umount_mnt(mnt);
-			hlist_add_head(&mnt->mnt_umount, &unmounted);
+			/* only a vacant mount is owned by its parent */
+			if (is_vacant(mnt))
+				list_add_tail(&mnt->mnt_list, &unmounted);
+		} else {
+			umount_tree(mnt, UMOUNT_CONNECTED);
 		}
-		else umount_tree(mnt, UMOUNT_CONNECTED);
 	}
 	unpin_mountpoint(&mp);
 }
@@ -6213,10 +6330,12 @@ static void __init init_mount_tree(void)
 	 *
 	 * (1) nullfs with mount id 1
 	 * (2) mutable rootfs with mount id 2
-	 * (3) private nullfs for kthreads (SB_KERNMOUNT)
+	 * (3) private nullfs for kthreads (SB_KERNMOUNT), kept in knullfs
 	 *
 	 * with (2) mounted on top of (1). The init_task's root and pwd
 	 * are pointed at (3) so all kthreads start isolated in nullfs.
+	 * A mount that dies while still attached to its parent is pointed
+	 * at (3) as well, see vacate_mount().
 	 */
 	nullfs_mnt = vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
 	if (IS_ERR(nullfs_mnt))
@@ -6248,11 +6367,11 @@ static void __init init_mount_tree(void)
 		init_mnt_ns.nr_mounts++;
 	}
 
-	nullfs_mnt = kern_mount(&nullfs_fs_type);
-	if (IS_ERR(nullfs_mnt))
+	knullfs = kern_mount(&nullfs_fs_type);
+	if (IS_ERR(knullfs))
 		panic("VFS: Failed to create private nullfs instance");
-	root.mnt	= nullfs_mnt;
-	root.dentry	= nullfs_mnt->mnt_root;
+	root.mnt	= knullfs;
+	root.dentry	= knullfs->mnt_root;
 
 	init_task.nsproxy->mnt_ns = &init_mnt_ns;
 	get_mnt_ns(&init_mnt_ns);

-- 
2.53.0

