Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF53F926D;
	Mon, 18 May 2026 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104943; cv=none; b=dis9jh/1+FeZd/o0I0fH809zAnNc9HMss4tboyH79LacG4XmMAsQPqbfxxeU+m2qU41YWB3EsspSxJmsxotUHIQKHMrn96OZerNiX7N24nQzjP5DBuvP2L/hTjlIb+JXHolMhB5Qi1OqrqYJIbz5X415SGdNS4khJpiyFVi4GtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104943; c=relaxed/simple;
	bh=4KEQ6/szQeIXJ4u2Mzaadi5hjOcYyTzhOZBTaUQvtVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmDo8nMRm1Wy74U7yuOCC7NudQiabBpcR0t3TR3v+VeF8tUGzrIOlQ7+f3ljiZgJse1niEoRkMCeK/RVAkur3CML2BuFn1KnEZlkTbbHv/dEJbJOQjoXVmGliQy1RmAruRuf+5MTiJXZMTAcmZeW0ZP3nRYNIXL9rScsrcqQXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7IGUjCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7IGUjCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF07BC2BCB7;
	Mon, 18 May 2026 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104943;
	bh=4KEQ6/szQeIXJ4u2Mzaadi5hjOcYyTzhOZBTaUQvtVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7IGUjCUC1eAybkUWmXXb7iBYtQHyawLBB1f9FhLFSwQCcChMQX3YwPY0vz9ZhQkZ
	 upHSMGr6uxHJs9XQOcVtCB3FuXFEpzDrzchwwbroSD7Qhh06eKBze5HICWwfPkx0k8
	 LVR80EQi5p/25VLWYUbf7wXNbYX+vMZJ6II5zLcrh+2wRQ4Fqw3zCOgg56qK6Hzlvn
	 rmNMJebRgUnBTMF3T2iO4D9sEGkq2encEBGrqevf8/u414yKTnd6qxQWROQRxCxd4p
	 LdY2Y2KRI5BsZAL5sByb522YXK3czgjIX85t2km8zIU/yx1xXpJshABfej+A07BY3J
	 hztz2gNjIWPaQ==
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
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 08/11] exfat: add iomap buffered I/O support
Date: Mon, 18 May 2026 20:47:02 +0900
Message-Id: <20260518114705.9601-9-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add full buffered I/O support using the iomap framework to the exfat
filesystem. This will replaces the old exfat_get_block(),
exfat_write_begin(), exfat_write_end(), and exfat_block_truncate_page()
with their iomap equivalents. Buffered writes now use
iomap_file_buffered_write(), read uses iomap_bio_read_folio() and
iomap_bio_readahead(), and writeback is handled through iomap_writepages().

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/Kconfig    |   1 +
 fs/exfat/Makefile   |   2 +-
 fs/exfat/exfat_fs.h |   6 +-
 fs/exfat/file.c     | 142 +++++++++++++++++++----------
 fs/exfat/inode.c    | 117 ++++++++----------------
 fs/exfat/iomap.c    | 213 ++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/iomap.h    |  14 +++
 7 files changed, 365 insertions(+), 130 deletions(-)
 create mode 100644 fs/exfat/iomap.c
 create mode 100644 fs/exfat/iomap.h

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
index cbeca8e44d9b..e0b200902253 100644
--- a/fs/exfat/Kconfig
+++ b/fs/exfat/Kconfig
@@ -5,6 +5,7 @@ config EXFAT_FS
 	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO
+	select FS_IOMAP
 	help
 	  This allows you to mount devices formatted with the exFAT file system.
 	  exFAT is typically used on SD-Cards or USB sticks.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
index ed51926a4971..e06bf85870ae 100644
--- a/fs/exfat/Makefile
+++ b/fs/exfat/Makefile
@@ -5,4 +5,4 @@
 obj-$(CONFIG_EXFAT_FS) += exfat.o
 
 exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
-	   file.o balloc.o
+	   file.o balloc.o iomap.o
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 08d22d2581da..2d482858bfaf 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -294,6 +294,8 @@ struct exfat_inode_info {
 	/* on-disk position of directory entry or 0 */
 	loff_t i_pos;
 	loff_t valid_size;
+	/* page-aligned size that has been zeroed out for mmap */
+	loff_t zeroed_size;
 	/* hash by i_location */
 	struct hlist_node i_hash_fat;
 	/* protect bmap against truncate */
@@ -649,7 +651,9 @@ struct inode *exfat_iget(struct super_block *sb, loff_t i_pos);
 int __exfat_write_inode(struct inode *inode, int sync);
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
 void exfat_evict_inode(struct inode *inode);
-int exfat_block_truncate_page(struct inode *inode, loff_t from);
+int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
+		unsigned int *clu, unsigned int *count, int create,
+		bool *balloc);
 
 /* exfat/nls.c */
 unsigned short exfat_toupper(struct super_block *sb, unsigned short a);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 1effdf08ab69..389ef7b36ed0 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -14,9 +14,11 @@
 #include <linux/writeback.h>
 #include <linux/filelock.h>
 #include <linux/falloc.h>
+#include <linux/iomap.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
+#include "iomap.h"
 
 static int exfat_cont_expand(struct inode *inode, loff_t size)
 {
@@ -26,8 +28,9 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_chain clu;
+	loff_t oldsize = i_size_read(inode);
 
-	truncate_pagecache(inode, i_size_read(inode));
+	truncate_pagecache(inode, oldsize);
 
 	ret = inode_newsize_ok(inode, size);
 	if (ret)
@@ -78,6 +81,13 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	/* Expanded range not zeroed, do not update valid_size */
 	i_size_write(inode, size);
+	/*
+	 * When extending file size, call truncate_pagecache() first,
+	 * then update i_size, and call pagecache_isize_extended()
+	 * to ensures the straddling folio is properly marked RO so
+	 * page_mkwrite() is called and post-EOF area is zeroed.
+	 */
+	pagecache_isize_extended(inode, oldsize, inode->i_size);
 
 	inode->i_blocks = round_up(size, sbi->cluster_size) >> 9;
 	mark_inode_dirty(inode);
@@ -236,7 +246,7 @@ int __exfat_truncate(struct inode *inode)
 	}
 
 	if (i_size_read(inode) < ei->valid_size)
-		ei->valid_size = i_size_read(inode);
+		ei->valid_size = ei->zeroed_size = i_size_read(inode);
 
 	if (ei->type == TYPE_FILE)
 		ei->attr |= EXFAT_ATTR_ARCHIVE;
@@ -383,10 +393,6 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	exfat_truncate_inode_atime(inode);
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		error = exfat_block_truncate_page(inode, attr->ia_size);
-		if (error)
-			goto out;
-
 		down_write(&EXFAT_I(inode)->truncate_lock);
 		truncate_setsize(inode, attr->ia_size);
 
@@ -631,42 +637,26 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 
 static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
 {
-	int err;
-	loff_t pos;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *ops = mapping->a_ops;
-
-	pos = ei->valid_size;
-	while (pos < new_valid_size) {
-		u32 len;
-		struct folio *folio;
-		unsigned long off;
-
-		len = PAGE_SIZE - (pos & (PAGE_SIZE - 1));
-		if (pos + len > new_valid_size)
-			len = new_valid_size - pos;
-
-		err = ops->write_begin(NULL, mapping, pos, len, &folio, NULL);
-		if (err)
-			goto out;
-
-		off = offset_in_folio(folio, pos);
-		folio_zero_new_buffers(folio, off, off + len);
+	loff_t old_valid_size = ei->valid_size;
+	int ret = 0;
 
-		err = ops->write_end(NULL, mapping, pos, len, len, folio, NULL);
-		if (err < 0)
-			goto out;
-		pos += len;
+	if (old_valid_size < new_valid_size) {
+		if (i_size_read(inode) < new_valid_size) {
+			i_size_write(inode, new_valid_size);
+			mark_inode_dirty(inode);
+		}
 
-		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
+		ret = iomap_zero_range(inode, old_valid_size,
+				new_valid_size - old_valid_size, NULL,
+				&exfat_write_iomap_ops, NULL, NULL);
+		if (ret) {
+			truncate_setsize(inode, old_valid_size);
+			exfat_truncate(inode);
+		}
 	}
 
-	return 0;
-
-out:
-	return err;
+	return ret;
 }
 
 static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
@@ -677,6 +667,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	loff_t pos = iocb->ki_pos;
 	loff_t valid_size;
+	int err;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
@@ -702,6 +693,12 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 	}
 
+	err = file_modified(iocb->ki_filp);
+	if (err) {
+		ret = err;
+		goto unlock;
+	}
+
 	if (pos > valid_size) {
 		ret = exfat_extend_valid_size(inode, pos);
 		if (ret < 0 && ret != -ENOSPC) {
@@ -713,7 +710,11 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto unlock;
 	}
 
-	ret = __generic_file_write_iter(iocb, iter);
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = __generic_file_write_iter(iocb, iter);
+	else
+		ret = iomap_file_buffered_write(iocb, iter,
+				&exfat_write_iomap_ops, NULL, NULL);
 	if (ret < 0)
 		goto unlock;
 
@@ -749,28 +750,56 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
 {
-	int err;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t new_valid_size;
+	vm_fault_t ret;
+	loff_t new_valid_size, mmap_valid_size;
 
 	if (!inode_trylock(inode))
 		return VM_FAULT_RETRY;
 
-	new_valid_size = ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
-	new_valid_size = min(new_valid_size, i_size_read(inode));
+	mmap_valid_size = ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
+	new_valid_size = min(mmap_valid_size, i_size_read(inode));
 
 	if (ei->valid_size < new_valid_size) {
-		err = exfat_extend_valid_size(inode, new_valid_size);
-		if (err < 0) {
-			inode_unlock(inode);
-			return vmf_fs_error(err);
+		if (ei->zeroed_size < mmap_valid_size) {
+			int err;
+
+			/*
+			 * Only zero the range that hasn't been zeroed yet for
+			 * this mmap write path. zeroed_size tracks the largest
+			 * page-aligned offset that has already been zeroed.
+			 *
+			 * This prevents unnecessarily zeroing out the entire
+			 * tail page on every page fault when userspace writes
+			 * data byte-by-byte through mmap (after a small
+			 * fallocate). It fixes data corruption in the tail page
+			 * while preserving the existing valid_size semantics.
+			 */
+			err = iomap_zero_range(inode, ei->zeroed_size,
+					mmap_valid_size - ei->zeroed_size, NULL,
+					&exfat_iomap_ops, NULL, NULL);
+			if (err < 0) {
+				inode_unlock(inode);
+				return vmf_fs_error(err);
+			}
+			ei->zeroed_size = mmap_valid_size;
 		}
+
+		ei->valid_size = new_valid_size;
+		mark_inode_dirty(inode);
 	}
 
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vmf->vma->vm_file);
+
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	ret = iomap_page_mkwrite(vmf, &exfat_write_iomap_ops, NULL);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+	sb_end_pagefault(inode->i_sb);
 	inode_unlock(inode);
 
-	return filemap_page_mkwrite(vmf);
+	return ret;
 }
 
 static const struct vm_operations_struct exfat_file_vm_ops = {
@@ -786,6 +815,25 @@ static int exfat_file_mmap_prepare(struct vm_area_desc *desc)
 	if (unlikely(exfat_forced_shutdown(file_inode(desc->file)->i_sb)))
 		return -EIO;
 
+	if (vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT)) {
+		struct inode *inode = file_inode(file);
+		loff_t from, to;
+		int err;
+
+		inode_lock(inode);
+		from = ((loff_t)desc->pgoff << PAGE_SHIFT);
+		to = min_t(loff_t, i_size_read(inode),
+				from + vma_desc_size(desc));
+		if (EXFAT_I(inode)->valid_size < to) {
+			err = exfat_extend_valid_size(inode, to);
+			if (err) {
+				inode_unlock(inode);
+				return err;
+			}
+		}
+		inode_unlock(inode);
+	}
+
 	file_accessed(file);
 	desc->vm_ops = &exfat_file_vm_ops;
 	return 0;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 7b09d94ac464..6083ccef9408 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -13,9 +13,11 @@
 #include <linux/uio.h>
 #include <linux/random.h>
 #include <linux/iversion.h>
+#include <linux/iomap.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
+#include "iomap.h"
 
 int __exfat_write_inode(struct inode *inode, int sync)
 {
@@ -76,15 +78,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
 		on_disk_size = 0;
 
 	ep2->dentry.stream.size = cpu_to_le64(on_disk_size);
-	/*
-	 * mmap write does not use exfat_write_end(), valid_size may be
-	 * extended to the sector-aligned length in exfat_get_block().
-	 * So we need to fixup valid_size to the writren length.
-	 */
-	if (on_disk_size < ei->valid_size)
-		ep2->dentry.stream.valid_size = ep2->dentry.stream.size;
-	else
-		ep2->dentry.stream.valid_size = cpu_to_le64(ei->valid_size);
+	ep2->dentry.stream.valid_size = cpu_to_le64(ei->valid_size);
 
 	if (on_disk_size) {
 		ep2->dentry.stream.flags = ei->flags;
@@ -123,7 +117,7 @@ void exfat_sync_inode(struct inode *inode)
  * Output: errcode, cluster number
  * *clu = (~0), if it's unable to allocate a new cluster
  */
-static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
+int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		unsigned int *clu, unsigned int *count, int create,
 		bool *balloc)
 {
@@ -377,7 +371,13 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 
 static int exfat_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_read_folio(folio, exfat_get_block);
+	struct iomap_read_folio_ctx ctx = {
+		.cur_folio = folio,
+		.ops = &exfat_iomap_bio_read_ops,
+	};
+
+	iomap_read_folio(&exfat_iomap_ops, &ctx, NULL);
+	return 0;
 }
 
 static void exfat_readahead(struct readahead_control *rac)
@@ -386,6 +386,10 @@ static void exfat_readahead(struct readahead_control *rac)
 	struct inode *inode = mapping->host;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	loff_t pos = readahead_pos(rac);
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &exfat_iomap_bio_read_ops,
+		.rac = rac,
+	};
 
 	/* Range cross valid_size, read it page by page. */
 	if (ei->valid_size < i_size_read(inode) &&
@@ -393,16 +397,22 @@ static void exfat_readahead(struct readahead_control *rac)
 	    ei->valid_size < pos + readahead_length(rac))
 		return;
 
-	mpage_readahead(rac, exfat_get_block);
+	iomap_readahead(&exfat_iomap_ops, &ctx, NULL);
 }
 
 static int exfat_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &exfat_writeback_ops,
+	};
+
 	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
 		return -EIO;
 
-	return mpage_writepages(mapping, wbc, exfat_get_block);
+	return iomap_writepages(&wpc);
 }
 
 static void exfat_write_failed(struct address_space *mapping, loff_t to)
@@ -416,51 +426,6 @@ static void exfat_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int exfat_write_begin(const struct kiocb *iocb,
-			     struct address_space *mapping,
-			     loff_t pos, unsigned int len,
-			     struct folio **foliop, void **fsdata)
-{
-	int ret;
-
-	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
-		return -EIO;
-
-	ret = block_write_begin(mapping, pos, len, foliop, exfat_get_block);
-
-	if (ret < 0)
-		exfat_write_failed(mapping, pos+len);
-
-	return ret;
-}
-
-static int exfat_write_end(const struct kiocb *iocb,
-			   struct address_space *mapping,
-			   loff_t pos, unsigned int len, unsigned int copied,
-			   struct folio *folio, void *fsdata)
-{
-	struct inode *inode = mapping->host;
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-	int err;
-
-	err = generic_write_end(iocb, mapping, pos, len, copied, folio, fsdata);
-	if (err < len)
-		exfat_write_failed(mapping, pos+len);
-
-	if (!(err < 0) && pos + err > ei->valid_size) {
-		ei->valid_size = pos + err;
-		mark_inode_dirty(inode);
-	}
-
-	if (!(err < 0) && !(ei->attr & EXFAT_ATTR_ARCHIVE)) {
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-		ei->attr |= EXFAT_ATTR_ARCHIVE;
-		mark_inode_dirty(inode);
-	}
-
-	return err;
-}
-
 static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
@@ -510,34 +475,23 @@ static sector_t exfat_aop_bmap(struct address_space *mapping, sector_t block)
 
 	/* exfat_get_cluster() assumes the requested blocknr isn't truncated. */
 	down_read(&EXFAT_I(mapping->host)->truncate_lock);
-	blocknr = generic_block_bmap(mapping, block, exfat_get_block);
+	blocknr = iomap_bmap(mapping, block, &exfat_iomap_ops);
 	up_read(&EXFAT_I(mapping->host)->truncate_lock);
 	return blocknr;
 }
 
-/*
- * exfat_block_truncate_page() zeroes out a mapping from file offset `from'
- * up to the end of the block which corresponds to `from'.
- * This is required during truncate to physically zeroout the tail end
- * of that block so it doesn't yield old data if the file is later grown.
- * Also, avoid causing failure from fsx for cases of "data past EOF"
- */
-int exfat_block_truncate_page(struct inode *inode, loff_t from)
-{
-	return block_truncate_page(inode->i_mapping, from, exfat_get_block);
-}
-
 static const struct address_space_operations exfat_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= exfat_read_folio,
-	.readahead	= exfat_readahead,
-	.writepages	= exfat_writepages,
-	.write_begin	= exfat_write_begin,
-	.write_end	= exfat_write_end,
-	.direct_IO	= exfat_direct_IO,
-	.bmap		= exfat_aop_bmap,
-	.migrate_folio	= buffer_migrate_folio,
+	.read_folio		= exfat_read_folio,
+	.readahead		= exfat_readahead,
+	.writepages		= exfat_writepages,
+	.dirty_folio		= iomap_dirty_folio,
+	.bmap			= exfat_aop_bmap,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.direct_IO		= exfat_direct_IO,
 };
 
 static inline unsigned long exfat_hash(loff_t i_pos)
@@ -601,6 +555,7 @@ static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
 	ei->flags = info->flags;
 	ei->type = info->type;
 	ei->valid_size = info->valid_size;
+	ei->zeroed_size = info->valid_size;
 
 	ei->version = 0;
 	ei->hint_stat.eidx = 0;
diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
new file mode 100644
index 000000000000..b360fadc9d58
--- /dev/null
+++ b/fs/exfat/iomap.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * iomap callack functions
+ *
+ * Copyright (C) 2026 Namjae Jeon <linkinjeon@kernel.org>
+ */
+
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+#include "iomap.h"
+
+static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned int flags, struct iomap *iomap, bool may_alloc)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	unsigned int cluster, num_clusters;
+	loff_t cluster_offset, cluster_length;
+	int err;
+	bool balloc = false;
+
+	if (!may_alloc) {
+		/* Completely beyond EOF. Treat as hole */
+		if (i_size_read(inode) <= offset) {
+			iomap->type = IOMAP_HOLE;
+			iomap->addr = IOMAP_NULL_ADDR;
+			iomap->offset = offset;
+			iomap->length = length;
+			return 0;
+		}
+
+		/* Clamp length if the requested range goes beyond i_size */
+		if (offset + length > i_size_read(inode))
+			length = round_up(i_size_read(inode),
+					  i_blocksize(inode)) - offset;
+	}
+
+	num_clusters = exfat_bytes_to_cluster_round_up(sbi,
+			offset + length) - exfat_bytes_to_cluster(sbi, offset);
+
+	mutex_lock(&sbi->s_lock);
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = offset;
+
+	err = exfat_map_cluster(inode, exfat_bytes_to_cluster(sbi, offset),
+			&cluster, &num_clusters, may_alloc, &balloc);
+	if (err)
+		goto out;
+
+	cluster_offset = exfat_cluster_offset(sbi, offset);
+	cluster_length = exfat_cluster_to_bytes(sbi, num_clusters);
+
+	iomap->length = min_t(loff_t, length, cluster_length - cluster_offset);
+	iomap->addr = exfat_cluster_to_phys_bytes(sbi, cluster) + cluster_offset;
+	iomap->type = IOMAP_MAPPED;
+	if (may_alloc) {
+		if (balloc)
+			iomap->flags = IOMAP_F_NEW;
+		else if (iomap->offset + iomap->length >= ei->valid_size) {
+			/*
+			 * This is a write that starts at or extends beyond
+			 * the current valid_size. The region between the old
+			 * valid_size and the end of this write needs to be
+			 * zeroed in the page cache to prevent stale data
+			 * exposure (see IOMAP_F_ZERO_TAIL handling in
+			 * __iomap_write_begin()).
+			 */
+			iomap->flags = IOMAP_F_ZERO_TAIL;
+		}
+	} else {
+		if (offset >= ei->valid_size) {
+			iomap->type = IOMAP_UNWRITTEN;
+		} else if (offset + iomap->length > ei->valid_size) {
+			iomap->length = round_up(ei->valid_size,
+						 i_blocksize(inode)) -
+							iomap->offset;
+		}
+	}
+
+	iomap->flags |= IOMAP_F_MERGED;
+out:
+	mutex_unlock(&sbi->s_lock);
+	return err;
+}
+
+static int exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return __exfat_iomap_begin(inode, offset, length, flags, iomap, false);
+}
+
+static int exfat_write_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return __exfat_iomap_begin(inode, offset, length, flags, iomap, true);
+}
+
+const struct iomap_ops exfat_iomap_ops = {
+	.iomap_begin = exfat_iomap_begin,
+};
+
+/*
+ * exfat_write_iomap_end - Update the state after write
+ *
+ * Extends ->valid_size to cover the newly written range.
+ * Marks the inode dirty if metadata was changed.
+ */
+static int exfat_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	bool dirtied = false;
+	loff_t end;
+
+	if (!written)
+		return 0;
+
+	end = pos + written;
+
+	if (ei->valid_size < end) {
+		ei->valid_size = end;
+		if (ei->zeroed_size < end)
+			ei->zeroed_size = end;
+		dirtied = true;
+	}
+
+	if (dirtied || iomap->flags & IOMAP_F_SIZE_CHANGED)
+		mark_inode_dirty(inode);
+
+	return written;
+}
+
+const struct iomap_ops exfat_write_iomap_ops = {
+	.iomap_begin	= exfat_write_iomap_begin,
+	.iomap_end	= exfat_write_iomap_end,
+};
+
+/*
+ * exfat_writeback_range - Map folio during writeback
+ *
+ * Called for each folio during writeback. If the folio falls outside the
+ * current iomap, remaps by calling read_iomap_begin.
+ */
+static ssize_t exfat_writeback_range(struct iomap_writepage_ctx *wpc,
+		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
+{
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		int error;
+
+		error = __exfat_iomap_begin(wpc->inode, offset, len,
+				0, &wpc->iomap, false);
+		if (error)
+			return error;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+}
+
+const struct iomap_writeback_ops exfat_writeback_ops = {
+	.writeback_range	= exfat_writeback_range,
+	.writeback_submit	= iomap_ioend_writeback_submit,
+};
+
+/**
+ * exfat_iomap_read_end_io - iomap read bio completion handler for exFAT
+ * @bio: bio that has completed reading
+ *
+ * exfat_iomap_begin() rounds up MAPPED extents to the block boundary of
+ * valid_size. This ensures that any subsequent blocks are treated as
+ * IOMAP_UNWRITTEN, but it also causes the "straddle block" containing
+ * valid_size to be read from disk. The disk data beyond valid_size in
+ * this block is stale and must be zeroed to prevent data leakage.
+ */
+static void exfat_iomap_read_end_io(struct bio *bio)
+{
+	int error = blk_status_to_errno(bio->bi_status);
+	struct folio_iter iter;
+
+	bio_for_each_folio_all(iter, bio) {
+		struct folio *folio = iter.folio;
+		struct exfat_inode_info *ei = EXFAT_I(folio->mapping->host);
+		s64 valid_size;
+		loff_t pos = folio_pos(folio);
+
+		valid_size = ei->valid_size;
+		if (pos + iter.offset < valid_size &&
+		    pos + iter.offset + iter.length > valid_size)
+			folio_zero_segment(folio, offset_in_folio(folio, valid_size),
+					   iter.offset + iter.length);
+
+		iomap_finish_folio_read(folio, iter.offset, iter.length, error);
+	}
+	bio_put(bio);
+}
+
+static void exfat_iomap_bio_submit_read(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx)
+{
+	struct bio *bio = ctx->read_ctx;
+
+	bio->bi_end_io = exfat_iomap_read_end_io;
+	submit_bio(bio);
+}
+
+const struct iomap_read_ops exfat_iomap_bio_read_ops = {
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= exfat_iomap_bio_submit_read,
+};
diff --git a/fs/exfat/iomap.h b/fs/exfat/iomap.h
new file mode 100644
index 000000000000..7f8dcbe20a17
--- /dev/null
+++ b/fs/exfat/iomap.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 Namjae Jeon <linkinjeon@kernel.org>
+ */
+
+#ifndef _LINUX_EXFAT_IOMAP_H
+#define _LINUX_EXFAT_IOMAP_H
+
+extern const struct iomap_ops exfat_iomap_ops;
+extern const struct iomap_ops exfat_write_iomap_ops;
+extern const struct iomap_writeback_ops exfat_writeback_ops;
+extern const struct iomap_read_ops exfat_iomap_bio_read_ops;
+
+#endif /* _LINUX_EXFAT_IOMAP_H */
-- 
2.25.1

