Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D748987C
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780526; cv=none; b=I6NIsXuvcHZSMtlZv1Fcu4PvapMEEnXVacOWRhnAq4QFzU7K9NrptAS2jUv/mq55q6a14xyTubvDhRLxyKSvCp9+lNslCKKznK/hAHC6vdC7CuOMPqCalMjChmp3Y8aGhwpSS5Z/OWxMI12fj9wIOikckQ3BtJqOX0CMikqa7yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780526; c=relaxed/simple;
	bh=ov0ZxImQEsYJcJvX8xdhNnzUus7UhmOk1kD3vKbinrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0B6jbHJmIrwlZB/1ALOBuA1gEK08KvoCsIi0X8MWtNH/tNqvuaGpF4+dyZWI982rRxAuLuix/ppeiKjK+8ViQEWEYpOC6ejmt+2OQVQFQAezarjaTAk7lCOrALDg6n4U0KOS8lXAPb4jVe1Vx8EuafTkz4uF1K6FzWpnRpqZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eElqbU+y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eElqbU+y"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1192769a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787780524; x=1788385324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kv3c9GC/khtykDvIth2imKR6x9vvbRKSQGnD75nijyQ=;
        b=eElqbU+yJC6UGX0OMP80ODLsjdxq25NdFB8V5krsRrqGHnuI2MvagBsVxfx0lPcoKC
         KDwin3e4OPP9H31wuvKRnhAGXa+ORRAySRTlMwW9OoyW/9U4LI8OMluyHYxjf5uPj3Lj
         8W3osyi+JgbVpaGupBnxGatYc79fxgKA1r9TxT7zDjZSS7hN20ASygjEcXu0BlQR6lpx
         MhOX9YSl5fEnm7MsFQtC/WNoPM6BSP3qlnPwqhamr7lf9fd8IX2soCneFzKLZN7Y1MSB
         D5tvwdfz4Zbxt8X7Clwyc1T1mya8QKb4pBhzXcKttxhuVGouQ20VyYgHXKgRUednuUfS
         QSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780524; x=1788385324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kv3c9GC/khtykDvIth2imKR6x9vvbRKSQGnD75nijyQ=;
        b=aB7TgU9hgEeXqz10oYZsSA8lCwfnZo/U6U/Eypfim441/8P1KE2W/dK7ssnCOCTax4
         2cesZ1aJdDlArekIdudICraHtOwVpii/jCVAC7NbQbW4fHDE7QbgewhS+36w4dm6/Dvc
         r60+jwNFymiyUDE6u36K8NsxYuMi2DskccV2pGPPApjtxPQiSi9Pyb+yUtaEL9u0qtZu
         hYTjVl/5kI6Nlvf/ogdBcHZNl5Bh8NR5RVZ+/TvTE5fg+fQLhbKRTphyzZOmBr2o7XwS
         t54VHVCvO6l+q2ftCdr+C1UCgPE8p0CgYVIXoKbGxOH+QHefSdx8p4jRBLYaf+MdzvO/
         WjzA==
X-Gm-Message-State: AFuF++lsP11Uk9LR5UoedfM0nt6XGMr/otfI4vjcpCZHKBQg8z22AXXb
	3pQFTERQFU28BkUAa4/m/zpmxAtLbPlX0ESU+og77zeswihIh0NnG+YraRIfI+50
X-Gm-Gg: AR+sD12nxLwZE5goiL8pL0HSvBcVcwUy/XhAHvt9RL57fpCuWcQBV97PowrvtA5A7j9
	tP+WiX7lr/ZUHsGf54OqtkM1Y3+bL7V1baV60aFSLqwX77+pwLskAKcfDJbehhvMum2RjYkUOvQ
	zwLZ0tLnlJO7s68MxBQ1CopQJoNQ50RMH14VWzo8oGPLwExd30X8pJmH5SyOi7WD/OumqaYQodv
	6yy+9coVV4q/FcggFzspjt1D+lAhgZDsAqsDw3Udp6Uk42jX/ERD1sfT+a8iQARAiTGzMJQe4Ln
	gEaismv/AuvhFiFwDLvtM/FIGfcmfA2ryKVymwfqQIpz9RrsE5vpmu+EPO4j5H571u+QTtE/bAG
	95zKvZLydmOALtlDPpxZqLmE4tqJNXqvi6K6wvFMkjmWQYEqC7uGpybe3guJBYl3i5N2Ek0EnMy
	YG836ZFLw0wycSzSXf6lNQwfP3ldG3fY5G6do=
X-Received: by 2002:a17:90b:3d4f:b0:396:635a:9b12 with SMTP id 98e67ed59e1d1-3966d48beb5mr20657270a91.12.1787780523937;
        Wed, 26 Aug 2026 14:42:03 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396689f1419sm5628673a91.9.2026.08.26.14.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:42:03 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	hch@infradead.org,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v4 2/3] minix: add iomap functions and definitions
Date: Wed, 26 Aug 2026 14:41:56 -0700
Message-ID: <e7ab836149f814b04017905dca2e07a4c94078db.1787770110.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787770110.git.jbingham@gmail.com>
References: <cover.1787770110.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a new file, iomap.c, to fs/minix. This provides minix_iomap_begin,
which is the iomap-based version of get_block in itree_common.c. It also
provides minix_iomap_end, which is a no-op function required by the
iomap_ops struct. The minix_iomap_begin function also uses helper
functions to undo the nest of gotos inherited from get_block.

This patch also wires iomap.c into itree_v1.c and itree_v2.c, similarly
to how itree_common.c is included in those files, and exports version
specific versions of minix_iomap_begin and iomap_ops.

Also updates 'unsigned' to 'unsigned int' a few places that got picked
up by checkpatch.pl.

Suggested-by: Darrick J. Wong <djwong@kernel.org>

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/iomap.c    | 122 ++++++++++++++++++++++++++++++++++++++++++++
 fs/minix/itree_v1.c |  25 ++++++++-
 fs/minix/itree_v2.c |  17 +++++-
 fs/minix/minix.h    |  21 +++++++-
 4 files changed, 181 insertions(+), 4 deletions(-)
 create mode 100644 fs/minix/iomap.c

diff --git a/fs/minix/iomap.c b/fs/minix/iomap.c
new file mode 100644
index 000000000000..90e016aaa01e
--- /dev/null
+++ b/fs/minix/iomap.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * iomap functions for minix.
+ */
+
+static inline void minix_chain_cleanup(Indirect *chain, Indirect *partial)
+{
+	while (partial > chain) {
+		brelse(partial->bh);
+		partial--;
+	}
+}
+
+static inline void minix_iomap_set_mapped(struct iomap *iomap, sector_t phys,
+		unsigned int blkbits, sector_t iblock)
+{
+	iomap->type = IOMAP_MAPPED;
+	iomap->addr = (u64)phys << blkbits;
+	iomap->length = 1 << blkbits;
+	iomap->offset = (u64)iblock << blkbits;
+}
+
+static inline void minix_iomap_set_hole(struct iomap *iomap,
+		unsigned int blkbits, sector_t iblock)
+{
+	iomap->type = IOMAP_HOLE;
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->length = 1 << blkbits;
+	iomap->offset = (u64)iblock << blkbits;
+}
+
+/*
+ * minix_iomap_begin - map a file range to disk blocks. It acts as a replacement
+ * for get_block in itree_common.c, at least in the important ways, and is
+ * adapted from it, but it uses iomap instead of buffer_head.
+ */
+static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int blkbits = sb->s_blocksize_bits;
+	sector_t iblock = offset >> blkbits;
+	int create = flags & IOMAP_WRITE;
+
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
+		return -EINVAL;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+
+reread:
+	partial = get_branch(inode, depth, offsets, chain, &err);
+
+	/* Simplest case - block found, no allocation needed */
+	if (!partial) {
+		iomap->flags = 0;
+		phys = block_to_cpu(chain[depth - 1].key);
+		partial = chain+depth-1;
+		minix_iomap_set_mapped(iomap, phys, blkbits, iblock);
+		minix_chain_cleanup(chain, partial);
+		return err;
+	}
+
+	/* Next simple case - plain lookup or failed read of indirect block */
+	if (!create || err == -EIO) {
+		minix_iomap_set_hole(iomap, blkbits, iblock);
+		minix_chain_cleanup(chain, partial);
+		return err;
+	}
+
+	/*
+	 * This is held over from the original get_block logic, where it
+	 * acted as a guard in case truncate() deleted blocks from under that
+	 * function. There should not be a race with iomap operations, but
+	 * we're retaining the defensive coding here to be extra safe just in
+	 * case.
+	 */
+	if (err == -EAGAIN) {
+		minix_chain_cleanup(chain, partial);
+		goto reread;
+	}
+
+	left = (chain + depth) - partial;
+	err = alloc_branch(inode, left, offsets + (partial - chain), partial);
+	if (err) {
+		minix_chain_cleanup(chain, partial);
+		return err;
+	}
+
+	if (splice_branch(inode, chain, partial, left) < 0) {
+		minix_chain_cleanup(chain, partial);
+		goto reread;
+	}
+
+	/* Successful allocation, mapping it. */
+	iomap->flags = IOMAP_F_NEW;
+	phys = block_to_cpu(chain[depth - 1].key);
+	minix_iomap_set_mapped(iomap, phys, blkbits, iblock);
+	minix_chain_cleanup(chain, partial);
+
+	return err;
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
index 78722ce22e1e..f1141d36e3d5 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -5,6 +5,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/minix_fs.h>
+#include <linux/iomap.h>
 
 #define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
 #define MINIX_V1		0x0001		/* original minix fs */
@@ -76,13 +77,23 @@ int minix_make_empty(struct inode*, struct inode*);
 int minix_empty_dir(struct inode*);
 int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 		struct inode *inode);
+
 struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
 ino_t minix_inode_by_name(struct dentry*);
 
+int V1_minix_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap,
+	struct iomap *srcmap);
+int V2_minix_iomap_begin(struct inode *inode, loff_t offset,
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
@@ -94,11 +105,17 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
 	return container_of(inode, struct minix_inode_info, vfs_inode);
 }
 
-static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
+static inline unsigned int minix_blocks_needed(unsigned int bits, unsigned int blocksize)
 {
 	return DIV_ROUND_UP_POW2(bits, blocksize * 8);
 }
 
+static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode *inode)
+{
+	return (INODE_VERSION(inode) == MINIX_V1) ?
+		&V1_minix_iomap_ops : &V2_minix_iomap_ops;
+}
+
 #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
 	defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
 
@@ -128,7 +145,7 @@ static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
  * big-endian 16bit indexed bitmaps
  */
 
-static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
+static inline int minix_find_first_zero_bit(const void *vaddr, unsigned int size)
 {
 	const unsigned short *p = vaddr, *addr = vaddr;
 	unsigned short num;
-- 
2.47.3

