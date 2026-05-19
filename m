Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CC3E559F;
	Tue, 19 May 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229686; cv=none; b=ZOYDEYsPhTUlcSUVWL7euCO0w/ZWuaa1wnIA5ftP0VsXxnEBahf96YBnz8aQDqR0wxxg1SqTRM1IXRjmlLtHmfhnEqQpWL5VJHSD7x4pgQ7q2yq3yybi743+34+VLUy9f1Hknj8Zo0qfQIFW6aqMiDT8jNKAExWcj4Csiyd8N5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229686; c=relaxed/simple;
	bh=Bu8ZzPLYsqkcopYHW8JJINnMz6fnB9JIY2FH0jDw6sQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxZmop9ZMTvePrkw70rpYDIII2iAsg3R2BcY2oCA3ADwiEjd0ZKO45dNaXrDvFw2ifh5VgVwpXymRPtbTaHhYXnCdxXDrxkHwDb90jUvEdK8/6Zyuy35at1G4HhQOiRmu+/gj/QbQi+R51UGTj+N6/lOP37yy1RdIHfCWXAxxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeHI2amv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeHI2amv"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 479581F00894;
	Tue, 19 May 2026 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229685;
	bh=et/0YsqwsKCL4nsTuRFrsKQ+isxlMrsk/61kWlwSJQ0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=KeHI2amvJtY/6MTZXvLZzFtyLajrwNUv0ho8WV6uWIDL5813d+B4c8p3rGtA9X95r
	 NA0Gnma6yfRzTCcgu36lqgTiGt2QY3lB1kt15mc8nexbvpBXopCjakl+wNlcTMY291
	 Zkhdc26vJWL/hLXM+zw2HWPy5JElV+DrIix6mMAbZhWx0disPwi1lAwkYsxQDr+HTu
	 Rpt7a4r86fzAwg8NBWdxELrgQWhTSLYTjcDmxaEaSrm3t5iUCnRXvo+Jvg9Xq6VZsJ
	 u3e0frQoN7VHdySKxefT4LEzDKFgH/el335moEjaf1OWSu9nnq+uLMNHNrsnFQE9pq
	 4PbZdrMh8fbwA==
Date: Tue, 19 May 2026 15:28:04 -0700
Subject: [PATCH 06/11] fuse: create a per-inode flag for setting exclusive
 mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945370.2436837.18390665802748535801.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a per-inode flag to control whether or not this inode can use
exclusive mode.  This enables more aggressive use of cached file
attributes for things such as ACL inheritance and transformations.

The initial user will be iomap filesystems, where we hoist the IO path
into the kernel and need ACLs to work for regular files and directories
in the manner that most local filesystems expect.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   17 +++++++++++++++++
 include/uapi/linux/fuse.h |    6 ++++++
 fs/fuse/inode.c           |   17 +++++++++++++++++
 3 files changed, 40 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 969d546ecbaaec..822b77da7a144c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1118,6 +1118,23 @@ static inline bool fuse_is_bad(struct inode *inode)
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
 
+static inline void fuse_inode_set_exclusive(const struct fuse_conn *fc,
+					    struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	/* This flag wasn't added until kernel API 7.99 */
+	if (fc->minor >= 99)
+		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
+static inline void fuse_inode_clear_exclusive(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
 static inline bool fuse_inode_is_exclusive(const struct inode *inode)
 {
 	const struct fuse_inode *fi = get_fuse_inode(inode);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 6ce5de5b74f256..7f4a7b7ba1e613 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -244,6 +244,7 @@
  *  7.99
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -584,9 +585,14 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
+ *     kernel can use cached attributes more aggressively (e.g. ACL
+ *     inheritance).  Must be set in the initial LOOKUP/GETATTR response.
+ *     Cannot be cleared.
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 
 /**
  * Open flags
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fdf5414c24160b..3ba80514bd59eb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -197,6 +197,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
+
+	fuse_inode_clear_exclusive(inode);
 }
 
 static int fuse_reconfigure(struct fs_context *fsc)
@@ -318,6 +320,15 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	 * anyway. Its less efficient but should be safe.
 	 */
 	inode->i_flags &= ~S_NOSEC;
+
+	/*
+	 * The root inode is created with attr->flags == 0 at mount time prior
+	 * to FUSE_INIT, so this is the only way that the fuse server can set
+	 * the attribute on the root directory after the fact.
+	 */
+	if (get_node_id(inode) == FUSE_ROOT_ID &&
+	    (attr->flags & FUSE_ATTR_EXCLUSIVE))
+		fuse_inode_set_exclusive(fc, inode);
 }
 
 u32 fuse_get_cache_mask(struct inode *inode)
@@ -436,6 +447,9 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
 
+	if (attr->flags & FUSE_ATTR_EXCLUSIVE)
+		fuse_inode_set_exclusive(fc, inode);
+
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		fuse_init_file_inode(inode, attr);
@@ -1783,6 +1797,9 @@ static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 		.rdev		= fi->inode.i_rdev,
 		.blksize	= 1u << fi->inode.i_blkbits,
 	};
+
+	if (fuse_inode_is_exclusive(&fi->inode))
+		attr->flags |= FUSE_ATTR_EXCLUSIVE;
 }
 
 static void fuse_sb_defaults(struct super_block *sb)

