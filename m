Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044564825DB;
	Mon, 21 Sep 2026 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988146; cv=none; b=BCHSN5rOjve1fFH9UlljQp2XzUfhhVy8Er9c3+o/LU8UgBueB37VNdsZgWH3D+4CVxDiebNy/y6W//dpcYA6Tpotpbd4c2Xg2sJUH6dU7num/QGuKGnrDqybAajuAKw/oBEV81yk/eaFaztheDzij9YuOW+fw6j1nUA+Nue5GfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988146; c=relaxed/simple;
	bh=LdcQiQl81BRUFzpQHKHOia0MgssJ6qnirzJpzHwoU/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgukyMyXKkbQjInT6icLkvsodgBDAXYu5LHlUN+AsOFCQq3jkEzNY66gBmSGN532aRQgJlj1+z1dXXprsS7RkIdfvlPdZVCnOm7Z3X5FwqG8NUyGHtKrQoxd4N2VDgSyZIzLGqKjfghbVN3lXoJE05VpiG/w/IPEcCK6CVEWqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKXktkLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKXktkLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC0A1F00893;
	Mon, 21 Sep 2026 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988143;
	bh=5KAq1qQJkKfrEAH9W82Sgm7oMlioE3hwh5IBDMHyP9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nKXktkLFSOw6dnBlr+gZII6UxyRZkLcFiZYq7P8fWjmeIcAD2oLXYn/uEn+bNv2/J
	 kEkNR8kHrgT0G+r3+XlHvHiRe+gzT48TlsGaQirIDp2fMzf5FwKikuAMa8PCLC6otD
	 ZlerfdKoNsHNRA5MpBSBOxH7efJkMCw1yP6Tk0ndRQBgDDmuglxus8NyaK6cgHlJtq
	 tHVuS2rbCVbXMSJ8YploNqo/Q6xSHvQKe6qSq9I3f+7EwSU7lUrYbDcQ2o7Dse9w+e
	 Wc4yzPgSTbp6xcJHGCJ7DLVxp2ZvRBFKvZIzycqnQxVtAFcd4SCtlekdsg9JLEYDMO
	 Zl3gtSY9Y0R5Q==
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/6] proc: sysctl: address table entries by index
Date: Mon, 21 Sep 2026 12:54:48 +0200
Message-ID: <083fea8fc2eecad8c33e922231f8f9886bcb9be9.1789987960.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789987960.git.legion@kernel.org>
References: <cover.1789987960.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_sysctl keeps pointers to ctl_table entries in several lookup and
inode paths. That makes it hard to support alternative descriptor
formats because the tree logic assumes that every registered entry
already is a ctl_table object.

Store the entry index in proc inodes and pass header/index pairs through
the lookup, iteration and permission paths instead. The existing
ctl_table entries are still used for all handler, permission and poll
operations, but the core no longer needs to carry a direct ctl_table
pointer through every internal path.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/inode.c       |   2 +-
 fs/proc/internal.h    |   2 +-
 fs/proc/proc_sysctl.c | 330 ++++++++++++++++++++++++------------------
 3 files changed, 194 insertions(+), 140 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b7634f975d98..c735338ecc8d 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -62,7 +62,7 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 	ei->op.proc_get_link = NULL;
 	ei->pde = NULL;
 	ei->sysctl = NULL;
-	ei->sysctl_entry = NULL;
+	ei->sysctl_entry_idx = 0;
 	INIT_HLIST_NODE(&ei->sibling_inodes);
 	ei->ns_ops = NULL;
 	return &ei->vfs_inode;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 04bd6c9e65a7..7fc730b0d7ab 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -123,7 +123,7 @@ struct proc_inode {
 	union proc_op op;
 	struct proc_dir_entry *pde;
 	struct ctl_table_header *sysctl;
-	const struct ctl_table *sysctl_entry;
+	size_t sysctl_entry_idx;
 	struct hlist_node sibling_inodes;
 	const struct proc_ns_operations *ns_ops;
 	struct inode vfs_inode;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 04a382178c65..b5cb219bcdbc 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -20,9 +20,8 @@
 #include <linux/lockdep.h>
 #include "internal.h"
 
-#define list_for_each_table_entry(entry, header)	\
-	entry = header->ctl_table;			\
-	for (size_t i = 0 ; i < header->ctl_table_size; ++i, entry++)
+#define list_for_each_table_entry(index, header)			\
+	for (size_t index = 0; index < (header)->ctl_table_size; index++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
@@ -88,16 +87,39 @@ static struct ctl_table_root sysctl_table_root = {
 static DEFINE_SPINLOCK(sysctl_lock);
 
 static void drop_sysctl_table(struct ctl_table_header *header);
-static int sysctl_follow_link(struct ctl_table_header **phead,
-	const struct ctl_table **pentry);
+static int sysctl_follow_link(struct ctl_table_header **phead, size_t *pindex);
 static int insert_links(struct ctl_table_header *head);
 static void put_links(struct ctl_table_header *header);
 
+static const char *sysctl_entry_procname(struct ctl_table_header *head,
+					 size_t index)
+{
+	return head->ctl_table[index].procname;
+}
+
+static umode_t sysctl_entry_mode(struct ctl_table_header *head, size_t index)
+{
+	return head->ctl_table[index].mode;
+}
+
+static struct ctl_table_poll *sysctl_entry_poll(struct ctl_table_header *head,
+						size_t index)
+{
+	return head->ctl_table[index].poll;
+}
+
+static const struct ctl_table *
+sysctl_entry_table(struct ctl_table_header *head, size_t index,
+		   struct ctl_table *table)
+{
+	return &head->ctl_table[index];
+}
+
 static void sysctl_print_dir(struct ctl_dir *dir)
 {
 	if (dir->header.parent)
 		sysctl_print_dir(dir->header.parent);
-	pr_cont("%s/", dir->header.ctl_table[0].procname);
+	pr_cont("%s/", sysctl_entry_procname(&dir->header, 0));
 }
 
 static int namecmp(const char *name1, int len1, const char *name2, int len2)
@@ -110,11 +132,10 @@ static int namecmp(const char *name1, int len1, const char *name2, int len2)
 	return cmp;
 }
 
-static const struct ctl_table *find_entry(struct ctl_table_header **phead,
-	struct ctl_dir *dir, const char *name, int namelen)
+static bool find_entry(struct ctl_table_header **phead, size_t *pindex,
+		       struct ctl_dir *dir, const char *name, int namelen)
 {
 	struct ctl_table_header *head;
-	const struct ctl_table *entry;
 	struct rb_node *node = dir->root.rb_node;
 
 	lockdep_assert_held(&sysctl_lock);
@@ -127,8 +148,8 @@ static const struct ctl_table *find_entry(struct ctl_table_header **phead,
 
 		ctl_node = rb_entry(node, struct ctl_node, node);
 		head = ctl_node->header;
-		entry = &head->ctl_table[ctl_node - head->node];
-		procname = entry->procname;
+		*pindex = ctl_node - head->node;
+		procname = sysctl_entry_procname(head, *pindex);
 
 		cmp = namecmp(name, namelen, procname, strlen(procname));
 		if (cmp < 0)
@@ -137,32 +158,32 @@ static const struct ctl_table *find_entry(struct ctl_table_header **phead,
 			node = node->rb_right;
 		else {
 			*phead = head;
-			return entry;
+			return true;
 		}
 	}
-	return NULL;
+	return false;
 }
 
-static int insert_entry(struct ctl_table_header *head, const struct ctl_table *entry)
+static int insert_entry(struct ctl_table_header *head, size_t index)
 {
-	struct rb_node *node = &head->node[entry - head->ctl_table].node;
+	struct rb_node *node = &head->node[index].node;
 	struct rb_node **p = &head->parent->root.rb_node;
 	struct rb_node *parent = NULL;
-	const char *name = entry->procname;
+	const char *name = sysctl_entry_procname(head, index);
 	int namelen = strlen(name);
 
 	while (*p) {
 		struct ctl_table_header *parent_head;
-		const struct ctl_table *parent_entry;
 		struct ctl_node *parent_node;
 		const char *parent_name;
+		size_t parent_index;
 		int cmp;
 
 		parent = *p;
 		parent_node = rb_entry(parent, struct ctl_node, node);
 		parent_head = parent_node->header;
-		parent_entry = &parent_head->ctl_table[parent_node - parent_head->node];
-		parent_name = parent_entry->procname;
+		parent_index = parent_node - parent_head->node;
+		parent_name = sysctl_entry_procname(parent_head, parent_index);
 
 		cmp = namecmp(name, namelen, parent_name, strlen(parent_name));
 		if (cmp < 0)
@@ -172,7 +193,7 @@ static int insert_entry(struct ctl_table_header *head, const struct ctl_table *e
 		else {
 			pr_err("sysctl duplicate entry: ");
 			sysctl_print_dir(head->parent);
-			pr_cont("%s\n", entry->procname);
+			pr_cont("%s\n", name);
 			return -EEXIST;
 		}
 	}
@@ -182,9 +203,9 @@ static int insert_entry(struct ctl_table_header *head, const struct ctl_table *e
 	return 0;
 }
 
-static void erase_entry(struct ctl_table_header *head, const struct ctl_table *entry)
+static void erase_entry(struct ctl_table_header *head, size_t index)
 {
-	struct rb_node *node = &head->node[entry - head->ctl_table].node;
+	struct rb_node *node = &head->node[index].node;
 
 	rb_erase(node, &head->parent->root);
 }
@@ -206,9 +227,7 @@ static void init_header(struct ctl_table_header *head,
 	head->node = node;
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
-		const struct ctl_table *entry;
-
-		list_for_each_table_entry(entry, head) {
+		list_for_each_table_entry(index, head) {
 			node->header = head;
 			node++;
 		}
@@ -219,15 +238,12 @@ static void init_header(struct ctl_table_header *head,
 
 static void erase_header(struct ctl_table_header *head)
 {
-	const struct ctl_table *entry;
-
 	list_for_each_table_entry(entry, head)
 		erase_entry(head, entry);
 }
 
 static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 {
-	const struct ctl_table *entry;
 	struct ctl_table_header *dir_h = &dir->header;
 	int err;
 
@@ -248,8 +264,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	err = insert_links(header);
 	if (err)
 		goto fail_links;
-	list_for_each_table_entry(entry, header) {
-		err = insert_entry(header, entry);
+	list_for_each_table_entry(index, header) {
+		err = insert_entry(header, index);
 		if (err)
 			goto fail;
 	}
@@ -258,7 +274,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	erase_header(header);
 	put_links(header);
 fail_links:
-	if (header->ctl_table == sysctl_mount_point)
+	if (sysctl_is_perm_empty_ctl_header(header))
 		sysctl_clear_perm_empty_ctl_header(dir_h);
 	header->parent = NULL;
 	drop_sysctl_table(dir_h);
@@ -350,21 +366,23 @@ lookup_header_set(struct ctl_table_root *root)
 	return set;
 }
 
-static const struct ctl_table *lookup_entry(struct ctl_table_header **phead,
-					    struct ctl_dir *dir,
-					    const char *name, int namelen)
+static bool lookup_entry(struct ctl_table_header **phead, size_t *pindex,
+			 struct ctl_dir *dir, const char *name, int namelen)
 {
 	struct ctl_table_header *head;
-	const struct ctl_table *entry;
+	size_t index;
+	bool found;
 
 	spin_lock(&sysctl_lock);
-	entry = find_entry(&head, dir, name, namelen);
-	if (entry && use_table(head))
+	found = find_entry(&head, &index, dir, name, namelen);
+	if (found && use_table(head)) {
 		*phead = head;
-	else
-		entry = NULL;
+		*pindex = index;
+	} else {
+		found = false;
+	}
 	spin_unlock(&sysctl_lock);
-	return entry;
+	return found;
 }
 
 static struct ctl_node *first_usable_entry(struct rb_node *node)
@@ -380,10 +398,10 @@ static struct ctl_node *first_usable_entry(struct rb_node *node)
 }
 
 static void first_entry(struct ctl_dir *dir,
-	struct ctl_table_header **phead, const struct ctl_table **pentry)
+	struct ctl_table_header **phead, size_t *pindex)
 {
 	struct ctl_table_header *head = NULL;
-	const struct ctl_table *entry = NULL;
+	size_t index = 0;
 	struct ctl_node *ctl_node;
 
 	spin_lock(&sysctl_lock);
@@ -391,17 +409,16 @@ static void first_entry(struct ctl_dir *dir,
 	spin_unlock(&sysctl_lock);
 	if (ctl_node) {
 		head = ctl_node->header;
-		entry = &head->ctl_table[ctl_node - head->node];
+		index = ctl_node - head->node;
 	}
 	*phead = head;
-	*pentry = entry;
+	*pindex = index;
 }
 
-static void next_entry(struct ctl_table_header **phead, const struct ctl_table **pentry)
+static void next_entry(struct ctl_table_header **phead, size_t *pindex)
 {
 	struct ctl_table_header *head = *phead;
-	const struct ctl_table *entry = *pentry;
-	struct ctl_node *ctl_node = &head->node[entry - head->ctl_table];
+	struct ctl_node *ctl_node = &head->node[*pindex];
 
 	spin_lock(&sysctl_lock);
 	unuse_table(head);
@@ -411,10 +428,9 @@ static void next_entry(struct ctl_table_header **phead, const struct ctl_table *
 	head = NULL;
 	if (ctl_node) {
 		head = ctl_node->header;
-		entry = &head->ctl_table[ctl_node - head->node];
+		*pindex = ctl_node - head->node;
 	}
 	*phead = head;
-	*pentry = entry;
 }
 
 /*
@@ -433,25 +449,30 @@ static int test_perm(int mode, int op)
 	return -EACCES;
 }
 
-static int sysctl_perm(struct ctl_table_header *head, const struct ctl_table *table, int op)
+static int sysctl_perm(struct ctl_table_header *head, size_t index, int op)
 {
 	struct ctl_table_root *root = head->root;
+	struct ctl_table table;
+	const struct ctl_table *entry;
 	int mode;
 
-	if (root->permissions)
-		mode = root->permissions(head, table);
-	else
-		mode = table->mode;
+	if (root->permissions) {
+		entry = sysctl_entry_table(head, index, &table);
+		mode = root->permissions(head, entry);
+	} else {
+		mode = sysctl_entry_mode(head, index);
+	}
 
 	return test_perm(mode, op);
 }
 
 static struct inode *proc_sys_make_inode(struct super_block *sb,
-		struct ctl_table_header *head, const struct ctl_table *table)
+		struct ctl_table_header *head, size_t index)
 {
 	struct ctl_table_root *root = head->root;
 	struct inode *inode;
 	struct proc_inode *ei;
+	umode_t mode;
 
 	inode = new_inode(sb);
 	if (!inode)
@@ -468,14 +489,15 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 		return ERR_PTR(-ENOENT);
 	}
 	ei->sysctl = head;
-	ei->sysctl_entry = table;
+	ei->sysctl_entry_idx = index;
 	hlist_add_head_rcu(&ei->sibling_inodes, &head->inodes);
 	head->count++;
 	spin_unlock(&sysctl_lock);
 
+	mode = sysctl_entry_mode(head, index);
 	simple_inode_init_ts(inode);
-	inode->i_mode = table->mode;
-	if (!S_ISDIR(table->mode)) {
+	inode->i_mode = mode;
+	if (!S_ISDIR(mode)) {
 		inode->i_mode |= S_IFREG;
 		inode->i_op = &proc_sys_inode_operations;
 		inode->i_fop = &proc_sys_file_operations;
@@ -518,7 +540,7 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 	struct ctl_table_header *head = grab_header(dir);
 	struct ctl_table_header *h = NULL;
 	const struct qstr *name = &dentry->d_name;
-	const struct ctl_table *p;
+	size_t index;
 	struct inode *inode;
 	struct dentry *err = ERR_PTR(-ENOENT);
 	struct ctl_dir *ctl_dir;
@@ -529,18 +551,17 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 
 	ctl_dir = container_of(head, struct ctl_dir, header);
 
-	p = lookup_entry(&h, ctl_dir, name->name, name->len);
-	if (!p)
+	if (!lookup_entry(&h, &index, ctl_dir, name->name, name->len))
 		goto out;
 
-	if (S_ISLNK(p->mode)) {
-		ret = sysctl_follow_link(&h, &p);
+	if (S_ISLNK(sysctl_entry_mode(h, index))) {
+		ret = sysctl_follow_link(&h, &index);
 		err = ERR_PTR(ret);
 		if (ret)
 			goto out;
 	}
 
-	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
+	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, index);
 	err = d_splice_alias_ops(inode, dentry, &proc_sys_dentry_operations);
 
 out:
@@ -555,7 +576,9 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct ctl_table_header *head = grab_header(inode);
-	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	size_t index = PROC_I(inode)->sysctl_entry_idx;
+	struct ctl_table table;
+	const struct ctl_table *entry;
 	size_t count = iov_iter_count(iter);
 	char *kbuf;
 	ssize_t error;
@@ -568,12 +591,14 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	 * and won't be until we finish.
 	 */
 	error = -EPERM;
-	if (sysctl_perm(head, table, write ? MAY_WRITE : MAY_READ))
+	if (sysctl_perm(head, index, write ? MAY_WRITE : MAY_READ))
 		goto out;
 
+	entry = sysctl_entry_table(head, index, &table);
+
 	/* if that can happen at all, it should be -EINVAL, not -EISDIR */
 	error = -EINVAL;
-	if (!table->proc_handler)
+	if (!entry->proc_handler)
 		goto out;
 
 	/* don't even try if the size is too large */
@@ -591,13 +616,13 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 		kbuf[count] = '\0';
 	}
 
-	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, &kbuf, &count,
+	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, entry, write, &kbuf, &count,
 					   &iocb->ki_pos);
 	if (error)
 		goto out_free_buf;
 
 	/* careful: calling conventions are nasty here */
-	error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);
+	error = entry->proc_handler(entry, write, kbuf, &count, &iocb->ki_pos);
 	if (error)
 		goto out_free_buf;
 
@@ -629,14 +654,16 @@ static ssize_t proc_sys_write(struct kiocb *iocb, struct iov_iter *iter)
 static int proc_sys_open(struct inode *inode, struct file *filp)
 {
 	struct ctl_table_header *head = grab_header(inode);
-	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	size_t index = PROC_I(inode)->sysctl_entry_idx;
+	struct ctl_table_poll *poll;
 
 	/* sysctl was unregistered */
 	if (IS_ERR(head))
 		return PTR_ERR(head);
 
-	if (table->poll)
-		filp->private_data = proc_sys_poll_event(table->poll);
+	poll = sysctl_entry_poll(head, index);
+	if (poll)
+		filp->private_data = proc_sys_poll_event(poll);
 
 	sysctl_head_finish(head);
 
@@ -647,7 +674,10 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 {
 	struct inode *inode = file_inode(filp);
 	struct ctl_table_header *head = grab_header(inode);
-	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	size_t index = PROC_I(inode)->sysctl_entry_idx;
+	struct ctl_table_poll *poll;
+	struct ctl_table table;
+	const struct ctl_table *entry;
 	__poll_t ret = DEFAULT_POLLMASK;
 	unsigned long event;
 
@@ -655,17 +685,19 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 	if (IS_ERR(head))
 		return EPOLLERR | EPOLLHUP;
 
-	if (!table->proc_handler)
+	entry = sysctl_entry_table(head, index, &table);
+	if (!entry->proc_handler)
 		goto out;
 
-	if (!table->poll)
+	poll = sysctl_entry_poll(head, index);
+	if (!poll)
 		goto out;
 
 	event = (unsigned long)filp->private_data;
-	poll_wait(filp, &table->poll->wait, wait);
+	poll_wait(filp, &poll->wait, wait);
 
-	if (event != atomic_read(&table->poll->event)) {
-		filp->private_data = proc_sys_poll_event(table->poll);
+	if (event != atomic_read(&poll->event)) {
+		filp->private_data = proc_sys_poll_event(poll);
 		ret = EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLPRI;
 	}
 
@@ -678,7 +710,7 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 static bool proc_sys_fill_cache(struct file *file,
 				struct dir_context *ctx,
 				struct ctl_table_header *head,
-				const struct ctl_table *table)
+				size_t index)
 {
 	struct dentry *child, *dir = file->f_path.dentry;
 	struct inode *inode;
@@ -686,8 +718,8 @@ static bool proc_sys_fill_cache(struct file *file,
 	ino_t ino = 0;
 	unsigned type = DT_UNKNOWN;
 
-	qname.name = table->procname;
-	qname.len  = strlen(table->procname);
+	qname.name = sysctl_entry_procname(head, index);
+	qname.len  = strlen(qname.name);
 	qname.hash = full_name_hash(dir, qname.name, qname.len);
 
 	child = d_lookup(dir, &qname);
@@ -697,7 +729,7 @@ static bool proc_sys_fill_cache(struct file *file,
 			return false;
 		if (d_in_lookup(child)) {
 			struct dentry *res;
-			inode = proc_sys_make_inode(dir->d_sb, head, table);
+			inode = proc_sys_make_inode(dir->d_sb, head, index);
 			res = d_splice_alias_ops(inode, child,
 						 &proc_sys_dentry_operations);
 			d_lookup_done(child);
@@ -721,7 +753,7 @@ static bool proc_sys_fill_cache(struct file *file,
 static bool proc_sys_link_fill_cache(struct file *file,
 				    struct dir_context *ctx,
 				    struct ctl_table_header *head,
-				    const struct ctl_table *table)
+				    size_t index)
 {
 	bool ret = true;
 
@@ -730,16 +762,16 @@ static bool proc_sys_link_fill_cache(struct file *file,
 		return false;
 
 	/* It is not an error if we can not follow the link ignore it */
-	if (sysctl_follow_link(&head, &table))
+	if (sysctl_follow_link(&head, &index))
 		goto out;
 
-	ret = proc_sys_fill_cache(file, ctx, head, table);
+	ret = proc_sys_fill_cache(file, ctx, head, index);
 out:
 	sysctl_head_finish(head);
 	return ret;
 }
 
-static int scan(struct ctl_table_header *head, const struct ctl_table *table,
+static int scan(struct ctl_table_header *head, size_t index,
 		unsigned long *pos, struct file *file,
 		struct dir_context *ctx)
 {
@@ -748,10 +780,10 @@ static int scan(struct ctl_table_header *head, const struct ctl_table *table,
 	if ((*pos)++ < ctx->pos)
 		return true;
 
-	if (unlikely(S_ISLNK(table->mode)))
-		res = proc_sys_link_fill_cache(file, ctx, head, table);
+	if (unlikely(S_ISLNK(sysctl_entry_mode(head, index))))
+		res = proc_sys_link_fill_cache(file, ctx, head, index);
 	else
-		res = proc_sys_fill_cache(file, ctx, head, table);
+		res = proc_sys_fill_cache(file, ctx, head, index);
 
 	if (res)
 		ctx->pos = *pos;
@@ -763,9 +795,9 @@ static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct ctl_table_header *head = grab_header(file_inode(file));
 	struct ctl_table_header *h = NULL;
-	const struct ctl_table *entry;
 	struct ctl_dir *ctl_dir;
 	unsigned long pos;
+	size_t index;
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -777,8 +809,8 @@ static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 
 	pos = 2;
 
-	for (first_entry(ctl_dir, &h, &entry); h; next_entry(&h, &entry)) {
-		if (!scan(h, entry, &pos, file, ctx)) {
+	for (first_entry(ctl_dir, &h, &index); h; next_entry(&h, &index)) {
+		if (!scan(h, index, &pos, file, ctx)) {
 			sysctl_head_finish(h);
 			break;
 		}
@@ -796,7 +828,7 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
 	 * are _NOT_ writeable, capabilities or not.
 	 */
 	struct ctl_table_header *head;
-	const struct ctl_table *table;
+	size_t index;
 	int error;
 
 	/* Executable files are not allowed under /proc/sys/ */
@@ -807,11 +839,12 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
 	if (IS_ERR(head))
 		return PTR_ERR(head);
 
-	table = PROC_I(inode)->sysctl_entry;
-	if (!table) /* global root - r-xr-xr-x */
+	if (!PROC_I(inode)->sysctl) { /* global root - r-xr-xr-x */
 		error = mask & MAY_WRITE ? -EACCES : 0;
-	else /* Use the permissions on the sysctl table entry */
-		error = sysctl_perm(head, table, mask & ~MAY_NOT_BLOCK);
+	} else {
+		index = PROC_I(inode)->sysctl_entry_idx;
+		error = sysctl_perm(head, index, mask & ~MAY_NOT_BLOCK);
+	}
 
 	sysctl_head_finish(head);
 	return error;
@@ -840,14 +873,14 @@ static int proc_sys_getattr(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct ctl_table_header *head = grab_header(inode);
-	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	if (table)
-		stat->mode = (stat->mode & S_IFMT) | table->mode;
+	if (PROC_I(inode)->sysctl)
+		stat->mode = (stat->mode & S_IFMT) |
+			     sysctl_entry_mode(head, PROC_I(inode)->sysctl_entry_idx);
 
 	sysctl_head_finish(head);
 	return 0;
@@ -944,12 +977,11 @@ static struct ctl_dir *find_subdir(struct ctl_dir *dir,
 				   const char *name, int namelen)
 {
 	struct ctl_table_header *head;
-	const struct ctl_table *entry;
+	size_t index;
 
-	entry = find_entry(&head, dir, name, namelen);
-	if (!entry)
+	if (!find_entry(&head, &index, dir, name, namelen))
 		return ERR_PTR(-ENOENT);
-	if (!S_ISDIR(entry->mode))
+	if (!S_ISDIR(sysctl_entry_mode(head, index)))
 		return ERR_PTR(-ENOTDIR);
 	return container_of(head, struct ctl_dir, header);
 }
@@ -1050,39 +1082,44 @@ static struct ctl_dir *xlate_dir(struct ctl_table_set *set, struct ctl_dir *dir)
 	parent = xlate_dir(set, dir->header.parent);
 	if (IS_ERR(parent))
 		return parent;
-	procname = dir->header.ctl_table[0].procname;
+	procname = sysctl_entry_procname(&dir->header, 0);
 	return find_subdir(parent, procname, strlen(procname));
 }
 
-static int sysctl_follow_link(struct ctl_table_header **phead,
-	const struct ctl_table **pentry)
+static int sysctl_follow_link(struct ctl_table_header **phead, size_t *pindex)
 {
 	struct ctl_table_header *head;
+	struct ctl_table table;
 	const struct ctl_table *entry;
 	struct ctl_table_root *root;
 	struct ctl_table_set *set;
 	struct ctl_dir *dir;
+	size_t index;
 	int ret;
 
+	entry = sysctl_entry_table(*phead, *pindex, &table);
+	root = entry->data;
 	spin_lock(&sysctl_lock);
-	root = (*pentry)->data;
 	set = lookup_header_set(root);
 	dir = xlate_dir(set, (*phead)->parent);
 	if (IS_ERR(dir))
 		ret = PTR_ERR(dir);
 	else {
-		const char *procname = (*pentry)->procname;
+		const char *procname = entry->procname;
 		head = NULL;
-		entry = find_entry(&head, dir, procname, strlen(procname));
 		ret = -ENOENT;
-		if (entry && use_table(head)) {
+		if (!find_entry(&head, &index, dir, procname, strlen(procname)))
+			goto out;
+		ret = -ENOENT;
+		if (use_table(head)) {
 			unuse_table(*phead);
 			*phead = head;
-			*pentry = entry;
+			*pindex = index;
 			ret = 0;
 		}
 	}
 
+out:
 	spin_unlock(&sysctl_lock);
 	return ret;
 }
@@ -1144,7 +1181,10 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
 	const struct ctl_table *entry;
 	int err = 0;
-	list_for_each_table_entry(entry, header) {
+	list_for_each_table_entry(index, header) {
+		struct ctl_table table;
+
+		entry = sysctl_entry_table(header, index, &table);
 		if (!entry->procname)
 			err |= sysctl_err(path, entry, "procname is null");
 		if ((entry->proc_handler == proc_dostring) ||
@@ -1180,14 +1220,13 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 {
 	struct ctl_table *link_table, *link;
 	struct ctl_table_header *links;
-	const struct ctl_table *entry;
 	struct ctl_node *node;
 	char *link_name;
 	int name_bytes;
 
 	name_bytes = 0;
-	list_for_each_table_entry(entry, head) {
-		name_bytes += strlen(entry->procname) + 1;
+	list_for_each_table_entry(index, head) {
+		name_bytes += strlen(sysctl_entry_procname(head, index)) + 1;
 	}
 
 	links = kzalloc(sizeof(struct ctl_table_header) +
@@ -1204,9 +1243,11 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	link_name = (char *)(link_table + head->ctl_table_size);
 	link = link_table;
 
-	list_for_each_table_entry(entry, head) {
-		int len = strlen(entry->procname) + 1;
-		memcpy(link_name, entry->procname, len);
+	list_for_each_table_entry(index, head) {
+		const char *procname = sysctl_entry_procname(head, index);
+		int len = strlen(procname) + 1;
+
+		memcpy(link_name, procname, len);
 		link->procname = link_name;
 		link->mode = S_IFLNK|S_IRWXUGO;
 		link->data = head->root;
@@ -1225,29 +1266,33 @@ static bool get_links(struct ctl_dir *dir,
 		      struct ctl_table_root *link_root)
 {
 	struct ctl_table_header *tmp_head;
-	const struct ctl_table *entry, *link;
+	size_t link_index;
 
 	if (header->ctl_table_size == 0 ||
 	    sysctl_is_perm_empty_ctl_header(header))
 		return true;
 
 	/* Are there links available for every entry in table? */
-	list_for_each_table_entry(entry, header) {
-		const char *procname = entry->procname;
-		link = find_entry(&tmp_head, dir, procname, strlen(procname));
-		if (!link)
+	list_for_each_table_entry(index, header) {
+		const char *procname = sysctl_entry_procname(header, index);
+
+		if (!find_entry(&tmp_head, &link_index, dir, procname,
+				strlen(procname)))
 			return false;
-		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
+		if (S_ISDIR(sysctl_entry_mode(tmp_head, link_index)) &&
+		    S_ISDIR(sysctl_entry_mode(header, index)))
 			continue;
-		if (S_ISLNK(link->mode) && (link->data == link_root))
+		if (S_ISLNK(sysctl_entry_mode(tmp_head, link_index)) &&
+		    tmp_head->ctl_table[link_index].data == link_root)
 			continue;
 		return false;
 	}
 
 	/* The checks passed.  Increase the registration count on the links */
-	list_for_each_table_entry(entry, header) {
-		const char *procname = entry->procname;
-		link = find_entry(&tmp_head, dir, procname, strlen(procname));
+	list_for_each_table_entry(index, header) {
+		const char *procname = sysctl_entry_procname(header, index);
+
+		find_entry(&tmp_head, &link_index, dir, procname, strlen(procname));
 		tmp_head->nreg++;
 	}
 	return true;
@@ -1374,9 +1419,12 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_header *header;
 	struct ctl_dir *dir;
 	struct ctl_node *node;
+	size_t alloc_size;
+
+	alloc_size = sizeof(struct ctl_table_header) +
+		     sizeof(struct ctl_node) * table_size;
 
-	header = kzalloc(sizeof(struct ctl_table_header) +
-			 sizeof(struct ctl_node)*table_size, GFP_KERNEL_ACCOUNT);
+	header = kzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
 	if (!header)
 		return NULL;
 
@@ -1476,7 +1524,7 @@ static void put_links(struct ctl_table_header *header)
 	struct ctl_table_root *root = header->root;
 	struct ctl_dir *parent = header->parent;
 	struct ctl_dir *core_parent;
-	const struct ctl_table *entry;
+	size_t link_index;
 
 	if (header->set == root_set)
 		return;
@@ -1485,18 +1533,24 @@ static void put_links(struct ctl_table_header *header)
 	if (IS_ERR(core_parent))
 		return;
 
-	list_for_each_table_entry(entry, header) {
+	list_for_each_table_entry(index, header) {
 		struct ctl_table_header *link_head;
+		struct ctl_table table;
 		const struct ctl_table *link;
-		const char *name = entry->procname;
+		const char *name = sysctl_entry_procname(header, index);
+
+		if (!find_entry(&link_head, &link_index, core_parent, name,
+				strlen(name)))
+			link = NULL;
+		else
+			link = sysctl_entry_table(link_head, link_index, &table);
 
-		link = find_entry(&link_head, core_parent, name, strlen(name));
 		if (link &&
-		    ((S_ISDIR(link->mode) && S_ISDIR(entry->mode)) ||
+		    ((S_ISDIR(link->mode) &&
+		      S_ISDIR(sysctl_entry_mode(header, index))) ||
 		     (S_ISLNK(link->mode) && (link->data == root)))) {
 			drop_sysctl_table(link_head);
-		}
-		else {
+		} else {
 			pr_err("sysctl link missing during unregister: ");
 			sysctl_print_dir(parent);
 			pr_cont("%s\n", name);
-- 
2.55.0

