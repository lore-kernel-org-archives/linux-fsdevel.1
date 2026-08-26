Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDE63242DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785014; cv=none; b=rrjvU41RwVmbP6Dz8qcDMdYlmGcrjcZMO9obM2dzOfX0Wdr99QdgHjLSZ0vz2/VD7wSTWDmO49Nniy0CK2OOSWFNHLuKbWP3pc77EsFRclJw4NWdBYc5rp08luR7pKb+4JNrU0wN8GloPduUVs7uORT8kUdGnKpaVphP8jvaQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785014; c=relaxed/simple;
	bh=z8nxWyZBGM2mWMHN3Gb3eNdOXLjX6i/8WNe3N3r6Jjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxCBD08Dh+nLPrPBXWqClYT1CGXI7DX6L0gJ/js+0SH6nIPQY1tZlxAIQ+t+A0e9qHuKsae2S1Tk7TnthpB+3WRyShTNbWzijrFMbyjSEVIAdyBFhS9UU6RiilnFhF/qIUgD/3vgomeCuktandVQ75AhBzlZGs8omkdIV2TYHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=PPHG+y4m; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="PPHG+y4m"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66ce4a63e17so1958628d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787785010; x=1788389810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06j1qeZXVtj7Nz/ZYPnBZzCHEmkktKQWmdPGkPaUsk8=;
        b=PPHG+y4mAS96zK5tpldD7SN5xt+KoQtyCMUl+r14OnXi7bkXweBWUA/0RgRYUJBSsZ
         QZilpfp36KkvCnQMU/R8SBZVejlJHurbIEBs8JsX2dYsXHs2UOXXe4JCk34FHPsYeLHJ
         7TGS/myKPklLNXqhStkcZvQZMJLvL5JU0iiBdpen4a7oMCkgEYLuYMxTGsxDTxcgckMo
         Xd5+FDgPkElZRDmWQQcFExAeB1N2L+aMJIZlC2sTaUazoaXCQ9cAK32f3XVzgbo/2GIQ
         FRMxeYyoySX5uxbcFFwswrKdjUChroIbdrtQLj/Fibsl82e32hxdBTsCL/0fCcR3QKiX
         9OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785010; x=1788389810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=06j1qeZXVtj7Nz/ZYPnBZzCHEmkktKQWmdPGkPaUsk8=;
        b=mNJTidLaEgCeB5LNJGYI5zaa0LjkJuQjgoE95wt7NeJp4+6NjHPSbYDWjPI2AMGVFl
         aFhGG0pHmlqiB/MoIRznqjFb4PPHUrP1zkqHkl42+SpS9F72rLtTF4N40ZggucRDjHvC
         aPDP1PnpU28+NSEdwKMYiP1TlkqOjlokYRt7gOMvyMlEtJexB6R0FosBACby7si1CoP+
         vgqloDjwJWslZicgnnVLRlYqKRVlgcWJrzZbhn+E/RfcWk2XqKC6jTJlkPBeUmIvOink
         WccIwHlTiOIYTsvfRUYDdH5NKgi3qtm1Ml4/7YDMG1fSQgR1ui4F/kuoKh6tz94smK5j
         xm4g==
X-Gm-Message-State: AFuF++kBNP8thEp/7gko1cX77lXH66YULWH5/171I9BeqRkpkjX0qskb
	hWul8nWAd9nGGxJLOnn500lZ5lZ0mgEfR1zzag4zH75lvcLj0zp7bFBzBsw73YRE3kE=
X-Gm-Gg: AR+sD12li8WNR75fF5+7jWaJKhij7VRd+kLB6/tOv85W9qak9ju3f+K3yMCJd7YH9pE
	KQ52x1NRJu+jOByiw/TidlT36JYILb67NUt9YGMueRbVIBnbLkObgB459MN6CrW5RrW0NSzV6o3
	aYDS6JBkHuzZ2eu/u0kIbG66Qma06RBZCN7E0ZMY1uBD94I1jmSdg0oJKnkNjMOnBtO3dB02bMq
	NhKBjjrstSHIwOc+j8vQiOTB3eXmJUp36R1nS73C6qFzaPmFlnHZ6SGLwjNN9jZylRctXw3w4Xa
	LuTkSGqkZbgRzV98z3sodIap0fqqoCOCpx8LSHduLOrZ9OyinbsJ9ZrZosmANrNjkbYm59wvsEa
	w2tFcgzTZzneFx1tHA0Wt6KRVbRXMdlqfFK3vi4xju2ieap1nvA/5rKUkf6rmhtury/u52eikAd
	WI0p1Ma+xT+JW7oS0bUqhSzrJqt/YxzzwrAa0tdEWxE7U4vcWaqNbkHnGjnA1eQFhooS2ZYfhui
	auOCYJgu+JR4h1ehGxA0i2ix74DX7GZQ2bnHdz85mVtA+7ZYXocf0qmwyC5QRYcScUhPib1C+sO
	xcxRCl1/pXXsMW7x+Q==
X-Received: by 2002:a53:e6c2:0:b0:66c:c661:3297 with SMTP id 956f58d0204a3-66d256acbf5mr2906860d50.8.1787785009769;
        Wed, 26 Aug 2026 15:56:49 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:49 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 5/7] hfsplus: move file related operations to file.c
Date: Wed, 26 Aug 2026 15:56:12 -0700
Message-ID: <20260826225614.486112-6-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826225614.486112-1-slava@dubeyko.com>
References: <20260826225614.486112-1-slava@dubeyko.com>
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

