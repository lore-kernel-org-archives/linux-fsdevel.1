Received: from mta1.migadu.com (out-162.mta1.migadu.com [95.215.58.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1D2248AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000638; cv=none; b=oAvpUqFgYvTthAiVxOX42GLVxs+GMwgzkKCgcWAqDa840xxFBDEFWIbDb/Mrk628YqnsOiUO0JGe3AGtEnu/9GdkTK9gududrvFOgVIysAV5WSQfdjEvxVhXGF9c13KP5QY0aAJEIeFmKqg/O3XlTMlakKwN5o3/vulAiML6XvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000638; c=relaxed/simple;
	bh=VvDtTR/RJe/lGiTbv0IzpIOqzSLy55lISYIRUs31UtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyXKTsYESIM6weNpim9NRKqJetQkC0jwiFWXyh5kK48xTOoOvhv2QXSTPZhY1g0vE9JZGwyxKmF2nYjaSPeBqwrMRyTb3NdFZhQ5SMNYv2gS/3PkAgkfix7n+zl5moIjJTOtx8+qAhE1S6ahMiohnh1gN1yk2hqhfStDIu7IUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRT417SB; arc=none smtp.client-ip=95.215.58.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRT417SB"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VvDtTR/RJe/lGiTbv0IzpIOqzSLy55lISYIRUs31UtE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789000634; v=1; x=1789605434;
 b=qRT417SBJO59Wu5dQvM0w3RF7K8/c7DW14I5BD1jhHGdKPqkPDA1oQw3c/A1dVWHyujC2mkq
 IWdpVEQJDZbga9z2eORhj2RTP43UQ8YDuVABfnL0dcUyFTyT6NGsMcbGEx7HqiTYmvAmS/HHOk4
 CVbxc8U3yG7SsduunASy9vwM=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ec4f0e322a026764;
	Thu, 10 Sep 2026 00:37:14 +0000
X-Mizu-Trace-ID: ec4f0e322a026764
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
Subject: [PATCH 1/3] kernfs: don't repeat or skip an entry when readdir resumes
Date: Wed,  9 Sep 2026 17:36:48 -0700
Message-ID: <20260910003650.1680854-2-shakeel.butt@linux.dev>
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

readdir keeps its place as a name hash in ctx->pos and pins the entry in
file->private_data.  If that entry is gone when the listing comes back,
kernfs_dir_pos() searches the rbtree for the hash and keeps whatever
node the descent stopped on.  That is the entry before or after the
missing one, depending on the shape of the tree.

Landing before it repeats an entry the previous getdents(2) call already
reported.  Landing after it, kernfs_dir_next_pos() calls rb_next() and
steps over an unreported entry.

With children A(10), B(20), C(30):

  report A, ctx->pos = 10
                                    A removed
  kernfs_dir_next_pos(10, A)
    A is gone, the search for 10 stops at B
    rb_next(B) -> C, so B is never reported

Only the repeat happens today, between two getdents(2) calls.  The skip
needs the pinned entry to go away inside one call, which the next patch
allows when it drops kernfs_rwsem around dir_emit().

Before the commit 4e4d6d860b93 the descent kept a node only on the way
left, which is a search for the first entry at or after the hash.  That
commit moved the assignment to the top of the loop, where it runs on
right turns too.  Restore that search, and step forward only when the
pinned entry is still there rather than when the hash matches, since two
entries in one directory can share a hash.

While here, kernfs_dir_next_pos() called the hash @ino.  It is never an
inode number, so name it @hash.

Fixes: 4e4d6d860b93 ("sysfs: Add s_hash to sysfs_dirent and order directory entries by hash")
Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 07abf59f0264..24a927c85123 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1903,9 +1903,16 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * Find where a listing left off.  @resumed says whether @pos is still that
+ * entry; if not, the first entry at or after @hash is returned instead.
+ */
 static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
-	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
+	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos,
+	bool *resumed)
 {
+	if (resumed)
+		*resumed = false;
 	if (pos) {
 		int valid = kernfs_active(pos) &&
 			rcu_access_pointer(pos->__parent) == parent &&
@@ -1913,23 +1920,26 @@ static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
 		kernfs_put(pos);
 		if (!valid)
 			pos = NULL;
+		else if (resumed)
+			*resumed = true;
 	}
 	if (!pos && (hash > 1) && (hash < INT_MAX)) {
 		struct rb_node *node = parent->dir.children.rb_node;
-		u64 ns_id = kernfs_ns_id(ns);
+
+		/*
+		 * Keep a node only on the way left, so the search ends on the
+		 * first entry at or after @hash.  The empty name sorts before
+		 * every entry sharing the hash, so it lands on the first.
+		 */
 		while (node) {
-			pos = rb_to_kn(node);
+			struct kernfs_node *kn = rb_to_kn(node);
 
-			if (hash < pos->hash)
+			if (kernfs_name_compare(hash, "", ns, kn) < 0) {
+				pos = kn;
 				node = node->rb_left;
-			else if (hash > pos->hash)
+			} else {
 				node = node->rb_right;
-			else if (ns_id < kernfs_ns_id(pos->ns))
-				node = node->rb_left;
-			else if (ns_id > kernfs_ns_id(pos->ns))
-				node = node->rb_right;
-			else
-				break;
+			}
 		}
 	}
 	/* Skip over entries which are dying/dead or in the wrong namespace */
@@ -1945,10 +1955,13 @@ static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
 }
 
 static struct kernfs_node *kernfs_dir_next_pos(const struct ns_common *ns,
-	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
+	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
 {
-	pos = kernfs_dir_pos(ns, parent, ino, pos);
-	if (pos) {
+	bool resumed;
+
+	pos = kernfs_dir_pos(ns, parent, hash, pos, &resumed);
+	/* Step over @pos only if it survived; two entries can share a hash. */
+	if (pos && resumed) {
 		do {
 			struct rb_node *node = rb_next(&pos->rb);
 			if (!node)
@@ -1978,7 +1991,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
 
-	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
+	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos, NULL);
 	     pos;
 	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
 		const char *name = kernfs_rcu_name(pos);
-- 
2.53.0-Meta

