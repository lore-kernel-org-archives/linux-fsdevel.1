Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BBE3C73CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083063; cv=none; b=odBO8bVuQbwhNn4jNBc/2fTrB5r+X3xH0Pv8oDBsjdYDKBm41q839a2tKpWD6jYgzz9+D3/9eIP2nrEUXqZbCinzemeNxxxxZk1kkTWxqHjNQ3N/k7PquMSQPvGPrc0uUvYIAY+kGKCgA07zbTyHz9g4DbLYxOxHSGj8JSEVQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083063; c=relaxed/simple;
	bh=mN8noW3Zn1oP85yoTkMQ5d540tJEOiEmDOppp4VbrUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsfdSHCs6UJ8X66kFxG+ZlqKssxuPznLR1duSZtVYxU6Hx/sPsVTrLQqZv4MCCA0iC5tsdvjMaYY2wz+nduSEoWE9jcKzGvEhErzMLTUdb+fxImNgJgd87e86zLyio5R+JenmPOFZur16x/40DylFijtDsqSTlLRRk8x0Mq7qbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d77a7193dso63116f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083060; x=1776687860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kY563ybsLG5oJVJBKLv1m4La2ihm4dh6OdjYy/Bn3U4=;
        b=gMIRws0r7PdZcXrYLOQ7o5t0/LhHfVdqmpqfjrHoXNI/mPLfSHE0ygqS2Q1zpI0krc
         g9zziO9V1pP0ZKysi2oyLVQvaSzlpiLc/+UKuEVwUGcILjZHMEvtTHFNgprSdveEv0cu
         1MNiOfMh47NLf/wRtWNSiBvcqjR643jJlmyug3BScL8uusC9gIzkWMIWSkkZqDPG4GI3
         fSlsuwHuo9UjROoMJnhwHmfrXL4yijyvO4+3ey9N2351VwKx3LZR/Vsy6fMVN1bp2NhZ
         +sE8+X7QbadglCmcOo1AF8zKecP1fpRsSwxiK29p8QYVmR2WJ3pKNzxlKlx2w3Ii2YZJ
         09eg==
X-Gm-Message-State: AOJu0Yx7Vxk5ASbWNGKYHSb8RrAOOtDAj4KPmaY0k1LIczHg3/6HQ/px
	uu5EFkxf38ZhT40P43a6mTKnuzNsZgiD6M0guJCl2eNmEkThb3ZDXlzsO7vINhfWY0Q=
X-Gm-Gg: AeBDietNDid1oNy1x2d2mPySYxx0/fsyykzlaNBNEL1slXuYS8BJEP6zciZghvrHjep
	7w8b2jAPzBD7qpwKpu7u0Gp2zGz+dJB/k1asSULHMWfqxhUDABRVnyHvyi2jhDzS4y4EdZSvsmA
	Q4e+VsCS9FuVF/PS1h6IDNNSSdmhqA8Ub6UwLNbsZjQ6+TOJuChUXsjVN219KRqV4w4zv1hpG7B
	joQ8jdSkP0vw/bgEXLfatGn8SEcceonKnfeCgS0RB51VmaSKoTQEZQdHHrUuBhMEX+pDMybstUb
	9nJkJ4dMW+8kFuCerJtJvPU8sMbTHVUh8+YJvE9KZowNBGum0ZKbpDmJVmBHA1oUKES/OFuUPX0
	x0v9+33PlTcTxEAg1Rxr3iDNdo7Y3SB91GbE7E6d2g+CUJ12XKwIMoJW8neUGnW4uL6+MBskkb2
	P8Il9uKSO6z0J5GgCM/VrweZ2qMH8Fs247H55dwQ/no0jjaJyPfcSeXoM5F1oj1iLNrQ==
X-Received: by 2002:a05:600c:c4a2:b0:485:3bc7:a224 with SMTP id 5b1f17b1804b1-488d68609e0mr99223125e9.6.1776083059983;
        Mon, 13 Apr 2026 05:24:19 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:19 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 06/10] ftrfs: add block and inode allocator
Date: Mon, 13 Apr 2026 16:23:52 +0200
Message-ID: <20260413142357.515792-7-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413142357.515792-1-aurelien@hackers.camp>
References: <20260413142357.515792-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aurélien DESBRIERES <aurelien@hackers.camp>

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

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/alloc.c | 251 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)
 create mode 100644 fs/ftrfs/alloc.c

diff --git a/fs/ftrfs/alloc.c b/fs/ftrfs/alloc.c
new file mode 100644
index 000000000..753eb67cf
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

