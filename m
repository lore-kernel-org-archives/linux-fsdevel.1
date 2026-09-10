Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B5306776
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000641; cv=none; b=bbD8i8h8DbhIcZF5PYQdRC9zU3viNjYU/0dgFg3iPvd9U6AMohq/EGcah9wn74Fp6kIiEYXRERQc+pjVSlQ4nbmvH6aAMQ1gys6pQcvDLYNlQe+fojp17GxZ4KtTQN7/VSdz+x9IVqNEayMW52yFY56IwSDvKfCB+swO3ok7v2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000641; c=relaxed/simple;
	bh=jkhCgg/Ol2NrqjC9zGZTLPFKrW8MH6tEHmgZVAhmkGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g00YPPkNm1LzszbRKhhXofVvA7naeukBQITSfjXjzTmi9n0evmX5XgS2Pz8frEH1i0QDClANruOiVI2aT7kOutg7ChH9FZE4uYuCQmYIxY6otaBBYbwk6QPpTk7zHE+LPpm9CCRyt5npPS+o0HPJvnXizy1PqBlsYyhMovwpcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZYl6sI/r; arc=none smtp.client-ip=91.218.175.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZYl6sI/r"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jkhCgg/Ol2NrqjC9zGZTLPFKrW8MH6tEHmgZVAhmkGk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789000636; v=1; x=1789605436;
 b=ZYl6sI/rHOSYiTKa6oH2NzwEOmpPP2+Xb/AJnbcierr2tS6Ym/azX9zlYTJImqZMZ3/Y4s/u
 0kQcqpsICdz424aEnUS4jepOKeRiMtWDWOp58ekWv9w3zBBGG3/V8EQVXv5QbILXe2ig6WW9hoZ
 +9prpb8AD2nS9NPITnIAEJW8=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 05243076f2be2f89;
	Thu, 10 Sep 2026 00:37:16 +0000
X-Mizu-Trace-ID: 05243076f2be2f89
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <christian@brauner.io>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kernfs: don't hold kernfs_rwsem across dir_emit()
Date: Wed,  9 Sep 2026 17:36:49 -0700
Message-ID: <20260910003650.1680854-3-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910003650.1680854-1-shakeel.butt@linux.dev>
References: <20260910003650.1680854-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_fop_readdir() holds kernfs_rwsem for reading across the whole
listing, dir_emit() included.  dir_emit() copies to userspace, so it can
fault into reclaim while holding the lock that every create, remove and
rename in the hierarchy needs.  sysfs and cgroupfs have one per machine.

Under memory pressure the monitoring daemons fault on their own
getdents(2) buffer with it held:

        below: page allocation stall for 120 secs: order:0,
        mode:0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP)
        nodemask=(null),cpuset=hostcritical.slice,mems_allowed=0
        Call Trace:
         <TASK>
         dump_stack_lvl+0x5d/0x80
         __alloc_frozen_pages_noprof+0x5f4d/0x6300
         ? memcg_list_lru_alloc+0x73/0x320
         ? ima_file_check+0xd0/0x7d0
         vma_alloc_folio_noprof+0x145/0x560
         handle_mm_fault+0x17c9/0x2720
         ? find_vma+0x27/0x30
         do_user_addr_fault+0x39f/0x6e0
         exc_page_fault+0x8f/0x110
         asm_exc_page_fault+0x22/0x30
        RIP: 0010:filldir64+0xd7/0x1a0
        [Code:/RSP:/RAX:..R15: register block elided]
         kernfs_fop_readdir+0x2de/0x420
         iterate_dir+0x8c/0x1f0
         __se_sys_getdents64+0x61/0xe0
         ? copy_page_from_iter+0x860/0x860
         do_syscall_64+0x6a/0x250
         entry_SYSCALL_64_after_hwframe+0x4b/0x53
         </TASK>

Commit 9aab10a0249e ("kernfs: Don't re-lock kernfs_root::kernfs_rwsem in
kernfs_fop_readdir().") took the lock drop out because dir_emit() was
handed kernfs_node::name, which a rename can free.  So copy the name
under the lock and emit the copy, and pass it to the resume so that a
resume within one call keys on (hash, ns_id, name) and not on the hash
alone.

A listing is no longer atomic within one getdents(2) call, which for
most sysfs and cgroup directories is all of it.  POSIX leaves that
unspecified for an entry added or removed since opendir(3).

Fixes: 9aab10a0249e ("kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().")
Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c | 52 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 24a927c85123..f7cd2be67e1a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1905,11 +1905,11 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 
 /*
  * Find where a listing left off.  @resumed says whether @pos is still that
- * entry; if not, the first entry at or after @hash is returned instead.
+ * entry; if not, the search falls back to @hash, keyed by @name if given.
  */
 static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
 	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos,
-	bool *resumed)
+	const char *name, bool *resumed)
 {
 	if (resumed)
 		*resumed = false;
@@ -1928,13 +1928,13 @@ static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
 
 		/*
 		 * Keep a node only on the way left, so the search ends on the
-		 * first entry at or after @hash.  The empty name sorts before
-		 * every entry sharing the hash, so it lands on the first.
+		 * first entry after the key.  An empty @name sorts before all
+		 * entries sharing the hash, so it lands on the first of them.
 		 */
 		while (node) {
 			struct kernfs_node *kn = rb_to_kn(node);
 
-			if (kernfs_name_compare(hash, "", ns, kn) < 0) {
+			if (kernfs_name_compare(hash, name ?: "", ns, kn) < 0) {
 				pos = kn;
 				node = node->rb_left;
 			} else {
@@ -1955,12 +1955,13 @@ static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
 }
 
 static struct kernfs_node *kernfs_dir_next_pos(const struct ns_common *ns,
-	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
+	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos,
+	const char *name)
 {
 	bool resumed;
 
-	pos = kernfs_dir_pos(ns, parent, hash, pos, &resumed);
-	/* Step over @pos only if it survived; two entries can share a hash. */
+	pos = kernfs_dir_pos(ns, parent, hash, pos, name, &resumed);
+	/* Step over @pos only if it survived; @name handles it if not. */
 	if (pos && resumed) {
 		do {
 			struct rb_node *node = rb_next(&pos->rb);
@@ -1979,34 +1980,55 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
+	char *name __free(kfree) = NULL;
 	struct kernfs_root *root;
 	const struct ns_common *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
+	/*
+	 * One buffer for the call, so each name can be copied out before
+	 * dropping kernfs_rwsem.  PATH_MAX: kernfs bounds no single name.
+	 */
+	name = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
 	root = kernfs_root(parent);
 	down_read(&root->kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
 
-	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos, NULL);
+	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos, NULL, NULL);
 	     pos;
-	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
-		const char *name = kernfs_rcu_name(pos);
+	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos, name)) {
 		unsigned int type = fs_umode_to_dtype(pos->mode);
-		int len = strlen(name);
 		ino_t ino = kernfs_ino(pos);
+		int len;
+
+		len = strscpy(name, kernfs_rcu_name(pos), PATH_MAX);
 
 		ctx->pos = pos->hash;
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		if (!dir_emit(ctx, name, len, ino, type)) {
-			up_read(&root->kernfs_rwsem);
+		/*
+		 * getname() caps a path, so only an in-kernel caller can get
+		 * here.  Skip the entry rather than report a truncated name.
+		 */
+		if (WARN_ON_ONCE(len < 0))
+			continue;
+
+		/*
+		 * dir_emit() can fault, so run it unlocked.  @pos is pinned
+		 * above and kernfs_dir_pos() rechecks it on the way back.
+		 */
+		up_read(&root->kernfs_rwsem);
+		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		}
+		down_read(&root->kernfs_rwsem);
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
-- 
2.53.0-Meta

