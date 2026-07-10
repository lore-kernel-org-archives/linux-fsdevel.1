Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD03F5BCE
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676035; cv=none; b=uCUBppMCB7KPu/4y3tNZ3KtLIrCylluizPz7Ks+0UhVZRggVvk5kE0nqHuWTIktSsirHowRia/09k/IIsuROfKg2KFmuOqShe8mmA2DQKUoLdp6eZW1TZz32/cBygBRTnpa31hAw1fZsUryohDWAfk20f4lLu4fmacH4/zdtRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676035; c=relaxed/simple;
	bh=s/vomeS/MbQXxph32te55T63SGt/GBU1Mp8VKWLPyDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7gfdyDmrnjJvTXt1w0AW/nGPKkxqjtljx+aaAONck9fR6mPJeglgnnIEa3yx1hu/nwIR43wjvo0T56JH4h0slXf1amJoxr9IqVueXZhZ+hD+H6K3/v656rjXSCw1huseygdj+TfcGnPnYqYrDXyNxallsin4S6a8ZjeQwIbiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1vBN/Up; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1vBN/Up"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8681F00A3A;
	Fri, 10 Jul 2026 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676033;
	bh=7Tggns+9/qGMnyXLSiyftgENXmZkplKbZJHOAgcmZLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q1vBN/UpJ7L4tmzygO9MA0VnSBh9Q88+XnH6Q4F1FGtWXbtV9YxqXgvEsvgPLjfnS
	 928SeLirWQLzvedkvneSIGjypYa1bNOQDsEBP50ASyAXrYHl3hm0ps/mXmPFqZoYfC
	 Z1ilHOd0uYXc0Nq36MEzFNdyHJZAeeVBdwe2jHkAt+wa6iP9jApQQL6Wb/5WSeFivK
	 5UCU+XIsXwvimxsKUcUNTTteN5BbDx5bZPVmy/4pyahQMOh9MauhYlIkeAbJWZzQhI
	 PBpmeBZJIIrJv2Il8cYMNYCrAymJknO2omJjzeTzaL9Kfa7fzL3PACiBEO4gGyAZBD
	 ugt7GO7EU5TRg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:18 +0200
Subject: [PATCH v3 17/24] binfmt_misc: factor out the entry removal
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-17-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5585; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s/vomeS/MbQXxph32te55T63SGt/GBU1Mp8VKWLPyDU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7IkPece/R6l3udbfdq2rMy6eLBNKmfL+m2fUvMrgC
 Y0rd87v6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5HaG/5UrP2VzLFt07+P6
 DDenZ68ZdL6fOnXK0dJ/i/XjokOhjkIM/ywkyorNumeuOnz44nIW77Cc+3XM3IGH5rqe/bBymW2
 sCRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Both write handlers open-code the same removal dance - grab the root
inode lock, unlink, unlock - each carrying a verbatim copy of the
same eleven-line locking comment, and bm_entry_write() reuses its
inode variable for the root inode halfway through to pull it off.
Move the dance into bm_remove_entry() and bm_remove_all_entries()
and the locking rules into the kernel-doc of remove_binfmt_handler()
which both helpers wrap.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 84 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 1f2b1d136819..d6bc2abc4a7f 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -686,11 +686,19 @@ static void bm_evict_inode(struct inode *inode)
  * @e: binary type handler to remove
  *
  * Remove a binary type handler from the list of binary type handlers and
- * remove its associated dentry. This is called from
- * binfmt_{entry,status}_write(). In the future, we might want to think about
- * adding a proper ->unlink() method to binfmt_misc instead of forcing caller's
- * to use writes to files in order to delete binary type handlers. But it has
- * worked for so long that it's not a pressing issue.
+ * remove its associated dentry.
+ *
+ * Adding and removing entries via bm_{entry,register,status}_write()
+ * happens under the exclusively held inode lock of the root dentry keeping
+ * the list stable for writers. load_misc_binary() walks it concurrently
+ * under RCU. The entries_lock is only held around the actual unlink to
+ * serialize against bm_evict_inode() which unlinks entries during umount
+ * without holding the root inode lock.
+ *
+ * In the future, we might want to think about adding a proper ->unlink()
+ * method to binfmt_misc instead of forcing callers to use writes to files
+ * in order to delete binary type handlers. But it has worked for so long
+ * that it's not a pressing issue.
  */
 static void remove_binfmt_handler(struct binfmt_misc *misc,
 				  struct binfmt_misc_entry *e)
@@ -701,6 +709,31 @@ static void remove_binfmt_handler(struct binfmt_misc *misc,
 	locked_recursive_removal(e->dentry, NULL);
 }
 
+/* Remove @e unless a concurrent write already unlinked it. */
+static void bm_remove_entry(struct binfmt_misc_entry *e, struct super_block *sb)
+{
+	struct inode *root = d_inode(sb->s_root);
+
+	inode_lock_nested(root, I_MUTEX_PARENT);
+	if (!hlist_unhashed(&e->node))
+		remove_binfmt_handler(i_binfmt_misc(root), e);
+	inode_unlock(root);
+}
+
+/* Remove all entries of the binfmt_misc instance @misc belonging to @sb. */
+static void bm_remove_all_entries(struct binfmt_misc *misc,
+				  struct super_block *sb)
+{
+	struct inode *root = d_inode(sb->s_root);
+	struct binfmt_misc_entry *e;
+	struct hlist_node *next;
+
+	inode_lock_nested(root, I_MUTEX_PARENT);
+	hlist_for_each_entry_safe(e, next, &misc->entries, node)
+		remove_binfmt_handler(misc, e);
+	inode_unlock(root);
+}
+
 /* /<entry> */
 
 static int bm_entry_open(struct inode *inode, struct file *file)
@@ -732,24 +765,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
 		break;
 	case BM_CMD_REMOVE:
-		inode = d_inode(inode->i_sb->s_root);
-		inode_lock_nested(inode, I_MUTEX_PARENT);
-
-		/*
-		 * In order to add new element or remove elements from the list
-		 * via bm_{entry,register,status}_write() inode_lock() on the
-		 * root inode must be held.
-		 * The lock is exclusive ensuring that the list can't be
-		 * modified. Only load_misc_binary() can access the list
-		 * concurrently and it does so under RCU. So entries_lock only
-		 * needs to be held when an entry is actually unlinked to
-		 * serialize against bm_evict_inode() during umount which
-		 * unlinks without holding inode_lock.
-		 */
-		if (!hlist_unhashed(&e->node))
-			remove_binfmt_handler(i_binfmt_misc(inode), e);
-
-		inode_unlock(inode);
+		bm_remove_entry(e, inode->i_sb);
 		break;
 	default:
 		return res;
@@ -865,9 +881,6 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 {
 	struct binfmt_misc *misc;
 	int res = parse_command(buffer, count);
-	struct hlist_node *next;
-	struct inode *inode;
-	struct binfmt_misc_entry *e;
 
 	misc = i_binfmt_misc(file_inode(file));
 	switch (res) {
@@ -878,24 +891,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		WRITE_ONCE(misc->enabled, true);
 		break;
 	case BM_CMD_REMOVE:
-		inode = d_inode(file_inode(file)->i_sb->s_root);
-		inode_lock_nested(inode, I_MUTEX_PARENT);
-
-		/*
-		 * In order to add new element or remove elements from the list
-		 * via bm_{entry,register,status}_write() inode_lock() on the
-		 * root inode must be held.
-		 * The lock is exclusive ensuring that the list can't be
-		 * modified. Only load_misc_binary() can access the list
-		 * concurrently and it does so under RCU. So entries_lock only
-		 * needs to be held when an entry is actually unlinked to
-		 * serialize against bm_evict_inode() during umount which
-		 * unlinks without holding inode_lock.
-		 */
-		hlist_for_each_entry_safe(e, next, &misc->entries, node)
-			remove_binfmt_handler(misc, e);
-
-		inode_unlock(inode);
+		bm_remove_all_entries(misc, file_inode(file)->i_sb);
 		break;
 	default:
 		return res;

-- 
2.53.0

