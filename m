Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6E43803B
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529495; cv=none; b=p2pycrjQp1AFAk6TNz+4u8PF0Q8aMvC/v1c6QtsnAaFFe+nca5p5kVz+ZP27ZBMTUKAclznpDWUHcS7jyTaspvUaYQob1T1UlwHUMqib/n5AUWyGKdM45yWLlXikWLbFoIeV0mmnvUOzUbJ81xWUSz8IoHvHYfhXwM8e2xq92dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529495; c=relaxed/simple;
	bh=X0EU2UC5Y9DLFeHVUkJgmE4dCHVzlmnJvafWhW201lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PU2XKQA8JK0e5WHxA9U6CXvvQDb+RGSarnDEIoCw6QaTLFZD3Igg2y38cMe4wYr5zsjZzwhbSWVZz9pZlAp1GXeTTk/j8NpEzhEL98yvZR92q4tNbzMDnf6DttUaJC9y+Ulk4Ki6aITF4ruAExtpylTxXj2BME/EpI/sXtrPnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/ZiWM1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/ZiWM1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFE81F000E9;
	Wed,  8 Jul 2026 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783529483;
	bh=HsdUs2oQHzftlWYJg+Bmq2Ixgz8LnH+wE6QNo+txWmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i/ZiWM1nJAKt8SJ2wPnCnSqfljWd2jEfI71ZBHagXqsi+aDmlpKCZVMVVQVdjqffp
	 b7ILvV1iH+lJSynRiIU5/puuWx10YmqC+c3fA1fliaJsB4YDA0Ky4601gHYZSOQjK0
	 ch24lxr55mldMgun2ita/lpo9Fu+FEfyGXpuv8rAPu+ZP+7vCnEt9yAHu9iDh1eppH
	 58Sa4Llq8z2oRMnzRY6hCbOsKbxlU6rz3QJDI8hvO80tN3Aglscafm1kcrQFc63q5X
	 4bOzavImVl31TynuaxEiM5jIgGt2r5QMi3zizlQvG2bP4Ewy1BTSjqveejDsiDoFGT
	 e6BXIZoDy7kcw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 08 Jul 2026 18:51:16 +0200
Subject: [PATCH 1/3] binfmt_misc: convert entry list to an hlist
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-work-binfmt_misc-locking-v1-1-a009dd5b56db@kernel.org>
References: <20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org>
In-Reply-To: <20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5590; i=brauner@kernel.org;
 h=from:subject:message-id; bh=X0EU2UC5Y9DLFeHVUkJgmE4dCHVzlmnJvafWhW201lE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5NbDvPeNzkaX3kPgVviOp0ibSG6y57E3TuNctzlK5p
 /SSa+7PjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0CDH8s/TSeRnx3/ZgrAez
 Avvj67wnP29IKJF2zmb3blcMzxVqYPgfKLXZ/8rP18u25M4XYJAKvZxQdeXpO/Wa6WuX21cq5Mk
 xAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The upcoming conversion of the handler lookup to RCU walks cannot use
list_del_init(): reinitializing the forward pointer of a removed entry
would make a concurrent lockless walker standing on that entry loop
back onto it indefinitely. The removal paths do rely on
reinitialization though because bm_{entry,status}_write() and
bm_evict_inode() need to detect whether an entry has already been
unlinked.

hlists support exactly this pattern: hlist_del_init_rcu() keeps the
forward pointer of the removed entry intact for concurrent walkers and
only zeroes ->pprev with hlist_unhashed() serving as the linked test.

Convert the entry list to an hlist now while keeping the rwlock so the
subsequent RCU conversion is a pure locking change. hlist_add_head()
inserts at the head just as list_add() did so lookup precedence
between registered handlers is unchanged.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c        | 25 +++++++++++++------------
 include/linux/binfmts.h |  2 +-
 kernel/user.c           |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 84349fcb93f1..34de1b01e9c2 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -48,7 +48,7 @@ enum {Enabled, Magic};
 #define MISC_FMT_OPEN_FILE (1UL << 28)
 
 typedef struct {
-	struct list_head list;
+	struct hlist_node node;
 	unsigned long flags;		/* type, status, etc. */
 	int offset;			/* offset of magic */
 	int size;			/* size of magic/mask */
@@ -95,7 +95,7 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
 	Node *e;
 
 	/* Walk all the registered handlers. */
-	list_for_each_entry(e, &misc->entries, list) {
+	hlist_for_each_entry(e, &misc->entries, node) {
 		char *s;
 		int j;
 
@@ -654,8 +654,8 @@ static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
  *
  * If the ->evict call was not caused by a super block shutdown but by a write
  * to remove the entry or all entries via bm_{entry,status}_write() the entry
- * will have already been removed from the list. We keep the list_empty() check
- * to make that explicit.
+ * will have already been removed from the list. We keep the hlist_unhashed()
+ * check to make that explicit.
 */
 static void bm_evict_inode(struct inode *inode)
 {
@@ -668,8 +668,8 @@ static void bm_evict_inode(struct inode *inode)
 
 		misc = i_binfmt_misc(inode);
 		write_lock(&misc->entries_lock);
-		if (!list_empty(&e->list))
-			list_del_init(&e->list);
+		if (!hlist_unhashed(&e->node))
+			hlist_del_init(&e->node);
 		write_unlock(&misc->entries_lock);
 		put_binfmt_handler(e);
 	}
@@ -690,7 +690,7 @@ static void bm_evict_inode(struct inode *inode)
 static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
 {
 	write_lock(&misc->entries_lock);
-	list_del_init(&e->list);
+	hlist_del_init(&e->node);
 	write_unlock(&misc->entries_lock);
 	locked_recursive_removal(e->dentry, NULL);
 }
@@ -746,7 +746,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		 * read-only. So we only need to take the write lock when we
 		 * actually remove the entry from the list.
 		 */
-		if (!list_empty(&e->list))
+		if (!hlist_unhashed(&e->node))
 			remove_binfmt_handler(i_binfmt_misc(inode), e);
 
 		inode_unlock(inode);
@@ -790,7 +790,7 @@ static int add_entry(Node *e, struct super_block *sb)
 	d_make_persistent(dentry, inode);
 	misc = i_binfmt_misc(inode);
 	write_lock(&misc->entries_lock);
-	list_add(&e->list, &misc->entries);
+	hlist_add_head(&e->node, &misc->entries);
 	write_unlock(&misc->entries_lock);
 	simple_done_creating(dentry);
 	return 0;
@@ -863,8 +863,9 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 {
 	struct binfmt_misc *misc;
 	int res = parse_command(buffer, count);
-	Node *e, *next;
+	struct hlist_node *next;
 	struct inode *inode;
+	Node *e;
 
 	misc = i_binfmt_misc(file_inode(file));
 	switch (res) {
@@ -890,7 +891,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		 * read-only. So we only need to take the write lock when we
 		 * actually remove the entry from the list.
 		 */
-		list_for_each_entry_safe(e, next, &misc->entries, list)
+		hlist_for_each_entry_safe(e, next, &misc->entries, node)
 			remove_binfmt_handler(misc, e);
 
 		inode_unlock(inode);
@@ -965,7 +966,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!misc)
 			return -ENOMEM;
 
-		INIT_LIST_HEAD(&misc->entries);
+		INIT_HLIST_HEAD(&misc->entries);
 		rwlock_init(&misc->entries_lock);
 
 		/* Pairs with smp_load_acquire() in load_binfmt_misc(). */
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 2c77e383e737..071da63f2b48 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -101,7 +101,7 @@ struct linux_binfmt {
 
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 struct binfmt_misc {
-	struct list_head entries;
+	struct hlist_head entries;
 	rwlock_t entries_lock;
 	bool enabled;
 } __randomize_layout;
diff --git a/kernel/user.c b/kernel/user.c
index 7aef4e679a6a..c6a2bfb4d918 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -23,7 +23,7 @@
 
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 struct binfmt_misc init_binfmt_misc = {
-	.entries = LIST_HEAD_INIT(init_binfmt_misc.entries),
+	.entries = HLIST_HEAD_INIT,
 	.enabled = true,
 	.entries_lock = __RW_LOCK_UNLOCKED(init_binfmt_misc.entries_lock),
 };

-- 
2.53.0

