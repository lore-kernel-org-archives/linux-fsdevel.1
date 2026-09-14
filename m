Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BB3B42F3
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429217; cv=none; b=pYk5WMxsyk33zgLTtRrn0uhw5f2z2CuJOK4umtZ1jnh/1bd/+8Eg4itihRbgPOQDF+xNTwCjmgLlImZqMPQY2sgIlWntrZqZNbosXUi2tWgYuuzB3moAAP7vrFLa0bIFWaQHlVEA2156I+VrcJWlr3zOSl0FdgBPB/5zUgxhfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429217; c=relaxed/simple;
	bh=z8nxWyZBGM2mWMHN3Gb3eNdOXLjX6i/8WNe3N3r6Jjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAQi1NaEIjPnNNLGqxY/me2b1gcwfZqJF8LL45xcva6YWdUFPzImclJvJ/sX2OdyvOgItEheimZsfk+tW6hwiV78NF5JPJpK0IYbNArwyryBi0g653vQh6GGbZ3baNpt+A9lmyXx5zxT0h/G3Nd73WhiYUZk4isBwfJlZ7vcFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Fmjwzhnq; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Fmjwzhnq"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43da99ddso24119077b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 16:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789429213; x=1790034013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06j1qeZXVtj7Nz/ZYPnBZzCHEmkktKQWmdPGkPaUsk8=;
        b=FmjwzhnqYQRblcZX5VpQN6xwDdjnywDtQqFzUr2YbKXsMwHyL7ods1wgZ/FqzxeM6U
         Q35KLQtS5pTn1cJvJdtoGdnniNkOX6R0sgv1uAYjLyBjfYcMs5kqD9Yd77amm2xxFoMt
         7tceEnKi1mDKfKRQDI5Z8uSFKgEfTGbbp8sc8VuJES68f02IZaYGMC4dw+zf2qNZxSHW
         IANaBSzszIDBlGxwEHy49u+CqTptvVoTR6j2TrZ5MCYR/aLP3eQUj52RSvOuiYyEod5Q
         pp1XzWz82eWLrK2Pqrgi4ixa5fmGY3V/KUffRc+XhbOKRd8h7ZF0bRF1GUROWi7/RLgu
         ng4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789429213; x=1790034013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=06j1qeZXVtj7Nz/ZYPnBZzCHEmkktKQWmdPGkPaUsk8=;
        b=r2l5aCZJlFQhqr+WdTCiPgMv7gq7suiEPrh+xaQbb052Zq9ZIbzWUGIFCxKSQC2IZJ
         I03B+Aeoj03Mxr7PX5u53TW6S/o1UbCx4l9wLMTLHZRIIZ5o1EWWml8GIcmMitKqvY+l
         Wiz6FEz1QKnkSQ/fXapi7J31+SBHt8XSeuHEBOGVORaCA4GShJZzi1v3pdKBW4+IJBhT
         Ky4VIMP36uyUmpEMb0nmJlylMnRfZ9cZK4TupPgZ0kAdaXBB1edbBqOTN5oZS948+ruF
         ov7cMnQkKiKsnj6e1jXD5PyCenF/YFmG42AUgA26E6JVK7Bm9QMKfaPnfaaa5PT4CRYH
         i4dA==
X-Gm-Message-State: AFuF++mCOnexZ9oJJbSAPVvhAlWQ9pKu6nRsQaO8qX1K92jEyhgHWrBv
	DUT1koEWOHr5CXzrq19W8AlBNU9/CVF+8mzFlPTe4SJSttdg+eqQ1bFkftBChW6M0dI=
X-Gm-Gg: AYBFou3BySHusTBPNwlXA4b5YtBCb9AyWSfAOFqhcIKzeW0jThC48G9EKpStROQgaJJ
	pY0622y1RoiUZFIp/UwtNBEmYOEFYRuuJesBPAhEP8BIYzvg//scMH4255sK5R8qgZhigyrkk8V
	VhUAcJuMugHCsADRK9RrZMJ7sKa7dUcl3lIOty/VWMd6n1QWo/6AtZoC4SrK8gF2ChUvtguuJPZ
	6vyp2dUfEvmnXr7z3Y0t+xfxgLD0PrV/KjPExDRAsW9ntrcD1RJ7l9vDthphvY8APzJHTG2cCOA
	OqM6m8gPoGzN2O0LXVvRznyoHb5SKaiFxsSUC6dPXXS2obnbn1QprehAt93KtHRfQn/YcuYI5gZ
	JT+1RhcPMAziXH6sOmxu6ftxlAodLzzK1uQ4Cmbo6UluRxo6JOv7enFiWcq0Scq694Ondo9yeX3
	kXGtvg17qE+EaHzxltKbVOfrDATWVXarOp61kVvErpnaUynGiHOkodNZbk4mzzLXGn9GbJHP3P4
	pzipHp6jwYzhxl2OeEHDXkXYH/l7EBjsl6CVNwRJeD3kzsiVi1+iWyOfdNtod+iqyDhJlgOnZjw
	VI46SMQc8x4YFwxlllvTTl7y0Ihn
X-Received: by 2002:a05:690e:4810:b0:671:47a8:e02a with SMTP id 956f58d0204a3-6714e0204demr1004358d50.45.1789429213548;
        Mon, 14 Sep 2026 16:40:13 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:df87:8743:655b:3824])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e3fa87sm5207804d50.14.2026.09.14.16.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:40:13 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v4 5/7] hfsplus: move file related operations to file.c
Date: Mon, 14 Sep 2026 16:39:39 -0700
Message-ID: <20260914233941.2966421-6-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914233941.2966421-1-slava@dubeyko.com>
References: <20260914233941.2966421-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces fs/hfsplus/file.c and moves
file related operations from fs/hfsplus/inode.c
into the new file.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/Makefile     |   6 +-
 fs/hfsplus/file.c       | 133 ++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h |   7 ++-
 fs/hfsplus/inode.c      | 122 ------------------------------------
 4 files changed, 141 insertions(+), 127 deletions(-)
 create mode 100644 fs/hfsplus/file.c

diff --git a/fs/hfsplus/Makefile b/fs/hfsplus/Makefile
index 2416dfdc3190..3ddea69a9c69 100644
--- a/fs/hfsplus/Makefile
+++ b/fs/hfsplus/Makefile
@@ -5,9 +5,9 @@
 
 obj-$(CONFIG_HFSPLUS_FS) += hfsplus.o
 
-hfsplus-objs := super.o options.o inode.o iomap.o ioctl.o extents.o catalog.o \
-		dir.o btree.o bnode.o brec.o bfind.o tables.o unicode.o \
-		wrapper.o bitmap.o part_tbl.o \
+hfsplus-objs := super.o options.o inode.o file.o iomap.o ioctl.o extents.o \
+		catalog.o dir.o btree.o bnode.o brec.o bfind.o tables.o \
+		unicode.o wrapper.o bitmap.o part_tbl.o \
 		attributes.o xattr.o xattr_user.o xattr_security.o xattr_trusted.o
 
 # KUnit tests
diff --git a/fs/hfsplus/file.c b/fs/hfsplus/file.c
new file mode 100644
index 000000000000..509046aad0c6
--- /dev/null
+++ b/fs/hfsplus/file.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * File operations: open/release/fsync and iomap-based read/write/seek
+ */
+
+#include <linux/fs.h>
+#include <linux/uio.h>
+#include <linux/mount.h>
+
+#include "hfsplus_fs.h"
+#include "hfsplus_raw.h"
+
+static int hfsplus_file_open(struct inode *inode, struct file *file)
+{
+	if (HFSPLUS_IS_RSRC(inode))
+		inode = HFSPLUS_I(inode)->rsrc_inode;
+	if (!(file->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
+		return -EOVERFLOW;
+	atomic_inc(&HFSPLUS_I(inode)->opencnt);
+	return 0;
+}
+
+static int hfsplus_file_release(struct inode *inode, struct file *file)
+{
+	struct super_block *sb = inode->i_sb;
+
+	if (HFSPLUS_IS_RSRC(inode))
+		inode = HFSPLUS_I(inode)->rsrc_inode;
+	if (atomic_dec_and_test(&HFSPLUS_I(inode)->opencnt)) {
+		inode_lock(inode);
+		hfsplus_file_truncate(inode);
+		if (inode->i_flags & S_DEAD) {
+			hfsplus_delete_cat(inode->i_ino,
+					   HFSPLUS_SB(sb)->hidden_dir, NULL);
+			hfsplus_delete_inode(inode);
+		}
+		inode_unlock(inode);
+	}
+	return 0;
+}
+
+int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
+		       int datasync)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_vh *vhdr = sbi->s_vhdr;
+	int error = 0, error2;
+
+	hfs_dbg("inode->i_ino %llu, start %llu, end %llu\n",
+		inode->i_ino, start, end);
+
+	error = file_write_and_wait_range(file, start, end);
+	if (error)
+		return error;
+	inode_lock(inode);
+
+	/*
+	 * Sync inode metadata into the catalog and extent trees.
+	 */
+	sync_inode_metadata(inode, 1);
+
+	/*
+	 * And explicitly write out the btrees.
+	 */
+	if (test_and_clear_bit(HFSPLUS_I_CAT_DIRTY,
+				&HFSPLUS_I(HFSPLUS_CAT_TREE_I(sb))->flags)) {
+		clear_bit(HFSPLUS_I_CAT_DIRTY, &hip->flags);
+		error = filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
+	}
+
+	if (test_and_clear_bit(HFSPLUS_I_EXT_DIRTY,
+				&HFSPLUS_I(HFSPLUS_EXT_TREE_I(sb))->flags)) {
+		clear_bit(HFSPLUS_I_EXT_DIRTY, &hip->flags);
+		error2 =
+			filemap_write_and_wait(sbi->ext_tree->inode->i_mapping);
+		if (!error)
+			error = error2;
+	}
+
+	if (sbi->attr_tree) {
+		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY,
+				&HFSPLUS_I(HFSPLUS_ATTR_TREE_I(sb))->flags)) {
+			clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags);
+			error2 =
+				filemap_write_and_wait(
+					    sbi->attr_tree->inode->i_mapping);
+			if (!error)
+				error = error2;
+		}
+	} else {
+		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags))
+			pr_err("sync non-existent attributes tree\n");
+	}
+
+	if (test_and_clear_bit(HFSPLUS_I_ALLOC_DIRTY,
+				&HFSPLUS_I(sbi->alloc_file)->flags)) {
+		clear_bit(HFSPLUS_I_ALLOC_DIRTY, &hip->flags);
+		error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
+		if (!error)
+			error = error2;
+	}
+
+	mutex_lock(&sbi->vh_mutex);
+	hfsplus_prepare_volume_header_for_commit(vhdr);
+	mutex_unlock(&sbi->vh_mutex);
+
+	error2 = hfsplus_commit_superblock(inode->i_sb);
+	if (!error)
+		error = error2;
+
+	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
+		blkdev_issue_flush(inode->i_sb->s_bdev);
+
+	inode_unlock(inode);
+
+	return error;
+}
+
+const struct file_operations hfsplus_file_operations = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= generic_file_read_iter,
+	.write_iter	= generic_file_write_iter,
+	.mmap_prepare	= generic_file_mmap_prepare,
+	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.fsync		= hfsplus_file_fsync,
+	.open		= hfsplus_file_open,
+	.release	= hfsplus_file_release,
+	.unlocked_ioctl = hfsplus_ioctl,
+};
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 0a0df0388e7b..190c7de704fd 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -446,6 +446,11 @@ int hfsplus_rename_cat(u32 cnid, struct inode *src_dir, const struct qstr *src_n
 extern const struct inode_operations hfsplus_dir_inode_operations;
 extern const struct file_operations hfsplus_dir_operations;
 
+/* file.c */
+extern const struct file_operations hfsplus_file_operations;
+int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
+		       int datasync);
+
 /* extents.c */
 int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
 			const hfsplus_btree_key *k2);
@@ -480,8 +485,6 @@ int hfsplus_cat_write_inode(struct inode *inode);
 int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 		    struct kstat *stat, u32 request_mask,
 		    unsigned int query_flags);
-int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
-		       int datasync);
 int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct file_kattr *fa);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 2ce6de574fa6..9d25e6224ee5 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -276,35 +276,6 @@ static int hfsplus_get_perms(struct inode *inode,
 	return -EIO;
 }
 
-static int hfsplus_file_open(struct inode *inode, struct file *file)
-{
-	if (HFSPLUS_IS_RSRC(inode))
-		inode = HFSPLUS_I(inode)->rsrc_inode;
-	if (!(file->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
-		return -EOVERFLOW;
-	atomic_inc(&HFSPLUS_I(inode)->opencnt);
-	return 0;
-}
-
-static int hfsplus_file_release(struct inode *inode, struct file *file)
-{
-	struct super_block *sb = inode->i_sb;
-
-	if (HFSPLUS_IS_RSRC(inode))
-		inode = HFSPLUS_I(inode)->rsrc_inode;
-	if (atomic_dec_and_test(&HFSPLUS_I(inode)->opencnt)) {
-		inode_lock(inode);
-		hfsplus_file_truncate(inode);
-		if (inode->i_flags & S_DEAD) {
-			hfsplus_delete_cat(inode->i_ino,
-					   HFSPLUS_SB(sb)->hidden_dir, NULL);
-			hfsplus_delete_inode(inode);
-		}
-		inode_unlock(inode);
-	}
-	return 0;
-}
-
 static int hfsplus_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
@@ -361,86 +332,6 @@ int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
-int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
-		       int datasync)
-{
-	struct inode *inode = file->f_mapping->host;
-	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	struct super_block *sb = inode->i_sb;
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
-	struct hfsplus_vh *vhdr = sbi->s_vhdr;
-	int error = 0, error2;
-
-	hfs_dbg("inode->i_ino %llu, start %llu, end %llu\n",
-		inode->i_ino, start, end);
-
-	error = file_write_and_wait_range(file, start, end);
-	if (error)
-		return error;
-	inode_lock(inode);
-
-	/*
-	 * Sync inode metadata into the catalog and extent trees.
-	 */
-	sync_inode_metadata(inode, 1);
-
-	/*
-	 * And explicitly write out the btrees.
-	 */
-	if (test_and_clear_bit(HFSPLUS_I_CAT_DIRTY,
-				&HFSPLUS_I(HFSPLUS_CAT_TREE_I(sb))->flags)) {
-		clear_bit(HFSPLUS_I_CAT_DIRTY, &hip->flags);
-		error = filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
-	}
-
-	if (test_and_clear_bit(HFSPLUS_I_EXT_DIRTY,
-				&HFSPLUS_I(HFSPLUS_EXT_TREE_I(sb))->flags)) {
-		clear_bit(HFSPLUS_I_EXT_DIRTY, &hip->flags);
-		error2 =
-			filemap_write_and_wait(sbi->ext_tree->inode->i_mapping);
-		if (!error)
-			error = error2;
-	}
-
-	if (sbi->attr_tree) {
-		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY,
-				&HFSPLUS_I(HFSPLUS_ATTR_TREE_I(sb))->flags)) {
-			clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags);
-			error2 =
-				filemap_write_and_wait(
-					    sbi->attr_tree->inode->i_mapping);
-			if (!error)
-				error = error2;
-		}
-	} else {
-		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags))
-			pr_err("sync non-existent attributes tree\n");
-	}
-
-	if (test_and_clear_bit(HFSPLUS_I_ALLOC_DIRTY,
-				&HFSPLUS_I(sbi->alloc_file)->flags)) {
-		clear_bit(HFSPLUS_I_ALLOC_DIRTY, &hip->flags);
-		error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
-		if (!error)
-			error = error2;
-	}
-
-	mutex_lock(&sbi->vh_mutex);
-	hfsplus_prepare_volume_header_for_commit(vhdr);
-	mutex_unlock(&sbi->vh_mutex);
-
-	error2 = hfsplus_commit_superblock(inode->i_sb);
-	if (!error)
-		error = error2;
-
-	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
-		blkdev_issue_flush(inode->i_sb->s_bdev);
-
-	inode_unlock(inode);
-
-	return error;
-}
-
 static const struct inode_operations hfsplus_file_inode_operations = {
 	.setattr	= hfsplus_setattr,
 	.getattr	= hfsplus_getattr,
@@ -462,19 +353,6 @@ static const struct inode_operations hfsplus_special_inode_operations = {
 	.listxattr	= hfsplus_listxattr,
 };
 
-static const struct file_operations hfsplus_file_operations = {
-	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
-	.mmap_prepare	= generic_file_mmap_prepare,
-	.splice_read	= filemap_splice_read,
-	.splice_write	= iter_file_splice_write,
-	.fsync		= hfsplus_file_fsync,
-	.open		= hfsplus_file_open,
-	.release	= hfsplus_file_release,
-	.unlocked_ioctl = hfsplus_ioctl,
-};
-
 struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 				umode_t mode)
 {
-- 
2.43.0

