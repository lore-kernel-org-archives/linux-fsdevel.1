Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FF3CBE71
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161255; cv=none; b=n1gApQ2luGv8dvlz3wnc4r5PfxN33+w88NRhmSiZEiklCLeeeZVOxy1Xa2t3VZ9DeDdRDqsgKsJCzvuSe8Nd3m81ZjuHOu4oygrrW3I4AwxJDihEV1bd9FlEQhF4sAFaheBtq573J8VrrMzGEIEnwydmKAkaSe6u9gAtz+joHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161255; c=relaxed/simple;
	bh=xU5n+mIIoZXtzCpNbCf/Cc4DkEYifetPRkM1IVS+p6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVgEJrRCX5lxFSkVVNCTacs1DkpLZtfLuivsUch1Z9vydTaapBGU9FLmu/MehLFYXOztIeocAuHn7zgK/roB2H3S4jM9lE113LWuNb1fTu8uEmrD3Ff3WWj+xxS3MUB/rj3UcO/u6NN/qx2hHUMfzlt6s+1/jsBoz0FOsIV/4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488822b93c7so6003725e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161252; x=1776766052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLsOWgSgd0+sji5zrVI71lwx4+8AIBuQ+XeZ7/IKXtA=;
        b=ZRvZYGu3wEZjzmOBUOybFaZrOH9u0QT8jHsC7mVlKtpxrHftg0QMZaV9RJmUwHsSvV
         xHnKFDQfuVCzO8Hd70p870xGQAVnZpbR3nQwwKEpTWZUYqPgkUs1fXsODai9wTHSKhDT
         /OHv8wISwKhwktKHSC6dRI8di1E7sLDdS0X8XstPlNdmxW9gGJA7XFCeym+C4i5uyi08
         lLxsYYd3P7S/39fYPU2DbzilEN/V0gRb0LMPWrcjhmCGBImPF1Pk3tL1+4TxEB61CweW
         dXmk5wpgqEEGdbSF5hSWDlzBfqClDk9paZZNWyd5HvUMQOWKoWK+1cOCxjBjOXnj2tAv
         +bHg==
X-Gm-Message-State: AOJu0Yw1SgM4gGHg02oCTRnwePryvYLu3OAblb7k0YTaKFEWgFSM/FFR
	RbGOhfEPxaJMH7mqTe3fb6Wq6PfP0FOvGiacAfYtDiooPSIXd4D3HIB9AwTU9jrQ
X-Gm-Gg: AeBDievwEF0GqYnCMNtQNZjSSIjkYeiEXR6994tziLZ8m6oydDfSd/MRpmTeBGlMdIp
	AC/D5ordeRjmLsKXx6UwWHaQs9G5VI12nXdj/X5Mr7IULLH2obambYZbo1iqhqIAKk7ERyRKH2y
	qbLY4jEYnqyw1fDBO8SzplvBOW+PsvqT+bN9OKPtYGDcod909EmDhl/vFzTf22egCgb/3VwJaHp
	i79ahrUCFqbkxAMzh8sWcX9JPu7tK4i/idR7Ieks3OkV9P9szJB5p7khS+LVdVBOvcozFffoy+/
	Q+uDlb7BXNN6V2kEYHEva+gEk3iUB4bIIBgDbYMCA8skwew0vYKsN4ksY77bb1I7Ch+ag6A6F3l
	i/9yrl97Qet4NMcqUE5q42EVLBQciR2R+/OcuncFPn55kJU/Ty7MZa9/PcAsPU6ikd0LwD+Aguz
	9iS6fXCLHsV2p2Lclru2XBdI7Wmw8clqjPorNsfMnfn44LNWLLJMpkcf6ZMEYG/NHpsGqIndax1
	1A=
X-Received: by 2002:a05:600c:4ece:b0:488:a2ac:a338 with SMTP id 5b1f17b1804b1-488d7f3328bmr115367545e9.5.1776161252032;
        Tue, 14 Apr 2026 03:07:32 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:31 -0700 (PDT)
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
Subject: [PATCH v3 03/12] ftrfs: add inode operations
Date: Tue, 14 Apr 2026 14:07:16 +0200
Message-ID: <20260414120726.5713-4-aurelien@hackers.camp>
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

Implement ftrfs_iget() to read inodes from the on-disk inode table:

- Locate inode block from s_inode_table_blk and inode number
- Read raw ftrfs_inode via sb_bread()
- Verify per-inode CRC32 checksum
- Populate VFS inode fields (mode, uid, gid, size, timestamps)
- Copy direct/indirect block pointers to ftrfs_inode_info
- Assign inode_operations and file_operations based on file type
- Use inode_state_read_once() for I_NEW test (kernel 7.0 API)

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/inode.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 fs/ftrfs/inode.c

diff --git a/fs/ftrfs/inode.c b/fs/ftrfs/inode.c
new file mode 100644
index 000000000000..e1279c7968a3
--- /dev/null
+++ b/fs/ftrfs/inode.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FTRFS — Inode operations
+ * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
+ */
+
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include "ftrfs.h"
+
+/*
+ * ftrfs_iget — read inode from disk into VFS
+ * @sb:  superblock
+ * @ino: inode number (1-based)
+ *
+ * Inode table starts at s_inode_table_blk.
+ * Each block holds FTRFS_BLOCK_SIZE / sizeof(ftrfs_inode) inodes.
+ */
+struct inode *ftrfs_iget(struct super_block *sb, unsigned long ino)
+{
+	struct ftrfs_sb_info    *sbi = FTRFS_SB(sb);
+	struct ftrfs_inode_info *fi;
+	struct ftrfs_inode      *raw;
+	struct buffer_head      *bh;
+	struct inode            *inode;
+	unsigned long            inodes_per_block;
+	unsigned long            block, offset;
+	__u32                    crc;
+
+	inode = iget_locked(sb, ino);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	/* Already in cache */
+	if (!(inode_state_read_once(inode) & I_NEW))
+		return inode;
+
+	inodes_per_block = FTRFS_BLOCK_SIZE / sizeof(struct ftrfs_inode);
+	block  = le64_to_cpu(sbi->s_ftrfs_sb->s_inode_table_blk)
+		 + (ino - 1) / inodes_per_block;
+	offset = (ino - 1) % inodes_per_block;
+
+	bh = sb_bread(sb, block);
+	if (!bh) {
+		pr_err("ftrfs: unable to read inode block %lu\n", block);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
+
+	raw = (struct ftrfs_inode *)bh->b_data + offset;
+	/* Verify inode CRC32 */
+	crc = ftrfs_crc32(raw, offsetof(struct ftrfs_inode, i_crc32));
+	if (crc != le32_to_cpu(raw->i_crc32)) {
+		pr_err("ftrfs: inode %lu CRC32 mismatch\n", ino);
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
+
+	fi = FTRFS_I(inode);
+
+	/* Populate VFS inode */
+	inode->i_mode  = le16_to_cpu(raw->i_mode);
+	inode->i_uid   = make_kuid(sb->s_user_ns, le16_to_cpu(raw->i_uid));
+	inode->i_gid   = make_kgid(sb->s_user_ns, le16_to_cpu(raw->i_gid));
+	set_nlink(inode, le16_to_cpu(raw->i_nlink));
+	inode->i_size  = le64_to_cpu(raw->i_size);
+	inode->i_blocks = le32_to_cpu(raw->i_blocks);
+
+	inode_set_atime(inode,
+		le64_to_cpu(raw->i_atime) / NSEC_PER_SEC,
+		le64_to_cpu(raw->i_atime) % NSEC_PER_SEC);
+	inode_set_mtime(inode,
+		le64_to_cpu(raw->i_mtime) / NSEC_PER_SEC,
+		le64_to_cpu(raw->i_mtime) % NSEC_PER_SEC);
+	inode_set_ctime(inode,
+		le64_to_cpu(raw->i_ctime) / NSEC_PER_SEC,
+		le64_to_cpu(raw->i_ctime) % NSEC_PER_SEC);
+
+	/* Copy block pointers to in-memory inode */
+	memcpy(fi->i_direct, raw->i_direct, sizeof(fi->i_direct));
+	fi->i_indirect  = raw->i_indirect;
+	fi->i_dindirect = raw->i_dindirect;
+	fi->i_flags     = le32_to_cpu(raw->i_flags);
+
+	/* Set ops based on file type */
+	if (S_ISDIR(inode->i_mode)) {
+		inode->i_op  = &ftrfs_dir_inode_operations;
+		inode->i_fop = &ftrfs_dir_operations;
+	} else if (S_ISREG(inode->i_mode)) {
+		inode->i_op  = &ftrfs_file_inode_operations;
+		inode->i_fop = &ftrfs_file_operations;
+	} else {
+		/* Special files: use generic */
+		init_special_inode(inode, inode->i_mode, 0);
+	}
+
+	brelse(bh);
+	unlock_new_inode(inode);
+	return inode;
+}
-- 
2.52.0

