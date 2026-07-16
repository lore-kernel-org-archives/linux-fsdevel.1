Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB42427F19F;
	Thu, 16 Jul 2026 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170054; cv=none; b=oR4HRdaTJrBV3CQoU5axnbkG4f1hgQ33CUBTgipLWgl/3ijM2Jv/Q1jlmsLXn7NMkC7mvH2LJGtjIUc0AbSHIl79x09FcFWAfSnGQzxYtfstRojRIiPRq10xvpmOfmq+jdyioMQc/UQpoqY+yj2+l4mG5Kdb7h2VINBhtlOCtLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170054; c=relaxed/simple;
	bh=EadGsnhomBSrXrwF90IfmoyD/VA8NaiY0HgA6t8iufo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGeVGw1beo/bGeFhTYH9vOIYAjESTuSSjFdjSptSFXqPICvII/EUt173nbiuNoIkSJnFYJvMfxQQ55rPeDoP3zH+qEE52BQpLCrZM4Zdb4MlaEmwPY3/AlDsvIqoOFj3OmO8Y3jtF8zZN85Mz/cqG8EjWxFEjHC69ZjuBatYh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huGEOE8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huGEOE8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21AF1F00A3A;
	Thu, 16 Jul 2026 02:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170052;
	bh=nXkQ4nnihBbhHD8fmJFZ6LxcgaOmCsRqTwnsciJLfhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huGEOE8eRdNg7xUDL9E0y4VmqSSFDK8NV7hBxqNE7VGm+kKb2MvaxJiFBeZRTUs0t
	 SMuo7GWYKyC0Ti1v9j0aTmWiZL8iD4aoEBwcw2zutofSz9BStlNskKMJvI40G94Lds
	 z2rCtKLxXLx2W+k0WPvW6DLa45rKWbIqsv2gECzZdKtT6cJHNfEPQZIGuQ4F3INlTU
	 qqOie2ssuVr8JLJh+J8E5jW55uV9kA5hZfge6QkKCEs6/gvt41A79PuRrVhJk2jQcv
	 f8o2HWtVuBCl2+zF0ZIA+RxBJjZ528lC+he1YjCN9AAquKcZDO9d7Ftt8laiawGaMZ
	 2d5dCYcnDfaqg==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ntfs: file extension before write submission
Date: Thu, 16 Jul 2026 11:46:39 +0900
Message-Id: <20260716024640.13396-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260716024640.13396-1-linkinjeon@kernel.org>
References: <20260716024640.13396-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare non-resident file allocation and initialized-size extension in
->write_iter() before entering the buffered or direct iomap write paths.

Previously, the iomap write callback extended initialized_size. When a
direct write started beyond initialized_size,
ntfs_extend_initialized_size() used iomap_zero_range() to zero the gap
through the page cache. This created dirty folios after iomap DIO had
invalidated its target cache range. The bsync path then had to
synchronously write back the entire zeroed gap to prevent the post-DIO
invalidation from encountering a dirty boundary folio.

Move allocation and initialized-size preparation ahead of iomap submission.
For DIO, kiocb_invalidate_pages() now sees any dirty boundary folio created
by iomap_zero_range(), writes it back when necessary, and invalidates it
before the direct I/O is issued. This removes the explicit synchronous
writeback of the zeroed gap while preserving the required boundary-folio
ordering.

Keep compressed writes out of the early initialized-size extension so their
existing write path can zero uninitialized data before compression. Move
compressed-file allocation expansion to write_iter as well, eliminating the
now-redundant expansion from ntfs_compress_write().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/compress.c | 10 ----------
 fs/ntfs/file.c     | 43 +++++++++++++++++++++++++++++++++++++++++--
 fs/ntfs/inode.c    |  6 +-----
 fs/ntfs/inode.h    |  2 +-
 fs/ntfs/iomap.c    | 34 +---------------------------------
 5 files changed, 44 insertions(+), 51 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index e866f43ca30b..fe1877b86f49 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -1459,16 +1459,6 @@ int ntfs_compress_write(struct ntfs_inode *ni, loff_t pos, size_t count,
 	size_t written = 0;
 	struct address_space *mapping = VFS_I(ni)->i_mapping;
 
-	if (NInoCompressed(ni) && pos + count > ni->allocated_size) {
-		int err;
-		loff_t end = pos + count;
-
-		err = ntfs_attr_expand(ni, end,
-				round_up(end, ni->itype.compressed.block_size));
-		if (err)
-			return err;
-	}
-
 	pages = kmalloc_array(pages_per_cb, sizeof(struct page *), GFP_NOFS);
 	if (!pages)
 		return -ENOMEM;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 6a7b638e523d..9061f8f77f7e 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -535,6 +535,31 @@ static ssize_t ntfs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
+static int ntfs_expand_for_write(struct ntfs_inode *ni, loff_t end)
+{
+	struct ntfs_volume *vol = ni->vol;
+	loff_t prealloc_size = 0;
+	int err;
+
+	if (end <= ni->data_size)
+		return 0;
+
+	if (NInoCompressed(ni)) {
+		if (end > ni->allocated_size)
+			prealloc_size = round_up(end,
+						 ni->itype.compressed.block_size);
+	} else if (end > ni->allocated_size &&
+		   end < ni->allocated_size + vol->preallocated_size) {
+		prealloc_size = ni->allocated_size + vol->preallocated_size;
+	}
+
+	mutex_lock(&ni->mrec_lock);
+	err = ntfs_attr_expand(ni, end, prealloc_size);
+	mutex_unlock(&ni->mrec_lock);
+
+	return err;
+}
+
 static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -543,7 +568,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct ntfs_volume *vol = ni->vol;
 	ssize_t ret;
 	ssize_t count;
-	loff_t pos;
+	loff_t pos, end;
 	int err;
 	loff_t old_data_size, old_init_size;
 
@@ -580,10 +605,24 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	pos = iocb->ki_pos;
 	count = ret;
+	end = pos + count;
 
 	old_data_size = ni->data_size;
 	old_init_size = ni->initialized_size;
 
+	if (end > old_data_size) {
+		ret = ntfs_expand_for_write(ni, end);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (NInoNonResident(ni) && !NInoCompressed(ni) &&
+	    end > old_init_size) {
+		ret = ntfs_extend_initialized_size(vi, pos, end);
+		if (ret < 0)
+			goto out;
+	}
+
 	if (NInoNonResident(ni) && NInoCompressed(ni)) {
 		ret = ntfs_compress_write(ni, pos, count, from);
 		if (ret > 0)
@@ -655,7 +694,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 			   from + desc->end - desc->start);
 
 		if (NTFS_I(inode)->initialized_size < to) {
-			err = ntfs_extend_initialized_size(inode, to, to, false);
+			err = ntfs_extend_initialized_size(inode, to, to);
 			if (err)
 				return err;
 		}
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 7381a18cfadd..50e244aa372e 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2401,7 +2401,7 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 }
 
 int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
-				 const loff_t new_size, bool bsync)
+				 const loff_t new_size)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
 	loff_t old_init_size;
@@ -2428,10 +2428,6 @@ int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
 				       &ntfs_iomap_folio_ops, NULL);
 		if (err)
 			return err;
-		if (bsync)
-			err = filemap_write_and_wait_range(vi->i_mapping,
-							   old_init_size,
-							   offset - 1);
 	}
 
 
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 9aacd5787ffe..c6d065aaecd5 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -352,7 +352,7 @@ static inline void ntfs_commit_inode(struct inode *vi)
 
 int ntfs_inode_sync_filename(struct ntfs_inode *ni);
 int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
-		const loff_t new_size, bool bsync);
+		const loff_t new_size);
 void ntfs_set_vfs_operations(struct inode *inode, mode_t mode, dev_t dev);
 struct folio *ntfs_get_locked_folio(struct address_space *mapping,
 		pgoff_t index, pgoff_t end_index, struct file_ra_state *ra);
diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb256..26a1831a2c18 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -675,21 +675,7 @@ static int ntfs_write_iomap_begin_non_resident(struct inode *inode, loff_t offse
 					       loff_t length, unsigned int flags,
 					       struct iomap *iomap, int ntfs_iomap_flags)
 {
-	struct ntfs_inode *ni = NTFS_I(inode);
-
-	if (ntfs_iomap_flags & (NTFS_IOMAP_FLAGS_BEGIN | NTFS_IOMAP_FLAGS_DIO) &&
-	    offset + length > ni->initialized_size) {
-		int ret;
-
-		ret = ntfs_extend_initialized_size(inode, offset,
-						   offset + length,
-						   ntfs_iomap_flags &
-						   NTFS_IOMAP_FLAGS_DIO);
-		if (ret < 0)
-			return ret;
-	}
-
-	mutex_lock(&ni->mrec_lock);
+	mutex_lock(&NTFS_I(inode)->mrec_lock);
 	if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
 		return  ntfs_write_simple_iomap_begin_non_resident(inode, offset,
 								   length, iomap);
@@ -705,28 +691,10 @@ static int __ntfs_write_iomap_begin(struct inode *inode, loff_t offset,
 				    struct iomap *iomap, int ntfs_iomap_flags)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
-	loff_t end = offset + length;
 
 	if (NVolShutdown(ni->vol))
 		return -EIO;
 
-	if (ntfs_iomap_flags & (NTFS_IOMAP_FLAGS_BEGIN | NTFS_IOMAP_FLAGS_DIO) &&
-	    end > ni->data_size) {
-		struct ntfs_volume *vol = ni->vol;
-		int ret;
-
-		mutex_lock(&ni->mrec_lock);
-		if (end > ni->allocated_size &&
-		    end < ni->allocated_size + vol->preallocated_size)
-			ret = ntfs_attr_expand(ni, end,
-					ni->allocated_size + vol->preallocated_size);
-		else
-			ret = ntfs_attr_expand(ni, end, 0);
-		mutex_unlock(&ni->mrec_lock);
-		if (ret)
-			return ret;
-	}
-
 	if (!NInoNonResident(ni)) {
 		mutex_lock(&ni->mrec_lock);
 		return ntfs_write_iomap_begin_resident(inode, offset, iomap);
-- 
2.25.1

