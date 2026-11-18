Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967366;
	b=t7aNIbGvjaz6QcHqPmdTFZbZ9YBmjxaUqCQR/p3H83xN3ftsPlr4fMfL8Qj81jfF3Ko0
	 U4A7K8hdhE5C2+9WAWcako8vJIRzDu8ZgWqHAmyLJeQ92Ha2Yul8Frg6AUsH1jHTwKEU9
	 LQr+PT+gWs2SdceC7MnGZpeiiK7jrfZgXan6D6+anMtrTN4BQu05mJQjRPsbJZGqQ7cLR
	 jxvzzCQEGyRZz016CI8vexmhSfgEL0goVDO9XlRmztH606NWgr2FwukmaGu3QfAP1kRaA
	 E/YCPcDakUTPZQ0NFxmM9hzTs1u+uz4PdTQXbAmkndmHWr4QDYxnCV+0jOKa2wsrbOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967366;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UCiAhx1hm/TSC9teC4T/87YXFk0bp1j85ACc70iArcY=;
	b=OXM9yh0Lerbc/87jfSsOw2Xqkh0p1/LdQqqPc+8aOeyw+gw8YQhsTqkoLsVWHxJcy1hF
	 /0Plh6Dmg0qhrJO3JdaM89t5F4e8QqIhV6g89ggaZDifqeOjfcnovxtnQ7dMaPv6rsmTB
	 efvxhdvFCWCkaNL3RE3RlrNVYXBScdklaMUR4ibEaq9hiPlGo47wckYV2amCZ2eyL9TEl
	 PcsP2+deHY16hLnligcmYThDp/DrIgxBekxk7kaEuO2J9asgrdJ73x0LWMWmnYblypq+d
	 ajAeu72ov58oy/VyxZWrV7G2MrAvz57oFHaExOHbi3uA4zOdyAFGCsXuJWULvH4N5sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=UKnRuFjr;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B09606A31C;
	Wed, 18 Nov 2026 02:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=UKnRuFjr
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 6AACC1210F2;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCiAhx1hm/TSC9teC4T/87YXFk0bp1j85ACc70iArcY=;
	b=UKnRuFjrleYklAWd9wO2VQGN9VK/s2MSMelobJTZfrJvDUyOjUP+zBH5OXa2j426k+BkpG
	88xho5bDtAd0qTV/Pzn8lz1Vw03T9t7oCUxFMqQsMzVqBvuXKUowcLclUn6MYOJpnB+3Xu
	GQTZ9yVMXF5N89Tv2fcoavHNhy4Nm3BShJWfOGX7LLrvwrCsThnI/ZFqkmx4aSTqCml668
	QE+xUXos4SWozXUHdXcK7P9sgbC8OtX5LJfIenE7yXntrGaR5DuJ2BXte81ansykVDAbQ1
	1K9iKvBdoy32iR/ySg6XzzsF7iA3GVNsfPH/xVBQnf+eriWHOmGP3HEEiufqCw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 6/8] fat: add iomap buffered I/O support
Date: Tue, 17 Nov 2026 23:01:46 -0300
Message-ID: <20261118020150.1023865-7-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
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
 fs/fat/file.c  |  48 ++++++++++++---
 fs/fat/inode.c | 157 +++++--------------------------------------------
 fs/fat/iomap.c |  81 +++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 150 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 7f0be1423..52b908120 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -416,9 +416,9 @@ extern int fat_getattr(const struct mnt_idmap *idmap,
 int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
 			  int datasync);
+int fat_preallocate(struct inode *inode, loff_t new_size);
 
 /* fat/inode.c */
-extern int fat_block_truncate_page(struct inode *inode, loff_t from);
 extern void fat_attach(struct inode *inode, loff_t i_pos);
 extern void fat_detach(struct inode *inode);
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
@@ -493,7 +493,9 @@ extern const struct export_operations fat_export_ops_nostale;
 /* fat/iomap.c */
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next);
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next_bmap);
+DECLARE_IOMAP_ITER_NEXT(fat_iomap_next_write);
 extern const struct iomap_dio_ops fat_iomap_write_dio_ops;
+extern const struct iomap_writeback_ops fat_writeback_ops;
 
 /* helper for printk */
 typedef unsigned long long	llu;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 83a066b50..0d611520d 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -266,10 +266,14 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
+static int fat_cont_expand(struct inode *inode, loff_t new_size);
+
 static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
 					    struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	loff_t offset, old_size, old_alloc, keep_alloc;
 	ssize_t ret;
 
 	inode_lock(inode);
@@ -281,7 +285,26 @@ static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
 	if (ret)
 		goto out;
 
-	ret = generic_perform_write(iocb, iter);
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
+	ret = iomap_file_buffered_write(iocb, iter, fat_iomap_next_write,
+					NULL, NULL);
+	if (ret < 0 || iov_iter_count(iter)) {
+		keep_alloc = max(old_alloc, round_up(i_size_read(inode),
+						     sbi->cluster_size));
+		if (inode_get_bytes(inode) > keep_alloc)
+			fat_truncate_blocks(inode, keep_alloc);
+	}
+
 out:
 	inode_unlock(inode);
 	return ret;
@@ -291,8 +314,12 @@ static ssize_t fat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
-		return generic_file_write_iter(iocb, iter);
+	if ((iocb->ki_flags & IOCB_DIRECT) == 0) {
+		ret = fat_file_write_iter_buffered(iocb, iter);
+		if (ret > 0)
+			ret = generic_write_sync(iocb, ret);
+		return ret;
+	}
 
 	ret = fat_file_dio_write_iter(iocb, iter);
 	if (ret == -ENOTBLK)
@@ -323,7 +350,7 @@ const struct file_operations fat_file_operations = {
 	.setlease	= generic_setlease,
 };
 
-static int fat_preallocate(struct inode *inode, loff_t new_size)
+int fat_preallocate(struct inode *inode, loff_t new_size)
 {
 	int nr_cluster; /* Number of clusters to be allocated */
 	loff_t mm_bytes; /* Number of bytes to be allocated for file */
@@ -395,7 +422,7 @@ static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
 			folio_zero_segment(folio, from, to);
 		} else {
 			folio_zero_segment(folio, 0, folio_size(folio));
-			folio_mark_uptodate(folio);
+			iomap_folio_mark_uptodate(folio);
 		}
 		folio_mark_dirty(folio);
 		mi->mmu_private = max(mi->mmu_private, next);
@@ -762,11 +789,16 @@ int fat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		error = fat_block_truncate_page(inode, attr->ia_size);
+		filemap_invalidate_lock(inode->i_mapping);
+		error = iomap_truncate_page(inode, attr->ia_size, NULL,
+					    fat_iomap_next, NULL, NULL);
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
index fd9d9ce0b..7c5bcf017 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -117,141 +117,27 @@ int fat_add_clusters(struct inode *inode, int nr_cluster)
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
+	iomap_bio_read_folio(folio, fat_iomap_next);
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
+	iomap_bio_readahead(rac, fat_iomap_next);
 }
 
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
@@ -274,29 +160,18 @@ static int fat_swap_activate(struct swap_info_struct *sis, struct file *file,
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
index 3ab40bb2d..f198fb7c8 100644
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
@@ -76,6 +79,62 @@ static int fat_iomap_begin(struct inode *inode, loff_t offset,
 
 DEFINE_IOMAP_ITER_NEXT(fat_iomap_next, fat_iomap_begin);
 
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
+	if (err != -ENOSPC || inode_get_bytes(inode) > old_alloc)
+		fat_truncate_blocks(inode, old_alloc);
+	return err;
+}
+
+DEFINE_IOMAP_ITER_NEXT_END(fat_iomap_next_write, fat_iomap_begin_write,
+			   fat_iomap_end_write);
+
 static int fat_iomap_begin_bmap(struct inode *inode, loff_t offset,
 				loff_t length, unsigned int flags,
 				struct iomap *iomap, struct iomap *srcmap)
@@ -115,3 +174,25 @@ static int fat_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
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

