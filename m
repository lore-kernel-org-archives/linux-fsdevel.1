Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DD349CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756313; cv=none; b=FCkt/4RjpZm5QiwJkOEF4frsm4qPw92yN2Ie9q4BELuUMPRv9pwavyuBS6xZv6245cylNlDW2MgkDGQQZV0Bo+5W4FYxgjrGmVzgvMFyOG9ZHt+L7hTuTroKQDRXTDBde+c6AMJTdf478Jm0wbiLzO6p5f3CGKI7DTmDKCb8T2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756313; c=relaxed/simple;
	bh=edLRMMRXPTp55VXUU5cmtMYb7TlXbyo67S9tnqJ2GN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2l8O/D3ovGCdRmI1/vgVLQvqwNYk35I08CaKKovQw2KcznPRgNVCxKCGH/A12Purz2PZ8Artr6B6kgjO8XlM19Llg8rXZm5POll51mEcQoSg8Ck2GlPCfrQqSylnmj9DbrRQYXK2UeFYTSAddcNCXV1QJorYrRcB84b1H+FyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=rA11NAQC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="rA11NAQC"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e69a2db34so76457b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784756310; x=1785361110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6X+z05aaZgK9aavMSBBbq1Ec833hpw6grvZijXoQPc8=;
        b=rA11NAQCCpSKSroK4m80A8MxyDhCau2cJbrK5VjGl9Dcq8Dr1sooMbjMd9V1BT3luX
         Etig6J3gRiKeiwZSSpI9ks4t6Dp0SjwYqpMiZ/ldf6mXIXrKL5Gn7yYFBVgk/DlyTcfX
         wsFf8AgrxhAGj5TVbPQZGIwrhW5lGKz8AaXffottXL8+jUctGVKKjrjB8tq5e+5QJxM/
         3wZG7pGHmkKF0sEoNuTuY8uB6G3t1x7uWYnZgg1VTtFydrbGjn6woG6NCZpsg2RKrzCQ
         3m8+d1wr9o7uPirrshOgWJVtG0+W2xkR2XL9sgmsp6QHxSGaDByFJFr+8HnRFneeUieU
         Cvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756310; x=1785361110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6X+z05aaZgK9aavMSBBbq1Ec833hpw6grvZijXoQPc8=;
        b=jEztr/kKY6wKML7lWjkYDYlF+qxwAx8kHXV2krBNmdmKzj0kbsky4Qoz35oHnfL64R
         t9vHBatdLDmjdpdDWxiEGKj4bUT/Xbb7BnE/7RUvEZbOgCfQ7BiKwP6XvqhXV7x1Qtoy
         bMH4yesyOVrxmlvCfQNrEdqy2+fnpSqJuxJs+/2Gif0QPlQ1sbp5sP0QahHgvi76C/An
         98e8Gh5qc2MT2kut8CRpQEi+FXfpI87aXhq4Y7BQdfk8r2fkeSVXTMMAovjg0cXxaSXI
         vy9y2eRkphY4NJOFQiYgDh1DKbtyPe2NBp/UMuOGPhddI6zd35c2GLW3n6GZO37Kr4ig
         nQMA==
X-Gm-Message-State: AOJu0YzcutYLiv6UZSaJNGbnkPD+lEto5NiXhdPz1Abie5534xyPqA5a
	VLzAip8klqQer01FNdhQtMmx2vrto8GoUgTc1OsjqpnLnJFbPbEzFrUyRTkDayHVitc=
X-Gm-Gg: AR+sD10s/AlJbo1SE263N/e7RzhkRR9wIdcvh6TuIaKwF47VueB2joetPAu/Q5Q/3vF
	yZ9hF2x5Dktuu1FFgazuTu7bT25TyoB7aJhehSf8f0SKtqnNJG9aQ78iU7WTxhk/klhrKeg0DJM
	UTcHuNDjQFZxuwcZKzaktXoArGNROtXy2eynZppaZ2gcHkFa/iwNQQVyxDc8I77vmtwpK4nH1PV
	1YycVLikHc3coVBoHU3wtJsIocJ+W6869y6p53f30r2nqvr/hzT+gRTgeUoTRFpvMyNMtRF2b8q
	BLpLdGyMc6496Tm4pLgLJ+yP1RKHvSadwzrw8UwIOHATZ3kptQ1Rx09lVEnUxMbrpyMcl4jM0qE
	2mRQ7ObMgEvwrJhgwnGBsKaQWqYq6f31yxYp9MWlptdXZPE2ekY9oyo6dDZAp+or9bKDX0zhOFk
	2yKRy6PXzY1JyUFZeAAX6TMrWquXxmr/AVnP5/MbEDd9OwfOT/lA+uUrZKFiVZxSEeAjNTjoKQp
	vVx0tlY/0Ycn48RigXL2vDQ2Pknau5yzTw=
X-Received: by 2002:a05:690c:ed0:b0:80f:9998:e614 with SMTP id 00721157ae682-81f4c2151dfmr1146977b3.28.1784756310518;
        Wed, 22 Jul 2026 14:38:30 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c7706dsm20034827b3.21.2026.07.22.14.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:38:29 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 5/6] hfsplus: add iomap-based file_operations
Date: Wed, 22 Jul 2026 14:37:57 -0700
Message-ID: <20260722213759.1360225-6-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722213759.1360225-1-slava@dubeyko.com>
References: <20260722213759.1360225-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds fs/hfsplus/file.c with the goal of
moving the file related operations from fs/hfsplus/inode.c.
The hfsplus_file_open() and hfsplus_file_release() have
been moved without any modifications. The hfsplus_file_fsync()
no longer takes inode_lock() itself, because taking inode_lock()
here would deadlock against callers that invoke fsync while
already holding it (swapon()).

The hfsplus_file_operations have been reworked for
supporting iomap-based operations.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/Makefile     |   6 +-
 fs/hfsplus/file.c       | 309 ++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h |   7 +-
 fs/hfsplus/inode.c      | 122 ----------------
 4 files changed, 317 insertions(+), 127 deletions(-)
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
index 000000000000..8c92e145295c
--- /dev/null
+++ b/fs/hfsplus/file.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/hfsplus/file.c
+ *
+ * File operations: open/release/fsync and iomap-based read/write/seek
+ */
+
+#include <linux/fs.h>
+#include <linux/uio.h>
+#include <linux/mount.h>
+#include <linux/iomap.h>
+
+#include "hfsplus_fs.h"
+#include "hfsplus_raw.h"
+#include "iomap.h"
+
+static int hfsplus_file_open(struct inode *inode, struct file *file)
+{
+	if (HFSPLUS_IS_RSRC(inode))
+		inode = HFSPLUS_I(inode)->rsrc_inode;
+	if (!(file->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
+		return -EOVERFLOW;
+	atomic_inc(&HFSPLUS_I(inode)->opencnt);
+	file->f_mode |= FMODE_CAN_ODIRECT;
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
+	return error;
+}
+
+/*
+ * hfsplus_fallback_buffered_write() - fall back to buffered I/O for the
+ * tail of a write that iomap_dio_rw() could not perform directly
+ * (unaligned tail, or no blocks could be mapped without allocation
+ * outside the direct path).
+ */
+static ssize_t hfsplus_fallback_buffered_write(struct kiocb *iocb,
+						struct iov_iter *from)
+{
+	loff_t offset = iocb->ki_pos, end;
+	ssize_t written;
+	int ret;
+
+	iocb->ki_flags &= ~IOCB_DIRECT;
+
+	written = iomap_file_buffered_write(iocb, from,
+					    &hfsplus_write_iomap_ops,
+					    NULL, NULL);
+	if (written < 0)
+		return written;
+
+	end = iocb->ki_pos + written - 1;
+	ret = filemap_write_and_wait_range(iocb->ki_filp->f_mapping,
+					   offset, end);
+	if (ret)
+		return -EIO;
+
+	invalidate_mapping_pages(iocb->ki_filp->f_mapping,
+				 offset >> PAGE_SHIFT,
+				 end >> PAGE_SHIFT);
+
+	return written;
+}
+
+static ssize_t hfsplus_dio_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
+{
+	ssize_t ret;
+
+	ret = iomap_dio_rw(iocb, from,
+			   &hfsplus_write_iomap_ops,
+			   &hfsplus_write_dio_ops,
+			   0, NULL, 0);
+	if (ret == -ENOTBLK)
+		ret = 0;
+	else if (ret < 0)
+		return ret;
+
+	if (iov_iter_count(from)) {
+		ssize_t written;
+
+		written = hfsplus_fallback_buffered_write(iocb, from);
+		if (written < 0)
+			return written;
+		ret += written;
+	}
+
+	return ret;
+}
+
+static ssize_t hfsplus_file_write_iter(struct kiocb *iocb,
+					struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	loff_t total_capacity;
+	ssize_t ret;
+	int err;
+
+	inode_lock(inode);
+
+	ret = generic_write_checks(iocb, iter);
+	if (ret <= 0)
+		goto unlock;
+
+	total_capacity = (loff_t)sbi->total_blocks << sbi->alloc_blksz_shift;
+	if (iocb->ki_pos >= total_capacity) {
+		ret = -EFBIG;
+		goto unlock;
+	}
+
+	err = file_modified(file);
+	if (err) {
+		ret = err;
+		goto unlock;
+	}
+
+	if (iocb->ki_pos > i_size_read(inode)) {
+		loff_t old_size = i_size_read(inode);
+		loff_t new_size = iocb->ki_pos;
+
+		if (iocb->ki_flags & IOCB_DIRECT) {
+			new_size = max_t(loff_t, new_size,
+					  HFSPLUS_I(inode)->phys_size);
+		}
+
+		i_size_write(inode, new_size);
+		err = hfsplus_iomap_cont_expand(inode, iocb->ki_pos);
+		if (err) {
+			i_size_write(inode, old_size);
+			ret = err;
+			goto unlock;
+		}
+		mark_inode_dirty(inode);
+	} else if ((iocb->ki_flags & IOCB_DIRECT) &&
+		   HFSPLUS_I(inode)->phys_size > i_size_read(inode)) {
+		i_size_write(inode, HFSPLUS_I(inode)->phys_size);
+		mark_inode_dirty(inode);
+	}
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = hfsplus_dio_write_iter(iocb, iter);
+	else {
+		ret = iomap_file_buffered_write(iocb, iter,
+						&hfsplus_write_iomap_ops,
+						NULL, NULL);
+	}
+
+unlock:
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+
+	return ret;
+}
+
+static ssize_t hfsplus_file_read_iter(struct kiocb *iocb,
+					struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	inode_lock_shared(inode);
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		file_accessed(iocb->ki_filp);
+		ret = iomap_dio_rw(iocb, iter,
+				   &hfsplus_iomap_ops,
+				   NULL, 0, NULL, 0);
+	} else
+		ret = generic_file_read_iter(iocb, iter);
+
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+static loff_t hfsplus_file_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+
+	switch (whence) {
+	case SEEK_HOLE:
+		inode_lock_shared(inode);
+		offset = iomap_seek_hole(inode, offset, &hfsplus_iomap_ops);
+		inode_unlock_shared(inode);
+		break;
+	case SEEK_DATA:
+		inode_lock_shared(inode);
+		offset = iomap_seek_data(inode, offset, &hfsplus_iomap_ops);
+		inode_unlock_shared(inode);
+		break;
+	default:
+		return generic_file_llseek(file, offset, whence);
+	}
+
+	if (offset < 0)
+		return offset;
+
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}
+
+const struct file_operations hfsplus_file_operations = {
+	.llseek		= hfsplus_file_llseek,
+	.read_iter	= hfsplus_file_read_iter,
+	.write_iter	= hfsplus_file_write_iter,
+	.mmap_prepare	= generic_file_mmap_prepare,
+	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.fsync		= hfsplus_file_fsync,
+	.open		= hfsplus_file_open,
+	.release	= hfsplus_file_release,
+	.unlocked_ioctl = hfsplus_ioctl,
+};
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 5c8ec0076bb4..ea0e35119d73 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -480,12 +480,15 @@ int hfsplus_cat_write_inode(struct inode *inode);
 int hfsplus_getattr(struct mnt_idmap *idmap, const struct path *path,
 		    struct kstat *stat, u32 request_mask,
 		    unsigned int query_flags);
-int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
-		       int datasync);
 int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct file_kattr *fa);
 
+/* file.c */
+extern const struct file_operations hfsplus_file_operations;
+int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
+		       int datasync);
+
 /* ioctl.c */
 long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 
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

