Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58650243951
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501957; cv=none; b=cZW/FVxVfKWhcstlZGrlQt03FEdcRq3BsHDaHx+VKUnbQH1MUAa/FsrJQSwoQtOXnznFu0hypabimxKU3tTOx4QfAT2yuhpBJMdAzsx5haxRleBNOU71rHlVptb0wZKIYZntvB72u8X47Ql0tO2KEthFKXCINYFkXAKabU9QTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501957; c=relaxed/simple;
	bh=y8fv5OGf9hm8oIgmHl9GEBPa86ORlhqNffdrY586jBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2hNfd/Ro5/I6XGkeEFeIWQGDTUrOZkFfKgaKNI/M3HAT9MmWNgx+XkdIbWETlbRwQGk3lvRoHPq9OS7sQrcc9Z02FYI5QWGMGMa66cuiqwxEQzsAIVyrI8Wte/xEG1YFMaGQEP8yY/t9UDalu4istNtnQjhE52cQYeah4wK340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+SA6AQg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+SA6AQg"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so874776a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782501954; x=1783106754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VZLwoROrnH4leCGZ1sg2nnzPVAk0Z3s06oS2+8BcUA=;
        b=C+SA6AQgNO2LksP3aEH1nsb+xeBWyavGUpHhCG1DuPvoph5bfwpVxHNn3C31yhNkvT
         pPo3nXTQBJv2r1/+KYKOd75m9N7q6GYrKmzDDsMdD7HWmPaQxCFajXrAs4IBvVruTWku
         kJrWI+fZKduYE1Akj6ChijKRgITOyyfUlYm84BF9FVWC/iPka85P6WJZDfNOu8o6H8od
         jmb3vPU2JXXGXJ+y0PCgxflURBGPGyHQecY3qxW3rK/bDd/3D5waj6n9VgmJMkXcedXo
         aME4YNA9xxoQbPNCF+8s+NmwEWyTX9EIgg1svvFfw1RitdGDnKRcVUsMYzyk4zNkb5+X
         6ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782501954; x=1783106754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VZLwoROrnH4leCGZ1sg2nnzPVAk0Z3s06oS2+8BcUA=;
        b=tDWNPdjZwHkAe0L2ySZjbrtCnJ83nCraRSmOHg8P++Q4hgOI7kopGWyME8kEgJAFIy
         XyetVSVw/L50bmS1rNTTZZcS95pXZNhLvVNNvWXIr16LZeoZZGB5ctkqBt1095B4VRXi
         NPIRC5L9/ErDUuKn3yR0wgjlrYY+kfgs3yVjjHyli5yZ+sg4/cmDXkOfFP8xx8v/SEmv
         Z7Zmi7NyZuyRoejang0g/oLEVKBI+VxntRSlrh2aC1uuFIRsgq4xQfMvrnkQzIfqZnI4
         OsfdOveUrU7X0CQL2YLJe0FpH8du9rwvx4tkR2/jdjERdvGHCnK5fh6qDKhH/XGZfuOC
         dBdQ==
X-Gm-Message-State: AOJu0YwaxI6RZr0aT8IrRQDkU9ji22yOnZo9/hy3BvAKpHDS4KBrxcgB
	5JNxjtoZ/jRdDJHcN5Y+10i18v/SrJdHlKz1cNNn7ZT/jwosfCFocurm
X-Gm-Gg: AfdE7clqijOKVElS1Rfk44tPsKq4Lvpi8D/LcT6EDb8IIhDYONBsUtoD70R4rFeIpZ0
	QbVH5Pe03Z+0z5SiK69Sun8FvAkGdjbn6cZvxgZrSKMMgkrQnKbbYLLEKEUo5W+H3HpTA5zGhZd
	BlvdT8HXCzXJNezbzzKNF6GTToCGva3onC1LuGokFow3koXrjVDMP8yx40N3W+zB/MiMRb+s3DB
	IZjh5al34pfukmWkuJnxTwKkHdivMoIZk/TCePblny+vC89DzDc+WiojB5v8p00BOJ+eagGO/63
	G5yFR9XIl4D6VIn9Q9e0w6RgKKs2Q/qaHYiHPSqn/6V6ga6ElUF0f3OTAye5hbh+jILiXopBWna
	vc9thsnwO8wbWHj6Jt10ZbLBWx4SVAtHZv8GW2pGngQSvQX7gZyRpb1DAuuTg4SudU/JEyPO2Bg
	==
X-Received: by 2002:a17:90b:3f4b:b0:369:1dbb:4732 with SMTP id 98e67ed59e1d1-37df8dc18a1mr5927450a91.0.1782501954349;
        Fri, 26 Jun 2026 12:25:54 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3dfdba5sm4557484a91.9.2026.06.26.12.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:25:53 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: syzbot+ci6eb2640f41075c71@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	syzkaller-bugs@googlegroups.com,
	Jeremy Bingham <jbingham@gmail.com>
Subject: Re: [syzbot ci] Re: minix: convert to iomap and add direct I/O
Date: Fri, 26 Jun 2026 12:25:41 -0700
Message-ID: <20260626192541.2458445-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a3e251e.b42ede87.2ae58d.0001.GAE@google.com>
References: <6a3e251e.b42ede87.2ae58d.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

---
 fs/minix/file.c         | 157 ++++++++++++++++++++++++++++++++++++++--
 fs/minix/inode.c        |  86 ++++++++++++++++++++--
 fs/minix/iomap.c        | 114 +++++++++++++++++++++++++++++
 fs/minix/itree_common.c |  11 ++-
 fs/minix/itree_v1.c     |  25 ++++++-
 fs/minix/itree_v2.c     |  17 ++++-
 fs/minix/minix.h        |  25 ++++++-
 7 files changed, 415 insertions(+), 20 deletions(-)
 create mode 100644 fs/minix/iomap.c

diff --git a/fs/minix/file.c b/fs/minix/file.c
index 86e5943cd2ff..b07c853fa43a 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -17,21 +17,166 @@ int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 			start, end, datasync);
 }
 
+static ssize_t minix_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	ssize_t ret;
+
+	inode_lock_shared(inode);
+
+	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);
+
+	ret = iomap_dio_rw(iocb, to, ops, NULL, 0, NULL, 0);
+	inode_unlock_shared(inode);
+	return ret;
+}
+
+static int minix_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
+		unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t pos = iocb->ki_pos;
+
+	if (error)
+		return error;
+
+	pos += size;
+	if (size && pos > i_size_read(inode)) {
+		i_size_write(inode, pos);
+		mark_inode_dirty(inode);
+	}
+	return 0;
+}
+
+static const struct iomap_dio_ops minix_dio_write_ops = {
+	.end_io = minix_dio_write_end_io,
+};
+
+static ssize_t minix_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	ssize_t ret;
+	unsigned int flags = 0;
+	unsigned long blocksize = inode->i_sb->s_blocksize;
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_unlock;
+
+	ret = kiocb_modified(iocb);
+	if (ret)
+		goto out_unlock;
+
+	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
+		!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize))
+		flags |= IOMAP_DIO_FORCE_WAIT;
+
+	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);
+
+	ret = iomap_dio_rw(iocb, from, ops,
+		&minix_dio_write_ops, flags, NULL, 0);
+	if (ret == -ENOTBLK)
+		ret = 0; /* fallback to buffered */
+
+	if (ret >= 0 && iov_iter_count(from)) {
+		loff_t pos;
+		loff_t endbyte;
+		ssize_t status;
+
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		pos = iocb->ki_pos;
+		status = iomap_file_buffered_write(iocb, from, ops,
+			NULL, NULL);
+		if (unlikely(status < 0)) {
+			ret = status;
+			goto out_unlock;
+		}
+
+		ret += status;
+		endbyte = pos + status - 1;
+		status = filemap_write_and_wait_range(inode->i_mapping, pos, endbyte);
+		if (!status) {
+			invalidate_mapping_pages(inode->i_mapping,
+				pos >> PAGE_SHIFT,
+				endbyte >> PAGE_SHIFT);
+			if (ret > 0)
+				ret = generic_write_sync(iocb, ret);
+		} else {
+			ret = status;
+		}
+	}
+
+out_unlock:
+	inode_unlock(inode);
+	return ret;
+}
+
+static ssize_t minix_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return minix_dio_read_iter(iocb, to);
+
+	return generic_file_read_iter(iocb, to);
+}
+
+static ssize_t minix_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	ssize_t ret;
+
+	/* minix_dio_write_iter also locks the inode and appears to do the same
+	 * general sorts of checks as this, so just return directly from there.
+	 */
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return minix_dio_write_iter(iocb, from);
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
+	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);
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
+static int minix_file_open(struct inode *inode, struct file *filp)
+{
+	filp->f_mode |= FMODE_CAN_ODIRECT;
+	return generic_file_open(inode, filp);
+}
+
 /*
- * We have mostly NULLs here: the current defaults are OK for
- * the minix filesystem.
+ * We still have some NULLs here, but not as many of the current defaults are
+ * still OK for the minix filesystem.
  */
+
 const struct file_operations minix_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
+	.read_iter	= minix_file_read_iter,
+	.write_iter	= minix_file_write_iter,
 	.mmap_prepare	= generic_file_mmap_prepare,
+	.open		= minix_file_open,
 	.fsync		= minix_fsync,
 	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
 };
 
-static int minix_setattr(struct mnt_idmap *idmap,
-			 struct dentry *dentry, struct iattr *attr)
+int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+	struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index c30cc590698d..8a79ff82a656 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -436,6 +436,31 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
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
@@ -445,17 +470,45 @@ static int minix_get_block(struct inode *inode, sector_t block,
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
@@ -487,24 +540,42 @@ static int minix_write_begin(const struct kiocb *iocb,
 
 static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping,block,minix_get_block);
+	const struct iomap_ops *ops = minix_iomap_ops_ver(mapping->host);
+
+	return iomap_bmap(mapping, block, ops);
 }
 
-static const struct address_space_operations minix_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
+const struct address_space_operations minix_aops = {
+	.dirty_folio	= iomap_dirty_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 	.read_folio = minix_read_folio,
+	.readahead = minix_readahead,
 	.writepages = minix_writepages,
+	.migrate_folio = filemap_migrate_folio,
+	.bmap = minix_bmap,
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
 	.bmap = minix_bmap,
-	.direct_IO = noop_direct_IO
+	.writepages = minix_block_writepages,
 };
 
 static const struct inode_operations minix_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.getattr	= minix_getattr,
+	.setattr	= minix_setattr,
 };
 
 void minix_set_inode(struct inode *inode, dev_t rdev)
@@ -516,7 +587,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &minix_dir_inode_operations;
 		inode->i_fop = &minix_dir_operations;
-		inode->i_mapping->a_ops = &minix_aops;
+		inode->i_mapping->a_ops = &minix_dir_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
 		inode->i_op = &minix_symlink_inode_operations;
 		inode_nohighmem(inode);
@@ -768,4 +839,3 @@ module_init(init_minix_fs)
 module_exit(exit_minix_fs)
 MODULE_DESCRIPTION("Minix file system");
 MODULE_LICENSE("GPL");
-
diff --git a/fs/minix/iomap.c b/fs/minix/iomap.c
new file mode 100644
index 000000000000..7bb0439e3669
--- /dev/null
+++ b/fs/minix/iomap.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * iomap functions for minix. At least the first pass of this file was taken
+ * from the xiafs iomap.c, which is fitting since the xiafs module in turn
+ * borrowed heavily from the modernized minix fs kernel module.
+ */
+
+/*
+ * minix_iomap_begin - map a file range to disk blocks. It acts as a replacement
+ * for get_block in itree_common.c, at least in the important ways, and is
+ * adapted from it, but it uses iomap instead of buffer_head. This is taken
+ * directly from the out-of-tree xiafs iomap changes, and the exfat iomap
+ * changes were an inspiration for that.
+ */
+static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int blkbits = sb->s_blocksize_bits;
+	sector_t iblock = offset >> blkbits;
+	int create = flags & IOMAP_WRITE;
+
+	/* Mostly taken from modern-xiafs itree.c get_block with elements from
+	 * similar exfat operations.
+	 */
+	int offsets[DEPTH];
+	Indirect chain[DEPTH];
+	Indirect *partial;
+	int depth = block_to_path(inode, iblock, offsets);
+	int left;
+	int err = -EIO;
+
+	sector_t phys;
+
+	/* block is beyond max file size */
+	if (depth == 0)
+		goto out;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+
+reread:
+	partial = get_branch(inode, depth, offsets, chain, &err);
+
+	/* Simplest case - block found, no allocation needed */
+	if (!partial) {
+		/* Bit of a weird order, but it'll make sense when you get to
+		 * the bottom.
+		 */
+		iomap->flags = IOMAP_F_MERGED;
+got_it:
+		phys = block_to_cpu(chain[depth - 1].key);
+		partial = chain+depth-1;
+		/* Set up the iomap struct before cleaning up */
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = (u64)phys << blkbits;
+		iomap->length = 1 << blkbits;
+		iomap->offset = (u64)iblock << blkbits;
+		goto cleanup;
+	}
+
+	/* Next simple case - plain lookup or failed read of indirect block */
+	if (!create || err == -EIO) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->length = 1 << blkbits;
+		iomap->offset = (u64)iblock << blkbits;
+		iomap->flags = 0;
+cleanup:
+		while (partial > chain) {
+			brelse(partial->bh);
+			partial--;
+		}
+out:
+		return err;
+	}
+
+	/*
+	 * Indirect block might be removed by truncate while we were
+	 * reading it. Handling of that case (forget what we've got and
+	 * reread) is taken out of the main path.
+	 */
+	if (err == -EAGAIN)
+		goto changed;
+
+	left = (chain + depth) - partial;
+	err = alloc_branch(inode, left, offsets + (partial - chain), partial);
+	if (err)
+		goto cleanup;
+
+	if (splice_branch(inode, chain, partial, left) < 0)
+		goto changed;
+
+	/* Successful allocation, mapping it. */
+	iomap->flags = IOMAP_F_NEW;
+	goto got_it;
+
+changed:
+	while (partial > chain) {
+		brelse(partial->bh);
+		partial--;
+	}
+	goto reread;
+}
+
+/*
+ * minix_iomap_end ends up being a nop; since minix doesn't have any extents or
+ * transactions to worry about, there isn't anything to update here. The on-disk
+ * indirect blocks get dirtied in minix_iomap_begin.
+ */
+static int minix_iomap_end(struct inode *inode, loff_t offset, loff_t length,
+	ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	return 0;
+}
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index c3cd2c75af9c..5a8b73a7beda 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -311,7 +311,16 @@ static inline void truncate (struct inode * inode)
 	long iblock;
 
 	iblock = (inode->i_size + sb->s_blocksize -1) >> sb->s_blocksize_bits;
-	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
+
+	/* Depending on what address space operations are being used by the
+	 * inode being truncated, we need to either call iomap_truncate_page or
+	 * block_truncate_page.
+	 */
+	if (inode->i_mapping->a_ops == &minix_aops)
+		iomap_truncate_page(inode, inode->i_size, NULL,
+			minix_iomap_ops_ver(inode), NULL, NULL);
+	else
+		block_truncate_page(inode->i_mapping, inode->i_size, get_block);
 
 	n = block_to_path(inode, iblock, offsets);
 	if (!n)
diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index 1fed906042aa..58c29f4443d3 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -49,6 +49,18 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 }
 
 #include "itree_common.c"
+/* NOTA BENE:
+ *
+ * This is icky to me, but at the same time having it be a standalone C file
+ * that's compiled to object form and linked separately like it is in xiafs is
+ * much nastier in minix because of the different versions of the minix fs that
+ * have some very, very different aspects, like the size of block_t. I don't
+ * like it, but since minix already has this pattern where a common itree file
+ * is included in the itree_v1 and itree_v2(and v3) files, I'm including iomap.c
+ * in these files as well. It does at least avoid exporting some currently
+ * static functions that aren't needed anywhere but itree_common.c and iomap.c.
+ */
+#include "iomap.c"
 
 int V1_minix_get_block(struct inode * inode, long block,
 			struct buffer_head *bh_result, int create)
@@ -61,7 +73,18 @@ void V1_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V1_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
+
+int V1_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+}
+
+const struct iomap_ops V1_minix_iomap_ops = {
+	.iomap_begin = V1_minix_iomap_begin,
+	.iomap_end   = minix_iomap_end,
+};
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
index 9d00f31a2d9d..fc7a5ae8fa1c 100644
--- a/fs/minix/itree_v2.c
+++ b/fs/minix/itree_v2.c
@@ -57,6 +57,10 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 }
 
 #include "itree_common.c"
+/* See the note in itree_v1 in a comment that starts "NOTA BENE" for an
+ * explanation for why iomap.c is included here.
+ */
+#include "iomap.c"
 
 int V2_minix_get_block(struct inode * inode, long block,
 			struct buffer_head *bh_result, int create)
@@ -69,7 +73,18 @@ void V2_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V2_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
+
+int V2_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+}
+
+const struct iomap_ops V2_minix_iomap_ops = {
+	.iomap_begin = V2_minix_iomap_begin,
+	.iomap_end   = minix_iomap_end,
+};
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index f2025c9b5825..270e4e0620a1 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -5,6 +5,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/minix_fs.h>
+#include <linux/iomap.h>
 
 #define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
 #define MINIX_V1		0x0001		/* original minix fs */
@@ -56,7 +57,9 @@ int minix_new_block(struct inode *inode);
 void minix_free_block(struct inode *inode, unsigned long block);
 unsigned long minix_count_free_blocks(struct super_block *sb);
 int minix_getattr(struct mnt_idmap *, const struct path *,
-		struct kstat *, u32, unsigned int);
+		struct kstat *, u32, unsigned);
+int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+	struct iattr *attr);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync);
@@ -80,10 +83,20 @@ int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
 ino_t minix_inode_by_name(struct dentry*);
 
+extern int V1_minix_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap,
+	struct iomap *srcmap);
+extern int V2_minix_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap,
+	struct iomap *srcmap);
+
+extern const struct address_space_operations minix_aops;
 extern const struct inode_operations minix_file_inode_operations;
 extern const struct inode_operations minix_dir_inode_operations;
 extern const struct file_operations minix_file_operations;
 extern const struct file_operations minix_dir_operations;
+extern const struct iomap_ops V1_minix_iomap_ops;
+extern const struct iomap_ops V2_minix_iomap_ops;
 
 static inline struct minix_sb_info *minix_sb(struct super_block *sb)
 {
@@ -95,11 +108,17 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
 	return container_of(inode, struct minix_inode_info, vfs_inode);
 }
 
-static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
+static inline unsigned int minix_blocks_needed(unsigned int bits, unsigned int blocksize)
 {
 	return DIV_ROUND_UP(bits, blocksize * 8);
 }
 
+static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode *inode)
+{
+	return (INODE_VERSION(inode) == MINIX_V1) ?
+		&V1_minix_iomap_ops : &V2_minix_iomap_ops;
+}
+
 #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
 	defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
 
@@ -129,7 +148,7 @@ static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
  * big-endian 16bit indexed bitmaps
  */
 
-static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
+static inline int minix_find_first_zero_bit(const void *vaddr, unsigned int size)
 {
 	const unsigned short *p = vaddr, *addr = vaddr;
 	unsigned short num;
-- 
2.47.3

