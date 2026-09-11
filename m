Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28684AEBED
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151312; cv=none; b=QGcrTRIhoZTTty/58K1XrX2BYwwQgVGWCCFFeZgGIOxGtl48SzT8DIPw4fwdE8/HPryRucQ8FRwMKhO4TrIQSmAkBYi0EZCK6uGMOh/qBkIEQPh6NW5urAha/ltHEg2gGIStKn7aEMFP6e24iaYAAf4D1llMfYseu8G/oCi90nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151312; c=relaxed/simple;
	bh=IoWGcPaTMsqGhUHvVr4sS4CIvF/oFhBhNBX0+SmNynI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3BxHGqNSIt2ALZ3P0sP71iMCL1+aiThNAOsao+qE3QyV86+oLvLKLm4apu6tGJo5jvrTKP1b3r869mi37K9p/iffWjM2GmgcEQo+NlvpogccJ8NbrCgsuEPsdpZOuGCFYLw1AMR5CU2/0lIibzPP0MCxsRBXOrbRWzA7wzBW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ClJL5OMU; arc=none smtp.client-ip=91.218.175.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ClJL5OMU"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IoWGcPaTMsqGhUHvVr4sS4CIvF/oFhBhNBX0+SmNynI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789151308; v=1; x=1789756108;
 b=ClJL5OMUPJfQIYrQQGM96MgfehOY3eRomRamcXHONhEJ17+IJK8tto35VKeHWYNL+SzVt53h
 XEkGVRYZUky2RaUg+s3k1/EvbrmOObCKM7eXZ1iaJ51d8SmoD78d7yrDRa0QIDBGDTc5EvJaUMj
 GPiWJHiv276vN+80UJjchbwk=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6689915ec235b4ee;
	Fri, 11 Sep 2026 18:28:28 +0000
X-Mizu-Trace-ID: 6689915ec235b4ee
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
Subject: [PATCH v2 2/4] kernfs: resume readdir on the full entry key
Date: Fri, 11 Sep 2026 11:28:13 -0700
Message-ID: <20260911182815.1992483-3-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911182815.1992483-1-shakeel.butt@linux.dev>
References: <20260911182815.1992483-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

readdir resumes at the entry pinned in file->private_data, and falls back
to the hash in ctx->pos when that entry is gone.  Two entries in one
directory can share a hash, so the hash alone does not say where the
listing stopped.

Copy the name under the lock, emit the copy, and keep it as the resume
key.  The pinned entry counts as the same entry only while its name still
matches, and the fallback search starts after (hash, ns, name) rather
than at the first entry with the hash.

No behaviour change yet.  kernfs_rwsem is held across the loop, so nothing
can move between two entries of one call, and a resume across getdents(2)
calls has no saved name and keys on the hash as before.

Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c | 50 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 24a927c85123..6d7d9c9ba33a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1905,18 +1905,24 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 
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
 	if (pos) {
+		/*
+		 * A rename keeps the hash if the new name hashes the same, so
+		 * check @name too.  Otherwise the caller would step over the
+		 * entry now sitting where @pos used to be.
+		 */
 		int valid = kernfs_active(pos) &&
 			rcu_access_pointer(pos->__parent) == parent &&
-			hash == pos->hash;
+			hash == pos->hash &&
+			(!name || !strcmp(name, kernfs_rcu_name(pos)));
 		kernfs_put(pos);
 		if (!valid)
 			pos = NULL;
@@ -1928,13 +1934,13 @@ static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
 
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
@@ -1955,12 +1961,13 @@ static struct kernfs_node *kernfs_dir_pos(const struct ns_common *ns,
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
+	/* Step over @pos only if it survived; @name finds the spot if not. */
 	if (pos && resumed) {
 		do {
 			struct rb_node *node = rb_next(&pos->rb);
@@ -1979,25 +1986,42 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
+	char *name __free(kfree) = NULL;
 	struct kernfs_root *root;
 	const struct ns_common *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
+	/*
+	 * One buffer for the call, holding the name of the entry the listing
+	 * is on.  PATH_MAX: kernfs bounds no single name.
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
+		/*
+		 * The copy is also the resume key, so a truncated name would
+		 * resume here again.  getname() caps a path, so only an
+		 * in-kernel caller can get here; end the listing instead.
+		 */
+		len = strscpy(name, kernfs_rcu_name(pos), PATH_MAX);
+		if (WARN_ON_ONCE(len < 0))
+			break;
 
 		ctx->pos = pos->hash;
 		file->private_data = pos;
-- 
2.53.0-Meta

