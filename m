Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967347;
	b=HuA1V2X55dKFF2ScUEzHaUpBWF1/0gguA+fUf4gvqx0rVYl5OVepReS2jUn3mfbxA5P7
	 IpTIpIdXdrEkL3Pn1TUnJKpGQ5UFVKq7mHh1uu9aU697SDf2vElQH5Ay6YZtU1bkDGufv
	 5avCrKtFpqFtFsVXFSPlgoQuzn0h78LGX6XP4F+GjCUOmHLYO7BHnVq/LLrI2lz9EbGTA
	 +aCd4s0DBUTmwHOWq6tbG8UcJAjqUJirQppk+RwLHENHgpopLlkUiGxkxbLb/Y/BGHlcK
	 x9b9usWZhU1wxYaSoBQDx2GDTto99/cc9EnnSxN0IMYTv347ceGztG61nbum/5RwdSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967347;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EkUV3GSJAcDZL4ezmv6mvXDk6w9N0HNOd3T0iVl04zo=;
	b=dsYfxG67DfVrhNWa4yK152/JCGoIABDrJNpUU/MvjdD2sRUfbFMHFhJa2RTxijXF3vBt
	 ArAsWE6ZH0F+QCywmfPTVfmM7XB3yIG+IMgDpseASDzsiRDrTcwHsm+McFX2PTYOprZGO
	 dDSu4ta8TsBoagSEUVmIICMOj47DdNvwHm+UU2y8bSxyq8T8APiZOfZRTIcEgaEqPC8wQ
	 Sal7YeDMupxl1GsXEX8SM48YPgVPdKBA5ZlcIo5S2DVo+vs5qaJOQWkAmRq4w+rxcCrdw
	 oR2auLUAsk6Id6JryNKdWk5SK0YIn/P3WLUajdxaYYjvKqGJUmA8LqYFdp7pfySUJzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=VpA8ANEr;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5F606A325;
	Wed, 18 Nov 2026 02:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F5F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=VpA8ANEr
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 233161210E7;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkUV3GSJAcDZL4ezmv6mvXDk6w9N0HNOd3T0iVl04zo=;
	b=VpA8ANErNKQuF/C1SuBxmltcTHmZbGfcttVMbwKvq4hI0dRvNuDD9aSCP0MaWRsOy8KNZ0
	2LTrXgI8FFdgSl8XG81dTa/tnOWbBEdGyin/hm7NzEBTh9FziYabV5nkYmJxrVnHsL6uqu
	o40ugGxFtj5CSzzO2Af11ork0nvP82CBpzrr4nSVOwThdAj+AeE65vOIFCKZl/+eyETFEB
	3REDXD+ac4oYc0C4mQnS33ffN4RCznIpOmms6krChgGkM5JtSpIv2HjXiioV0L+nxsK0Zb
	NBj7GCfXmjrjTHcogVm5L3ZCJQR3/jeat+aE1ahwbQ198ZhONvePjmenRE1vbA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/8] fat: use iomap for ->bmap()
Date: Tue, 17 Nov 2026 23:01:42 -0300
Message-ID: <20261118020150.1023865-3-matheus.aalmeida@inf.ufrgs.br>
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

Make FAT ->bmap() use iomap_bmap(). Add an iomap-backed
fat_swap_activate() to prevent a swapon() deadlock. Remove
truncate_lock as ->bmap() now uses i_rwsem.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fat.h   |  2 +-
 fs/fat/file.c  |  2 --
 fs/fat/inode.c | 47 ++++++++++++++---------------------------------
 fs/fat/iomap.c | 20 ++++++++++++++++++++
 4 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index a21fbca12..e0cc46130 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -131,7 +131,6 @@ struct msdos_inode_info {
 	loff_t i_pos;		/* on-disk position of directory entry or 0 */
 	struct hlist_node i_fat_hash;	/* hash by i_location */
 	struct hlist_node i_dir_hash;	/* hash by i_logstart */
-	struct rw_semaphore truncate_lock; /* protect bmap against truncate */
 	struct timespec64 i_crtime;	/* File creation (birth) time */
 	struct mapping_metadata_bhs i_metadata_bhs;
 	struct inode vfs_inode;
@@ -493,6 +492,7 @@ extern const struct export_operations fat_export_ops_nostale;
 
 /* fat/iomap.c */
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next);
+DECLARE_IOMAP_ITER_NEXT(fat_iomap_next_bmap);
 
 /* helper for printk */
 typedef unsigned long long	llu;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 7712cfa2b..60bb8b544 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -614,10 +614,8 @@ int fat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 		error = fat_block_truncate_page(inode, attr->ia_size);
 		if (error)
 			goto out;
-		down_write(&MSDOS_I(inode)->truncate_lock);
 		truncate_setsize(inode, attr->ia_size);
 		fat_truncate_blocks(inode, attr->ia_size);
-		up_write(&MSDOS_I(inode)->truncate_lock);
 	}
 
 	/*
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 642e69063..fa38dfb90 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -217,9 +217,7 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
 
 	if (to > inode->i_size) {
 		truncate_pagecache(inode, inode->i_size);
-		down_write(&MSDOS_I(inode)->truncate_lock);
 		fat_truncate_blocks(inode, inode->i_size);
-		up_write(&MSDOS_I(inode)->truncate_lock);
 	}
 }
 
@@ -291,43 +289,26 @@ static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-static int fat_get_block_bmap(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh_result, int create)
-{
-	struct super_block *sb = inode->i_sb;
-	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
-	int err;
-	sector_t bmap;
-	unsigned long mapped_blocks;
-
-	BUG_ON(create != 0);
-
-	err = fat_bmap(inode, iblock, &bmap, &mapped_blocks, create, true);
-	if (err)
-		return err;
-
-	if (bmap) {
-		map_bh(bh_result, sb, bmap);
-		max_blocks = min(mapped_blocks, max_blocks);
-	}
-
-	bh_result->b_size = max_blocks << sb->s_blocksize_bits;
-
-	return 0;
-}
-
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	sector_t blocknr;
 
-	/* fat_get_cluster() assumes the requested blocknr isn't truncated. */
-	down_read(&MSDOS_I(mapping->host)->truncate_lock);
-	blocknr = generic_block_bmap(mapping, block, fat_get_block_bmap);
-	up_read(&MSDOS_I(mapping->host)->truncate_lock);
-
+	inode_lock_shared(mapping->host);
+	blocknr = iomap_bmap(mapping, block, fat_iomap_next_bmap);
+	inode_unlock_shared(mapping->host);
 	return blocknr;
 }
 
+static int fat_swap_activate(struct swap_info_struct *sis, struct file *file,
+			     sector_t *span)
+{
+#ifdef CONFIG_SWAP
+	return iomap_swapfile_activate(sis, file, span, fat_iomap_next);
+#else
+	return -EIO;
+#endif
+}
+
 /*
  * fat_block_truncate_page() zeroes out a mapping from file offset `from'
  * up to the end of the block which corresponds to `from'.
@@ -351,6 +332,7 @@ static const struct address_space_operations fat_aops = {
 	.direct_IO	= fat_direct_IO,
 	.bmap		= _fat_bmap,
 	.migrate_folio	= buffer_migrate_folio,
+	.swap_activate  = fat_swap_activate,
 };
 
 /*
@@ -790,7 +772,6 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
 	if (!ei)
 		return NULL;
 
-	init_rwsem(&ei->truncate_lock);
 	/* Zeroing to allow iput() even if partial initialized inode. */
 	ei->mmu_private = 0;
 	ei->i_start = 0;
diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
index 4073dc996..c3b48a820 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -71,3 +71,23 @@ static int fat_iomap_begin(struct inode *inode, loff_t offset,
 }
 
 DEFINE_IOMAP_ITER_NEXT(fat_iomap_next, fat_iomap_begin);
+
+static int fat_iomap_begin_bmap(struct inode *inode, loff_t offset,
+				loff_t length, unsigned int flags,
+				struct iomap *iomap, struct iomap *srcmap)
+{
+	int err;
+
+	err = __fat_iomap_begin(inode, offset, length, flags, iomap);
+	if (err)
+		return err;
+	/*
+	 * iomap_bmap() only returns blocks in an IOMAP_MAPPED range.
+	 * As the old ->bmap() returned KEEP_SIZE blocks, keep that behavior.
+	 */
+	if (iomap->type == IOMAP_UNWRITTEN)
+		iomap->type = IOMAP_MAPPED;
+	return 0;
+}
+
+DEFINE_IOMAP_ITER_NEXT(fat_iomap_next_bmap, fat_iomap_begin_bmap);
-- 
2.43.0

