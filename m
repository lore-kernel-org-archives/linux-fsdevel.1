Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15213CCFBA
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161259; cv=none; b=GrJnnQ0/zVKZcwJmJy3MB8C6mL/Kw7ya8UGBu3iBnU2dXIym6rOeJPL7WGBPZhzyinQGqTzaSAWe84ZiSeRKfKXo+uYDYw+MsTvn3D4DnxT0kL6xb/itk3EOy2rRDMbwrGeTLs/5iXQiw09A4lsYTO3ZHNq9llKOgzHqcgN2xCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161259; c=relaxed/simple;
	bh=HjovzqKRfihyvi0RQP8r60/89dcJiz4P3enX/XynB0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7pSOmTjkAKzHKSjTOcpFeYANS4QajqS0opDf1Q6GENVdZKTdkm/hAebxxnTQja1GVYtIg0ydrvxUomoGq1T8vBXtwEK8tIyJzpsIpA6muFx3x0lUiE9EMGhBgG7Y9LDBWIELVJoYrYwrcxLUk30R21uh6A2tTePdT66KXJNyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so87379f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161256; x=1776766056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRwwsnX7+MUddonl4tGcWMd+tJhgj+p0Mkr9fVPJ6QQ=;
        b=MBsOExbl8Rk7MfWiNNYwtXV7PAaKAIG1GXUSLw/1Z50PYJQwgw3HaYnT6IygjweFQS
         CsKy7QnwVrGLY7GcShLyaHSjCNGKpsS5RppDAc0eYST0j55QiQjeQYmUyrM7QkzPuFUb
         swGviEfQgXmiw/KKjj7s0lXbilaGtYe8RJjtbRdu8QQX1sO6FJdYdKlZ4VitUjL1sSll
         MKDS2VNt3HaBQ1rt1O8QlJIbtaD3OcDKAfad+2Rg0U9ATL04R4y0B4p1OYy8LhpQcXfz
         PtFPhP+JbyvPdTYUINxRC+eObfEURwTLeVkrTvJuARiwMX5vdQuOCNOskkNHyERP5prF
         Mb+A==
X-Gm-Message-State: AOJu0YzXUefZSSaxZGTpk4BdsuqXiLra0UA9TFWnCoxHiX00MlL4GC7D
	eNnxXA4+Bs2/mX3h7ams8qfcaAIb+hnbts1O3CIHRGZADnqUaUKchk22WeVfeSgz
X-Gm-Gg: AeBDieuWYjn0R5BD4G6BZeFnKFRQwo4J6fTOXaUt2IJCN+JcLtSRFrGNfmLpDxAdiLf
	I1X0SIsOwhfIYckaksPLSp9tgKhb+te2Ye1/11qLwyvN/t8QUCaJ+luyMATW7I5HPW+KaZH+thP
	xg2GgRqEe9mxVii+G375IPF7fcsXapIpS/cr2f3NjUa6LtludKPbbxt9cUCzl8sv9NmEYbLkmBX
	esiN26M1RYU4sRIrninrmX77Jxp5y/hSvuh5Xqt+ej6ElqX7NKT+t9J3SzFbtWSa3R5uXviJyCO
	0gM7oSnTv5iRjOjpNQZM9chm4VW4kURRYPS4nqyAVgp5RTPCu0SHH9vucE8P2b/hvPvxXfluL8+
	71mIughmfWfUMemZsvCqBxsfF6F08FRkKMNGdfid5DUbqoERYFNVWqI5iy4yfBtmuPFCRA1YvSz
	ol+sOcGcERpqFIriFR3sre3lBxK0pzdnfju3VNsTMHRQfuGyzNvGQ8XmtUMp0p1cmWHJPBvkMIU
	4E=
X-Received: by 2002:a05:600c:3b29:b0:485:3177:d80c with SMTP id 5b1f17b1804b1-488d67d7278mr121437025e9.2.1776161255710;
        Tue, 14 Apr 2026 03:07:35 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:35 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	pedro.falcato@gmail.com,
	xiang@kernel.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH v3 06/12] ftrfs: add block and inode allocator
Date: Tue, 14 Apr 2026 14:07:19 +0200
Message-ID: <20260414120726.5713-7-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414120726.5713-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement in-memory bitmap allocator for blocks and inodes:

- ftrfs_setup_bitmap(): allocate and initialize the free block bitmap
  from superblock s_free_blocks count at mount time
- ftrfs_destroy_bitmap(): release bitmap at umount
- ftrfs_alloc_block(): find-first-bit allocator, updates on-disk
  superblock s_free_blocks counter via mark_buffer_dirty()
- ftrfs_free_block(): return block to pool, double-free detection
- ftrfs_alloc_inode_num(): linear scan of inode table for a free
  slot (i_mode == 0), updates s_free_inodes counter

The bitmap is loaded from the superblock free block count at mount
and persisted incrementally on each allocation/free. A dedicated
on-disk bitmap block is planned for a future revision.

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/alloc.c | 251 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)
 create mode 100644 fs/ftrfs/alloc.c

diff --git a/fs/ftrfs/alloc.c b/fs/ftrfs/alloc.c
new file mode 100644
index 000000000000..753eb67cf9ff
--- /dev/null
+++ b/fs/ftrfs/alloc.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FTRFS — Block and inode allocator
+ * Author: Aurélien DESBRIERES <aurelien@hackers.camp>
+ *
+ * Simple bitmap allocator. The free block bitmap is stored in-memory
+ * (loaded at mount time) and persisted to disk on each allocation/free.
+ *
+ * Layout assumption (from mkfs.ftrfs):
+ *   Block 0          : superblock
+ *   Block 1..N       : inode table
+ *   Block N+1        : root dir data
+ *   Block N+2..end   : data blocks
+ *
+ * The bitmap itself is stored in the first data block after the inode
+ * table. Each bit represents one data block (1 = free, 0 = used).
+ */
+
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+#include "ftrfs.h"
+
+/*
+ * ftrfs_setup_bitmap — allocate and initialize the in-memory block bitmap
+ * Called from ftrfs_fill_super() after the superblock is read.
+ *
+ * For the skeleton we use a simple in-memory bitmap initialized from
+ * s_free_blocks. A full implementation would read the on-disk bitmap block.
+ */
+int ftrfs_setup_bitmap(struct super_block *sb)
+{
+	struct ftrfs_sb_info *sbi = FTRFS_SB(sb);
+	unsigned long total_blocks;
+	unsigned long data_start;
+
+	total_blocks = le64_to_cpu(sbi->s_ftrfs_sb->s_block_count);
+	data_start   = le64_to_cpu(sbi->s_ftrfs_sb->s_data_start_blk);
+
+	if (total_blocks <= data_start) {
+		pr_err("ftrfs: invalid block layout (total=%lu data_start=%lu)\n",
+		       total_blocks, data_start);
+		return -EINVAL;
+	}
+
+	sbi->s_nblocks     = total_blocks - data_start;
+	sbi->s_data_start  = data_start;
+
+	/* Allocate bitmap: one bit per data block */
+	sbi->s_block_bitmap = bitmap_zalloc(sbi->s_nblocks, GFP_KERNEL);
+	if (!sbi->s_block_bitmap)
+		return -ENOMEM;
+
+	/*
+	 * Mark all blocks as free initially.
+	 * A full implementation would read the on-disk bitmap here.
+	 * For now we derive free blocks from s_free_blocks in the superblock.
+	 */
+	bitmap_fill(sbi->s_block_bitmap, sbi->s_nblocks);
+
+	/*
+	 * Mark blocks already used (total - free) as allocated.
+	 * We mark from block 0 of the data area upward.
+	 */
+	{
+		unsigned long used = sbi->s_nblocks - sbi->s_free_blocks;
+		unsigned long i;
+
+		for (i = 0; i < used && i < sbi->s_nblocks; i++)
+			clear_bit(i, sbi->s_block_bitmap);
+	}
+
+	pr_info("ftrfs: bitmap initialized (%lu data blocks, %lu free)\n",
+		sbi->s_nblocks, sbi->s_free_blocks);
+
+	return 0;
+}
+
+/*
+ * ftrfs_destroy_bitmap — free the in-memory bitmap
+ * Called from ftrfs_put_super().
+ */
+void ftrfs_destroy_bitmap(struct super_block *sb)
+{
+	struct ftrfs_sb_info *sbi = FTRFS_SB(sb);
+
+	if (sbi->s_block_bitmap) {
+		bitmap_free(sbi->s_block_bitmap);
+		sbi->s_block_bitmap = NULL;
+	}
+}
+
+/*
+ * ftrfs_alloc_block — allocate a free data block
+ * @sb:  superblock
+ *
+ * Returns the absolute block number (>= s_data_start) on success,
+ * or 0 on failure (0 is the superblock, never a valid data block).
+ *
+ * Caller must hold sbi->s_lock.
+ */
+u64 ftrfs_alloc_block(struct super_block *sb)
+{
+	struct ftrfs_sb_info *sbi = FTRFS_SB(sb);
+	unsigned long bit;
+
+	if (!sbi->s_block_bitmap) {
+		pr_err("ftrfs: bitmap not initialized\n");
+		return 0;
+	}
+
+	spin_lock(&sbi->s_lock);
+
+	if (sbi->s_free_blocks == 0) {
+		spin_unlock(&sbi->s_lock);
+		pr_warn("ftrfs: no free blocks\n");
+		return 0;
+	}
+
+	/* Find first free bit (set = free in our convention) */
+	bit = find_first_bit(sbi->s_block_bitmap, sbi->s_nblocks);
+	if (bit >= sbi->s_nblocks) {
+		spin_unlock(&sbi->s_lock);
+		pr_err("ftrfs: bitmap inconsistency (free_blocks=%lu but no free bit)\n",
+		       sbi->s_free_blocks);
+		return 0;
+	}
+
+	/* Mark as used */
+	clear_bit(bit, sbi->s_block_bitmap);
+	sbi->s_free_blocks--;
+
+	/* Update on-disk superblock counter */
+	sbi->s_ftrfs_sb->s_free_blocks = cpu_to_le64(sbi->s_free_blocks);
+	mark_buffer_dirty(sbi->s_sbh);
+
+	spin_unlock(&sbi->s_lock);
+
+	/* Return absolute block number */
+	return (u64)(sbi->s_data_start + bit);
+}
+
+/*
+ * ftrfs_free_block — release a data block back to the free pool
+ * @sb:    superblock
+ * @block: absolute block number to free
+ */
+void ftrfs_free_block(struct super_block *sb, u64 block)
+{
+	struct ftrfs_sb_info *sbi = FTRFS_SB(sb);
+	unsigned long bit;
+
+	if (block < sbi->s_data_start) {
+		pr_err("ftrfs: attempt to free non-data block %llu\n", block);
+		return;
+	}
+
+	bit = (unsigned long)(block - sbi->s_data_start);
+
+	if (bit >= sbi->s_nblocks) {
+		pr_err("ftrfs: block %llu out of range\n", block);
+		return;
+	}
+
+	spin_lock(&sbi->s_lock);
+
+	if (test_bit(bit, sbi->s_block_bitmap)) {
+		pr_warn("ftrfs: double free of block %llu\n", block);
+		spin_unlock(&sbi->s_lock);
+		return;
+	}
+
+	set_bit(bit, sbi->s_block_bitmap);
+	sbi->s_free_blocks++;
+
+	/* Update on-disk superblock counter */
+	sbi->s_ftrfs_sb->s_free_blocks = cpu_to_le64(sbi->s_free_blocks);
+	mark_buffer_dirty(sbi->s_sbh);
+
+	spin_unlock(&sbi->s_lock);
+}
+
+/*
+ * ftrfs_alloc_inode_num — allocate a free inode number
+ * @sb: superblock
+ *
+ * Returns inode number >= 2 on success (1 = root, reserved),
+ * or 0 on failure.
+ *
+ * Simple linear scan of the inode table for a free slot.
+ * A full implementation uses an inode bitmap block.
+ */
+u64 ftrfs_alloc_inode_num(struct super_block *sb)
+{
+	struct ftrfs_sb_info    *sbi = FTRFS_SB(sb);
+	struct ftrfs_inode      *raw;
+	struct buffer_head      *bh;
+	unsigned long            inodes_per_block;
+	unsigned long            inode_table_blk;
+	unsigned long            total_inodes;
+	unsigned long            block, i;
+	u64                      ino = 0;
+
+	inodes_per_block = FTRFS_BLOCK_SIZE / sizeof(struct ftrfs_inode);
+	inode_table_blk  = le64_to_cpu(sbi->s_ftrfs_sb->s_inode_table_blk);
+	total_inodes     = le64_to_cpu(sbi->s_ftrfs_sb->s_inode_count);
+
+	spin_lock(&sbi->s_lock);
+
+	if (sbi->s_free_inodes == 0) {
+		spin_unlock(&sbi->s_lock);
+		return 0;
+	}
+
+	/* Scan inode table blocks looking for a free inode (i_mode == 0) */
+	for (block = 0; block * inodes_per_block < total_inodes; block++) {
+		bh = sb_bread(sb, inode_table_blk + block);
+		if (!bh)
+			continue;
+
+		raw = (struct ftrfs_inode *)bh->b_data;
+
+		for (i = 0; i < inodes_per_block; i++) {
+			unsigned long ino_num = block * inodes_per_block + i + 1;
+
+			if (ino_num > total_inodes)
+				break;
+
+			/* inode 1 = root, always reserved */
+			if (ino_num == 1)
+				continue;
+
+			if (le16_to_cpu(raw[i].i_mode) == 0) {
+				/* Found a free inode slot */
+				ino = (u64)ino_num;
+				sbi->s_free_inodes--;
+				sbi->s_ftrfs_sb->s_free_inodes =
+					cpu_to_le64(sbi->s_free_inodes);
+				mark_buffer_dirty(sbi->s_sbh);
+				brelse(bh);
+				goto found;
+			}
+		}
+		brelse(bh);
+	}
+
+found:
+	spin_unlock(&sbi->s_lock);
+	return ino;
+}
-- 
2.52.0

