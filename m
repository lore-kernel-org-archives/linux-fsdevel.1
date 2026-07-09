Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94D3233F4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636225; cv=none; b=NgfUfe7flVQAz7FZMjR/BOJ5ngNLhKAIiLeIZG92W+qh2vPrGrgi2oW+hpkSy8Qhsoj5mL8kkOmWx8ynrYeBa9Wdz04pBLyRuqYqNvNxfv/wMHvs7wiSamJ/Wbq4JMzUhikYAgRCKe6ri0xv1PqgIj+GPo9hnFLVTIwf+YYBLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636225; c=relaxed/simple;
	bh=/namHj7AAAPs1Rc/Lq8mW/GtxxQeDFBTlQUn0UHq3RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5XKmxqt2Vmlh7KPkUwFY8oRY57nIN4pjZpZ3IxkAHL4MbTun8m3c8k9soKFrZR83CqGGU/9FnoGS0JF33aosWISgi25yxI4TeX7AL1j8Ik0GtbN8hPPgU+XNYk31T1o44wi1ZKHCYzM4DgGQ2OSZWo4FiaMd28hZkdfi7cuzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV4V4NHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV4V4NHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BAA1F00A3D;
	Thu,  9 Jul 2026 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636224;
	bh=pldXDPPLydih2vs5vP2jfMLMsZXXHWIISdyJZRPePC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YV4V4NHUr7+EODbMN60ycetPuFLm6BecVcbL1Fk3wH15OATqSu8nbzMxmynKPHfnl
	 Dmp2D9Q8we0KbTL1aIojx+/k6yeau35zMzibriJqzkFXWQrazwbHUi8xGDS8BxXqoD
	 BhKr3TjNOiDxiQSshmBzfKrO4VEqHu3oGi3qsPCII+iy0ck61ivZb6jZPLFioIAr9U
	 bMib3Ct3pgIfFgBPGLsfxicBtWAh0YqRIaKH9PRL5jJeztIqhJ3xhFBCOaMmtRJkXO
	 lEmBX6mgdc/D1BKUm2B15KGrkB0BMbGK/uzzuR30oTA9iZHBNVC6X25+gjFNfMEOM4
	 VKmBeOfjqNw+w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:29:59 +0200
Subject: [PATCH v2 04/23] binfmt_misc: use RCU for the handler lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-4-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=9608; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/namHj7AAAPs1Rc/Lq8mW/GtxxQeDFBTlQUn0UHq3RU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHz9vXqKm+cu669p1dJeZrlTuL5+T4764Pumue7SE
 dfwj1zfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyuZThf85yx9A5qQGfZfbu
 +b52KuNfjetdzLlHnh6W7cnK2/5bvYThn+a8429CfmQHnQpQ+1nU9PqE+bOkrVM0ywVsNkvwC8+
 dzwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Once binfmt_misc is loaded load_misc_binary() runs for every execve()
on the system since binfmt_misc registers at the head of the formats
list. Every exec therefore performs read_lock() and read_unlock() on
the entries_lock of the relevant binfmt_misc instance, i.e., two
atomic read-modify-writes on a shared cacheline. User namespaces
without their own binfmt_misc mount fall back to an ancestor's
instance so on container-heavy systems every exec on the machine
typically ends up hammering the cacheline of init_binfmt_misc. On
PREEMPT_RT the rwlock additionally turns the handler lookup into a
sleeping lock on the exec fast path.

The lock protects very little. Entries are immutable after publication
except for the Enabled bit which is already toggled locklessly via
set_bit()/clear_bit() and entry lifetime is already handled by the
users refcount via get_binfmt_handler()/put_binfmt_handler(). The read
lock's only remaining job is to make "the entry is still linked" and
"take a reference" atomic with respect to the unlink sites.

Switch the lookup to an RCU walk:

* Lookup walks the entry list under rcu_read_lock() and acquires a
  reference via refcount_inc_not_zero(). The refcount can only drop to
  zero after an entry has been unlinked so a failed increment means
  the walk raced with an unlink. Restarting the search is bounded
  because an unlinked entry cannot be found again.

* The unlink sites use hlist_del_init_rcu() which keeps the forward
  pointer intact for concurrent walkers and preserves hlist_unhashed()
  as the protection against double removal.

* The final put frees the entry via kfree_rcu() as a concurrent walker
  may still dereference its flags, magic, mask, and inline strings.
  They all live in the entry allocation itself and thus stay valid
  until a grace period has elapsed. Closing the interpreter file stays
  synchronous. It is only used with a reference already held and all
  final puts run in process context.

* Writers remain serialized by the inode lock of the root dentry with
  one exception. bm_evict_inode() called from generic_shutdown_super()
  during umount unlinks entries without holding it. Keep a spinlock
  around the unlink sites instead of relying on superblock lifetime
  rules to make that exclusion implicit.

Handler removal semantics are unchanged. An exec that acquired a
reference just before its handler was unregistered already completes
with the removed handler today. The read lock never protected against
that, it only made the window smaller.

With this an exec that matches no binfmt_misc entry, the common case,
no longer writes to any shared cacheline at all.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c        | 59 +++++++++++++++++++++++++++++--------------------
 include/linux/binfmts.h |  2 +-
 kernel/user.c           |  2 +-
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ab7dbd898977..08fd7991d4c8 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -24,6 +24,7 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/rculist.h>
 #include <linux/fs_context.h>
 #include <linux/syscalls.h>
 #include <linux/fs.h>
@@ -59,6 +60,7 @@ typedef struct {
 	struct dentry *dentry;
 	struct file *interp_file;
 	refcount_t users;		/* sync removal with load_misc_binary() */
+	struct rcu_head rcu;
 } Node;
 
 static struct file_system_type bm_fs_type;
@@ -86,6 +88,8 @@ static struct file_system_type bm_fs_type;
  * Search for a binary type handler for @bprm in the list of registered binary
  * type handlers.
  *
+ * The caller must hold the RCU read lock.
+ *
  * Return: binary type list entry on success, NULL on failure
  */
 static Node *search_binfmt_handler(struct binfmt_misc *misc,
@@ -95,7 +99,7 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
 	Node *e;
 
 	/* Walk all the registered handlers. */
-	hlist_for_each_entry(e, &misc->entries, node) {
+	hlist_for_each_entry_rcu(e, &misc->entries, node) {
 		char *s;
 		int j;
 
@@ -134,7 +138,10 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
  * @bprm: binary for which we are looking for a handler
  *
  * Try to find a binfmt handler for the binary type. If one is found take a
- * reference to protect against removal via bm_{entry,status}_write().
+ * reference to protect against removal via bm_{entry,status}_write(). The
+ * refcount of an entry can only drop to zero once it has been unlinked and
+ * a restarted search cannot find an unlinked entry again so the retry loop
+ * is bounded.
  *
  * Return: binary type list entry on success, NULL on failure
  */
@@ -143,11 +150,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
 {
 	Node *e;
 
-	read_lock(&misc->entries_lock);
-	e = search_binfmt_handler(misc, bprm);
-	if (e)
-		refcount_inc(&e->users);
-	read_unlock(&misc->entries_lock);
+	guard(rcu)();
+	do {
+		e = search_binfmt_handler(misc, bprm);
+	} while (e && !refcount_inc_not_zero(&e->users));
 	return e;
 }
 
@@ -166,7 +172,8 @@ static void put_binfmt_handler(Node *e)
 			exe_file_allow_write_access(e->interp_file);
 			filp_close(e->interp_file, NULL);
 		}
-		kfree(e);
+		/* Lockless walkers may still dereference this entry. */
+		kfree_rcu(e, rcu);
 	}
 }
 
@@ -675,10 +682,10 @@ static void bm_evict_inode(struct inode *inode)
 		struct binfmt_misc *misc;
 
 		misc = i_binfmt_misc(inode);
-		write_lock(&misc->entries_lock);
+		spin_lock(&misc->entries_lock);
 		if (!hlist_unhashed(&e->node))
-			hlist_del_init(&e->node);
-		write_unlock(&misc->entries_lock);
+			hlist_del_init_rcu(&e->node);
+		spin_unlock(&misc->entries_lock);
 		put_binfmt_handler(e);
 	}
 }
@@ -697,9 +704,9 @@ static void bm_evict_inode(struct inode *inode)
  */
 static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
 {
-	write_lock(&misc->entries_lock);
-	hlist_del_init(&e->node);
-	write_unlock(&misc->entries_lock);
+	spin_lock(&misc->entries_lock);
+	hlist_del_init_rcu(&e->node);
+	spin_unlock(&misc->entries_lock);
 	locked_recursive_removal(e->dentry, NULL);
 }
 
@@ -750,9 +757,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		 * via bm_{entry,register,status}_write() inode_lock() on the
 		 * root inode must be held.
 		 * The lock is exclusive ensuring that the list can't be
-		 * modified. Only load_misc_binary() can access but does so
-		 * read-only. So we only need to take the write lock when we
-		 * actually remove the entry from the list.
+		 * modified. Only load_misc_binary() can access the list
+		 * concurrently and it does so under RCU. So entries_lock only
+		 * needs to be held when an entry is actually unlinked to
+		 * serialize against bm_evict_inode() during umount which
+		 * unlinks without holding inode_lock.
 		 */
 		if (!hlist_unhashed(&e->node))
 			remove_binfmt_handler(i_binfmt_misc(inode), e);
@@ -797,9 +806,9 @@ static int add_entry(Node *e, struct super_block *sb)
 
 	d_make_persistent(dentry, inode);
 	misc = i_binfmt_misc(inode);
-	write_lock(&misc->entries_lock);
-	hlist_add_head(&e->node, &misc->entries);
-	write_unlock(&misc->entries_lock);
+	spin_lock(&misc->entries_lock);
+	hlist_add_head_rcu(&e->node, &misc->entries);
+	spin_unlock(&misc->entries_lock);
 	simple_done_creating(dentry);
 	return 0;
 }
@@ -895,9 +904,11 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		 * via bm_{entry,register,status}_write() inode_lock() on the
 		 * root inode must be held.
 		 * The lock is exclusive ensuring that the list can't be
-		 * modified. Only load_misc_binary() can access but does so
-		 * read-only. So we only need to take the write lock when we
-		 * actually remove the entry from the list.
+		 * modified. Only load_misc_binary() can access the list
+		 * concurrently and it does so under RCU. So entries_lock only
+		 * needs to be held when an entry is actually unlinked to
+		 * serialize against bm_evict_inode() during umount which
+		 * unlinks without holding inode_lock.
 		 */
 		hlist_for_each_entry_safe(e, next, &misc->entries, node)
 			remove_binfmt_handler(misc, e);
@@ -975,7 +986,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 			return -ENOMEM;
 
 		INIT_HLIST_HEAD(&misc->entries);
-		rwlock_init(&misc->entries_lock);
+		spin_lock_init(&misc->entries_lock);
 
 		/* Pairs with smp_load_acquire() in load_binfmt_misc(). */
 		smp_store_release(&user_ns->binfmt_misc, misc);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 071da63f2b48..7e7333b7bb0f 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -102,7 +102,7 @@ struct linux_binfmt {
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 struct binfmt_misc {
 	struct hlist_head entries;
-	rwlock_t entries_lock;
+	spinlock_t entries_lock;
 	bool enabled;
 } __randomize_layout;
 
diff --git a/kernel/user.c b/kernel/user.c
index c6a2bfb4d918..21bafdc11379 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -25,7 +25,7 @@
 struct binfmt_misc init_binfmt_misc = {
 	.entries = HLIST_HEAD_INIT,
 	.enabled = true,
-	.entries_lock = __RW_LOCK_UNLOCKED(init_binfmt_misc.entries_lock),
+	.entries_lock = __SPIN_LOCK_UNLOCKED(init_binfmt_misc.entries_lock),
 };
 EXPORT_SYMBOL_GPL(init_binfmt_misc);
 #endif

-- 
2.53.0

