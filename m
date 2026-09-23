Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BC410D13
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201968; cv=none; b=LXVQUkS4ylBd7w2ElVBPKt8IESYTrC8avVbNW+TmEf2ImfhEj4ot7ZdbmngbIs6asW+3oh3MoiGt6fGkTGOeB98BLD8mWZMGwVasqLVd0ylSJjVC4e1twJ+V4Oe7bYiCqRMjWPzncSajq0cev0VW8Di0d60AI2oM22R8MHbpLGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201968; c=relaxed/simple;
	bh=Gol+kdUaemqCeox+VaKjeAMH05x2ovFG9KXuwCT2w8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pujJzURaq0dbkblC9Az2gfcCy0WGk01y96i3KbANAdfum7Hoh9bRldIcofdWUUAbkkIDyyShZa24wLktcI7G490ESL3jP6fZvyXHvCuN4OGcEqcaMkJyddCwQDZ6MqEmU0yq6nFT80rwZ5rzWoRMkvbBRElXZyHQSB0tMAqYJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkPJOdV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkPJOdV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC7F1F00893;
	Wed, 23 Sep 2026 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790201965;
	bh=KSzUSSJhh3ZryGVqSEzSeF+sUOcF70djad1xdtqzRow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GkPJOdV8XPtQqi5nfogzVyZYgYu6ynniEskz+74cOj1+uuQiShTiXLTuBzxXrF/IH
	 TnrhnqXarn+d64u6ujX9rFs0w65Lg+T6IvKCw4irTonxzYG4OZoFKV/bkjgkt83kqw
	 XJhuRiWQeAR+zb3/eexpAFHZNREhvKHArlHG194qkKYEAZp28zE/2sN2AcJ0a8XTGw
	 uG6f+ENk9by0R1Dn2wXG3G8hw6T7y/WksCFIfWtU+4yFZxXd25+/G/fEbQvfrq2npi
	 MRDBLK1zf6+CQYg3PKAijhbhmEkBmEYAcawycNqw2hbtMLucFgfIUbEnIKXpso1b8m
	 qZtzhb81m0CkQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Sep 2026 00:18:52 +0200
Subject: [PATCH RFC 3/6] namespace: prevent UMOUNT_CONNECTED reference
 count cycles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-work-mount-knullfs-v1-3-ae89b29f7cb3@kernel.org>
References: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
In-Reply-To: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=16057; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Gol+kdUaemqCeox+VaKjeAMH05x2ovFG9KXuwCT2w8M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtCUhWMF5xc98FN7Ws41d+HD2/b8nM0LcfTTvb8sX6y
 7f9WmvC11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARsaMM//3DP/25P1s9KOqw
 5LroW9y7X0/i7WSe/DCje23Jt+L2zcwM/+ylInPzvj58JrjMIdnMd8vuOyz/fl6cfC/yUrnNemk
 fBmYA
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
tmpfs on /x. Now rmdir /x on the host. This will lazily unmount the
mount on top of /x in the container with UMOUNT_CONNECTED. Once the
namespace exists nothing references the mount anymore. Now the tmpfs is
pinned by the backing file of the loop device and the loop mount is
owned by the tmpfs superblock.

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
 fs/mount.h     |  12 +++--
 fs/namespace.c | 146 +++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 121 insertions(+), 37 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 94fcc306d21e..50d0999ff09f 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -6,6 +6,7 @@
 #include <linux/fs_pin.h>
 
 extern struct file_system_type nullfs_fs_type;
+extern struct vfsmount *knullfs;
 extern struct list_head notify_list;
 
 struct mnt_namespace {
@@ -50,8 +51,13 @@ struct mount {
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
+			struct dentry *mnt_old_root; /* what a vacant mount stands in for */
+		};
 	};
 #ifdef CONFIG_SMP
 	struct mnt_pcp __percpu *mnt_pcp;
@@ -84,7 +90,7 @@ struct mount {
 	struct mountpoint *mnt_mp;	/* where is it mounted */
 	union {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
-		struct hlist_node mnt_umount;
+		struct hlist_node mnt_umount;	/* in the parent's mnt_stuck_children */
 	};
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
diff --git a/fs/namespace.c b/fs/namespace.c
index 580877e46b1a..175e8165693b 100644
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
@@ -1150,18 +1162,28 @@ static void commit_tree(struct mount *mnt)
 	touch_mnt_namespace(n);
 }
 
-static void setup_mnt(struct mount *m, struct dentry *root)
+/*
+ * Point @m at @root: a reference on the superblock and its root, and a
+ * place on the superblock's list of instances.
+ * locks: mount_lock, as mount_locked_reader or mount_writer
+ */
+static void __setup_mnt(struct mount *m, struct dentry *root)
 {
 	struct super_block *s = root->d_sb;
 
 	atomic_inc(&s->s_active);
 	m->mnt.mnt_sb = s;
 	m->mnt.mnt_root = dget(root);
-	m->mnt_mountpoint = m->mnt.mnt_root;
+	mnt_add_instance(m, s);
+}
+
+static void setup_mnt(struct mount *m, struct dentry *root)
+{
+	m->mnt_mountpoint = root;
 	m->mnt_parent = m;
 
 	guard(mount_locked_reader)();
-	mnt_add_instance(m, s);
+	__setup_mnt(m, root);
 }
 
 /**
@@ -1294,8 +1316,20 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	return ERR_PTR(err);
 }
 
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
+	bool release = !(mnt->mnt.mnt_flags & MNT_DOOMED);
+	struct dentry *root = release ? mnt->mnt_old_root : mnt->mnt.mnt_root;
+	struct super_block *sb = root->d_sb;
 	struct hlist_node *p;
 	struct mount *m;
 	/*
@@ -1303,9 +1337,10 @@ static void cleanup_mnt(struct mount *mnt)
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
@@ -1313,12 +1348,35 @@ static void cleanup_mnt(struct mount *mnt)
 		mntput(&m->mnt);
 	}
 	fsnotify_vfsmount_delete(&mnt->mnt);
-	dput(mnt->mnt.mnt_root);
-	deactivate_super(mnt->mnt.mnt_sb);
+	dput(root);
+	deactivate_super(sb);
+	/* A new vacant mount is just put here. */
+	if (unlikely(release)) {
+		/* the reference vacate_mount() gave the release */
+		mntput(&mnt->mnt);
+		return;
+	}
 	mnt_free_id(mnt);
 	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
 }
 
+/*
+ * @mnt lost its last reference while still attached. Don't reveal what's
+ * beneath so mount knullfs over it.
+ */
+static void vacate_mount(struct mount *mnt)
+{
+	/* a vacant mount is put only after it has been unhashed */
+	VFS_WARN_ON_ONCE(is_vacant(mnt));
+	mnt->mnt_old_root = mnt->mnt.mnt_root;
+	__setup_mnt(mnt, knullfs->mnt_root);
+	mnt->mnt.mnt_flags |= MNT_READONLY;
+	/* It's a new mount so give it its own mount id. */
+	mnt->mnt_id_unique = mnt_alloc_unique_id();
+	/* One reference for the parent and one for cleanup_mnt(). */
+	mnt_add_count(mnt, 2);
+}
+
 static void __cleanup_mnt(struct rcu_head *head)
 {
 	cleanup_mnt(container_of(head, struct mount, mnt_rcu));
@@ -1338,6 +1396,7 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 {
 	LIST_HEAD(list);
+	bool vacate = false;
 	int count;
 
 	VFS_BUG_ON(mnt->mnt_ns);
@@ -1360,7 +1419,11 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 		unlock_mount_hash();
 		return;
 	}
-	mnt->mnt.mnt_flags |= MNT_DOOMED;
+	/* Still attached, so it held its own reference: keep the slot filled. */
+	if (unlikely(mnt_has_parent(mnt)))
+		vacate = true;
+	else
+		mnt->mnt.mnt_flags |= MNT_DOOMED;
 	rcu_read_unlock();
 
 	mnt_del_instance(mnt);
@@ -1371,9 +1434,13 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 		struct mount *p, *tmp;
 		list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
 			__umount_mnt(p, &list);
-			hlist_add_head(&p->mnt_umount, &mnt->mnt_stuck_children);
+			/* only a vacant mount is owned by its parent */
+			if (is_vacant(p))
+				hlist_add_head(&p->mnt_umount, &mnt->mnt_stuck_children);
 		}
 	}
+	if (unlikely(vacate))
+		vacate_mount(mnt);
 	unlock_mount_hash();
 	shrink_dentry_list(&list);
 
@@ -1688,13 +1755,12 @@ static bool need_notify_mnt_list(void)
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
 
@@ -1718,13 +1784,14 @@ static void namespace_unlock(void)
 
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
@@ -1740,6 +1807,19 @@ enum umount_tree_flags {
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
@@ -1750,10 +1830,7 @@ static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
 	if (!mnt_has_parent(mnt))
 		return true;
 
-	/* Because the reference counting rules change when mounts are
-	 * unmounted and connected, umounted mounts may not be
-	 * connected to mounted mounts.
-	 */
+	/* An unmounted mount may only stay attached to an unmounted parent */
 	if (!(mnt->mnt_parent->mnt.mnt_flags & MNT_UMOUNT))
 		return true;
 
@@ -1769,10 +1846,6 @@ static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
 	return true;
 }
 
-/*
- * mount_lock must be held
- * namespace_sem must be held for write
- */
 static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 {
 	LIST_HEAD(tmp_list);
@@ -1824,8 +1897,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 				umount_mnt(p);
 			}
 		}
-		if (disconnect)
-			hlist_add_head(&p->mnt_umount, &unmounted);
+		/* attached or not, it holds its own reference */
+		list_add_tail(&p->mnt_list, &unmounted);
 
 		/*
 		 * At this point p->mnt_ns is NULL, notification will be queued
@@ -1994,9 +2067,12 @@ void __detach_mounts(struct dentry *dentry)
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
@@ -6210,10 +6286,12 @@ static void __init init_mount_tree(void)
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
@@ -6245,11 +6323,11 @@ static void __init init_mount_tree(void)
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

