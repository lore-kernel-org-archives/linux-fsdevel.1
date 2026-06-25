Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EEA34B1A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424095; cv=none; b=WIx+tQClGUc8mZhqlxtYOxH2JsIFbe452XOBLYmxmmFJsZxvEKXSTJKIVB7VWxxg93NYgF6QWbJLPSF5obrK4uG1GQVgidjJQ/+b7Lql2HZ+L/y7l+h60H5v97D+0qrG7mkqLF7JmuY7BHx3XBoHbeh7suT756gGVoCucEtuZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424095; c=relaxed/simple;
	bh=V3g7C0jqoLG2alwrs6GdtjwCVs/S6NCBH4ixsdY+UB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ha+auB8ryYNoxzL/z2cebzvUtClDihE+yD1dG3ALKHHi5ZjObLh5P34E7E+xGvDWgSQ8bejlxztKboKuuez3a3usG49K48Pl2Q+rgO4+TSRa/Lf9Iszmh29XtgBOZcnBM+zn5Qly9oFh8F4zaJYscn//IwDY0Jyq9uyZPf376W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnfJrupX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnfJrupX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84347ad88edso195533b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424093; x=1783028893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzZzcJji8exbfH9L+WNRRfCQ9G1y0Yuiy5hbtOM6efk=;
        b=LnfJrupXtldKwTxC/Y+agTgTohDtAz/QvbktO47W2pAbTzsBHoz6ZyOhTEMUKjRPNQ
         j8PxGWZP5ugFOUZVciNyjGoQaICEMHeJ+vc0yRK9uqAK3Gm7jOCCR7IqCLvY4/mrSMHn
         3GbPXxC1rduxxAk2txXkF6LqJLSCnzhhrUhJSj907PnOH6PRiPm6gscTeKF0nY4JTtlY
         bW0ASkoPMA76FtXx5eWUiOxgGuY15gtuJxLcPCPEVlRnFApqAL/oBEvLRHQobKzei7g4
         C7GnR5K+Pa31I0NW2+jDk3VnkkAuB9Mt4TQ52mh11Uu+le8oDgQw5Cm3hlQRz9QU2TBf
         qQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424093; x=1783028893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mzZzcJji8exbfH9L+WNRRfCQ9G1y0Yuiy5hbtOM6efk=;
        b=rwTaqHCD6G2mv6La5HJQxSL9ZsRHtkP2oPo2ce+FGzsgBgNJeNvbwhsCIbvVMpIqUp
         gU7p8ccMk5JAHidWBvMxTVq/DkEuEDDLWaPZgNW2w/JighoCmgHn2Bg+i+G9BWTFguHE
         4c091TcErK2s1FUOkhnsbO+l5D2h/z1kKZ7eXb1M/35srOWc8tA95peZti9Ejos+vwzL
         tIL50y/qZTR8HX1yAhpXgI1CzKZzPZUORY0o2KbIc4xFuGdPmmZ697z+Exsk9aCdykO5
         JiTqcPAuJkKYXoA5PSnpnEkAl64WljlkR36yO1gXNv76qbCBQclYviWKhb/sblrR/ovr
         c2Ww==
X-Gm-Message-State: AOJu0Yx+bvIamWy2yawzL6RmN2pt4GJG+d0zr418S3t14BpXXIgmVDZH
	P0DwB7ihYMF2lx+3HHtou/+dPyDSzVBohpDjVrEacrrHfo9+Q0SKG4JxZRVFlQ==
X-Gm-Gg: AfdE7cm/j8+bUJ8JSzlE0eI7X2DnTohHg0QGvO2ZKzi7/Ejr49oO6eTGERUBl/SI2M7
	ylu2O1OOoydZwVAM/XrsCmlMN5+m2tp59cup4HqodmZ7ztku8TDlMLQqVDB1oxPch1qbM3AxRS4
	oekazjlCGBfrC/krkyjbY6UpAPwSLWN0rEBvPlS9us64hc2WMsUJUh4aPUCT6s5PNn1aiYcZeZQ
	5PHqm44ASt0MT3HZphDKLr2+MA0bzonpckhdWNO9ta8lSn2pjPQv4/L9YuidaU7bp8/1oC0l6Ju
	0hBQ+MHmz4vDTJeRNwq8R+IGey0RHLsiUcvoNKp3GkyI+UZu6ENpjTVQksJLYMU6oHTGuzKQutA
	Mqg+6i9+Tya0Kd5IKRjl+XaWnSZBszHZoMqZio7ih5EHoDXlEkJvI3zZIKbpdMCk=
X-Received: by 2002:a05:6a00:92a6:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-845b3abb5bdmr4806355b3a.13.1782424093126;
        Thu, 25 Jun 2026 14:48:13 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c39fsm6192134b3a.55.2026.06.25.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:48:12 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH 1/3] minix: add iomap infrastructure
Date: Thu, 25 Jun 2026 14:48:03 -0700
Message-ID: <c33315267d47aebed2078f19d08243b58ffd941e.1782422707.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782422707.git.jbingham@gmail.com>
References: <cover.1782422707.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap mapping functions for the minix filesystem, providing an
iomap_begin/iomap_end implementation that replaces the buffer_head-based
get_block path for regular file I/O.

The iomap.c file is included into itree_v1.c and itree_v2.c (rather
than compiled as a standalone translation unit) because the minix
filesystem versions have different block_t sizes and different indirect
tree depths.  This follows the existing pattern where itree_common.c is
included into both itree_v1.c and itree_v2.c.  Each version provides a
thin wrapper (V1_minix_iomap_begin / V2_minix_iomap_begin) and a
corresponding iomap_ops struct.

The iomap_end callback is a no-op: minix has no extents or transactions
to finalize, and on-disk indirect blocks are dirtied during
iomap_begin.

This patch adds the infrastructure only; no callers are wired up yet.

The minix iomap implementation was adapted from the out-of-tree xiafs
iomap conversion. The xiafs module itself borrowed heavily from the
modernized minix kernel module.  The exfat iomap changes were an
additional reference for both conversions.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/iomap.c    | 114 ++++++++++++++++++++++++++++++++++++++++++++
 fs/minix/itree_v1.c |  25 +++++++++-
 fs/minix/itree_v2.c |  17 ++++++-
 fs/minix/minix.h    |  22 +++++++--
 4 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100644 fs/minix/iomap.c

diff --git a/fs/minix/iomap.c b/fs/minix/iomap.c
new file mode 100644
index 000000000000..7bb0439e3669
--- /dev/null
+++ b/fs/minix/iomap.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * iomap functions for minix. At least the first pass of this file was taken
+ * from the xiafs iomap.c, which is fitting since the xiafs module in turn
+ * borrowed heavily from the modernized minix fs kernel module.
+ */
+
+/*
+ * minix_iomap_begin - map a file range to disk blocks. It acts as a replacement
+ * for get_block in itree_common.c, at least in the important ways, and is
+ * adapted from it, but it uses iomap instead of buffer_head. This is taken
+ * directly from the out-of-tree xiafs iomap changes, and the exfat iomap
+ * changes were an inspiration for that.
+ */
+static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int blkbits = sb->s_blocksize_bits;
+	sector_t iblock = offset >> blkbits;
+	int create = flags & IOMAP_WRITE;
+
+	/* Mostly taken from modern-xiafs itree.c get_block with elements from
+	 * similar exfat operations.
+	 */
+	int offsets[DEPTH];
+	Indirect chain[DEPTH];
+	Indirect *partial;
+	int depth = block_to_path(inode, iblock, offsets);
+	int left;
+	int err = -EIO;
+
+	sector_t phys;
+
+	/* block is beyond max file size */
+	if (depth == 0)
+		goto out;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+
+reread:
+	partial = get_branch(inode, depth, offsets, chain, &err);
+
+	/* Simplest case - block found, no allocation needed */
+	if (!partial) {
+		/* Bit of a weird order, but it'll make sense when you get to
+		 * the bottom.
+		 */
+		iomap->flags = IOMAP_F_MERGED;
+got_it:
+		phys = block_to_cpu(chain[depth - 1].key);
+		partial = chain+depth-1;
+		/* Set up the iomap struct before cleaning up */
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = (u64)phys << blkbits;
+		iomap->length = 1 << blkbits;
+		iomap->offset = (u64)iblock << blkbits;
+		goto cleanup;
+	}
+
+	/* Next simple case - plain lookup or failed read of indirect block */
+	if (!create || err == -EIO) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->length = 1 << blkbits;
+		iomap->offset = (u64)iblock << blkbits;
+		iomap->flags = 0;
+cleanup:
+		while (partial > chain) {
+			brelse(partial->bh);
+			partial--;
+		}
+out:
+		return err;
+	}
+
+	/*
+	 * Indirect block might be removed by truncate while we were
+	 * reading it. Handling of that case (forget what we've got and
+	 * reread) is taken out of the main path.
+	 */
+	if (err == -EAGAIN)
+		goto changed;
+
+	left = (chain + depth) - partial;
+	err = alloc_branch(inode, left, offsets + (partial - chain), partial);
+	if (err)
+		goto cleanup;
+
+	if (splice_branch(inode, chain, partial, left) < 0)
+		goto changed;
+
+	/* Successful allocation, mapping it. */
+	iomap->flags = IOMAP_F_NEW;
+	goto got_it;
+
+changed:
+	while (partial > chain) {
+		brelse(partial->bh);
+		partial--;
+	}
+	goto reread;
+}
+
+/*
+ * minix_iomap_end ends up being a nop; since minix doesn't have any extents or
+ * transactions to worry about, there isn't anything to update here. The on-disk
+ * indirect blocks get dirtied in minix_iomap_begin.
+ */
+static int minix_iomap_end(struct inode *inode, loff_t offset, loff_t length,
+	ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	return 0;
+}
diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index 1fed906042aa..58c29f4443d3 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -49,6 +49,18 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 }
 
 #include "itree_common.c"
+/* NOTA BENE:
+ *
+ * This is icky to me, but at the same time having it be a standalone C file
+ * that's compiled to object form and linked separately like it is in xiafs is
+ * much nastier in minix because of the different versions of the minix fs that
+ * have some very, very different aspects, like the size of block_t. I don't
+ * like it, but since minix already has this pattern where a common itree file
+ * is included in the itree_v1 and itree_v2(and v3) files, I'm including iomap.c
+ * in these files as well. It does at least avoid exporting some currently
+ * static functions that aren't needed anywhere but itree_common.c and iomap.c.
+ */
+#include "iomap.c"
 
 int V1_minix_get_block(struct inode * inode, long block,
 			struct buffer_head *bh_result, int create)
@@ -61,7 +73,18 @@ void V1_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V1_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
+
+int V1_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+}
+
+const struct iomap_ops V1_minix_iomap_ops = {
+	.iomap_begin = V1_minix_iomap_begin,
+	.iomap_end   = minix_iomap_end,
+};
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
index 9d00f31a2d9d..fc7a5ae8fa1c 100644
--- a/fs/minix/itree_v2.c
+++ b/fs/minix/itree_v2.c
@@ -57,6 +57,10 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 }
 
 #include "itree_common.c"
+/* See the note in itree_v1 in a comment that starts "NOTA BENE" for an
+ * explanation for why iomap.c is included here.
+ */
+#include "iomap.c"
 
 int V2_minix_get_block(struct inode * inode, long block,
 			struct buffer_head *bh_result, int create)
@@ -69,7 +73,18 @@ void V2_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V2_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
+
+int V2_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+}
+
+const struct iomap_ops V2_minix_iomap_ops = {
+	.iomap_begin = V2_minix_iomap_begin,
+	.iomap_end   = minix_iomap_end,
+};
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index f2025c9b5825..face74100346 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -5,6 +5,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/minix_fs.h>
+#include <linux/iomap.h>
 
 #define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
 #define MINIX_V1		0x0001		/* original minix fs */
@@ -56,7 +57,7 @@ int minix_new_block(struct inode *inode);
 void minix_free_block(struct inode *inode, unsigned long block);
 unsigned long minix_count_free_blocks(struct super_block *sb);
 int minix_getattr(struct mnt_idmap *, const struct path *,
-		struct kstat *, u32, unsigned int);
+		struct kstat *, u32, unsigned);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync);
@@ -80,10 +81,19 @@ int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
 ino_t minix_inode_by_name(struct dentry*);
 
+extern int V1_minix_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap,
+	struct iomap *srcmap);
+extern int V2_minix_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap,
+	struct iomap *srcmap);
+
 extern const struct inode_operations minix_file_inode_operations;
 extern const struct inode_operations minix_dir_inode_operations;
 extern const struct file_operations minix_file_operations;
 extern const struct file_operations minix_dir_operations;
+extern const struct iomap_ops V1_minix_iomap_ops;
+extern const struct iomap_ops V2_minix_iomap_ops;
 
 static inline struct minix_sb_info *minix_sb(struct super_block *sb)
 {
@@ -95,11 +105,17 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
 	return container_of(inode, struct minix_inode_info, vfs_inode);
 }
 
-static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
+static inline unsigned int minix_blocks_needed(unsigned int bits, unsigned int blocksize)
 {
 	return DIV_ROUND_UP(bits, blocksize * 8);
 }
 
+static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode *inode)
+{
+	return (INODE_VERSION(inode) == MINIX_V1) ?
+		&V1_minix_iomap_ops : &V2_minix_iomap_ops;
+}
+
 #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
 	defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
 
@@ -129,7 +145,7 @@ static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
  * big-endian 16bit indexed bitmaps
  */
 
-static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
+static inline int minix_find_first_zero_bit(const void *vaddr, unsigned int size)
 {
 	const unsigned short *p = vaddr, *addr = vaddr;
 	unsigned short num;
-- 
2.47.3

