Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF11175A64;
	Wed, 29 Apr 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473201; cv=none; b=e5fUue4akrhqdzK+BmhxGq3o1R5jW3GmQAzY2iUMjzVs9sXiCGSCm+0EMyPfYS9BWhY+tpy3gbNWX9dXuZp+Y5v5xOYC82fnJ7s5kMtLHh88h+OQcl6kXKK5KMDrF6rJoC2UqGWfn+gk3I5rbq2a/1bMlJyDryXXjwme8xQbc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473201; c=relaxed/simple;
	bh=qWl1Zutn2sserlIZsrZNNmyo5kzvkR475w1CpyX11Kc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXQQVZSRHJdfYucISIfHLjPIoMB3uVbNMKmvJQXa5xQ7fhH74tiDylkdrAmQcUbe9wNJGAnFRg1YjsovGgjoGRQxcKVeRQlcJJN/H36fPshUwtPIMnveyzX+OEVkaPteNzsBK+DrBUDlsqGBZ9RvasXaQ844lRkORYDRGigTTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAceoxec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAceoxec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B46DC2BCFD;
	Wed, 29 Apr 2026 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473201;
	bh=qWl1Zutn2sserlIZsrZNNmyo5kzvkR475w1CpyX11Kc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oAceoxecJcT1WcZjKwPuddrr4jYFr35UgFjx8RqwzFMofLkpMUz6q0uiuyksepg23
	 2bnSEQTPgN09ZGnSmmIg0GOF7MHVI7fmSyQEs+NQAGTr8Vu+w/seevkWqJ/rJgvtCs
	 9BjdF9tfoUDyF9u5i5zF5EQB/zk5kyVKH9ZZ6IikUbunnOGbI5gQLUX78PyXITPWFf
	 peXawkEWPEEf3vCT4e91xk+jc6Ljr509DS7/aOGDAZmy6FqvYiQ3J6ZFX6AX6wREb6
	 Onzg2LILE2+JvwSWSlI4cbsA3xGzbRZOG/MoHBPQwoF9pS37VIRWxkRztgX4In4M/H
	 a8PeaPntYXeCA==
Date: Wed, 29 Apr 2026 07:33:20 -0700
Subject: [PATCH 1/9] fuse: enable caching of timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206510.4103309.7610933581068572895.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache the timestamps in the kernel so that the kernel sends FUSE_SETATTR
calls to the fuse server after writes, because the iomap infrastructure
won't do that for us.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c        |    5 ++++-
 fs/fuse/file.c       |   18 ++++++++++++------
 fs/fuse/fuse_iomap.c |    6 ++++++
 fs/fuse/inode.c      |   13 +++++++------
 4 files changed, 29 insertions(+), 13 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3a76eea04c6425..11898102adefe2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2265,7 +2265,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_attr_out outarg;
 	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = false;
-	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
+	bool is_wb = (is_iomap || fc->writeback_cache) &&
+		     S_ISREG(inode->i_mode);
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb;
@@ -2405,6 +2406,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
+		if ((attr->ia_valid & ATTR_ATIME) && is_iomap)
+			inode_set_atime_to_ts(inode, attr->ia_atime);
 		if (attr->ia_valid & ATTR_MTIME)
 			inode_set_mtime_to_ts(inode, attr->ia_mtime);
 		if (attr->ia_valid & ATTR_CTIME)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fa67b20f5ad3ae..eecd0610fbd3e5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -262,7 +262,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	int err;
 	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
-	bool is_wb_truncate = is_truncate && fc->writeback_cache;
+	bool is_wb_truncate = is_truncate && (is_iomap || fc->writeback_cache);
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
 
 	if (fuse_is_bad(inode))
@@ -477,12 +477,14 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_flush_in inarg;
 	FUSE_ARGS(args);
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int err;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+	if ((ff->open_flags & FOPEN_NOFLUSH) &&
+	    !fm->fc->writeback_cache && !is_iomap)
 		return 0;
 
 	err = write_inode_now(inode, 1);
@@ -518,7 +520,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	 * In memory i_blocks is not maintained by fuse, if writeback cache is
 	 * enabled, i_blocks from cached attr may not be accurate.
 	 */
-	if (!err && fm->fc->writeback_cache)
+	if (!err && (is_iomap || fm->fc->writeback_cache))
 		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
 	return err;
 }
@@ -820,8 +822,10 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	 * If writeback_cache is enabled, a short read means there's a hole in
 	 * the file.  Some data after the hole is in page cache, but has not
 	 * reached the client fs yet.  So the hole is not present there.
+	 * If iomap is enabled, a short read means we hit EOF so there's
+	 * nothing to adjust.
 	 */
-	if (!fc->writeback_cache) {
+	if (!fc->writeback_cache && !fuse_inode_has_iomap(inode)) {
 		loff_t pos = folio_pos(ap->folios[0]) + num_read;
 		fuse_read_update_size(inode, pos, attr_ver);
 	}
@@ -870,6 +874,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned int flags, struct iomap *iomap,
 			    struct iomap *srcmap)
 {
+	WARN_ON(fuse_inode_has_iomap(inode));
+
 	iomap->type = IOMAP_MAPPED;
 	iomap->length = length;
 	iomap->offset = offset;
@@ -2021,7 +2027,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	 * Do this only if writeback_cache is not enabled.  If writeback_cache
 	 * is enabled, we trust local ctime/mtime.
 	 */
-	if (!fc->writeback_cache)
+	if (!fc->writeback_cache && !fuse_inode_has_iomap(inode))
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
 	spin_lock(&fi->lock);
 	fi->writectr--;
@@ -3114,7 +3120,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
 	const bool is_iomap = fuse_inode_has_iomap(inode_out);
-	bool is_unstable = (!fc->writeback_cache) &&
+	bool is_unstable = (!fc->writeback_cache && !is_iomap) &&
 			   ((pos_out + len) > inode_out->i_size);
 
 	if (fc->no_copy_file_range)
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index cf52e2747e7f7f..a39370b97ca508 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1873,6 +1873,12 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	unsigned int min_order = 0;
 
+	/*
+	 * Manage timestamps ourselves, don't make the fuse server do it.  This
+	 * is critical for mtime updates to work correctly with page_mkwrite.
+	 */
+	inode->i_flags &= ~S_NOCMTIME;
+	inode->i_flags &= ~S_NOATIME;
 	inode->i_data.a_ops = &fuse_iomap_aops;
 
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d48a76e6d17995..2513ea108ff9a8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -331,10 +331,11 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
-		return 0;
+	if (S_ISREG(inode->i_mode) &&
+	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
+		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 
-	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
+	return 0;
 }
 
 static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr,
@@ -349,9 +350,9 @@ static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr
 
 	spin_lock(&fi->lock);
 	/*
-	 * In case of writeback_cache enabled, writes update mtime, ctime and
-	 * may update i_size.  In these cases trust the cached value in the
-	 * inode.
+	 * In case of writeback_cache or iomap enabled, writes update mtime,
+	 * ctime and may update i_size.  In these cases trust the cached value
+	 * in the inode.
 	 */
 	cache_mask = fuse_get_cache_mask(inode);
 	fuse_iomap_set_disk_size(fi, attr->size);

