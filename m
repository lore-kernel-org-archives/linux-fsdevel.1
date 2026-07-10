Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2463F7877
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676010; cv=none; b=Mf5thpXrycLGiwYxhwiLoM6IO3MWglJAcPo4u+Vlk3RQYrlTuJwCgEQcYtvaUdlllJ8de5adyKjTdophObcPJ5+ynZ5WKQ0z8j71OrcxS8OGsKfELHyRBkioCrVvgH+xUbywWUPsVJ3A5XEHtC2ZaxI/C5bSvGTFbW2tb0bfhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676010; c=relaxed/simple;
	bh=5fDg4FRHGjOzb4Oq1vmjh5/iD5qe0IA0aJXniqKPh7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7Ej+Y1hkPL936fxf0nRgi4jCTmkJ2XJrVBx0qs4osmtri3dcC3WJGB7Cduu9oZBspRfleEf0MXhAOMH/7yPcP49g2Cx86Ax8zebp+anBiTucwCqb0qdTVw/Qddh4NYsqr+M/V4oBr0D/nB+7KWBnpjJCm7KBsd/fzSSdvXg1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kle6o5z1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kle6o5z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB38C1F000E9;
	Fri, 10 Jul 2026 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676009;
	bh=zHZbonjleyir4US03XvVFpkPPdCeIkxBX4Jq3eCRCy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kle6o5z16bvxOO0JAheBnkUMZzXuI19kyZHAu5ukPVfeksKZQVihIR3Qo1q9XWH5/
	 5FgjIlZmBVM3KNZkVigjM+awEKd1XL20zph4YJ/PZslpc1ewtQr1QxIhE3KdKTEwyk
	 NVm8Hcw2E84apAbK7QCOP9s5CXvUSoI9kfiOCZijpmHeKAHPqRd5+HoW2N+hXLMFvV
	 VnQuHjraMlRIPJQwaK7OES1Q8Ia6Xcn15SOto5hq/TYaqWLcXivfW1Rc0+A+xYMw1G
	 H0vxPdJIifz3698fyNmwExe7olakremOyNOOET8sO1Jew0fgv2DhU9tiGNWiPT37Yx
	 8KofCmiuonxZw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:05 +0200
Subject: [PATCH v3 04/24] binfmt_misc: convert entry list to an hlist
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-4-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5590; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5fDg4FRHGjOzb4Oq1vmjh5/iD5qe0IA0aJXniqKPh7c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Il7qqSxVEyMxS5LWdlMM3rviqBdjq1NqiuPM6+bE
 3jkSdL5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkoxjIyXH4qe1Mq7P2E6W3M
 k4x3n3duKJ66vlFbfU/Yj43rFv6atIDhv2u3A/e6l8yn/GWqGk30s5e9sjixlrNj7qbH37dLJ20
 /wQIA
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
index b7664d90eb8f..89da2d4e7f91 100644
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
 
@@ -666,8 +666,8 @@ static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
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
@@ -680,8 +680,8 @@ static void bm_evict_inode(struct inode *inode)
 
 		misc = i_binfmt_misc(inode);
 		write_lock(&misc->entries_lock);
-		if (!list_empty(&e->list))
-			list_del_init(&e->list);
+		if (!hlist_unhashed(&e->node))
+			hlist_del_init(&e->node);
 		write_unlock(&misc->entries_lock);
 		put_binfmt_handler(e);
 	}
@@ -702,7 +702,7 @@ static void bm_evict_inode(struct inode *inode)
 static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
 {
 	write_lock(&misc->entries_lock);
-	list_del_init(&e->list);
+	hlist_del_init(&e->node);
 	write_unlock(&misc->entries_lock);
 	locked_recursive_removal(e->dentry, NULL);
 }
@@ -758,7 +758,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		 * read-only. So we only need to take the write lock when we
 		 * actually remove the entry from the list.
 		 */
-		if (!list_empty(&e->list))
+		if (!hlist_unhashed(&e->node))
 			remove_binfmt_handler(i_binfmt_misc(inode), e);
 
 		inode_unlock(inode);
@@ -802,7 +802,7 @@ static int add_entry(Node *e, struct super_block *sb)
 	d_make_persistent(dentry, inode);
 	misc = i_binfmt_misc(inode);
 	write_lock(&misc->entries_lock);
-	list_add(&e->list, &misc->entries);
+	hlist_add_head(&e->node, &misc->entries);
 	write_unlock(&misc->entries_lock);
 	simple_done_creating(dentry);
 	return 0;
@@ -875,8 +875,9 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 {
 	struct binfmt_misc *misc;
 	int res = parse_command(buffer, count);
-	Node *e, *next;
+	struct hlist_node *next;
 	struct inode *inode;
+	Node *e;
 
 	misc = i_binfmt_misc(file_inode(file));
 	switch (res) {
@@ -902,7 +903,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		 * read-only. So we only need to take the write lock when we
 		 * actually remove the entry from the list.
 		 */
-		list_for_each_entry_safe(e, next, &misc->entries, list)
+		hlist_for_each_entry_safe(e, next, &misc->entries, node)
 			remove_binfmt_handler(misc, e);
 
 		inode_unlock(inode);
@@ -977,7 +978,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
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

