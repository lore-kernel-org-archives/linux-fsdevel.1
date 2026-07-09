Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AF1A9FA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636249; cv=none; b=PnjGEkmEAIpRBVvM2tpiaftm+/Mdit7tpS4I/hUGYTudcHEPsh8q0LE7djDqy9M8ByvCiX0zhOukE6QpfnCvMUMq/x0fRUDGL4iuZW3+6inCyOpPiICr/brv/yNSYYtpmygZTRH6/HOdjG1sI5nDlBZ9xt9LWBb9lhE4ja4spRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636249; c=relaxed/simple;
	bh=cyHkmmDfiEKgpVxkufJ06j5rYo5ZpvYalwvx7n/HkSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMZTrXGihyGhwJrbqeuZwbwgcAzzTXiRi7nxytBTrKuTwQDzpsa7C8Voc8OkG2jpo5t216d6iOowl2W3VSL4dfJZN1o1Vt93sdDDDWYVqy2nwOTum37R0lZQRY+fFbv064YyQos8Nrszyo0j+gFIO3u3Uwl8rfNfW+IfultCfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvLHDCTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvLHDCTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B41F00A3D;
	Thu,  9 Jul 2026 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636248;
	bh=o//3Wih6kSQ9SPV0MLA8r8h1Tfx37FGOuDRdL1ZjK3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SvLHDCTF++3dv2LSDQOuRo6G5cYBywHSVMKtjT/VYmM/luH3NY4oeFevsYUMN6WEt
	 +f3/Py91jcpK+2wdjxOBjzJymZMJ5289+woOYPXsMORHTybuHJvu82MDDEAEbYYeuJ
	 1pp7gOE8+C9/RNhJwKXUOjOpA9d0YPDF9hAUtdUfYjBOKvSlYJcjmOmN+3tCwdU1CR
	 zHQ64AfGxE+0mpI87PX0NgwW4AsmRxx16E0K14zIt25qwMK9ScQzUjS/HnHeYJ1Q4a
	 Ww1At403wkoaKjoVBztB3pxGuo5R1CVOQj6YaPxtezEPIzD3PwcrcrL6CUKczIzX8j
	 yTQyoWtnJvsaw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:11 +0200
Subject: [PATCH v2 16/23] binfmt_misc: factor out the entry removal
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-16-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5585; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cyHkmmDfiEKgpVxkufJ06j5rYo5ZpvYalwvx7n/HkSE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHxbfXMZx3vxnhpjzQlPpJMEQ+tbL2ZEM8qeCz2TE
 RkgGb2xo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJr3jD84V60d95fqae516QZ
 r9XonTj52UVuR/aj5Wbvz0v6qn708mBkWPQ0IPBP+7FjXzvjee8bn7j8S+3NnXdiRT9+NL7+nSf
 XygAA
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
index 83f84934d57c..4267f66128c4 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -682,11 +682,19 @@ static void bm_evict_inode(struct inode *inode)
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
@@ -697,6 +705,31 @@ static void remove_binfmt_handler(struct binfmt_misc *misc,
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
@@ -728,24 +761,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
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
@@ -861,9 +877,6 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 {
 	struct binfmt_misc *misc;
 	int res = parse_command(buffer, count);
-	struct hlist_node *next;
-	struct inode *inode;
-	struct binfmt_misc_entry *e;
 
 	misc = i_binfmt_misc(file_inode(file));
 	switch (res) {
@@ -874,24 +887,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
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

