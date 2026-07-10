Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE73F86E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676048; cv=none; b=C5cx6OHLy5i0XAnWz+g61MSfdIHSwf4QqQvjaPU0XOpBTOhuT+UfcSHeO6damykow2JtNcbCRbbRyf66Wh31wstYLbLpBH3UmgXbx9dgkJe1mDf6KcIqgRDyyY7WWglWUCcQ9VU3la5Rgs3l53igt1aX+nK1aQJjFij+ZuwnJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676048; c=relaxed/simple;
	bh=gajV6Gerb5soyWHpzcSzNPsse6oQeO4+kUXaUNww+wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r380yrnRNCpHUxicT3Uxx5siCSeCOgkSMIu2ZSUgyhpW2yTg5PVL4rDaxQBp6xtxL5GNXi6i3W50cCDTHgbrCI6zchOKb79CiQsA/vt/SwG9BLBeog5hmCMjChyBBSGF94ga0y5NCj43myBgoFXVb6G6KTK/YenSZO3mPWj5S+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYxWy8K3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYxWy8K3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C71D1F00A3A;
	Fri, 10 Jul 2026 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676047;
	bh=VRgsQ6iWAyoRimrMyUgwqz4rWPbphSGZh0ZUXGgODw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NYxWy8K38BKgQYRZMP1grVsyR1eBFzAbyKgLjss6fnpfFwLxWg8h57TU0wASQG2kX
	 4dVc6n8YiSfNpeMeqVLa3Z/IVkpdXAWWtCsIM/rBknqDpe4W3KZMIeOh5z8Jnfn8zG
	 cpy+IamXqeHJeKvs+NAa91MdsZ4gtaNkrhw1vCRb9MNK+DC+XmIU5MPxrw63bEwSLI
	 9oyH3+pLOjHdYm5Qt47BHXvasV0R4hsys/3x4e/bWI9jopkOkqu8wOfwR8s2vpy9/P
	 NsYa8MieifgKHde2xH5RT5pHvHE2XNafyx2ONzBJT7jHqiXYAuWTaGaRe7OWh9BfBQ
	 Myf2PGWqFOJAg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:25 +0200
Subject: [PATCH v3 24/24] binfmt_misc: allow removing entries via unlink(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-24-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6632; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gajV6Gerb5soyWHpzcSzNPsse6oQeO4+kUXaUNww+wg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7IkXFM5ie5mymcV51pM7ma96xct/Mz1c9beGb2uf6
 OoUsVLNjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImENjH8D45Yd+mUq920CAHV
 lHQ/q6nGofeb71TvefgiK/vCntCX6xgZ1ke2rTt59f1d+xzPJvOr7qfW7exqeKb6vr2A6Wfxgd5
 VfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Removing a binary type handler requires echoing -1 into its entry
file which works but is an odd interface to discover for something
that already looks like a plain file in a filesystem. The comment on
remove_binfmt_handler() has been suggesting a proper ->unlink()
method for years, so add one: unlinking an entry file unhashes the
entry from the handler list and removes the file, exactly like
writing -1 to it does. The status and register control files refuse
removal with EPERM the same way binderfs protects binder-control.
Writing -1 keeps working.

Permission-wise nothing new is exposed: unlink(2) requires write
access to the root directory which is owned by the (user namespace)
root with mode 0755, matching the privilege needed to write to the
0644 entry files. The VFS calls ->unlink() with the root inode lock
held so the existing writer serialization scheme applies unchanged,
and eviction of the unlinked inode drops the entry reference exactly
as for the write based removal.

Document the new way in admin-guide/binfmt-misc.rst.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst |  3 +-
 fs/binfmt_misc.c                          | 77 ++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index c0a34fbf8022..306ef48f5de6 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -133,7 +133,8 @@ or 1 (to enable) to ``/proc/sys/fs/binfmt_misc/status`` or
 Catting the file tells you the current status of ``binfmt_misc/the_entry``.
 
 You can remove one entry or all entries by echoing -1 to ``/proc/.../the_name``
-or ``/proc/sys/fs/binfmt_misc/status``.
+or ``/proc/sys/fs/binfmt_misc/status``. A single entry can also be removed
+by simply unlinking (``rm``) ``/proc/.../the_name``.
 
 
 Hints
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 46c65a618b19..fcaad14f81a3 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -639,8 +639,8 @@ static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
  * entry is removed or the filesystem is unmounted and the super block is
  * shutdown.
  *
- * If the ->evict call was not caused by a super block shutdown but by a write
- * to remove the entry or all entries via bm_{entry,status}_write() the entry
+ * If the ->evict call was not caused by a super block shutdown but by
+ * removing the entry via bm_{entry,status}_write() or unlink(2) the entry
  * will have already been removed from the list. We keep the hlist_unhashed()
  * check to make that explicit.
 */
@@ -662,6 +662,26 @@ static void bm_evict_inode(struct inode *inode)
 	}
 }
 
+/**
+ * unlink_binfmt_handler - unhash a binary type handler
+ * @misc: handle to binfmt_misc instance
+ * @e: binary type handler to unhash
+ *
+ * Adding and removing entries via bm_{entry,register,status}_write() and
+ * unlink(2) happens under the exclusively held inode lock of the root
+ * dentry keeping the list stable for writers. load_misc_binary() walks it
+ * concurrently under RCU. The entries_lock is only held around the actual
+ * unlink to serialize against bm_evict_inode() which unlinks entries
+ * during umount without holding the root inode lock.
+ */
+static void unlink_binfmt_handler(struct binfmt_misc *misc,
+				  struct binfmt_misc_entry *e)
+{
+	spin_lock(&misc->entries_lock);
+	hlist_del_init_rcu(&e->node);
+	spin_unlock(&misc->entries_lock);
+}
+
 /**
  * remove_binfmt_handler - remove a binary type handler
  * @misc: handle to binfmt_misc instance
@@ -669,29 +689,15 @@ static void bm_evict_inode(struct inode *inode)
  *
  * Remove a binary type handler from the list of binary type handlers and
  * remove its associated dentry.
- *
- * Adding and removing entries via bm_{entry,register,status}_write()
- * happens under the exclusively held inode lock of the root dentry keeping
- * the list stable for writers. load_misc_binary() walks it concurrently
- * under RCU. The entries_lock is only held around the actual unlink to
- * serialize against bm_evict_inode() which unlinks entries during umount
- * without holding the root inode lock.
- *
- * In the future, we might want to think about adding a proper ->unlink()
- * method to binfmt_misc instead of forcing callers to use writes to files
- * in order to delete binary type handlers. But it has worked for so long
- * that it's not a pressing issue.
  */
 static void remove_binfmt_handler(struct binfmt_misc *misc,
 				  struct binfmt_misc_entry *e)
 {
-	spin_lock(&misc->entries_lock);
-	hlist_del_init_rcu(&e->node);
-	spin_unlock(&misc->entries_lock);
+	unlink_binfmt_handler(misc, e);
 	locked_recursive_removal(e->dentry, NULL);
 }
 
-/* Remove @e unless a concurrent write already unlinked it. */
+/* Remove @e unless it was already removed. */
 static void bm_remove_entry(struct binfmt_misc_entry *e, struct super_block *sb)
 {
 	struct inode *root = d_inode(sb->s_root);
@@ -716,6 +722,32 @@ static void bm_remove_all_entries(struct binfmt_misc *misc,
 	inode_unlock(root);
 }
 
+/**
+ * bm_unlink - remove a binary type handler via unlink(2)
+ * @dir: inode of the root directory
+ * @dentry: entry file to remove
+ *
+ * Removing the entry file removes its binary type handler, exactly like
+ * writing -1 to it does. The status and register control files can't be
+ * removed. The VFS calls this with the root inode lock held which
+ * serializes against the write based add and remove paths.
+ */
+static int bm_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct binfmt_misc_entry *e = d_inode(dentry)->i_private;
+
+	if (!e)
+		return -EPERM;
+
+	unlink_binfmt_handler(i_binfmt_misc(dir), e);
+	return simple_unlink(dir, dentry);
+}
+
+static const struct inode_operations bm_dir_inode_operations = {
+	.lookup		= simple_lookup,
+	.unlink		= bm_unlink,
+};
+
 /* /<entry> */
 
 static int bm_entry_open(struct inode *inode, struct file *file)
@@ -966,9 +998,12 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 	WRITE_ONCE(misc->enabled, true);
 
 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
-	if (!err)
-		sb->s_op = &bm_super_ops;
-	return err;
+	if (err)
+		return err;
+
+	sb->s_op = &bm_super_ops;
+	d_inode(sb->s_root)->i_op = &bm_dir_inode_operations;
+	return 0;
 }
 
 static void bm_free(struct fs_context *fc)

-- 
2.53.0

