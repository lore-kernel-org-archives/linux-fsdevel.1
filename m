Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967371;
	b=Cvl/rhJhW7rbeMKj9ganDV2Vs9NDJWqC7bnu33yQiIJalC132KPt0B6eyk/ELCRb/V4W
	 5Ls7iPiqdTT30hksftbIxIMw34/PxZC9eZu+SyIrXNUVNdhdckcMt6ZmJKLgY+MYHan09
	 3MwmkQasc9QyxA9kBN8rjaUaa6paQe5zqRgYS5E0OE9QJ0SYWE2HgQgeqok1rr/6jYMKX
	 EaztHH0tMfugXJuUF2cMAzJGd9zPh+kTxrxfYfnUXPRqsrwRxj0fQWnwsT4xj3m8YAN99
	 c1Cwn65d4/U9pmDpHGenmx/KRkRVY60u+4mfy6IAMu0IfUsFux9vvl6SbmU2jQLWQkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967371;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dJ/4fZ6SnQUebP3v8xuQxhkqzKwH78h/fAAXDtlDV8M=;
	b=XKeXg1aPdJVpO+AvhxNyXFO5r0dPeuiYjLqfBnoYEETlVIqt6UO82Tof1nMq8QN8mYoS
	 GYgVFSRQtxnsVBsjQFW9CF9EmFXNEhzdzKU0y9bicDXKNvB+R5teebTrktDXTZW5YTD33
	 LM0Kts0Jamj+mtk7LiKWpGbDrynPBr6Ji1J/SqxhbBKeUeFlspWEOoRHO7mbjcN9CW+Z1
	 V7ztbvLddde45V6Fya4tunV1bLHkBntlBHiClcnQXSI7KjRaUAnLybMzEfbBD0a4YHNvK
	 NSZPHbhws/8wxaownqTntIfrp5CU/PzzxnC8F5/GS9d1x8pspG7017hm354MGTkcz1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=KcHlLQpB;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D1606A325;
	Wed, 18 Nov 2026 02:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B4D1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=KcHlLQpB
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 7E4301210F3;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJ/4fZ6SnQUebP3v8xuQxhkqzKwH78h/fAAXDtlDV8M=;
	b=KcHlLQpBO8gYKzEwUMCN+ee6HZ2EFmPZvLEChFsntNIVYrrBpYtMg2GHJ3WL52Qz8NEBSK
	CuQs+Ylwhne9Faz4mSi5xsRO7/NkrXSoIA/tb/3UPUn1QOiOOR6tgAhWQjH/lvC1QZhDpz
	Ifzyo0fg/yd/8iD63yEQcGQ/wWIJ7TBYrEl3dM04LRf5K+T9MEBsEdBuBcaQ+FV1/aZT0c
	WdMAJZxxQRVJqFfAOaA8zr4DGc1AycwNmram0YagxpL66OTrJlY8HCCndabiMlmoC8yKt3
	dPko6SqyIMF1tMCdHOOwl+C7yDXn5nLvsa0ZwkMoNlyuPZeSCrSIewci6Vx/MA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 7/8] fat: remove ->mmu_private
Date: Tue, 17 Nov 2026 23:01:47 -0300
Message-ID: <20261118020150.1023865-8-matheus.aalmeida@inf.ufrgs.br>
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

With the iomap conversion of buffered I/O complete, the ->mmu_private
inode field is no longer necessary.

Replace remaining users with ->i_size checks. Remove the DIO end callback
as DIO now checks ->i_size directly to reject extending writes.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/cache.c | 15 ++-------------
 fs/fat/dir.c   |  1 -
 fs/fat/fat.h   |  4 ----
 fs/fat/file.c  | 23 +++++------------------
 fs/fat/inode.c | 10 +++-------
 fs/fat/iomap.c | 29 +++--------------------------
 6 files changed, 13 insertions(+), 69 deletions(-)

diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 18a0bb500..84dacc290 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -390,19 +390,8 @@ static int is_exceed_eof(struct inode *inode, sector_t sector,
 	const unsigned char blocksize_bits = sb->s_blocksize_bits;
 
 	*last_block = (i_size_read(inode) + (blocksize - 1)) >> blocksize_bits;
-	if (sector >= *last_block) {
-		if (!create)
-			return 1;
-
-		/*
-		 * ->mmu_private can access on only allocation path.
-		 * (caller must hold ->i_mutex)
-		 */
-		*last_block = (MSDOS_I(inode)->mmu_private + (blocksize - 1))
-			>> blocksize_bits;
-		if (sector >= *last_block)
-			return 1;
-	}
+	if (sector >= *last_block && !create)
+		return 1;
 
 	return 0;
 }
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 0cebcaf82..914ed7738 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1453,7 +1453,6 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 				& ~((loff_t)sbi->cluster_size - 1);
 		}
 		dir->i_size += nr_cluster << sbi->cluster_bits;
-		MSDOS_I(dir)->mmu_private += nr_cluster << sbi->cluster_bits;
 	}
 	sinfo->slot_off = pos;
 	sinfo->de = de;
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 52b908120..00041fa11 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -122,9 +122,6 @@ struct msdos_inode_info {
 	/* for avoiding the race between fat_free() and fat_get_cluster() */
 	unsigned int cache_valid_id;
 
-	/* NOTE: mmu_private is 64bits, so must hold ->i_mutex to access */
-	loff_t mmu_private;	/* physically allocated size */
-
 	int i_start;		/* first cluster or 0 */
 	int i_logstart;		/* logical first cluster */
 	int i_attrs;		/* unused attribute bits */
@@ -494,7 +491,6 @@ extern const struct export_operations fat_export_ops_nostale;
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next);
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next_bmap);
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next_write);
-extern const struct iomap_dio_ops fat_iomap_write_dio_ops;
 extern const struct iomap_writeback_ops fat_writeback_ops;
 
 /* helper for printk */
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 0d611520d..90be24bfa 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -234,7 +234,6 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 				       struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct msdos_inode_info *mi = MSDOS_I(inode);
 	unsigned int dio_flags = 0;
 	ssize_t ret;
 
@@ -244,7 +243,7 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 		goto out;
 
 	/* We do not support DIO writes which would need zeroing */
-	if (iocb->ki_pos + iov_iter_count(iter) > mi->mmu_private) {
+	if (iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode)) {
 		ret = -ENOTBLK;
 		goto out;
 	}
@@ -253,14 +252,13 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 	if (ret)
 		goto out;
 
-	/* Wait under the inode lock for size updates and partial-block zeroing. */
-	if (iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode) ||
-	    !IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
+	/* Wait under the inode lock for unaligned writes */
+	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
 			i_blocksize(inode)))
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
 
-	ret = iomap_dio_rw(iocb, iter, fat_iomap_next,
-			   &fat_iomap_write_dio_ops, dio_flags, NULL, 0);
+	ret = iomap_dio_rw(iocb, iter, fat_iomap_next, NULL, dio_flags,
+			   NULL, 0);
 out:
 	inode_unlock(inode);
 	return ret;
@@ -373,7 +371,6 @@ int fat_preallocate(struct inode *inode, loff_t new_size)
 
 static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
 {
-	struct msdos_inode_info *mi = MSDOS_I(inode);
 	struct address_space *mapping = inode->i_mapping;
 	loff_t pos = i_size_read(inode), fpos, next;
 	loff_t old_size = pos;
@@ -425,7 +422,6 @@ static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
 			iomap_folio_mark_uptodate(folio);
 		}
 		folio_mark_dirty(folio);
-		mi->mmu_private = max(mi->mmu_private, next);
 		i_size_write(inode, next);
 
 		folio_unlock(folio);
@@ -446,7 +442,6 @@ static int fat_cont_expand(struct inode *inode, loff_t new_size)
 	struct msdos_inode_info *mi = MSDOS_I(inode);
 	loff_t old_alloc = inode_get_bytes(inode);
 	loff_t old_size = i_size_read(inode);
-	loff_t old_mmu_private = mi->mmu_private;
 	int err;
 
 	err = inode_newsize_ok(inode, new_size);
@@ -466,7 +461,6 @@ static int fat_cont_expand(struct inode *inode, loff_t new_size)
 		truncate_setsize(inode, old_size);
 		if (inode_get_bytes(inode) > old_alloc)
 			fat_truncate_blocks(inode, old_alloc);
-		mi->mmu_private = old_mmu_private;
 		filemap_invalidate_unlock(inode->i_mapping);
 		return err;
 	}
@@ -594,13 +588,6 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	const unsigned int cluster_size = sbi->cluster_size;
 	int nr_clusters;
 
-	/*
-	 * This protects against truncating a file bigger than it was then
-	 * trying to write into the hole.
-	 */
-	if (MSDOS_I(inode)->mmu_private > offset)
-		MSDOS_I(inode)->mmu_private = offset;
-
 	nr_clusters = (offset + (cluster_size - 1)) >> sbi->cluster_bits;
 
 	fat_free(inode, nr_clusters);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 7c5bcf017..76755c2b4 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -357,7 +357,6 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 		error = fat_calc_dir_size(inode);
 		if (error < 0)
 			return error;
-		MSDOS_I(inode)->mmu_private = inode->i_size;
 
 		set_nlink(inode, fat_subdirs(inode));
 
@@ -376,7 +375,6 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 		inode->i_op = &fat_file_inode_operations;
 		inode->i_fop = &fat_file_operations;
 		inode->i_mapping->a_ops = &fat_aops;
-		MSDOS_I(inode)->mmu_private = inode->i_size;
 	}
 	if (de->attr & ATTR_SYS) {
 		if (sbi->options.sys_immutable)
@@ -487,11 +485,11 @@ static void fat_free_eofblocks(struct inode *inode)
 {
 	/* Release unwritten fallocated blocks on inode eviction. */
 	if ((inode->i_blocks << 9) >
-			round_up(MSDOS_I(inode)->mmu_private,
-				MSDOS_SB(inode->i_sb)->cluster_size)) {
+			round_up(i_size_read(inode),
+				 MSDOS_SB(inode->i_sb)->cluster_size)) {
 		int err;
 
-		fat_truncate_blocks(inode, MSDOS_I(inode)->mmu_private);
+		fat_truncate_blocks(inode, i_size_read(inode));
 		/* Fallocate results in updating the i_start/iogstart
 		 * for the zero byte file. So, make it return to
 		 * original state during evict and commit it to avoid
@@ -612,7 +610,6 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
 		return NULL;
 
 	/* Zeroing to allow iput() even if partial initialized inode. */
-	ei->mmu_private = 0;
 	ei->i_start = 0;
 	ei->i_logstart = 0;
 	ei->i_attrs = 0;
@@ -1194,7 +1191,6 @@ static int fat_read_root(struct inode *inode)
 	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
-	MSDOS_I(inode)->mmu_private = inode->i_size;
 
 	fat_save_attrs(inode, ATTR_DIR);
 	inode_set_mtime_to_ts(inode,
diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
index f198fb7c8..f73076230 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -85,12 +85,9 @@ static int fat_iomap_end_write(struct inode *inode, loff_t offset,
 {
 	struct msdos_inode_info *mi = MSDOS_I(inode);
 
-	if (written > 0) {
-		mi->mmu_private = max(mi->mmu_private, offset + written);
-		if (!(mi->i_attrs & ATTR_ARCH)) {
-			mi->i_attrs |= ATTR_ARCH;
-			mark_inode_dirty(inode);
-		}
+	if (written > 0 && !(mi->i_attrs & ATTR_ARCH)) {
+		mi->i_attrs |= ATTR_ARCH;
+		mark_inode_dirty(inode);
 	}
 
 	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
@@ -155,26 +152,6 @@ static int fat_iomap_begin_bmap(struct inode *inode, loff_t offset,
 
 DEFINE_IOMAP_ITER_NEXT(fat_iomap_next_bmap, fat_iomap_begin_bmap);
 
-static int fat_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
-				unsigned int flags)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-
-	if (error)
-		return error;
-
-	if (size && i_size_read(inode) < iocb->ki_pos + size) {
-		i_size_write(inode, iocb->ki_pos + size);
-		mark_inode_dirty(inode);
-	}
-
-	return 0;
-}
-
-const struct iomap_dio_ops fat_iomap_write_dio_ops = {
-	.end_io = fat_dio_write_end_io
-};
-
 static ssize_t fat_writeback_range(struct iomap_writepage_ctx *wpc,
 				   struct folio *folio, u64 offset,
 				   unsigned int len, u64 end_pos)
-- 
2.43.0

