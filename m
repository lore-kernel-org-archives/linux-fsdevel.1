Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFA1DF74F
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920334; cv=none; b=ZBe2yMCGEO/crG7Dyj1IlK65w8T2/0WiATPO+AXeGmRCCmHVEVwye4lSMTvHYQXSPg3EAL3OztVuKl6tX1f6KQ9sl/xiPvIE53eYir57beB0RQhm10WYf0bUPtIaGRMVDH4w6YFfdZldbDBXM8OwLe+rAZJ46Qffy56pfmVKZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920334; c=relaxed/simple;
	bh=BJ04Gv7+B2m7jZaIi40hW4hNN3KlgK/Ajt5HF+AnKnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXzdWC2rNzbfaDqvl1wnHm2UJ1IGXlR7AOXbmFy4kPvFlZxv44aJgoGueFz0PTjsmjGE1+3NiD19M8Bx2hx/RPDvgnzkimZly+cTyXjVCGHfuA7FKmKWxjOXh6xaTC+7fFHh6pfR0AIOwlbcJy6wdu2dlC5VDoKjiNYZQvG8nvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW2t+xLz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW2t+xLz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so20649805e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775920331; x=1776525131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPAb2Zu1xqpWj4DS9q88UMB36cViMy8+t4UmASklm7E=;
        b=OW2t+xLz1DaUYdQ1LnzY7kB7G+3Cw5iMcTlKb7pirDVWxRsrpIeeMclC15kme7VpJ1
         cD5uGSr9x/X3KyZP9KnSJ+1b/75wZDqyg9NwvhnUtQ+WhU3aF+Zg11YBMFlRauUbC158
         M5bK9MmFpiAxlUbMOOIO09Bjtjvqc8YQm+fCXdZEqGYMzJod7x2+1yBAEKGDO6jmS5vr
         +x5Kx7cu+OD9HYu50Fg8aLRtm+s2qrvqwxOYGKnDA9dSsP/os96mDfWeNfBr4t0m0OBQ
         0vGP354vpeS796Yg+H3llTpWMaQS+80Uc0h9jURQB+azSYuSIJcGUIQDkHD6bmax1fHs
         ZMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775920331; x=1776525131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPAb2Zu1xqpWj4DS9q88UMB36cViMy8+t4UmASklm7E=;
        b=LQnUoc1hzFXMOJgc35vz2xZ7I9H2bOPfXa0G+HfTi5sMYAgaFNIPdclTKqkJoywg0+
         QnyWBMcRZiylSPOqZqX3UnX0CbC1duYLU71KS1EB4eunKCVL6zoHwe2+KAKOebiWnY5I
         Q72k9JogJ1opxMWhwco5pej5i88WCI5BUH+mI6r96PUh1RRo8DlX37tiTPjaSS2lIbgf
         aXpxfjna5pIM7xh4StUBsh4AyzGLbLsTejw1zQAo64oNuqv6fAKMen9LbXk0Dfe+mNsG
         /VMq/oZlsPy/bSBpMaSVDK0GlN/SIJnnO97wnzAr3TwhhgmQA9yjprcS3CZUrJ4rf554
         gClA==
X-Gm-Message-State: AOJu0Yx1D6mfifY5WJ1UaJqKm1qbzLFvFMwO4QTKuZefSY0ku30rIwVF
	oZjIkjLM1Jrlp6YUiV2C/BT63rD92H6BhdiqZ0PJDLie51gCbVwZPqswJuOTAQ==
X-Gm-Gg: AeBDievaowtFexaJ6li6jWfT6Bh/SPDU+sQ/nNlR+UGrAkUbxWG6KjQwLPO8zTTGhIa
	SMgH/cg3sSicF50fow0A/A2XVWZaMLn8VLqAb9kStx/nAW/U+zGu5ZhWgyykeJvFVcs0d+X7/bp
	nPFdYhoaquo+vyzsfriiC4Ot/XIfUO64gmQR7DPF4fqOt6qNV4bdRtxhhW4c+cKXivIhdvraTqS
	M7AbZ/AeneKPf1aJkPjunv6gJkcls/hkaRvndjlrRjRQ/nzIlk1pB9kSvUDuIzS/7s8M1Rvk8n0
	2nVFN40LtM6RfLTnXkVE3vsm4subeYEteCnouvTkq7hgN2wf41n+bXX556Oc2ee2t7yz5AYrmUm
	ySNbuxB/B5opzhtR0fDHCfPnb1I2VkMV/V1wU928kuCG7P/6eajaNFNj0XzUCWWIpBgAWLQHCRB
	EMFaRkuewmGIINEL6HoU2Bc4OrPA5Qt1qg9wmH4JgpY8RtjfdnVELGmm+gNu4oUsDR0U5q/vSEl
	d3ZMfTY529Cu1wRyds9
X-Received: by 2002:a05:600c:c0da:b0:488:ab5b:d711 with SMTP id 5b1f17b1804b1-488d6864b6cmr76496725e9.23.1775920330880;
        Sat, 11 Apr 2026 08:12:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:37d6:c100:81d8:4e83:a60e:1a81])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm17167835f8f.33.2026.04.11.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:12:10 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: Linux FS development <linux-fsdevel@vger.kernel.org>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5 -v2] Add vmufat super.c
Date: Sat, 11 Apr 2026 16:11:35 +0100
Message-ID: <20260411151155.321214-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


super.c provides superblock services for VMUFAT.

A VMUFAT filesystem includes a system block (at block 255 on a factory supplied
VMU) which contains information about the volume size, the file allocation
table and the directory. This code accesses this information.

Using this information super.c also handles basic creation and removal of files
(represented as inodes, though there are no physical inodes on the underlying
medium).

It also initialises (and destroys) caches of inode structures and block lists
(each inode structure holds a linked list of the blocks used by a file).

The code supports, as default behaviour, the Dreamcast policy of placing
executables in lower block numbers and data files in higher block numbers
but it will not fail if this policy cannot be followed.

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>



---
 fs/vmufat/super.c | 581 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 581 insertions(+)
 create mode 100644 fs/vmufat/super.c

diff --git a/fs/vmufat/super.c b/fs/vmufat/super.c
new file mode 100644
index 000000000000..69f4852f3d03
--- /dev/null
+++ b/fs/vmufat/super.c
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VMUFAT file system
+ *
+ * Copyright (C) 2002-2012, 2025, 2026	Adrian McMenamin
+ * Copyright (C) 2002			Paul Mundt
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/fs.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/magic.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/statfs.h>
+#include <linux/buffer_head.h>
+#include <linux/fs_context.h>
+#include "vmufat.h"
+
+static struct kmem_cache *vmufat_inode_cachep;
+struct kmem_cache *vmufat_blist_cachep;
+static const struct super_operations vmufat_super_operations;
+extern int *day_n;
+extern const struct inode_operations vmufat_inode_operations;
+extern const struct file_operations vmufat_file_operations;
+extern const struct address_space_operations vmufat_address_space_operations;
+extern const struct file_operations vmufat_file_dir_operations;
+
+static time64_t vmufat_get_date(struct buffer_head *bh, int offset)
+{
+	int century, year, month, day, hour, minute, second;
+	century = bcd2bin(bh->b_data[offset++]);
+	year = bcd2bin(bh->b_data[offset++]);
+	month = bcd2bin(bh->b_data[offset++]);
+	day = bcd2bin(bh->b_data[offset++]);
+	hour = bcd2bin(bh->b_data[offset++]);
+	minute = bcd2bin(bh->b_data[offset++]);
+	second = bcd2bin(bh->b_data[offset]);
+
+	return mktime64(century * 100 + year, month, day, hour, minute,
+		second);
+}
+
+static struct inode *vmufat_alloc_inode(struct super_block *sb)
+{
+	struct vmufat_inode *vi = kmem_cache_alloc(vmufat_inode_cachep,
+		GFP_KERNEL);
+	if (!vi)
+		return NULL;
+
+	INIT_LIST_HEAD(&vi->blocks);
+	return &vi->vfs_inode;
+}
+
+static void vmufat_destroy_inode(struct inode *in)
+{
+	struct vmufat_inode *vi;
+	struct vmufat_block *iter, *iter2;
+	vi = VMUFAT_I(in);
+	if (!vi)
+		return;
+
+	list_for_each_entry_safe(iter, iter2, &vi->blocks, b_list) {
+		list_del(&iter->b_list);
+		kmem_cache_free(vmufat_blist_cachep, iter);
+	}
+	kmem_cache_free(vmufat_inode_cachep, vi);
+}
+
+struct inode *vmufat_get_inode(struct super_block *sb, long ino)
+{
+	struct buffer_head *bh = NULL;
+	int error = 0, i, j;
+	int offsetindir;
+	struct inode *inode;
+	struct memcard *vmudetails;
+	long superblock_bno;
+	struct timespec64 current_time;
+
+	inode = iget_locked(sb, ino);
+	if (!inode) {
+		error = -ENOENT;
+		goto reterror;
+	}
+	vmudetails = sb->s_fs_info;
+	if (!vmudetails) {
+		error = -ENOMEM;
+		goto reterror;
+	}
+	superblock_bno = vmudetails->sb_bnum;
+
+	if (inode_state_read_once(inode) & I_NEW) {
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
+		inode->i_mode &= ~S_IFMT;
+		if (inode->i_ino == superblock_bno) {
+			bh = vmufat_sb_bread(sb, inode->i_ino);
+			if (!bh) {
+				error = -ENOENT;
+				goto failed;
+			}
+			inode->i_ctime_sec = inode->i_mtime_sec =
+				vmufat_get_date(bh, VMUFAT_SB_DATEOFFSET);
+
+			/* Mark as a directory */
+			inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
+			inode->i_op = &vmufat_inode_operations;
+			inode->i_fop = &vmufat_file_dir_operations;
+		} else {
+			/* Mark file as regular type */
+			inode->i_mode = S_IFREG | S_IRUGO | S_IWUSR;
+
+			/* Scan through the directory to find matching file */
+			for (i = 0; i < vmudetails->dir_len; i++) {
+				brelse(bh);
+				bh = vmufat_sb_bread(sb,
+					vmudetails->dir_bnum - i);
+				if (!bh) {
+					error = -ENOMEM;
+					goto failed;
+				}
+				for (j = 0; j < VMU_DIR_ENTRIES_PER_BLOCK; j++)
+				{
+					u16 ino_read = le16_to_cpu(((u16 *)
+						bh->b_data)[j * 
+						VMU_DIR_RECORD_LEN16 + 
+						VMUFAT_FIRSTBLOCK_OFFSET16]);
+					if (ino_read == ino) {
+							goto found;
+					}
+				}
+			}
+			error = -ENOENT;
+			goto failed;
+found:
+			/* identified the correct directory entry */
+			offsetindir = j * VMU_DIR_RECORD_LEN;
+			inode->i_ctime_sec = inode->i_mtime_sec =
+				vmufat_get_date(bh,
+					offsetindir + VMUFAT_FILE_DATEOFFSET);
+			/* Execute if a game, write if not copy protected */
+			inode->i_mode &= ~(S_IWUGO | S_IXUGO);
+			inode->i_mode |= S_IRUGO;
+			/* Mode - is it write protected? */
+			if ((((u8 *) bh->b_data)[0x01 + offsetindir] == 0x00) &
+				~(sb->s_flags & SB_RDONLY)) {
+				inode->i_mode |= S_IWUSR;
+			}
+			/* Is file executible - ie a game */
+			if ((((u8 *) bh->b_data)[offsetindir] == 0xcc) &
+				~(sb->s_flags & SB_NOEXEC)) {
+				inode->i_mode |= S_IXUSR;
+			}
+			inode->i_blocks =
+				le16_to_cpu(((u16 *) bh->b_data)
+				[offsetindir / 2 + 0x0C]);
+			inode->i_size = inode->i_blocks * sb->s_blocksize;
+			inode->i_mapping->a_ops =
+				&vmufat_address_space_operations;
+			inode->i_op = &vmufat_inode_operations;
+			inode->i_fop = &vmufat_file_operations;
+			error = vmufat_list_blocks(inode);
+			if (error)
+				goto failed;
+		}
+		ktime_get_coarse_real_ts64(&current_time);
+		inode->i_atime_sec = current_time.tv_sec;
+		unlock_new_inode(inode);
+	}
+	brelse(bh);
+	return inode;
+
+failed:
+	iget_failed(inode);
+reterror:
+	brelse(bh);
+	return ERR_PTR(error);
+}
+
+static void vmufat_put_super(struct super_block *sb)
+{
+	sb->s_dev = 0;
+	kfree(sb->s_fs_info);
+}
+
+static void vmufat_count_freeblocks(struct super_block *sb,
+					struct kstatfs *kstatbuf)
+{
+	int i, free = 0;
+	struct memcard *vmudetails = sb->s_fs_info;
+
+	/* Look through the FAT */
+	for (i = 0; i < vmudetails->numblocks; i++) {
+		if (vmufat_get_fat(sb, i) == VMUFAT_UNALLOCATED) {
+			free++;
+		}
+	}
+	kstatbuf->f_bfree = free;
+	kstatbuf->f_bavail = free;
+	kstatbuf->f_blocks = vmudetails->sb_bnum + 1;
+}
+
+int vmufat_count_files(struct super_block *sb)
+{
+	int error = -1;
+	int files_found = 0;
+	struct buffer_head *bh = NULL;
+	struct memcard *vmudetails;
+	// get directory
+	vmudetails = sb->s_fs_info;
+	if (!vmudetails) {
+		return error;
+	}
+	for (int i = vmudetails->dir_bnum;
+		i > vmudetails->dir_bnum - vmudetails->dir_len; i--) {
+		brelse(bh);
+		bh = vmufat_sb_bread(sb, i);
+		if (!bh) {
+			error = -EIO;
+			return error;
+		}
+		for (int j = 0; j < VMU_DIR_ENTRIES_PER_BLOCK; j++) {
+			int record_offset = j * VMU_DIR_RECORD_LEN;
+			if (bh->b_data[record_offset] != 0) {
+				files_found++;
+			}
+		}
+	}
+	return files_found;
+}
+
+static int vmufat_count_file_space(struct super_block *sb)
+{
+	int error = -1;
+	int files_available = 0;
+	struct buffer_head *bh = NULL;
+	struct memcard *vmudetails;
+	// get directory
+	if (!sb) {
+		return error;
+	}
+	vmudetails = sb->s_fs_info;
+	if (!vmudetails) {
+		return error;
+	}
+	for (int i = vmudetails->dir_bnum;
+		i > vmudetails->numblocks; i--) {
+		brelse(bh);
+		bh = vmufat_sb_bread(sb, i);
+		if (!bh) {
+			error = -EIO;
+			return error;
+		}
+		for (int j = 0; j < VMU_DIR_ENTRIES_PER_BLOCK; j++) {
+			int record_offset = j * VMU_DIR_RECORD_LEN;
+			if (bh->b_data[record_offset] == 0) {
+				files_available++;
+			}
+		}
+	}
+	return files_available;
+}
+
+static int vmufat_statfs(struct dentry *dentry, struct kstatfs *kstatbuf)
+{
+	struct super_block *sb;
+	sb = dentry->d_sb;
+	vmufat_count_freeblocks(sb, kstatbuf);
+	kstatbuf->f_type = VMUFAT_SUPER_MAGIC;
+	kstatbuf->f_bsize = sb->s_blocksize;
+	kstatbuf->f_namelen = VMUFAT_NAMELEN;
+	kstatbuf->f_files = vmufat_count_files(sb);
+	kstatbuf->f_ffree = vmufat_count_file_space(sb);
+	if (kstatbuf->f_ffree > kstatbuf->f_bfree) {
+		kstatbuf->f_ffree = kstatbuf->f_bfree;
+	}
+	return 0;
+}
+
+/* Remove inode from memory */
+static void vmufat_evict_inode(struct inode *in)
+{
+	truncate_inode_pages(&in->i_data, 0);
+	invalidate_inode_buffers(in);
+	in->i_size = 0;
+	clear_inode(in);
+}
+
+/*
+ * There are no inodes on the medium - vmufat_write_inode
+ * updates the directory entry
+ */
+static int vmufat_write_inode(struct inode *in, struct writeback_control *wbc)
+{
+	struct buffer_head *bh = NULL;
+	unsigned long inode_num;
+	int i, j; 
+	int found = 0;
+	int pos, pos16;
+	struct super_block *sb;
+	struct memcard *vmudetails;
+	struct timespec64 current_time;
+	sb = in->i_sb;
+	vmudetails = sb->s_fs_info;
+
+	/* As most real world devices are flash we
+	 * won't update the superblock every time */
+	if (in->i_ino == vmudetails->sb_bnum)
+		return 0;
+	if (in->i_ino == VMUFAT_ZEROBLOCK)
+		inode_num = 0;
+	else
+		inode_num = in->i_ino;
+
+	/* update the directory and inode details */
+	/* Now search for the directory entry */
+	mutex_lock(&vmudetails->mutex);
+	for (i = vmudetails->dir_bnum;
+		i > vmudetails->dir_bnum - vmudetails->dir_len; i--) {
+		bh = vmufat_sb_bread(sb, i);
+		if (!bh) {
+			mutex_unlock(&vmudetails->mutex);
+			return -ENXIO;
+		}
+		for (j = 0; j < VMU_DIR_ENTRIES_PER_BLOCK; j++) {
+			pos = j * VMU_DIR_RECORD_LEN;
+			pos16 = j * VMU_DIR_RECORD_LEN16;
+			if (bh->b_data[pos] == 0) {
+				mutex_unlock(&vmudetails->mutex);
+				brelse(bh);
+				return -ENOENT;
+			}
+			if (le16_to_cpu(((u16 *)bh->b_data)
+				[pos16 + VMUFAT_FIRSTBLOCK_OFFSET16])
+				== inode_num) {
+				found = 1;
+				goto found;
+			}
+		}
+		brelse(bh);
+	}
+found:
+	if (found == 0) {
+		mutex_unlock(&vmudetails->mutex);
+		return -ENXIO;
+	}
+	/* BCD timestamp it */
+	ktime_get_coarse_real_ts64(&current_time);
+	in->i_mtime_sec = current_time.tv_sec;
+	vmufat_save_bcd(in, bh->b_data, pos);
+	mutex_unlock(&vmudetails->mutex);
+	mark_buffer_dirty(bh);
+	brelse(bh);
+	return 0;
+}
+
+static int check_sb_format(struct buffer_head *bh)
+{
+	return (((u32 *) bh->b_data)[0] == VMUFAT_SUPER_MAGIC &&
+		((u32 *) bh->b_data)[1] == VMUFAT_SUPER_MAGIC &&
+		((u32 *) bh->b_data)[2] == VMUFAT_SUPER_MAGIC &&
+		((u32 *) bh->b_data)[3] == VMUFAT_SUPER_MAGIC);
+}
+
+static void vmufat_populate_vmudata(struct memcard *vmudata,
+		struct buffer_head *bh, int test_sz)
+{
+	vmudata->sb_bnum = test_sz - 1;
+	vmudata->fat_bnum =
+		le16_to_cpu(((u16 *) bh->b_data)[VMU_LOCATION_FAT]);
+	vmudata->fat_len =
+		le16_to_cpu(((u16 *) bh->b_data)[VMU_LOCATION_FATLEN]);
+	vmudata->dir_bnum =
+		le16_to_cpu(((u16 *) bh->b_data)[VMU_LOCATION_DIR]);
+	vmudata->dir_len =
+		le16_to_cpu(((u16 *) bh->b_data)[VMU_LOCATION_DIRLEN]);
+	if (test_sz == VMU_PHYS_SZ) {
+		vmudata->numblocks =
+		le16_to_cpu(((u16 *) bh->b_data)[VMU_LOCATION_USRLEN]);
+		if (vmudata->numblocks == 0) {
+			vmudata->numblocks =
+				vmudata->dir_bnum;
+		}
+	} else {
+	/* return the true number of user available blocks - physical VMUs
+ 	 * return a neat 200 and ignore 40 blocks of usable space -
+ 	 * we get round that in a hardware neutral way */
+		vmudata->numblocks =
+			vmudata->dir_bnum;
+	}
+}
+
+static int vmufat_get_size(struct super_block *sb, struct buffer_head **bh)
+{
+	int i;
+	for (i = VMUFAT_MIN_BLK; i <= VMUFAT_MAX_BLK; i = i * 2) {
+		brelse(*bh);
+		*bh = vmufat_sb_bread(sb, i - 1);
+		if (*bh == NULL) {
+			return -EIO;
+		}
+		if (check_sb_format(*bh))
+			break;
+	}
+	if (i > VMUFAT_MAX_BLK) {
+		return -ENOENT;
+	}
+	return i;
+}
+
+static int vmufat_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct buffer_head *bh = NULL;
+	struct memcard *vmudata = NULL;
+	int test_sz;
+	struct inode *root_i;
+	int ret = 0;
+
+	vmudata = kzalloc(sizeof(struct memcard), GFP_KERNEL);
+	if (!vmudata) {
+		return -ENOMEM;
+	}
+	sb->s_fs_info = vmudata;
+	sb_set_blocksize(sb, VMU_BLK_SZ);
+	sb->s_blocksize_bits = ilog2(VMU_BLK_SZ);
+	sb->s_magic = VMUFAT_SUPER_MAGIC;
+	sb->s_op = &vmufat_super_operations;
+
+	/* 
+	 * Hardware VMUs are 256 blocks in size but
+	 * the specification allows for other sizes
+	 */
+	test_sz = vmufat_get_size(sb, &bh);
+	if (test_sz < VMUFAT_MIN_BLK) {
+		printk(KERN_ERR "VMUFAT: attempted to mount corrupted vmufat "
+			"or non-vmufat volume as vmufat.\n");
+		ret = test_sz;
+		goto freebh_out;
+	}
+
+	vmufat_populate_vmudata(vmudata, bh, test_sz);
+	mutex_init(&vmudata->mutex);
+
+	root_i = vmufat_get_inode(sb, vmudata->sb_bnum);
+	if (!root_i) {
+		printk(KERN_ERR "VMUFAT: get root inode failed\n");
+		ret = -ENOMEM;
+		goto freebh_out;
+	}
+	if (IS_ERR(root_i)) {
+		printk(KERN_ERR "VMUFAT: get root"
+			" inode failed - error 0x%lX\n",
+			PTR_ERR(root_i));
+		ret = PTR_ERR(root_i);
+		goto freebh_out;
+	}
+
+	sb->s_root = d_make_root(root_i);
+	if (!sb->s_root) {
+		ret = -EIO;
+		goto freebh_out;
+	}
+	else 
+		goto out;
+
+freebh_out:
+	brelse(bh);
+	kfree(vmudata);
+out:
+	return ret;
+}
+
+static void init_once(void *foo)
+{
+	struct vmufat_inode *vi = foo;
+	vi->nblcks = 0;
+	inode_init_once(&vi->vfs_inode);
+}
+
+static int init_inodecache(void)
+{
+	vmufat_blist_cachep = kmem_cache_create("vmufat_block_cache",
+		sizeof(struct vmufat_block), 0, SLAB_RECLAIM_ACCOUNT, 0);
+	if (!vmufat_blist_cachep) {
+		printk(KERN_CRIT
+			"VMUFAT: Could not create block list cache.\n");
+		return -ENOMEM;
+	}
+	vmufat_inode_cachep = kmem_cache_create("vmufat_inode_cache",
+		sizeof(struct vmufat_inode), 0, SLAB_RECLAIM_ACCOUNT,
+		init_once);
+	if (!vmufat_inode_cachep) {
+		printk(KERN_CRIT
+			"VMUFAT: Could not create inode cache.\n");
+		kmem_cache_destroy(vmufat_inode_cachep);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void destroy_inodecache(void)
+{
+	// ensure the caches are up to date before we try to destroy them
+	rcu_barrier();
+	kmem_cache_destroy(vmufat_inode_cachep);
+	rcu_barrier();
+	kmem_cache_destroy(vmufat_blist_cachep);
+}
+
+static const struct super_operations vmufat_super_operations = {
+	.alloc_inode =		vmufat_alloc_inode,
+	.destroy_inode =	vmufat_destroy_inode,
+	.write_inode =		vmufat_write_inode,
+	.evict_inode =		vmufat_evict_inode,
+	.put_super =		vmufat_put_super,
+	.statfs =		vmufat_statfs,
+};
+
+static int vmufat_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, vmufat_fill_super);
+}
+
+static const struct fs_context_operations vmufat_fs_context_ops = {
+	.get_tree	= vmufat_get_tree,
+};
+
+static int vmufat_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &vmufat_fs_context_ops;
+	return 0;
+}
+
+static struct file_system_type vmufat_fs_type = {
+	.owner =			THIS_MODULE,
+	.name = 			"vmufat",
+	.kill_sb = 			kill_block_super,
+	.fs_flags =			FS_REQUIRES_DEV,
+	.init_fs_context =		vmufat_init_fs_context,
+};
+
+static int __init init_vmufat_fs(void)
+{
+	int err;
+	err = init_inodecache();
+	if (err)
+		return err;
+	else
+		return register_filesystem(&vmufat_fs_type);
+}
+
+static void __exit exit_vmufat_fs(void)
+{
+	destroy_inodecache();
+	// ensure all caches removed before we disappear
+	rcu_barrier();
+	unregister_filesystem(&vmufat_fs_type);
+}
+
+module_init(init_vmufat_fs);
+module_exit(exit_vmufat_fs);
+
+MODULE_DESCRIPTION("Filesystem used in Sega Dreamcast VMU");
+MODULE_AUTHOR("Adrian McMenamin <adrianmcmenamin@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0

