Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142884AD4C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950480; cv=none; b=mtV5O4tlpMEsPR2PFDw+hnAeaIVWpAOZetzxOEMh+dIhrJb5d2u1WMrBAaqDNT15pNOelg8CrlMbw460Ssles6390flItW0W913pJ76BaSco/VKkJSX2JFJwlTumIy4CWKyR48WgUFLnUsJSXMUUPHcVhyZ/WFCWuI8gFjpb1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950480; c=relaxed/simple;
	bh=pPYiaC3RehZRYJlC0Nx7aEYXhZOK4HsI4lVVJ1pDYTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpkXKEMq0WJF/GUxVcNc+SuOiH0P70/v5bUugeppCyZQqq9gBdF13SAonSgqkYCvRBkRO0gGhojAD5rd3++TcWsEl2nI23Qsy9DAJ1+YhU+vmrR7BM+IYdIyaPva2tX8dmnwptocTICYZVxsHq8xp31D78Dz3CBzSsD36On1GbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2juIbIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2juIbIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050741F000FF;
	Fri,  2 Oct 2026 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950478;
	bh=P975eWv8Zd/mysxwGlxL49cFIfRr5YlszSl24gdkXjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N2juIbIC/CpgtRBnOV9puk58FDtdXJUOOwOQExEWCwfKIqWqSga2UodGG8gz4Tw7E
	 Zsisobj97A/E5xwpHFLi2fVtHKIyb9ECOy7sppkcaNzDatXfXKRkPvirZZGMqHptAr
	 n9Ht6UbWl9/NENglm00Y4J85vlwiPiPxnaPZIRQezG65+QQsAbftr7SYkta9n3OUSP
	 s8/C5DAcz99Xkh9qnLWOIsIW/NteAkuCCXkCA7AWXT9TTAL7VQhbW4X8/BZSDkcC8j
	 D19gdDyZkddnX2PgGgX8RLBh5N++pNcGMcvzd8BnYU3uDcmRs6QP3R8LT1lGXlH6KR
	 UPE2K6fS1jyHA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 16:14:28 +0200
Subject: [PATCH 2/3] namespace: rework connected mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
In-Reply-To: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=18684; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pPYiaC3RehZRYJlC0Nx7aEYXhZOK4HsI4lVVJ1pDYTw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3+P2bZvCj/J1M7iSlf8J9yiteeuzccH1FVVP3VVq8
 ySeGujO6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIihAjw5JrjfkVMf62oQIs
 zrV3xH+/iqz64Rk++9Gt262rnkpNm8Twz2Sv/W7hKg2jO9wls8uF807uZfU9muzYfLjt4ISC58c
 42QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

UMOUNT_CONNECTED as implemented allows for the creation of reference
count cycles. Here's a simple example

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
UMOUNT_CONNECTED. Once the namespace exits nothing references the mount
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

Don't keep the child attached at all. What the parent needs is that a
lookup at the child's mountpoint keeps finding some mount, not the child
itself and it's not a guarantee we have given really.

When an unmounted mount would have stayed attached to its unmounted
parent disconnect it like every other unmounted mount and leave a
marker behind.

A lookup on the parent that misses the mount hash and hits a marker
finds knullfs. Either a file or a directory. Nothing leads from a marker
to any other mount.

The marker is owned by the parent and dropped by the parent's final
mntput() or by __detach_mounts() when the mountpoint is deleted from
under it. It is allocated together with the mount.

With that every unmounted mount is a root and holds only its own
reference which namespace_unlock() drops. No unmounted mount owns
another one. A superblock that pins an ancestor can't form a cycle.

It has a visible change. Mounts left connected (rmdir etc.) used to stay
traversable through the parent for as long as something held the parent.
Now it is detached with the umount. It lives as long as something
references it but it isn't reachable through the parent anymore and ".."
inside it leads nowhere which is the same as for every other lazily
unmounted mount.

Link: https://gist.github.com/mvo5/63ef46482349f3b1c3957d463a0c9c6f
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/filesystems/propagate_umount.txt |  12 +--
 fs/mount.h                                     |  10 +-
 fs/namespace.c                                 | 129 +++++++++++++++++--------
 fs/pnode.c                                     |   4 +-
 4 files changed, 104 insertions(+), 51 deletions(-)

diff --git a/Documentation/filesystems/propagate_umount.txt b/Documentation/filesystems/propagate_umount.txt
index 9a7eb96df300..de58ce817582 100644
--- a/Documentation/filesystems/propagate_umount.txt
+++ b/Documentation/filesystems/propagate_umount.txt
@@ -32,12 +32,12 @@ of set.  They can be reparented to the place where the bottom of
 stack is attached to a mount that will survive.  NOTE: doing that
 will violate a constraint on having no more than one mount with
 the same parent/mountpoint pair; however, the caller (umount_tree())
-will immediately remedy that - it may keep unmounted element attached
-to parent, but only if the parent itself is unmounted.  Since all
-conflicts created by reparenting have common parent *not* in the
-set and one side of the conflict (bottom of the stack of overmounts)
-is in the set, it will be resolved.  However, we rely upon umount_tree()
-doing that pretty much immediately after the call of propagate_umount().
+will immediately remedy that - it detaches every element of the set
+from its parent.  Since all conflicts created by reparenting have
+common parent *not* in the set and one side of the conflict (bottom
+of the stack of overmounts) is in the set, it will be resolved.
+However, we rely upon umount_tree() doing that pretty much immediately
+after the call of propagate_umount().
 
 Algorithm is based on two statements:
 	1) for any set S, there is a maximal non-shifting subset of S
diff --git a/fs/mount.h b/fs/mount.h
index 2e29cdbaeb74..4d23cade9f6c 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -43,9 +43,12 @@ struct mnt_pcp {
 struct mountpoint {
 	struct hlist_node m_hash;
 	struct dentry *m_dentry;
-	struct hlist_head m_list;
+	struct hlist_head m_list;	/* mounts on it and pins */
+	struct hlist_head m_covers;	/* covers of unmounted parents */
 };
 
+struct mnt_cover;
+
 struct mount {
 	struct hlist_node mnt_hash;
 	struct mount *mnt_parent;
@@ -87,7 +90,7 @@ struct mount {
 	struct mountpoint *mnt_mp;	/* where is it mounted */
 	union {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
-		struct hlist_node mnt_umount;
+		struct hlist_node mnt_umount;	/* on the unmounted list */
 	};
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
@@ -101,7 +104,8 @@ struct mount {
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
-	struct hlist_head mnt_stuck_children;
+	struct mnt_cover *mnt_cover;	/* the one it may leave behind */
+	struct hlist_head mnt_covers;	/* left behind by its unmounted children */
 	struct hlist_node mnt_ns_visible; /* link in ns->mnt_visible_mounts */
 	struct mount *overmount;	/* mounted on ->mnt_root */
 } __randomize_layout;
diff --git a/fs/namespace.c b/fs/namespace.c
index ff21e0440fae..e09f2d098abf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -211,6 +211,19 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
 	return &mountpoint_hashtable[tmp & mp_hash_mask];
 }
 
+/*
+ * What an unmounted mount leaves behind at its unmounted parent instead of
+ * staying attached to it. A lookup on the parent at the mountpoint finds
+ * a stand-in for as long as the cover is there. The parent frees it.
+ */
+struct mnt_cover {
+	struct hlist_node node;		/* parent->mnt_covers, RCU */
+	struct hlist_node pin;		/* mp->m_covers, keeps the mountpoint */
+	struct dentry *dentry;
+	struct mountpoint *mp;
+	struct rcu_head rcu;
+};
+
 static int mnt_alloc_id(struct mount *mnt)
 {
 	int res;
@@ -300,6 +313,10 @@ static struct mount *alloc_vfsmnt(const char *name)
 	if (mnt) {
 		int err;
 
+		mnt->mnt_cover = kzalloc_obj(struct mnt_cover, GFP_KERNEL_ACCOUNT);
+		if (!mnt->mnt_cover)
+			goto out_free_cache;
+
 		err = mnt_alloc_id(mnt);
 		if (err)
 			goto out_free_cache;
@@ -332,7 +349,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_HEAD(&mnt->mnt_slave_list);
 		INIT_HLIST_NODE(&mnt->mnt_slave);
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
-		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
+		INIT_HLIST_HEAD(&mnt->mnt_covers);
 		INIT_HLIST_NODE(&mnt->mnt_ns_visible);
 #ifdef CONFIG_FSNOTIFY
 		INIT_LIST_HEAD(&mnt->to_notify);
@@ -349,6 +366,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 out_free_id:
 	mnt_free_id(mnt);
 out_free_cache:
+	kfree(mnt->mnt_cover);
 	kmem_cache_free(mnt_cache, mnt);
 	return NULL;
 }
@@ -740,6 +758,8 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 static void free_vfsmnt(struct mount *mnt)
 {
 	mnt_idmap_put(mnt_idmap(&mnt->mnt));
+	/* NULL if it left it behind */
+	kfree(mnt->mnt_cover);
 	kfree_const(mnt->mnt_devname);
 #ifdef CONFIG_SMP
 	free_percpu(mnt->mnt_pcp);
@@ -796,20 +816,31 @@ static bool legitimize_mnt(struct vfsmount *bastard, unsigned seq)
  * @dentry:	dentry of mountpoint
  *
  * If @mnt has a child mount @c mounted on @dentry find and return it.
+ * If @mnt is unmounted and a child that was unmounted with it left its
+ * cover behind at @dentry, return the stand-in for it instead: knullfs
+ * for a directory, its regular file for anything else.
  * Caller must either hold the spinlock component of @mount_lock or
  * hold rcu_read_lock(), sample the seqcount component before the call
  * and recheck it afterwards.
  *
- * Return: The child of @mnt mounted on @dentry or %NULL.
+ * Return: The child of @mnt mounted on @dentry, a stand-in or %NULL.
  */
 struct mount *__lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct hlist_head *head = m_hash(mnt, dentry);
+	struct mnt_cover *cover;
 	struct mount *p;
 
 	hlist_for_each_entry_rcu(p, head, mnt_hash)
 		if (&p->mnt_parent->mnt == mnt && p->mnt_mountpoint == dentry)
 			return p;
+	/* an unmounted mount keeps the covers its unmounted children left */
+	/* a lockless caller rechecks mount_lock after a miss, a stale flag is harmless */
+	if (unlikely(data_race(mnt->mnt_flags) & MNT_UMOUNT)) {
+		hlist_for_each_entry_rcu(cover, &real_mount(mnt)->mnt_covers, node)
+			if (cover->dentry == dentry)
+				return real_mount(d_is_dir(dentry) ? knullfs : knullfs_file);
+	}
 	return NULL;
 }
 
@@ -925,6 +956,7 @@ static int get_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
 	mp->m_dentry = dget(dentry);
 	hlist_add_head(&mp->m_hash, mp_hash(dentry));
 	INIT_HLIST_HEAD(&mp->m_list);
+	INIT_HLIST_HEAD(&mp->m_covers);
 	hlist_add_head(&m->node, &mp->m_list);
 	m->mp = no_free_ptr(mp);
 	read_sequnlock_excl(&mount_lock);
@@ -937,7 +969,7 @@ static int get_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
  */
 static void maybe_free_mountpoint(struct mountpoint *mp, struct list_head *list)
 {
-	if (hlist_empty(&mp->m_list)) {
+	if (hlist_empty(&mp->m_list) && hlist_empty(&mp->m_covers)) {
 		struct dentry *dentry = mp->m_dentry;
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags &= ~DCACHE_MOUNTED;
@@ -1024,6 +1056,36 @@ static void umount_mnt(struct mount *mnt)
 	__umount_mnt(mnt, &ex_mountpoints);
 }
 
+/*
+ * @mnt is unmounted together with its parent and would have stayed attached
+ * to it. Leave its cover behind before it is detached so that a lookup on the
+ * parent at the mountpoint keeps finding a mount instead of what @mnt covered.
+ *
+ * locks: mount_lock[write_seqlock]
+ */
+static void leave_cover(struct mount *mnt)
+{
+	struct mnt_cover *cover = mnt->mnt_cover;
+
+	mnt->mnt_cover = NULL;
+	cover->dentry = mnt->mnt_mountpoint;
+	cover->mp = mnt->mnt_mp;
+	/* keeps the mountpoint once @mnt has let go of it */
+	hlist_add_head(&cover->pin, &cover->mp->m_covers);
+	hlist_add_head_rcu(&cover->node, &mnt->mnt_parent->mnt_covers);
+}
+
+/*
+ * locks: mount_lock[write_seqlock]
+ */
+static void drop_cover(struct mnt_cover *cover, struct list_head *shrink_list)
+{
+	hlist_del_rcu(&cover->node);
+	hlist_del(&cover->pin);
+	maybe_free_mountpoint(cover->mp, shrink_list);
+	kfree_rcu(cover, rcu);
+}
+
 /*
  * vfsmount lock must be held for write
  */
@@ -1315,8 +1377,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
 static void cleanup_mnt(struct mount *mnt)
 {
-	struct hlist_node *p;
-	struct mount *m;
 	/*
 	 * The warning here probably indicates that somebody messed
 	 * up a mnt_want/drop_write() pair.  If this happens, the
@@ -1327,10 +1387,6 @@ static void cleanup_mnt(struct mount *mnt)
 	WARN_ON(mnt_get_writers(mnt));
 	if (unlikely(mnt->mnt_pins.first))
 		mnt_pin_kill(mnt);
-	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
-	}
 	fsnotify_vfsmount_delete(&mnt->mnt);
 	dput(mnt->mnt.mnt_root);
 	deactivate_super(mnt->mnt.mnt_sb);
@@ -1356,6 +1412,8 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
 static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 {
+	struct mnt_cover *cover;
+	struct hlist_node *n;
 	LIST_HEAD(list);
 	int count;
 
@@ -1386,13 +1444,10 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 	if (unlikely(!list_empty(&mnt->mnt_expire)))
 		list_del(&mnt->mnt_expire);
 
-	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
-		struct mount *p, *tmp;
-		list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
-			__umount_mnt(p, &list);
-			hlist_add_head(&p->mnt_umount, &mnt->mnt_stuck_children);
-		}
-	}
+	/* nothing stays attached to an unmounted mount */
+	VFS_WARN_ON_ONCE(!list_empty(&mnt->mnt_mounts));
+	hlist_for_each_entry_safe(cover, n, &mnt->mnt_covers, node)
+		drop_cover(cover, &list);
 	unlock_mount_hash();
 	shrink_dentry_list(&list);
 
@@ -1757,7 +1812,7 @@ static inline void namespace_lock(void)
 enum umount_tree_flags {
 	UMOUNT_SYNC = 1,
 	UMOUNT_PROPAGATE = 2,
-	UMOUNT_CONNECTED = 4,
+	UMOUNT_COVER = 4,
 };
 
 static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
@@ -1770,18 +1825,15 @@ static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
 	if (!mnt_has_parent(mnt))
 		return true;
 
-	/* Because the reference counting rules change when mounts are
-	 * unmounted and connected, umounted mounts may not be
-	 * connected to mounted mounts.
-	 */
+	/* Only an unmounted parent has a mountpoint to keep covered */
 	if (!(mnt->mnt_parent->mnt.mnt_flags & MNT_UMOUNT))
 		return true;
 
-	/* Has it been requested that the mount remain connected? */
-	if (how & UMOUNT_CONNECTED)
+	/* Has it been requested that the mountpoint stays covered? */
+	if (how & UMOUNT_COVER)
 		return false;
 
-	/* Is the mount locked such that it needs to remain connected? */
+	/* Is the mount locked such that its mountpoint must stay covered? */
 	if (IS_MNT_LOCKED(mnt))
 		return false;
 
@@ -1824,7 +1876,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 	while (!list_empty(&tmp_list)) {
 		struct mnt_namespace *ns;
-		bool disconnect;
 		p = list_first_entry(&tmp_list, struct mount, mnt_list);
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
@@ -1837,17 +1888,12 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 
-		disconnect = disconnect_mount(p, how);
 		if (mnt_has_parent(p)) {
-			if (!disconnect) {
-				/* Don't forget about p */
-				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
-			} else {
-				umount_mnt(p);
-			}
+			if (!disconnect_mount(p, how))
+				leave_cover(p);
+			umount_mnt(p);
 		}
-		if (disconnect)
-			hlist_add_head(&p->mnt_umount, &unmounted);
+		hlist_add_head(&p->mnt_umount, &unmounted);
 
 		/*
 		 * At this point p->mnt_ns is NULL, notification will be queued
@@ -2006,6 +2052,8 @@ static int do_umount(struct mount *mnt, int flags)
 void __detach_mounts(struct dentry *dentry)
 {
 	struct pinned_mountpoint mp = {};
+	struct mnt_cover *cover;
+	struct hlist_node *n;
 	struct mount *mnt;
 
 	guard(namespace_excl)();
@@ -2019,12 +2067,11 @@ void __detach_mounts(struct dentry *dentry)
 	event++;
 	while (mp.node.next) {
 		mnt = hlist_entry(mp.node.next, struct mount, mnt_mp_list);
-		if (mnt->mnt.mnt_flags & MNT_UMOUNT) {
-			umount_mnt(mnt);
-			hlist_add_head(&mnt->mnt_umount, &unmounted);
-		}
-		else umount_tree(mnt, UMOUNT_CONNECTED);
+		umount_tree(mnt, UMOUNT_COVER);
 	}
+	/* the dentry goes away, so do the covers left behind on it */
+	hlist_for_each_entry_safe(cover, n, &mp.mp->m_covers, pin)
+		drop_cover(cover, &ex_mountpoints);
 	unpin_mountpoint(&mp);
 }
 
@@ -2348,7 +2395,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 
 		emptied_ns = m->mnt_ns;
 		lock_mount_hash();
-		umount_tree(m, UMOUNT_CONNECTED);
+		umount_tree(m, UMOUNT_COVER);
 		unlock_mount_hash();
 		mntput(no_free_ptr(p));
 	}
@@ -6367,6 +6414,8 @@ static void __init init_mount_tree(void)
 	 *
 	 * with (2) mounted on top of (1). The init_task's root and pwd
 	 * are pointed at (3) so all kthreads start isolated in nullfs.
+	 * A lookup at the cover an unmounted mount left behind finds (3)
+	 * or (4), see __lookup_mnt().
 	 */
 	nullfs_mnt = vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
 	if (IS_ERR(nullfs_mnt))
diff --git a/fs/pnode.c b/fs/pnode.c
index 2cd667958efe..5f07fa14099b 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -697,8 +697,8 @@ static void handle_locked(struct mount *m, struct list_head *to_umount)
  * the same parent and mountpoint; that will be remedied as soon as we
  * return from propagate_umount() - its caller (umount_tree()) will detach
  * the stack from the parent it (and now @m) is attached to.  umount_tree()
- * might choose to keep unmounted pieces stuck to each other, but it always
- * detaches them from the mounts that remain in the tree.
+ * detaches every unmounted mount from its parent, whether that parent
+ * remains in the tree or not.
  */
 static void reparent(struct mount *m)
 {

-- 
2.53.0

