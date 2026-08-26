Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B748A8A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780527; cv=none; b=Xs4jMCxaRBlvCZc7fMRWPNtcKau8pbbI1aOVGkbOKOqWwnOHrSuQvj8XaS3jnWI82tXyfpLM8siaEMjQ6Itz0n9mE1RYRvH7VhMnx6VT0BsVmTjOGpl0cUb65XezdII+zjzv1TKxx0QJC7+dw179bmzSvJHT3mlZA0nF8XSuNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780527; c=relaxed/simple;
	bh=ZBTCYxg/g/1YoU4wXmnf1kFuJEma80I5r1HtT2UZx1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9j+ZFCPo1jlK8nZg6fjNfk1dXzrDksXXiEIXxBfbMlFWK7fhl+8mNBCeKWx4oXW4BaK731erJ1PYZ06Qsc+xkoZw2SGOfGtNZWp7iK/saBJPEUzh+roPC7mUsdedR2yTFggpGck3zu5zcABOXcDmr7XzuqpGiV1a3bhClXQxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWRYp3/r; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWRYp3/r"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3968e063f84so696708a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787780525; x=1788385325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg73ZkRLNpj1F3eKZcoeBv1OHmS+aB70wYPXjLHVKFg=;
        b=dWRYp3/rCgHPGIAN4VpVLLXFkrIGOt7D9rswWAEMkSQ33wx7FrgDOW7cvXffPCLAt+
         nusN3wva+FS/Odln2skapHEUEX5h/zVBeJrq6VzBUD1MXO4cVDQN5h/OsguM0MEIn30h
         gZNK8oTgsyaB15wrGhB/JgSgQCMZMqf29xt3rqzwtmqoWeia/SiOF66H72InGuVhaW9u
         Yn+r/r8EQ7G9QLeyiRml+nSgxLK6r/JvqmEPjVEaGU48luUdIzUuypYTb85PR80MEoIh
         dkAjYPJuV4tzw166rdycVvy+Fp11+nOmSs1ToDA/OIg2DBmBkpsxej9buPMP9kx3fi+I
         +Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780525; x=1788385325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gg73ZkRLNpj1F3eKZcoeBv1OHmS+aB70wYPXjLHVKFg=;
        b=pvBbyZ/4urTuS3zyS5Fr4p0JkrlfmY9pz1OrzP4xkJXr+kq6YCOxs/hOHwX6LLdpQk
         BLwzfJ/F1EgEmvhHInEVE4KHyNjFd5h/kERYs8xgxlfX7RDELJ4Wzg5hJYLV5CW/IJum
         dAA31tpTmo+Z0ud9+YSpOyD6ekxvSyEhFtPGoa6oajcXUDwpnzCB3YphSrmvqEvoswd2
         GWTUM1HCY8FL772EzToRuaOnktXNpZPEF3Mhc6lQHEabd1NkbisgqgYDwlteSr068lEE
         4esJNSEnwIeLc1PMZmLQ51nzt1ZC28yEWcZy6m/GbgRuu70fAFKU1CxkObLofRsyCmD/
         0uPQ==
X-Gm-Message-State: AFuF++nfFRAu08VMct2pnulO0nR86AcB3DKX8snaej1WvZWdzxEe0HhC
	tge90wLrOyuDiJTjhHrh7Y09U8QtGmzTMDQufKxVwAVj3RJVdMWab7XODZl+IovZ
X-Gm-Gg: AR+sD13YnkU/T8Aqocf6fXlyOc022nWtOhATgQKwDVJeYtWPAG7AcTD9eIH/FAmrsMd
	2YezwCKW3zkd4B3FxY/aegKimas1PA5/LOTZI+J6QPsy4qf7yuiBGouRKm7vfb2n4RuuAE+fCDn
	RpmbsqJVKJtorYGJXqAP6uuPdLeXtrwiUk8B274LKoF6ytY1/XDIH8KG+W/DsbYg8Y0GsZV4T+4
	Nc9lEssogRPbeYvLOhbkB3zizuXZwJxy7Bm1Tb5DHqyq7DcEnSdqwDZAJEccFHNZXdu6U762tCH
	1Qa7AIhBqTCy3AeCIU1fSJbJAJjDge9prEwX9v1ZeVU2S/EERjMlNSpk/JpN+lb00a2cpWhqHoM
	Pusqmf8fCHxv1DXL4IwPCFSCNaSG5ctsHij5AD3X1XvWtJtu7T8TMX4/tt8NBYQ5XxqslFsBvL1
	DJYX3uZRHfDKR4S5OMimpQL2gOxJqfMSutPEk=
X-Received: by 2002:a17:90b:3a05:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-3966d44312fmr21131048a91.12.1787780525021;
        Wed, 26 Aug 2026 14:42:05 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396689f1419sm5628673a91.9.2026.08.26.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:42:04 -0700 (PDT)
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
Subject: [PATCH v4 3/3] minix: finish wiring in iomap functions
Date: Wed, 26 Aug 2026 14:41:57 -0700
Message-ID: <668bd5f317e3bf8eaee0254ca79e595395b6e332.1787770110.git.jbingham@gmail.com>
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

Wire in the new iomap functionality in one pass. Per Christoph Hellwig's
feedback, there are no longer direct I/O operations. Without that, only
write_iter in minix_file_operations needs a custom function. That and
exporting minix_setattr for minix_symlink_inode_operations are the only
changes in file.c.

There are two main additions in inode.c. First, minix_writeback_range
and minix_writeback_ops are newly added. Secondly, the old
minix_writepages and minix_read_folio functions were renamed to
minix_block_writepages and minix_block_read_folio respectively while new
functions with those names were created that use iomap. Because
directory operations need to stay using buffer heads, a new set of
address space operations just for directory operations was created while
other file types use the new iomap based address space operations. The
minix_symlink_inode_operations also have setattr set to minix_setattr
now. Support for bmap has been dropped entirely, per Darrick J. Wong's
suggestion.

In itree_common.c, truncate() is updated to use different functions
depending on whether the inode being truncated is a directory or not.
This is because of the changes above where directory operations still
use buffer heads and have their own address operations.

This patch also updates minix_symlink to use the new iomap_symlink_write
function, which brings symlinks under iomap and removes the need to
bypass it with a private custom function. This was suggested by Darrick
J. Wong in an earlier version of this patch series.


Suggested-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/file.c         | 30 ++++++++++++++-
 fs/minix/inode.c        | 85 +++++++++++++++++++++++++++++++++++------
 fs/minix/itree_common.c | 10 ++++-
 fs/minix/minix.h        |  2 +
 fs/minix/namei.c        |  7 +++-
 5 files changed, 118 insertions(+), 16 deletions(-)

diff --git a/fs/minix/file.c b/fs/minix/file.c
index 02aabbdb5dea..6765f571bd3f 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -10,6 +10,32 @@
 #include <linux/buffer_head.h>
 #include "minix.h"
 
+static ssize_t minix_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	ssize_t ret;
+	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto unlock;
+
+	ret = file_modified(iocb->ki_filp);
+	if (ret)
+		goto unlock;
+
+	ret = iomap_file_buffered_write(iocb, from, ops,
+			NULL, NULL);
+
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+
+unlock:
+	inode_unlock(inode);
+	return ret;
+}
+
 /*
  * We have mostly NULLs here: the current defaults are OK for
  * the minix filesystem.
@@ -17,13 +43,13 @@
 const struct file_operations minix_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
+	.write_iter	= minix_file_write_iter,
 	.mmap_prepare	= generic_file_mmap_prepare,
 	.fsync		= simple_fsync,
 	.splice_read	= filemap_splice_read,
 };
 
-static int minix_setattr(struct mnt_idmap *idmap,
+int minix_setattr(struct mnt_idmap *idmap,
 			 struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index daf83e4ff25c..2bf5ea92360a 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -439,6 +439,31 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static ssize_t minix_writeback_range(struct iomap_writepage_ctx *wpc,
+	struct folio *folio, u64 pos, unsigned int len, u64 end_pos)
+{
+	int error;
+
+	if (pos < wpc->iomap.offset ||
+			pos >= wpc->iomap.offset + wpc->iomap.length) {
+		if (INODE_VERSION(wpc->inode) == MINIX_V1)
+			error = V1_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
+				&wpc->iomap, NULL);
+		else
+			error = V2_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
+				&wpc->iomap, NULL);
+		if (error)
+			return error;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, pos, end_pos, len);
+}
+
+static const struct iomap_writeback_ops minix_writeback_ops = {
+	.writeback_range = minix_writeback_range,
+	.writeback_submit = iomap_ioend_writeback_submit,
+};
+
 static int minix_get_block(struct inode *inode, sector_t block,
 		    struct buffer_head *bh_result, int create)
 {
@@ -448,17 +473,45 @@ static int minix_get_block(struct inode *inode, sector_t block,
 		return V2_minix_get_block(inode, block, bh_result, create);
 }
 
-static int minix_writepages(struct address_space *mapping,
+/* The old minix_writepages, preserved for directory operations. */
+static int minix_block_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	return mpage_writepages(mapping, wbc, minix_get_block);
 }
 
+static int minix_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = {
+		.inode = mapping->host,
+		.wbc = wbc,
+		.ops = &minix_writeback_ops,
+	};
+	return iomap_writepages(&wpc);
+}
+
 static int minix_read_folio(struct file *file, struct folio *folio)
+{
+	const struct iomap_ops *ops = minix_iomap_ops_ver(folio->mapping->host);
+
+	iomap_bio_read_folio(folio, ops);
+	return 0;
+}
+
+/* The old minix_read_folio, preserved for directory operations. */
+static int minix_block_read_folio(struct file *file, struct folio *folio)
 {
 	return block_read_full_folio(folio, minix_get_block);
 }
 
+static void minix_readahead(struct readahead_control *rac)
+{
+	const struct iomap_ops *ops = minix_iomap_ops_ver(rac->mapping->host);
+
+	iomap_bio_readahead(rac, ops);
+}
+
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
 	return __block_write_begin(folio, pos, len, minix_get_block);
@@ -488,26 +541,35 @@ static int minix_write_begin(const struct kiocb *iocb,
 	return ret;
 }
 
-static sector_t minix_bmap(struct address_space *mapping, sector_t block)
-{
-	return generic_block_bmap(mapping,block,minix_get_block);
-}
-
 static const struct address_space_operations minix_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio	= iomap_dirty_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 	.read_folio = minix_read_folio,
+	.readahead = minix_readahead,
 	.writepages = minix_writepages,
+	.migrate_folio = filemap_migrate_folio,
+	.is_partially_uptodate = iomap_is_partially_uptodate,
+	.release_folio = iomap_release_folio,
+	.error_remove_folio = generic_error_remove_folio,
+};
+
+/* A special aops for directories that keeps using the buffer head chunks, at
+ * least for the time being.
+ */
+static const struct address_space_operations minix_dir_aops = {
+	.dirty_folio = block_dirty_folio,
+	.invalidate_folio = block_invalidate_folio,
+	.read_folio = minix_block_read_folio,
 	.write_begin = minix_write_begin,
 	.write_end = generic_write_end,
 	.migrate_folio = buffer_migrate_folio,
-	.bmap = minix_bmap,
-	.direct_IO = noop_direct_IO
+	.writepages = minix_block_writepages,
 };
 
 static const struct inode_operations minix_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.getattr	= minix_getattr,
+	.setattr	= minix_setattr,
 };
 
 void minix_set_inode(struct inode *inode, dev_t rdev)
@@ -519,7 +581,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &minix_dir_inode_operations;
 		inode->i_fop = &minix_dir_operations;
-		inode->i_mapping->a_ops = &minix_aops;
+		inode->i_mapping->a_ops = &minix_dir_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
 		inode->i_op = &minix_symlink_inode_operations;
 		inode_nohighmem(inode);
@@ -786,4 +848,3 @@ module_init(init_minix_fs)
 module_exit(exit_minix_fs)
 MODULE_DESCRIPTION("Minix file system");
 MODULE_LICENSE("GPL");
-
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index c3cd2c75af9c..d73ab1caacfe 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -311,7 +311,15 @@ static inline void truncate (struct inode * inode)
 	long iblock;
 
 	iblock = (inode->i_size + sb->s_blocksize -1) >> sb->s_blocksize_bits;
-	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
+
+	/* Depending on whether the inode being truncated is a directory or not,
+	 * we need to either call iomap_truncate_page or block_truncate_page.
+	 */
+	if (S_ISDIR(inode->i_mode))
+		block_truncate_page(inode->i_mapping, inode->i_size, get_block);
+	else
+		iomap_truncate_page(inode, inode->i_size, NULL,
+			minix_iomap_ops_ver(inode), NULL, NULL);
 
 	n = block_to_path(inode, iblock, offsets);
 	if (!n)
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index f1141d36e3d5..9035604c68ca 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -58,6 +58,8 @@ void minix_free_block(struct inode *inode, unsigned long block);
 unsigned long minix_count_free_blocks(struct super_block *sb);
 int minix_getattr(struct mnt_idmap *, const struct path *,
 		struct kstat *, u32, unsigned int);
+int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+	struct iattr *attr);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 5525ba367ed7..52e115013abf 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -6,6 +6,7 @@
  */
 
 #include "minix.h"
+#include <linux/iomap.h>
 
 static int add_nondir(struct dentry *dentry, struct inode *inode)
 {
@@ -84,12 +85,16 @@ static int minix_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return PTR_ERR(inode);
 
 	minix_set_inode(inode, 0);
-	err = page_symlink(inode, symname, i);
+	err = iomap_symlink_write(inode, symname, i, minix_iomap_ops_ver(inode), NULL, NULL);
+
 	if (unlikely(err)) {
 		inode_dec_link_count(inode);
 		iput(inode);
 		return err;
 	}
+
+	i_size_write(inode, i - 1);
+
 	return add_nondir(dentry, inode);
 }
 
-- 
2.47.3

