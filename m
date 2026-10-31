Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465071;
	b=jEtJeBYK4AdxnMNRDKNMzwYGT8akp3f4eMeDPr2c35UiQYa4ZqcEOUlTFxfNj6LsHN6d
	 SI2EQ082sFJ1ZKnundtgmSoZdrebZ2oaRcW0Gs0mN8gK0HrIFcv9xpYasQbdLuErBcUIX
	 MKxmi2DxjTeo/5hOi3B5sXlH1l0Sb1M/k2bpG/3WkfDczxNLlsseHoRjbv6vioHyub8rO
	 AelTzdBnljj7pGd58RnYNp+j2o5WS2LpNjqUYUVED3XeCbn6XOxmRoYlRwBO5nfnf8Dw4
	 aBgPz6Ynw5PB+d3rJRjvfu8BIODty6hOU4pM4fXPAqIQESSMv6n3mwOXKFBEMjHTVzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465071;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0PmMqAfUOs12+NDVbE69ZLsuEf1No4KveDJoNk4lNwM=;
	b=fIgalhYDZ+o+JFnHgHHIrBnIoAT0ULiQw5FcTRGt1Y1kBXXQW5iZQ/WamhksF5I3+U9w
	 8O4qTimfufX4vEfh0gwb4cQgKlav7EkARRH3UjP+vn/q0eZTWLTdgMSJXil7rAdSgq4mW
	 byS22tYha8KNWKL6QDabLl3XGGE8OWfY7wA0A3XhM6us3MVf7siPMwK7+2FAalnqHqhKI
	 gvsSF2O2lYtAoyS5qgyjwq8vLQFvhsXqwRM4jkDAnac1IWMQ+Gzx/4BRkOOvARK41gmE0
	 TgDRnNo4aBzk9SqCeb/4StOOUxUmXBQAb59SOkEXdVpp+PKDqW0zScxSV44f4MduWNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=vuA83h+1;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70334606A31C;
	Sat, 31 Oct 2026 16:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70334606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=vuA83h+1
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 02CF2120590;
	Sat, 31 Oct 2026 13:43:50 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PmMqAfUOs12+NDVbE69ZLsuEf1No4KveDJoNk4lNwM=;
	b=vuA83h+1rhVWWUlOncIlwnse/MwMEOunDbAt1Q7ORMySfu3I1z54wRQtqCrU1fW7eMfpEW
	K1j3gAwwJe62ooPBJNytYjr8/9ehezIrrCVQetzGzf3z4mgxRUiobIQwPJaFY/7iDCdwCE
	nMjDwYTCbF9vtYqGDbrptwOhc8ehzetTZY89D8cd9e7Mq6H1CQtIk5XHMhdfHhgcauLBT5
	7At0j8zr7ac6P2CiivTEF3vP2VyKJwbqsrMI+TtaSyI9Je7yowiwUnW2dn/BHyTr6c/Rkg
	fg1mdnap8RpUGp5CUaImFtkzjpHPSQO7BfXtjO3w9Tb1LbdsbMFiFyQJutnPkA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 6/8] fat: add iomap buffered I/O support
Date: Sat, 31 Oct 2026 13:43:24 -0300
Message-ID: <20261031164326.278125-7-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iomap for buffered I/O, replacing buffer_heads. Remove
fat_get_block(), fat_write_begin(), fat_write_failed() as the iomap path
makes them unnecessary.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fat.h   |   4 +-
 fs/fat/file.c  |  72 +++++++++++++++++++----
 fs/fat/inode.c | 157 +++++--------------------------------------------
 fs/fat/iomap.c |  84 ++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 153 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index e14d6d9a6ac1..78c6fb5cdc46 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -415,9 +415,9 @@ extern int fat_getattr(const struct mnt_idmap *idmap,
 int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
 			  int datasync);
+int fat_preallocate(struct inode *inode, loff_t new_size);
 
 /* fat/inode.c */
-extern int fat_block_truncate_page(struct inode *inode, loff_t from);
 extern void fat_attach(struct inode *inode, loff_t i_pos);
 extern void fat_detach(struct inode *inode);
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
@@ -492,7 +492,9 @@ extern const struct export_operations fat_export_ops_nostale;
 /* fat/iomap.c */
 extern const struct iomap_ops fat_iomap_ops;
 extern const struct iomap_ops fat_iomap_bmap_ops;
+extern const struct iomap_ops fat_iomap_write_ops;
 extern const struct iomap_dio_ops fat_iomap_write_dio_ops;
+extern const struct iomap_writeback_ops fat_writeback_ops;
 
 /* helper for printk */
 typedef unsigned long long	llu;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 8689cbbdad13..723b671d5b4b 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -220,12 +220,13 @@ static ssize_t fat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
-		return generic_file_read_iter(iocb, iter);
-
 	inode_lock_shared(inode);
-	file_accessed(iocb->ki_filp);
-	ret = iomap_dio_rw(iocb, iter, &fat_iomap_ops, NULL, 0, NULL, 0);
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		file_accessed(iocb->ki_filp);
+		ret = iomap_dio_rw(iocb, iter, &fat_iomap_ops, NULL, 0, NULL, 0);
+	} else {
+		ret = generic_file_read_iter(iocb, iter);
+	}
 	inode_unlock_shared(inode);
 	return ret;
 }
@@ -266,6 +267,50 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
+static int fat_cont_expand(struct inode *inode, loff_t new_size);
+
+static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
+					    struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	loff_t offset, old_size, old_alloc, keep_alloc;
+	ssize_t ret;
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, iter);
+	if (ret <= 0)
+		goto out;
+
+	ret = file_modified(iocb->ki_filp);
+	if (ret)
+		goto out;
+
+	offset = iocb->ki_pos;
+	old_size = i_size_read(inode);
+	if (offset > old_size) {
+		/* We need to fill this hole */
+		ret = fat_cont_expand(inode, offset);
+		if (ret)
+			goto out;
+	}
+
+	inode_dio_wait(inode);
+	old_alloc = inode_get_bytes(inode);
+	ret = iomap_file_buffered_write(iocb, iter, &fat_iomap_write_ops,
+					NULL, NULL);
+	keep_alloc = max(old_alloc, round_up(i_size_read(inode),
+					     sbi->cluster_size));
+	if (inode_get_bytes(inode) > keep_alloc)
+		fat_truncate_blocks(inode, keep_alloc);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+
+out:
+	inode_unlock(inode);
+	return ret;
+}
+
 static ssize_t fat_file_write_iter_buffered_fallback(struct kiocb *iocb,
 						     struct iov_iter *iter)
 {
@@ -274,7 +319,7 @@ static ssize_t fat_file_write_iter_buffered_fallback(struct kiocb *iocb,
 	int err;
 
 	iocb->ki_flags &= ~IOCB_DIRECT;
-	ret = generic_file_write_iter(iocb, iter);
+	ret = fat_file_write_iter_buffered(iocb, iter);
 	if (ret <= 0)
 		return ret;
 
@@ -297,7 +342,7 @@ static ssize_t fat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;
 
 	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
-		return generic_file_write_iter(iocb, iter);
+		return fat_file_write_iter_buffered(iocb, iter);
 
 	ret = fat_file_dio_write_iter(iocb, iter);
 	if (ret == -ENOTBLK)
@@ -334,7 +379,7 @@ const struct file_operations fat_file_operations = {
 	.setlease	= generic_setlease,
 };
 
-static int fat_preallocate(struct inode *inode, loff_t new_size)
+int fat_preallocate(struct inode *inode, loff_t new_size)
 {
 	int nr_cluster; /* Number of clusters to be allocated */
 	loff_t mm_bytes; /* Number of bytes to be allocated for file */
@@ -755,11 +800,16 @@ int fat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		error = fat_block_truncate_page(inode, attr->ia_size);
+		filemap_invalidate_lock(inode->i_mapping);
+		error = iomap_truncate_page(inode, attr->ia_size, NULL,
+					    &fat_iomap_ops, NULL, NULL);
+		if (!error) {
+			truncate_setsize(inode, attr->ia_size);
+			fat_truncate_blocks(inode, attr->ia_size);
+		}
+		filemap_invalidate_unlock(inode->i_mapping);
 		if (error)
 			goto out;
-		truncate_setsize(inode, attr->ia_size);
-		fat_truncate_blocks(inode, attr->ia_size);
 	}
 
 	/*
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 953706aab68b..9df10e5a1ede 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -116,141 +116,27 @@ int fat_add_clusters(struct inode *inode, int nr_cluster)
 	return err;
 }
 
-static inline int __fat_get_block(struct inode *inode, sector_t iblock,
-				  unsigned long *max_blocks,
-				  struct buffer_head *bh_result, int create)
-{
-	struct super_block *sb = inode->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	unsigned long mapped_blocks;
-	sector_t phys, last_block;
-	int err, offset;
-
-	err = fat_bmap(inode, iblock, &phys, &mapped_blocks, create, false);
-	if (err)
-		return err;
-	if (phys) {
-		map_bh(bh_result, sb, phys);
-		*max_blocks = min(mapped_blocks, *max_blocks);
-		return 0;
-	}
-	if (!create)
-		return 0;
-
-	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
-		fat_fs_error(sb, "corrupted file size (i_pos %lld, %lld)",
-			MSDOS_I(inode)->i_pos, MSDOS_I(inode)->mmu_private);
-		return -EIO;
-	}
-
-	last_block = inode->i_blocks >> (sb->s_blocksize_bits - 9);
-	offset = (unsigned long)iblock & (sbi->sec_per_clus - 1);
-	/*
-	 * allocate a cluster according to the following.
-	 * 1) no more available blocks
-	 * 2) not part of fallocate region
-	 */
-	if (!offset && !(iblock < last_block)) {
-		/* TODO: multiple cluster allocation would be desirable. */
-		err = fat_add_clusters(inode, 1);
-		if (err)
-			return err;
-	}
-	/* available blocks on this cluster */
-	mapped_blocks = sbi->sec_per_clus - offset;
-
-	*max_blocks = min(mapped_blocks, *max_blocks);
-	MSDOS_I(inode)->mmu_private += *max_blocks << sb->s_blocksize_bits;
-
-	err = fat_bmap(inode, iblock, &phys, &mapped_blocks, create, false);
-	if (err)
-		return err;
-	if (!phys) {
-		fat_fs_error(sb,
-			     "invalid FAT chain (i_pos %lld, last_block %llu)",
-			     MSDOS_I(inode)->i_pos,
-			     (unsigned long long)last_block);
-		return -EIO;
-	}
-
-	BUG_ON(*max_blocks != mapped_blocks);
-	set_buffer_new(bh_result);
-	map_bh(bh_result, sb, phys);
-
-	return 0;
-}
-
-static int fat_get_block(struct inode *inode, sector_t iblock,
-			 struct buffer_head *bh_result, int create)
-{
-	struct super_block *sb = inode->i_sb;
-	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
-	int err;
-
-	err = __fat_get_block(inode, iblock, &max_blocks, bh_result, create);
-	if (err)
-		return err;
-	bh_result->b_size = max_blocks << sb->s_blocksize_bits;
-	return 0;
-}
-
 static int fat_writepages(struct address_space *mapping,
 			  struct writeback_control *wbc)
 {
-	return mpage_writepages(mapping, wbc, fat_get_block);
+	struct iomap_writepage_ctx wpc = {
+		.inode = mapping->host,
+		.wbc = wbc,
+		.ops = &fat_writeback_ops,
+	};
+
+	return iomap_writepages(&wpc);
 }
 
 static int fat_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_read_folio(folio, fat_get_block);
+	iomap_bio_read_folio(folio, &fat_iomap_ops);
+	return 0;
 }
 
 static void fat_readahead(struct readahead_control *rac)
 {
-	mpage_readahead(rac, fat_get_block);
-}
-
-static void fat_write_failed(struct address_space *mapping, loff_t to)
-{
-	struct inode *inode = mapping->host;
-
-	if (to > inode->i_size) {
-		truncate_pagecache(inode, inode->i_size);
-		fat_truncate_blocks(inode, inode->i_size);
-	}
-}
-
-static int fat_write_begin(const struct kiocb *iocb,
-			   struct address_space *mapping,
-			   loff_t pos, unsigned len,
-			   struct folio **foliop, void **fsdata)
-{
-	int err;
-
-	err = cont_write_begin(iocb, mapping, pos, len,
-				foliop, fsdata, fat_get_block,
-				&MSDOS_I(mapping->host)->mmu_private);
-	if (err < 0)
-		fat_write_failed(mapping, pos + len);
-	return err;
-}
-
-static int fat_write_end(const struct kiocb *iocb,
-			 struct address_space *mapping,
-			 loff_t pos, unsigned len, unsigned copied,
-			 struct folio *folio, void *fsdata)
-{
-	struct inode *inode = mapping->host;
-	int err;
-	err = generic_write_end(iocb, mapping, pos, len, copied, folio, fsdata);
-	if (err < len)
-		fat_write_failed(mapping, pos + len);
-	if (!(err < 0) && !(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
-		fat_truncate_time(inode, NULL, FAT_UPDATE_CMTIME);
-		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
-		mark_inode_dirty(inode);
-	}
-	return err;
+	iomap_bio_readahead(rac, &fat_iomap_ops);
 }
 
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
@@ -273,29 +159,18 @@ static int fat_swap_activate(struct swap_info_struct *sis, struct file *file,
 #endif
 }
 
-/*
- * fat_block_truncate_page() zeroes out a mapping from file offset `from'
- * up to the end of the block which corresponds to `from'.
- * This is required during truncate to physically zeroout the tail end
- * of that block so it doesn't yield old data if the file is later grown.
- * Also, avoid causing failure from fsx for cases of "data past EOF"
- */
-int fat_block_truncate_page(struct inode *inode, loff_t from)
-{
-	return block_truncate_page(inode->i_mapping, from, fat_get_block);
-}
-
 static const struct address_space_operations fat_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio	= iomap_dirty_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 	.read_folio	= fat_read_folio,
 	.readahead	= fat_readahead,
 	.writepages	= fat_writepages,
-	.write_begin	= fat_write_begin,
-	.write_end	= fat_write_end,
 	.bmap		= _fat_bmap,
-	.migrate_folio	= buffer_migrate_folio,
+	.migrate_folio	= filemap_migrate_folio,
 	.swap_activate  = fat_swap_activate,
+	.is_partially_uptodate = iomap_is_partially_uptodate,
+	.error_remove_folio = generic_error_remove_folio,
+	.release_folio = iomap_release_folio,
 };
 
 /*
diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
index 8a697deba9d4..cfeaea5d352e 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2026 Matheus Alves de Almeida
  */
 
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+
 #include "fat.h"
 
 static int __fat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
@@ -74,6 +77,65 @@ const struct iomap_ops fat_iomap_ops = {
 	.iomap_next = fat_iomap_next
 };
 
+static int fat_iomap_end_write(struct inode *inode, loff_t offset,
+			       loff_t length, ssize_t written,
+			       unsigned int flags, struct iomap *iomap)
+{
+	struct msdos_inode_info *mi = MSDOS_I(inode);
+
+	if (written > 0) {
+		mi->mmu_private = max(mi->mmu_private, offset + written);
+		if (!(mi->i_attrs & ATTR_ARCH)) {
+			mi->i_attrs |= ATTR_ARCH;
+			mark_inode_dirty(inode);
+		}
+	}
+
+	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
+		mark_inode_dirty(inode);
+
+	return 0;
+}
+
+static int fat_iomap_begin_write(struct inode *inode, loff_t offset,
+				 loff_t length, unsigned int flags,
+				 struct iomap *iomap, struct iomap *srcmap)
+{
+	loff_t curr_size = i_size_read(inode);
+	loff_t old_alloc = inode_get_bytes(inode);
+	int err;
+
+	/* Only support extending writes that start at EOF */
+	if (WARN_ONCE(offset > curr_size, "Write starting past EOF"))
+		return -EOPNOTSUPP;
+
+	if (offset == curr_size) {
+		/*
+		 * TODO: allocate multiple blocks while allowing
+		 * short writes
+		 */
+		err = fat_preallocate(inode, offset + 1);
+		if (err)
+			goto err_truncate;
+	}
+
+	err = __fat_iomap_begin(inode, offset, length, flags, iomap);
+	if (err)
+		goto err_truncate;
+
+	return 0;
+err_truncate:
+	fat_truncate_blocks(inode, old_alloc);
+	return err;
+}
+
+static DEFINE_IOMAP_ITER_NEXT_END(fat_iomap_next_write, fat_iomap_begin_write,
+				  fat_iomap_end_write);
+
+const struct iomap_ops fat_iomap_write_ops = {
+	.iomap_next = fat_iomap_next_write
+};
+
 static int fat_iomap_begin_bmap(struct inode *inode, loff_t offset,
 				loff_t length, unsigned int flags,
 				struct iomap *iomap, struct iomap *srcmap)
@@ -117,3 +179,25 @@ static int fat_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 const struct iomap_dio_ops fat_iomap_write_dio_ops = {
 	.end_io = fat_dio_write_end_io
 };
+
+static ssize_t fat_writeback_range(struct iomap_writepage_ctx *wpc,
+				   struct folio *folio, u64 offset,
+				   unsigned int len, u64 end_pos)
+{
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		int err;
+
+		err = __fat_iomap_begin(wpc->inode, offset, len, 0,
+					&wpc->iomap);
+		if (err)
+			return err;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+}
+
+const struct iomap_writeback_ops fat_writeback_ops = {
+	.writeback_range = fat_writeback_range,
+	.writeback_submit = iomap_ioend_writeback_submit,
+};
-- 
2.43.0

