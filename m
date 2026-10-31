Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465075;
	b=fKb6gXAabjiNcgwYm0VK08tZFvMmBffzTbPhuIcdaruNS5AbJfXryTJlCSAG4e8RUyqe
	 uILl1Qyq4epd2FRa2a4+rpIdhNgkYuj2oxG6UvIDf9HujAmucVx4cH38r7cGr/1t/JWF3
	 SsybewlwI6EPmWDPBFPPaFrS4J3UGsJu4ZZ9nyBjV+al+8BJmQMRudsGDSSZReqByVrj8
	 /sdaiHT6f2Tyoq86kH+eula1MhgPDDvfo/QDTHQFbasRMhkQEDQn9tA5sAkgMaZ7JZTtS
	 PmijAXO78VkubC0eg7maPN0MxlL/S5wvRCtAXj9ClN61jZ9D7qldwQZ0g1FAwRgPaGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465075;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uF5fT7UcJm5OglPQxZilXz/ybLtjmS5yWkbD77sKmJs=;
	b=pyACsm35bPF3DjWYlr0w9W7NTkGpABjsCowu+QTusyr4chyjA5etHMjF8Ctxa3qcptI4
	 k+pRNCDE30R7w5s6ZMxOgP9sA9ixHQ60ZTIleGXgQ5Aqh/pd4Jc0vYX8CKuJ+2XybmnCO
	 EQTKF+wLJDHsYqriwvYexmPs0lsyHBBlwJVlXVb3MNVS+4B8mrOymX1T50neG63SqKbEP
	 dcNytZbX2ev00KqKtC76FgKvownY0cup7fS7l/D9ttlrBhaPTHaG9tuNVwFkBuEzm1ceR
	 zlYykPfTldvkr7tUYfYwceHljF/7XP6dJXr976+YiZg7aGLP2i0yC1pQPstiJLP/RNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b="RGKg/ice";
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18A60A2603;
	Sat, 31 Oct 2026 16:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD18A60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=RGKg/ice
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 23DAF120FB9;
	Sat, 31 Oct 2026 13:43:50 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uF5fT7UcJm5OglPQxZilXz/ybLtjmS5yWkbD77sKmJs=;
	b=RGKg/icepEzCKrpVIgv9rK7514oZeMbR8f2oaLEksyDpay/EPOXKlwSm9qe+gXfBT+4xen
	Z+Rr86tjorsWnlUqGLEiJWtpfVtaFI0+xbtJsR4ufUoFXz4Is38Juuy81e9WoPHz1exRwZ
	VcecRNp8f/IJatrIC6nVOUJnEALV1wBKvOucLsJ3+1KPvU3XhqCOHwoRHHLb0I2JaKr7bt
	LEGFDTamnOpU/VivDjqeACyBwG8L86g4HIXbyXtPdMPvUDL/zTMx0MCFo4SyatLYr+UMYy
	sqLYUftS2D0dr17lUPTDtnL+uH9md5dH3kX6u68TbuPdK0z91j6kuTLSKgAGXQ==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 7/8] fat: remove ->mmu_private
Date: Sat, 31 Oct 2026 13:43:25 -0300
Message-ID: <20261031164326.278125-8-matheus.aalmeida@inf.ufrgs.br>
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
index f545e1db1d47..89c950f87493 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -377,19 +377,8 @@ static int is_exceed_eof(struct inode *inode, sector_t sector,
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
index 35bdb62944a2..9996bd121e07 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1443,7 +1443,6 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 				& ~((loff_t)sbi->cluster_size - 1);
 		}
 		dir->i_size += nr_cluster << sbi->cluster_bits;
-		MSDOS_I(dir)->mmu_private += nr_cluster << sbi->cluster_bits;
 	}
 	sinfo->slot_off = pos;
 	sinfo->de = de;
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 78c6fb5cdc46..962f6f6b7717 100644
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
@@ -493,7 +490,6 @@ extern const struct export_operations fat_export_ops_nostale;
 extern const struct iomap_ops fat_iomap_ops;
 extern const struct iomap_ops fat_iomap_bmap_ops;
 extern const struct iomap_ops fat_iomap_write_ops;
-extern const struct iomap_dio_ops fat_iomap_write_dio_ops;
 extern const struct iomap_writeback_ops fat_writeback_ops;
 
 /* helper for printk */
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 723b671d5b4b..ac6329d36062 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -235,7 +235,6 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 				       struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct msdos_inode_info *mi = MSDOS_I(inode);
 	unsigned int dio_flags = 0;
 	ssize_t ret;
 
@@ -245,7 +244,7 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 		goto out;
 
 	/* We do not support DIO writes which would need zeroing */
-	if (iocb->ki_pos + iov_iter_count(iter) > mi->mmu_private) {
+	if (iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode)) {
 		ret = -ENOTBLK;
 		goto out;
 	}
@@ -254,14 +253,13 @@ static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
 	if (ret)
 		goto out;
 
-	/* Wait under the inode lock for size updates and partial-block zeroing. */
-	if (iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode) ||
-	    !IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
+	/* Wait under the inode lock for unaligned writes */
+	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
 			i_blocksize(inode)))
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
 
-	ret = iomap_dio_rw(iocb, iter, &fat_iomap_ops,
-			   &fat_iomap_write_dio_ops, dio_flags, NULL, 0);
+	ret = iomap_dio_rw(iocb, iter, &fat_iomap_ops, NULL, dio_flags,
+			   NULL, 0);
 out:
 	inode_unlock(inode);
 	return ret;
@@ -402,7 +400,6 @@ int fat_preallocate(struct inode *inode, loff_t new_size)
 
 static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
 {
-	struct msdos_inode_info *mi = MSDOS_I(inode);
 	struct address_space *mapping = inode->i_mapping;
 	loff_t pos = i_size_read(inode), fpos, next;
 	loff_t old_size = pos;
@@ -439,7 +436,6 @@ static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
 
 		folio_zero_segment(folio, from, to);
 		folio_mark_dirty(folio);
-		mi->mmu_private = max(mi->mmu_private, next);
 		i_size_write(inode, next);
 
 		folio_unlock(folio);
@@ -460,7 +456,6 @@ static int fat_cont_expand(struct inode *inode, loff_t new_size)
 	struct msdos_inode_info *mi = MSDOS_I(inode);
 	loff_t old_alloc = inode_get_bytes(inode);
 	loff_t old_size = i_size_read(inode);
-	loff_t old_mmu_private = mi->mmu_private;
 	int err;
 
 	err = inode_newsize_ok(inode, new_size);
@@ -478,7 +473,6 @@ static int fat_cont_expand(struct inode *inode, loff_t new_size)
 		filemap_invalidate_lock(inode->i_mapping);
 		truncate_setsize(inode, old_size);
 		fat_truncate_blocks(inode, old_alloc);
-		mi->mmu_private = old_mmu_private;
 		filemap_invalidate_unlock(inode->i_mapping);
 		return err;
 	}
@@ -605,13 +599,6 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
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
index 9df10e5a1ede..cb2316062bb3 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -356,7 +356,6 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 		error = fat_calc_dir_size(inode);
 		if (error < 0)
 			return error;
-		MSDOS_I(inode)->mmu_private = inode->i_size;
 
 		set_nlink(inode, fat_subdirs(inode));
 
@@ -375,7 +374,6 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 		inode->i_op = &fat_file_inode_operations;
 		inode->i_fop = &fat_file_operations;
 		inode->i_mapping->a_ops = &fat_aops;
-		MSDOS_I(inode)->mmu_private = inode->i_size;
 	}
 	if (de->attr & ATTR_SYS) {
 		if (sbi->options.sys_immutable)
@@ -486,11 +484,11 @@ static void fat_free_eofblocks(struct inode *inode)
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
index cfeaea5d352e..893d94f6b70c 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -83,12 +83,9 @@ static int fat_iomap_end_write(struct inode *inode, loff_t offset,
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
@@ -160,26 +157,6 @@ const struct iomap_ops fat_iomap_bmap_ops = {
 	.iomap_next = fat_iomap_next_bmap
 };
 
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

