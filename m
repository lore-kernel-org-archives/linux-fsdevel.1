Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A634751B;
	Wed, 13 May 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671356; cv=none; b=Ox5jdiTyGssSCreqgXEg1/fWr+AzxXjbAK+m32AhckyTfngsny6c8+I4yVVv3IDoG5kapoDzRo/c3meKvdIn7VgW6Pi0ylkEONHTGDOupA7nJP8o8RHb2c33bfMXSh0bcC/c5RI/Ms7LiGlH+P+pybHkR2O1NBrBOi0xd+1+qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671356; c=relaxed/simple;
	bh=2qIjAfomMaFbyoT130Ipe4Dz2JPaqvxaAfe4xWCctGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNqlNqveoX/jASml3vAzDuJR3wx/0mzGlUnZ4AE/plRxU6tsOere/o6ZvjUzXW0gOMuT66/jn8orfxo5xA99m9SMpM5YGBNDrqOewqkogs7P6pBLMWourFUCtdFb6pMkIeEZy6OP6WcBOv1j/RhQgUhxXK1hc3qO3ZdzO1W3SdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWly4NCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWly4NCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A66C2BCC7;
	Wed, 13 May 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671356;
	bh=2qIjAfomMaFbyoT130Ipe4Dz2JPaqvxaAfe4xWCctGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWly4NCVd8wQ3DXBzRONVogOweMtRUIYarnG2mDGMdKVbYCUIuqdrxtbBTVWSBOQz
	 LIFuivGqVRw61raeD251k0xOUpIHL63fPOURuXsiyy+s6fMiFr2l5NQ3dDz9IJSeGS
	 dJrtoNnQ4T0WifFSlc81u3cxshkGMNo1nyc3TFL5ypaZP2+/+sF7U1O5T61NHyQk5C
	 Sj3OtKXQVQfgE0A3lo7/xdr/pXJTZ2RypvP6NsquU49dxfvrD4FvjsmvBWTARHhBnc
	 Bw2LpovoS2Q6f4VwAlN+mJquM4cFyeVHig2ROJcdWNuaj7jEuhwL4KnYS/JPtnAKeC
	 gYFGU7mkbYgfg==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 09/11] exfat: add iomap direct I/O support
Date: Wed, 13 May 2026 20:21:54 +0900
Message-Id: <20260513112156.9122-10-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260513112156.9122-1-linkinjeon@kernel.org>
References: <20260513112156.9122-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap-based direct I/O support to the exfat filesystem. This replaces
the previous exfat_direct_IO() implementation that used
blockdev_direct_IO() with iomap_dio_rw() interface.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/Kconfig    |   1 -
 fs/exfat/exfat_fs.h |   1 -
 fs/exfat/file.c     |  88 +++++++++++++++----
 fs/exfat/inode.c    | 200 --------------------------------------------
 fs/exfat/iomap.c    |  26 ++++++
 fs/exfat/iomap.h    |   1 +
 6 files changed, 101 insertions(+), 216 deletions(-)

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
index e0b200902253..1fcb10c8d7bc 100644
--- a/fs/exfat/Kconfig
+++ b/fs/exfat/Kconfig
@@ -4,7 +4,6 @@ config EXFAT_FS
 	tristate "exFAT filesystem support"
 	select BUFFER_HEAD
 	select NLS
-	select LEGACY_DIRECT_IO
 	select FS_IOMAP
 	help
 	  This allows you to mount devices formatted with the exFAT file system.
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 448857d4b70f..6f3ad1586261 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -557,7 +557,6 @@ int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
 /* file.c */
 extern const struct file_operations exfat_file_operations;
 int __exfat_truncate(struct inode *inode);
-void exfat_truncate(struct inode *inode);
 int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
 int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 389ef7b36ed0..bd947e963f93 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -292,7 +292,7 @@ int __exfat_truncate(struct inode *inode)
 	return 0;
 }
 
-void exfat_truncate(struct inode *inode)
+static void exfat_truncate(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -659,6 +659,55 @@ static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
 	return ret;
 }
 
+static ssize_t exfat_fallback_buffered_write(struct kiocb *iocb,
+		struct iov_iter *from)
+{
+	loff_t offset = iocb->ki_pos;
+	ssize_t written;
+	int ret;
+
+	iocb->ki_flags &= ~IOCB_DIRECT;
+
+	written = iomap_file_buffered_write(iocb, from, &exfat_write_iomap_ops,
+			NULL, NULL);
+	if (written < 0)
+		return written;
+
+	ret = filemap_write_and_wait_range(iocb->ki_filp->f_mapping,
+			offset, iocb->ki_pos + written - 1);
+	if (ret)
+		return -EIO;
+
+	invalidate_mapping_pages(iocb->ki_filp->f_mapping,
+			offset >> PAGE_SHIFT,
+			(iocb->ki_pos + written - 1) >> PAGE_SHIFT);
+
+	return written;
+}
+
+static ssize_t exfat_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t ret;
+
+	ret = iomap_dio_rw(iocb, from, &exfat_write_iomap_ops,
+			&exfat_write_dio_ops, 0, NULL, 0);
+	if (ret == -ENOTBLK)
+		ret = 0;
+	else if (ret < 0)
+		return ret;
+
+	if (iov_iter_count(from)) {
+		ssize_t written;
+
+		written = exfat_fallback_buffered_write(iocb, from);
+		if (written < 0)
+			return written;
+		ret += written;
+	}
+
+	return ret;
+}
+
 static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
@@ -683,16 +732,6 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret <= 0)
 		goto unlock;
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		unsigned long align = pos | iov_iter_alignment(iter);
-
-		if (!IS_ALIGNED(align, i_blocksize(inode)) &&
-		    !IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev))) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-	}
-
 	err = file_modified(iocb->ki_filp);
 	if (err) {
 		ret = err;
@@ -711,7 +750,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		ret = __generic_file_write_iter(iocb, iter);
+		ret = exfat_dio_write_iter(iocb, iter);
 	else
 		ret = iomap_file_buffered_write(iocb, iter,
 				&exfat_write_iomap_ops, NULL, NULL);
@@ -741,11 +780,24 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-	return generic_file_read_iter(iocb, iter);
+	inode_lock_shared(inode);
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		file_accessed(iocb->ki_filp);
+		ret = iomap_dio_rw(iocb, iter, &exfat_iomap_ops, NULL, 0,
+				NULL, 0);
+	} else {
+		ret = generic_file_read_iter(iocb, iter);
+	}
+
+	inode_unlock_shared(inode);
+
+	return ret;
 }
 
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
@@ -850,10 +902,18 @@ static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,
 
 static int exfat_file_open(struct inode *inode, struct file *filp)
 {
+	int err;
+
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-	return generic_file_open(inode, filp);
+	err = generic_file_open(inode, filp);
+	if (err)
+		return err;
+
+	filp->f_mode |= FMODE_CAN_ODIRECT;
+
+	return 0;
 }
 
 const struct file_operations exfat_file_operations = {
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 6083ccef9408..e58561d65294 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -224,151 +224,6 @@ int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	return 0;
 }
 
-static int exfat_get_block(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh_result, int create)
-{
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct super_block *sb = inode->i_sb;
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
-	int err = 0;
-	unsigned long mapped_blocks = 0;
-	unsigned int cluster, sec_offset, count;
-	sector_t last_block;
-	sector_t phys = 0;
-	sector_t valid_blks;
-	loff_t i_size;
-
-	mutex_lock(&sbi->s_lock);
-	i_size = i_size_read(inode);
-	last_block = exfat_bytes_to_block_round_up(sb, i_size);
-	if (iblock >= last_block && !create)
-		goto done;
-
-	/* Is this block already allocated? */
-	count = exfat_bytes_to_cluster_round_up(sbi, bh_result->b_size);
-	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
-			&cluster, &count, create, NULL);
-	if (err) {
-		if (err != -ENOSPC)
-			exfat_fs_error_ratelimit(sb,
-				"failed to bmap (inode : %p iblock : %llu, err : %d)",
-				inode, (unsigned long long)iblock, err);
-		goto unlock_ret;
-	}
-
-	if (cluster == EXFAT_EOF_CLUSTER)
-		goto done;
-
-	/* sector offset in cluster */
-	sec_offset = iblock & (sbi->sect_per_clus - 1);
-
-	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
-	mapped_blocks = ((unsigned long)count << sbi->sect_per_clus_bits) - sec_offset;
-	max_blocks = min(mapped_blocks, max_blocks);
-
-	map_bh(bh_result, sb, phys);
-	if (buffer_delay(bh_result))
-		clear_buffer_delay(bh_result);
-
-	/*
-	 * In most cases, we just need to set bh_result to mapped, unmapped
-	 * or new status as follows:
-	 *  1. i_size == valid_size
-	 *  2. write case (create == 1)
-	 *  3. direct_read (!bh_result->b_folio)
-	 *     -> the unwritten part will be zeroed in exfat_direct_IO()
-	 *
-	 * Otherwise, in the case of buffered read, it is necessary to take
-	 * care the last nested block if valid_size is not equal to i_size.
-	 */
-	if (i_size == ei->valid_size || create || !bh_result->b_folio)
-		valid_blks = exfat_bytes_to_block_round_up(sb, ei->valid_size);
-	else
-		valid_blks = exfat_bytes_to_block(sb, ei->valid_size);
-
-	/* The range has been fully written, map it */
-	if (iblock + max_blocks < valid_blks)
-		goto done;
-
-	/* The range has been partially written, map the written part */
-	if (iblock < valid_blks) {
-		max_blocks = valid_blks - iblock;
-		goto done;
-	}
-
-	/* The area has not been written, map and mark as new for create case */
-	if (create) {
-		set_buffer_new(bh_result);
-		ei->valid_size = exfat_block_to_bytes(sb, iblock + max_blocks);
-		mark_inode_dirty(inode);
-		goto done;
-	}
-
-	/*
-	 * The area has just one block partially written.
-	 * In that case, we should read and fill the unwritten part of
-	 * a block with zero.
-	 */
-	if (bh_result->b_folio && iblock == valid_blks &&
-	    (ei->valid_size & (sb->s_blocksize - 1))) {
-		loff_t size, pos;
-		void *addr;
-
-		max_blocks = 1;
-
-		/*
-		 * No buffer_head is allocated.
-		 * (1) bmap: It's enough to set blocknr without I/O.
-		 * (2) read: The unwritten part should be filled with zero.
-		 *           If a folio does not have any buffers,
-		 *           let's returns -EAGAIN to fallback to
-		 *           block_read_full_folio() for per-bh IO.
-		 */
-		if (!folio_buffers(bh_result->b_folio)) {
-			err = -EAGAIN;
-			goto done;
-		}
-
-		pos = exfat_block_to_bytes(sb, iblock);
-		size = ei->valid_size - pos;
-		addr = folio_address(bh_result->b_folio) +
-			offset_in_folio(bh_result->b_folio, pos);
-
-		/* Check if bh->b_data points to proper addr in folio */
-		if (bh_result->b_data != addr) {
-			exfat_fs_error_ratelimit(sb,
-					"b_data(%p) != folio_addr(%p)",
-					bh_result->b_data, addr);
-			err = -EINVAL;
-			goto done;
-		}
-
-		/* Read a block */
-		err = bh_read(bh_result, 0);
-		if (err < 0)
-			goto done;
-
-		/* Zero unwritten part of a block */
-		memset(bh_result->b_data + size, 0, bh_result->b_size - size);
-		err = 0;
-		goto done;
-	}
-
-	/*
-	 * The area has not been written, clear mapped for read/bmap cases.
-	 * If so, it will be filled with zero without reading from disk.
-	 */
-	clear_buffer_mapped(bh_result);
-done:
-	bh_result->b_size = exfat_block_to_bytes(sb, max_blocks);
-	if (err < 0)
-		clear_buffer_mapped(bh_result);
-unlock_ret:
-	mutex_unlock(&sbi->s_lock);
-	return err;
-}
-
 static int exfat_read_folio(struct file *file, struct folio *folio)
 {
 	struct iomap_read_folio_ctx ctx = {
@@ -415,60 +270,6 @@ static int exfat_writepages(struct address_space *mapping,
 	return iomap_writepages(&wpc);
 }
 
-static void exfat_write_failed(struct address_space *mapping, loff_t to)
-{
-	struct inode *inode = mapping->host;
-
-	if (to > i_size_read(inode)) {
-		truncate_pagecache(inode, i_size_read(inode));
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-		exfat_truncate(inode);
-	}
-}
-
-static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t pos = iocb->ki_pos;
-	loff_t size = pos + iov_iter_count(iter);
-	int rw = iov_iter_rw(iter);
-	ssize_t ret;
-
-	/*
-	 * Need to use the DIO_LOCKING for avoiding the race
-	 * condition of exfat_get_block() and ->truncate().
-	 */
-	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
-	if (ret < 0) {
-		if (rw == WRITE && ret != -EIOCBQUEUED)
-			exfat_write_failed(mapping, size);
-
-		return ret;
-	}
-
-	size = pos + ret;
-
-	if (rw == WRITE) {
-		/*
-		 * If the block had been partially written before this write,
-		 * ->valid_size will not be updated in exfat_get_block(),
-		 * update it here.
-		 */
-		if (ei->valid_size < size) {
-			ei->valid_size = size;
-			mark_inode_dirty(inode);
-		}
-	} else if (pos < ei->valid_size && ei->valid_size < size) {
-		/* zero the unwritten part in the partially written block */
-		iov_iter_revert(iter, size - ei->valid_size);
-		iov_iter_zero(size - ei->valid_size, iter);
-	}
-
-	return ret;
-}
-
 static sector_t exfat_aop_bmap(struct address_space *mapping, sector_t block)
 {
 	sector_t blocknr;
@@ -491,7 +292,6 @@ static const struct address_space_operations exfat_aops = {
 	.error_remove_folio	= generic_error_remove_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
-	.direct_IO		= exfat_direct_IO,
 };
 
 static inline unsigned long exfat_hash(loff_t i_pos)
diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index f7e66a4061fb..8d3c95d00a01 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -12,6 +12,32 @@
 #include "exfat_fs.h"
 #include "iomap.h"
 
+/*
+ * exfat_file_write_dio_end_io - Direct I/O write completion handler
+ *
+ * Updates i_size if the write extended the file. Called from the dio layer
+ * after I/O completion.
+ */
+static int exfat_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
+		int error, unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error)
+		return error;
+
+	if (size && i_size_read(inode) < iocb->ki_pos + size) {
+		i_size_write(inode, iocb->ki_pos + size);
+		mark_inode_dirty(inode);
+	}
+
+	return 0;
+}
+
+const struct iomap_dio_ops exfat_write_dio_ops = {
+	.end_io		= exfat_file_write_dio_end_io,
+};
+
 static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, bool may_alloc)
 {
diff --git a/fs/exfat/iomap.h b/fs/exfat/iomap.h
index 7f8dcbe20a17..830388f386f4 100644
--- a/fs/exfat/iomap.h
+++ b/fs/exfat/iomap.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_EXFAT_IOMAP_H
 #define _LINUX_EXFAT_IOMAP_H
 
+extern const struct iomap_dio_ops exfat_write_dio_ops;
 extern const struct iomap_ops exfat_iomap_ops;
 extern const struct iomap_ops exfat_write_iomap_ops;
 extern const struct iomap_writeback_ops exfat_writeback_ops;
-- 
2.25.1

