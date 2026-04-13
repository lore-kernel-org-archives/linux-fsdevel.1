Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEF3C65E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083061; cv=none; b=kLHtOTxGYeDwfkSOoYaj7HnQNBJzIByn4PttV5wMZT7U/xdhRRga5YIWK22cBboFyzJf8nAE7lEwjnPB2gwQ2P7Sr0alEUi2R824xv0kxkNFeiTmyPaBGxQlUwZTyOsRvgN+HX9r+rIXJbvVroK+P/dTBRk3uH3PRWMoNvErcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083061; c=relaxed/simple;
	bh=njbQ6TRGYgAFDYSaXN6nlDFDqqbrx0ijRkIup15Habc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJQNDA5hoMf+Mt/Yi1XWBMPVf16F/V+Z3XW0DZuEdPthTM0/8ZbdSZo5j2/5ynyxcmrx96gs6vssuSPqPvwqYXELO3Ps+iLsVibFfLcBvommcIWaOPc9omhXc99QpM4YAOsRf51VvrpcWFTaSCzhU9/tF6OqFk2uZR3RPJxePmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so5140215e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083058; x=1776687858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2Mpy3zHfwPAQWDaXayn/C+o10mu0D5BapmAlAiE67Y=;
        b=iNRuyJ5SdYQx1ksJb+PvmhLjuehiWoix9maEa8ZD1P6AnGmG8TE5nY+gl3ZB93KB80
         lzMmDBtbqev9WJ3REwaTNVLLkjCAuY+VbSIBmcAR//LI8Yu4t0LHFglbraXCb/yQOX3m
         XQnvt8bkGMSG2zU0reM31c/KGzXp/dgKSmRXivsy8vdErDmmbEjdab3rvB26gB01WI+D
         Yw5uCkCDvkE9RbT002RgFbmbfDgZq9Lp5EVvndpD61r4ZWh49PqFeWT5u25HrPfZpSst
         ickrJgid45xrhPT4d0fdLsScVFIhPfhI6+qFmyH0PSRyW+aXgCpxCWhoU9VrrlIDlSv9
         5VoA==
X-Gm-Message-State: AOJu0YzBp+vzXLHASHKB09Cc3CW39azFW/eUmcJ38OzzqFIfFxDamndb
	d2bKT6fg52JW04YEIa+iKiCsvd3uCuWtFYz6cylRVPYib97TkopQG5u4EvleXrxjNVA=
X-Gm-Gg: AeBDietI0w7+s9uAsare+5NE4mc8uzmwBXHnuGWr1iBwzgKhHV6CtXpcsuzKAUPCkx0
	wZEnjnAHmpAVzvc/3w63dcLO2sIMZfDIJ4GGGTq7usWFzfhUPEjRAr8bnkcHmoxMRax5Mu/Oh0l
	mAFoIaOVmdTmqT2kGJQDZyWk5LT/B11xG6sbKtRoyhZWiOGso2G9ndu+OlT9Rw/e3HSdjW26txu
	GiPK/uLqOvXsC69mINjeTFDecUA23d9wsyC16b9q70VugrgdSh6Hktw1ZvUm0mK7QCC6Rp0FowT
	MbiAyvrbMD3plb2xIOKSoL06nH4mSO7RabpCmhYhEbi06gwZZEXoT4dHqJfhre9cD0YBvvfSM7f
	TQ72TP6wNmeVRFvUVa++yOOjxZdVV3fbB2Y6ZzbPDi182ZYq7DiugAaUQVu/t9nBaAQ+ZjLbD/T
	QINpJADZUL7eQ83t10CybYQM30iNirZbQyGAGRmMgv+h3TE4Ppv2k7lNPMbTB5RAGb4ErYbzKQu
	qoD
X-Received: by 2002:a05:600c:b85:b0:488:afb4:b98c with SMTP id 5b1f17b1804b1-488d68b3827mr100330225e9.3.1776083056585;
        Mon, 13 Apr 2026 05:24:16 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:16 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 03/10] ftrfs: add inode operations
Date: Mon, 13 Apr 2026 16:23:49 +0200
Message-ID: <20260413142357.515792-4-aurelien@hackers.camp>
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

Implement ftrfs_iget() to read inodes from the on-disk inode table:

- Locate inode block from s_inode_table_blk and inode number
- Read raw ftrfs_inode via sb_bread()
- Verify per-inode CRC32 checksum
- Populate VFS inode fields (mode, uid, gid, size, timestamps)
- Copy direct/indirect block pointers to ftrfs_inode_info
- Assign inode_operations and file_operations based on file type
- Use inode_state_read_once() for I_NEW test (kernel 7.0 API)

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/inode.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 fs/ftrfs/inode.c

diff --git a/fs/ftrfs/inode.c b/fs/ftrfs/inode.c
new file mode 100644
index 000000000..e1279c796
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

