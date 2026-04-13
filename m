Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83B395DA9
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114391; cv=none; b=tvWfpPyoxJyUM73hgY530fLE52H7PbPnLLxNRO4S+6DyuZlky8FxQkz7tqJRpDWl1ZE5EXyIIhyYvWWmhkqLzZeb77UEvpmEnFigCP6s5a7xUTs+s4yw4AF1Cj9YhFgjSvpOJ1AgFSUf4ZehE3dFX9EOCHeObHS/PDpUSogzB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114391; c=relaxed/simple;
	bh=wrV7Ca5qThAL415CiyY44+jpphMO33Ku/SaUki5fZYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxA+rGRzP8ncS3x47osv/PvtUtQgl/YaPUALCJFKIq1CJbNOVPo4n4Mt/fo0ZSMbhrBrLZ5ZSoOzYWndPOkGrb8HMwnJiOH0c9lq4w6dRa1C9K5JGfkXJRsZGJOeJur3Ze6lyp0rTeO1EbYC5/Wkh2dqJ38IdI5t8md92xl8Cb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so5844065e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114387; x=1776719187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/Zdrwtc1Pp3hc8TSWkY940GPVELN0WXsAyqaQmbSgU=;
        b=eoA06+o12pdSd/NhcUK8CsxMbCLWUMAwRyg1se0m7tYJB1UKepXgcYytTR+ZGPFtjd
         +x+kImVZB0iGX0rESxH2f62xQPDSYQYUKq8hB3aLVZR99MMoJoOQyRQSgy7S4BAI5MHq
         E9KQlhA90GuNAnIfgOuwHncdMq/b952SHLMHOCUvqCGs/6ZzTvpBSaeUHJj0c78oR4Sj
         VqRJvA1wV2XD1bbZ2HS9q/GML2sfdAkGsZlcLC/WvvhE1z32VQE0IkNtiNNoW1UdXx6E
         NVlIaMpnjAocn50M7+wbpwi06JGofof+tQzzLHp2Z9JcEH6Jrf7BGU+FMKKKdM5lolWa
         +UTQ==
X-Gm-Message-State: AOJu0YxBizKQBmI5zgcuNw0thuZTzQfFIRX4WEEw0rhtrCgWZD0CIqIo
	ip9arToF3ahGT7Q0/CZt7fQrQJOR9vgsO4hpGSh/PZ02/NuoNrsCKeKO7vDihH5KLvg=
X-Gm-Gg: AeBDieu8j2kb4CGmW0/Yta5aGmcW1xAqsT0HU799+CxlP2GdacW1K1+ikOFbTBAhSdO
	Po33k4RJC4dgafiq6G7JkznDCsFOJ1MwwqOIdVE21apWRppSGUbmuIb9v6p4O4in7cK0q/SW6Cy
	HS7Hk0N7LXMpL3oEJAlbu0MeTgPIu0yOPA9f+WaVu0ZQKWQbhq5HP5SrJGC1nWp8vVlUNBtiz2s
	qFepBCiXWPwR3lCqHoMKcnhfDqM1xuBs+mxe6/TWatyjuJ/1dj/obIqzJlhUAK8leAY5qycyUyS
	GzIwdwy3k+UW2d8wxu4AyuPq0QxYmFWeoAyvJg6CT1mQkUDLTAwSmNVuXrA3BwWJVbcSA6Rm1Iz
	cmXIFgbVvzC+hBH6z8r0MtAEkLlH+kjNwSoj9JQdulESSDyPvtOxBVK/64k6ERa9vsqEPtFeMVu
	I+hXT8DzuxflSiHfoSFkwQzlhD74FdkiJohhqtmjo/1uYqUWmHiIOAQud+NqeEDIMbE4XDo9hvT
	IUg
X-Received: by 2002:a05:600c:3149:b0:487:575:5e3 with SMTP id 5b1f17b1804b1-488d68c7001mr96385805e9.5.1776114386759;
        Mon, 13 Apr 2026 14:06:26 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:26 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger@dilger.ca,
	pfalcato@suse.de
Subject: [PATCH v2 07/11] ftrfs: add filename and directory entry operations
Date: Tue, 14 Apr 2026 01:05:48 +0200
Message-ID: <20260413230601.525400-8-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413230601.525400-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement VFS inode_operations for directories and write path:

- ftrfs_create(): allocate inode, write to disk, add dir entry
- ftrfs_mkdir(): create directory with . and .. entries
- ftrfs_unlink(): remove directory entry, decrement link count
- ftrfs_rmdir(): remove empty directory
- ftrfs_link(): create hard link
- ftrfs_write_inode(): VFS super_op, persist inode via sb_bread/
  mark_buffer_dirty with CRC32 update
- ftrfs_new_inode(): allocate and initialize a new VFS inode

ftrfs_mkdir() returns struct dentry * as required by kernel 7.0
inode_operations.mkdir API change.

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/namei.c | 428 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 428 insertions(+)
 create mode 100644 fs/ftrfs/namei.c

diff --git a/fs/ftrfs/namei.c b/fs/ftrfs/namei.c
new file mode 100644
index 000000000..a8c1f79eb
--- /dev/null
+++ b/fs/ftrfs/namei.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FTRFS — Filename / directory entry operations
+ * Author: Aurélien DESBRIERES <aurelien@hackers.camp>
+ *
+ * Implements: create, mkdir, unlink, rmdir, link, rename
+ */
+
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include "ftrfs.h"
+
+/* ------------------------------------------------------------------ */
+/* Helper: write a raw ftrfs_inode to disk                             */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_write_inode_raw(struct inode *inode)
+{
+	struct super_block      *sb  = inode->i_sb;
+	struct ftrfs_sb_info    *sbi = FTRFS_SB(sb);
+	struct ftrfs_inode_info *fi  = FTRFS_I(inode);
+	struct ftrfs_inode      *raw;
+	struct buffer_head      *bh;
+	unsigned long            inodes_per_block;
+	unsigned long            block, offset;
+
+	inodes_per_block = FTRFS_BLOCK_SIZE / sizeof(struct ftrfs_inode);
+	block  = le64_to_cpu(sbi->s_ftrfs_sb->s_inode_table_blk)
+		 + (inode->i_ino - 1) / inodes_per_block;
+	offset = (inode->i_ino - 1) % inodes_per_block;
+
+	bh = sb_bread(sb, block);
+	if (!bh)
+		return -EIO;
+
+	raw = (struct ftrfs_inode *)bh->b_data + offset;
+
+	raw->i_mode   = cpu_to_le16(inode->i_mode);
+	raw->i_uid    = cpu_to_le16(i_uid_read(inode));
+	raw->i_gid    = cpu_to_le16(i_gid_read(inode));
+	raw->i_nlink  = cpu_to_le16(inode->i_nlink);
+	raw->i_size   = cpu_to_le64(inode->i_size);
+	raw->i_blocks = cpu_to_le32(inode->i_blocks);
+	raw->i_atime  = cpu_to_le64(inode_get_atime_sec(inode) * NSEC_PER_SEC
+				     + inode_get_atime_nsec(inode));
+	raw->i_mtime  = cpu_to_le64(inode_get_mtime_sec(inode) * NSEC_PER_SEC
+				     + inode_get_mtime_nsec(inode));
+	raw->i_ctime  = cpu_to_le64(inode_get_ctime_sec(inode) * NSEC_PER_SEC
+				     + inode_get_ctime_nsec(inode));
+	raw->i_flags  = cpu_to_le32(fi->i_flags);
+
+	memcpy(raw->i_direct, fi->i_direct, sizeof(fi->i_direct));
+	raw->i_indirect  = fi->i_indirect;
+	raw->i_dindirect = fi->i_dindirect;
+
+	raw->i_crc32 = ftrfs_crc32(raw,
+				    offsetof(struct ftrfs_inode, i_crc32));
+
+	mark_buffer_dirty(bh);
+	brelse(bh);
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Helper: add a directory entry to a directory inode                  */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_add_dirent(struct inode *dir, const struct qstr *name,
+			    u64 ino, unsigned int file_type)
+{
+	struct super_block      *sb = dir->i_sb;
+	struct ftrfs_inode_info *fi = FTRFS_I(dir);
+	struct ftrfs_dir_entry  *de;
+	struct buffer_head      *bh;
+	unsigned int             offset;
+	u64                      block_no;
+	int                      i;
+
+	/* Look for space in existing direct blocks */
+	for (i = 0; i < FTRFS_DIRECT_BLOCKS; i++) {
+		block_no = le64_to_cpu(fi->i_direct[i]);
+		if (!block_no)
+			break;
+
+		bh = sb_bread(sb, block_no);
+		if (!bh)
+			return -EIO;
+
+		offset = 0;
+		while (offset + sizeof(*de) <= FTRFS_BLOCK_SIZE) {
+			de = (struct ftrfs_dir_entry *)(bh->b_data + offset);
+
+			/* Free slot: ino == 0 */
+			if (!de->d_ino) {
+				de->d_ino       = cpu_to_le64(ino);
+				de->d_name_len  = name->len;
+				de->d_file_type = file_type;
+				de->d_rec_len   = cpu_to_le16(
+					sizeof(struct ftrfs_dir_entry));
+				memcpy(de->d_name, name->name, name->len);
+				de->d_name[name->len] = '\0';
+				mark_buffer_dirty(bh);
+				brelse(bh);
+				inode_set_mtime_to_ts(dir,
+					current_time(dir));
+				mark_inode_dirty(dir);
+				return 0;
+			}
+			offset += le16_to_cpu(de->d_rec_len);
+			if (!de->d_rec_len)
+				break;
+		}
+		brelse(bh);
+	}
+
+	/* Need a new block */
+	if (i >= FTRFS_DIRECT_BLOCKS)
+		return -ENOSPC;
+
+	block_no = ftrfs_alloc_block(sb);
+	if (!block_no)
+		return -ENOSPC;
+
+	bh = sb_bread(sb, block_no);
+	if (!bh) {
+		ftrfs_free_block(sb, block_no);
+		return -EIO;
+	}
+
+	memset(bh->b_data, 0, FTRFS_BLOCK_SIZE);
+
+	de = (struct ftrfs_dir_entry *)bh->b_data;
+	de->d_ino       = cpu_to_le64(ino);
+	de->d_name_len  = name->len;
+	de->d_file_type = file_type;
+	de->d_rec_len   = cpu_to_le16(sizeof(struct ftrfs_dir_entry));
+	memcpy(de->d_name, name->name, name->len);
+	de->d_name[name->len] = '\0';
+
+	mark_buffer_dirty(bh);
+	brelse(bh);
+
+	fi->i_direct[i] = cpu_to_le64(block_no);
+	dir->i_size += FTRFS_BLOCK_SIZE;
+	dir->i_blocks++;
+	inode_set_mtime_to_ts(dir, current_time(dir));
+	mark_inode_dirty(dir);
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Helper: remove a directory entry from a directory                   */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_del_dirent(struct inode *dir, const struct qstr *name)
+{
+	struct super_block      *sb = dir->i_sb;
+	struct ftrfs_inode_info *fi = FTRFS_I(dir);
+	struct ftrfs_dir_entry  *de;
+	struct buffer_head      *bh;
+	unsigned int             offset;
+	u64                      block_no;
+	int                      i;
+
+	for (i = 0; i < FTRFS_DIRECT_BLOCKS; i++) {
+		block_no = le64_to_cpu(fi->i_direct[i]);
+		if (!block_no)
+			break;
+
+		bh = sb_bread(sb, block_no);
+		if (!bh)
+			return -EIO;
+
+		offset = 0;
+		while (offset + sizeof(*de) <= FTRFS_BLOCK_SIZE) {
+			de = (struct ftrfs_dir_entry *)(bh->b_data + offset);
+
+			if (de->d_ino &&
+			    de->d_name_len == name->len &&
+			    !memcmp(de->d_name, name->name, name->len)) {
+				/* Zero out the entry (mark as free) */
+				memset(de, 0, sizeof(*de));
+				mark_buffer_dirty(bh);
+				brelse(bh);
+				inode_set_mtime_to_ts(dir,
+					current_time(dir));
+				mark_inode_dirty(dir);
+				return 0;
+			}
+
+			if (!de->d_rec_len)
+				break;
+			offset += le16_to_cpu(de->d_rec_len);
+		}
+		brelse(bh);
+	}
+
+	return -ENOENT;
+}
+
+/* ------------------------------------------------------------------ */
+/* Helper: allocate and initialize a new VFS inode                     */
+/* ------------------------------------------------------------------ */
+
+struct inode *ftrfs_new_inode(struct inode *dir, umode_t mode)
+{
+	struct super_block   *sb = dir->i_sb;
+	struct inode         *inode;
+	struct ftrfs_inode_info *fi;
+	u64                   ino;
+
+	ino = ftrfs_alloc_inode_num(sb);
+	if (!ino)
+		return ERR_PTR(-ENOSPC);
+
+	inode = new_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+	inode->i_ino    = ino;
+	inode->i_blocks = 0;
+	inode->i_size   = 0;
+	inode_set_atime_to_ts(inode, current_time(inode));
+	inode_set_mtime_to_ts(inode, current_time(inode));
+	inode_set_ctime_to_ts(inode, current_time(inode));
+
+	fi = FTRFS_I(inode);
+	memset(fi->i_direct, 0, sizeof(fi->i_direct));
+	fi->i_indirect  = 0;
+	fi->i_dindirect = 0;
+	fi->i_flags     = 0;
+
+	if (S_ISDIR(mode)) {
+		inode->i_op  = &ftrfs_dir_inode_operations;
+		inode->i_fop = &ftrfs_dir_operations;
+		set_nlink(inode, 2);
+	} else {
+		inode->i_op  = &ftrfs_file_inode_operations;
+		inode->i_fop = &ftrfs_file_operations;
+		set_nlink(inode, 1);
+	}
+
+	insert_inode_hash(inode);
+	mark_inode_dirty(inode);
+	return ERR_CAST(inode);
+}
+
+/* ------------------------------------------------------------------ */
+/* create — create a regular file                                       */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_create(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
+{
+	struct inode *inode;
+	int           ret;
+
+	inode = ftrfs_new_inode(dir, mode | S_IFREG);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	ret = ftrfs_write_inode_raw(inode);
+	if (ret)
+		goto out_iput;
+
+	ret = ftrfs_add_dirent(dir, &dentry->d_name, inode->i_ino, 1 /* DT_REG */);
+	if (ret)
+		goto out_iput;
+
+	ret = ftrfs_write_inode_raw(dir);
+	if (ret)
+		goto out_iput;
+
+	d_instantiate(dentry, inode);
+	return 0;
+
+out_iput:
+	iput(inode);
+	return ret;
+}
+
+/* ------------------------------------------------------------------ */
+/* mkdir — create a directory                                          */
+/* ------------------------------------------------------------------ */
+
+static struct dentry *ftrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode;
+	int           ret;
+
+	inode_inc_link_count(dir);
+
+	inode = ftrfs_new_inode(dir, mode | S_IFDIR);
+	if (IS_ERR(inode)) {
+		inode_dec_link_count(dir);
+		return ERR_CAST(inode);
+	}
+
+	/* Add . and .. entries */
+	ret = ftrfs_add_dirent(inode, &(struct qstr)QSTR_INIT(".", 1),
+			       inode->i_ino, 4 /* DT_DIR */);
+	if (ret)
+		goto out_fail;
+
+	ret = ftrfs_add_dirent(inode, &(struct qstr)QSTR_INIT("..", 2),
+			       dir->i_ino, 4 /* DT_DIR */);
+	if (ret)
+		goto out_fail;
+
+	ret = ftrfs_write_inode_raw(inode);
+	if (ret)
+		goto out_fail;
+
+	ret = ftrfs_add_dirent(dir, &dentry->d_name, inode->i_ino,
+			       4 /* DT_DIR */);
+	if (ret)
+		goto out_fail;
+
+	ret = ftrfs_write_inode_raw(dir);
+	if (ret)
+		goto out_fail;
+
+	d_instantiate(dentry, inode);
+	return NULL;
+
+out_fail:
+	inode_dec_link_count(inode);
+	inode_dec_link_count(inode);
+	iput(inode);
+	inode_dec_link_count(dir);
+	return ERR_PTR(ret);
+}
+
+/* ------------------------------------------------------------------ */
+/* unlink — remove a file                                              */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	int           ret;
+
+	ret = ftrfs_del_dirent(dir, &dentry->d_name);
+	if (ret)
+		return ret;
+
+	inode_set_ctime_to_ts(inode, current_time(inode));
+	inode_dec_link_count(inode);
+	ftrfs_write_inode_raw(dir);
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* rmdir — remove an empty directory                                   */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	int           ret;
+
+	if (inode->i_nlink > 2)
+		return -ENOTEMPTY;
+
+	ret = ftrfs_del_dirent(dir, &dentry->d_name);
+	if (ret)
+		return ret;
+
+	inode_dec_link_count(inode);
+	inode_dec_link_count(inode);
+	inode_dec_link_count(dir);
+	ftrfs_write_inode_raw(dir);
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* link — create a hard link                                           */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_link(struct dentry *old_dentry, struct inode *dir,
+		      struct dentry *dentry)
+{
+	struct inode *inode = d_inode(old_dentry);
+	int           ret;
+
+	inode_set_ctime_to_ts(inode, current_time(inode));
+	inode_inc_link_count(inode);
+
+	ret = ftrfs_add_dirent(dir, &dentry->d_name, inode->i_ino, 1);
+	if (ret) {
+		inode_dec_link_count(inode);
+		return ret;
+	}
+
+	ftrfs_write_inode_raw(inode);
+	ftrfs_write_inode_raw(dir);
+	d_instantiate(dentry, inode);
+	ihold(inode);
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* write_inode — VFS super_op: persist inode to disk                  */
+/* ------------------------------------------------------------------ */
+
+int ftrfs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	return ftrfs_write_inode_raw(inode);
+}
+
+/* ------------------------------------------------------------------ */
+/* dir inode_operations — exported                                     */
+/* ------------------------------------------------------------------ */
+
+const struct inode_operations ftrfs_dir_inode_operations = {
+	.lookup  = ftrfs_lookup,
+	.create  = ftrfs_create,
+	.mkdir   = ftrfs_mkdir,
+	.unlink  = ftrfs_unlink,
+	.rmdir   = ftrfs_rmdir,
+	.link    = ftrfs_link,
+};
-- 
2.52.0

