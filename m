Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF53D1CA7;
	Tue, 26 May 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803379; cv=none; b=iFhtdYj3UFrAdwiTOWsgZpzlc/tzlJUR7kx2cqsDEzj86bJeDDoXspyWw+NbfyDw/8GKrkzWcoVGBOBOp8YA8uu7bugmYR9fBBPtA1k4VVXdj7BMeUSNo9SfWRshUtYg8X34pf7CrH/TlpbYsdNt6A2Cn8gB6bG2iHNF2gb2p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803379; c=relaxed/simple;
	bh=zoxcOjS65bzYA183nVfLEM9Mp+YADBx0tA2OotYBBII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwTTzy1HSRzWyfSnb9bsvGY6aIaG2cLnnR6HXro0+IOhFGZdr2xNfvCulcnr6i/HAU3uPhxvLdjduVpaAP+AX9tln6+wNa6CxxOCK8NnNrwd7A7g28iOlqvosk9+nzxxK6Sfom9tJgyEjEt3GaPNxDEiF90eWG1Yt3zP85VzW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ZJHXJo6E; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ZJHXJo6E"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AD2561D3B;
	Tue, 26 May 2026 13:49:38 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=ZJHXJo6E;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id F339C2126;
	Tue, 26 May 2026 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779803376;
	bh=oXFfSAS2haSHo8sd3SCqP5trv8nTkjRXWKTqfWLQcKI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZJHXJo6EBpA44VoWOpgPQioTYh5VmQfdGVuAp/jeyudR+9yYD1UX2iDSqGkqaGNz4
	 gOgsSXWJSt9nIcVuwMlRrvu7ejzcuUjrOU6KIbQMVofxQUS1k5ZXYeldCTiBhR0Q+P
	 JozkP03V6qT6yoeXfxOkZLTOR/I8FLrXepnNcN24=
Received: from localhost.localdomain (172.30.20.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 May 2026 16:49:34 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6/6] fs/ntfs3: fold file size handling into ntfs_set_size()
Date: Tue, 26 May 2026 15:49:07 +0200
Message-ID: <20260526134907.11402-7-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
References: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Remove the separate ntfs_extend() and ntfs_truncate() helpers and route
file size changes through ntfs_set_size().

This consolidates ntfs3 size updates in one place and lets the write,
fallocate, and setattr paths share the same logic for updating i_size,
valid data length, and preallocated extents.

This patch fixes a few issues found during internal tests.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c  | 178 +++++++++++------------------------------------
 fs/ntfs3/inode.c |  21 +++---
 2 files changed, 51 insertions(+), 148 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 26bec5be248e..06a5d9b44ac1 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -450,93 +450,6 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	return err;
 }
 
-static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
-		       struct file *file)
-{
-	struct ntfs_inode *ni = ntfs_i(inode);
-	struct address_space *mapping = inode->i_mapping;
-	loff_t end = pos + count;
-	bool extend_init = file && pos > ni->i_valid;
-	int err;
-
-	if (end <= inode->i_size && !extend_init)
-		return 0;
-
-	/* Mark rw ntfs as dirty. It will be cleared at umount. */
-	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);
-
-	if (end > inode->i_size) {
-		/*
-		 * Normal files: increase file size, allocate space.
-		 * Sparse/Compressed: increase file size. No space allocated.
-		 */
-		err = ntfs_set_size(inode, end);
-		if (err)
-			goto out;
-	}
-
-	if (extend_init && !is_compressed(ni)) {
-		err = ntfs_extend_initialized_size(file, ni, pos);
-		if (err)
-			goto out;
-	} else {
-		err = 0;
-	}
-
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-	mark_inode_dirty(inode);
-
-	if (IS_SYNC(inode)) {
-		int err2;
-
-		err = filemap_fdatawrite_range(mapping, pos, end - 1);
-		err2 = write_inode_now(inode, 1);
-		if (!err)
-			err = err2;
-		if (!err)
-			err = filemap_fdatawait_range(mapping, pos, end - 1);
-	}
-
-out:
-	return err;
-}
-
-static int ntfs_truncate(struct inode *inode, loff_t new_size)
-{
-	int err;
-	struct ntfs_inode *ni = ntfs_i(inode);
-	u64 new_valid = min_t(u64, ni->i_valid, new_size);
-
-	truncate_setsize(inode, new_size);
-
-	ni_lock(ni);
-
-	down_write(&ni->file.run_lock);
-	err = attr_set_size_ex(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
-			       &new_valid, ni->mi.sbi->options->prealloc, NULL,
-			       false);
-	up_write(&ni->file.run_lock);
-
-	ni->i_valid = new_valid;
-
-	ni_unlock(ni);
-
-	if (err)
-		return err;
-
-	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-	if (!IS_DIRSYNC(inode)) {
-		mark_inode_dirty(inode);
-	} else {
-		err = ntfs_sync_inode(inode);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 /*
  * ntfs_fallocate - file_operations::ntfs_fallocate
  *
@@ -743,57 +656,25 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		if (is_supported_holes) {
 			CLST vcn = vbo >> cluster_bits;
 			CLST cend = bytes_to_cluster(sbi, end);
-			CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
 			CLST lcn, clen;
 			bool new;
 
-			if (cend_v > cend)
-				cend_v = cend;
-
 			/*
 			 * Allocate and zero new clusters.
-			 * Zeroing these clusters may be too long.
-			 */
-			for (; vcn < cend_v; vcn += clen) {
-				err = attr_data_get_block(ni, vcn, cend_v - vcn,
-							  &lcn, &clen, &new,
-							  true, NULL, false);
-				if (err)
-					goto out;
-			}
-
-			/*
-			 * Moving up 'valid size'.
-			 */
-			err = ntfs_extend_initialized_size(
-				file, ni, (u64)cend_v << cluster_bits);
-			if (err)
-				goto out;
-
-			/*
-			 * Allocate but not zero new clusters.
 			 */
 			for (; vcn < cend; vcn += clen) {
 				err = attr_data_get_block(ni, vcn, cend - vcn,
 							  &lcn, &clen, &new,
-							  false, NULL, false);
+							  true, NULL, false);
 				if (err)
 					goto out;
 			}
 		}
 
 		if (mode & FALLOC_FL_KEEP_SIZE) {
-			ni_lock(ni);
-			/* True - Keep preallocated. */
-			err = attr_set_size(ni, ATTR_DATA, NULL, 0,
-					    &ni->file.run, i_size, &ni->i_valid,
-					    true);
-			ni_unlock(ni);
+			err = ntfs_set_size(inode, i_size);
 			if (err)
 				goto out;
-			i_size_write(inode, i_size);
-		} else if (new_size > i_size) {
-			i_size_write(inode, new_size);
 		}
 	}
 
@@ -850,16 +731,20 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		oldsize = i_size_read(inode);
 		newsize = attr->ia_size;
 
-		if (newsize <= oldsize)
-			err = ntfs_truncate(inode, newsize);
-		else
-			err = ntfs_extend(inode, newsize, 0, NULL);
+		if (newsize != oldsize) {
+			truncate_setsize(inode, newsize);
 
-		if (err)
-			goto out;
+			err = ntfs_set_size(inode, newsize);
+			if (err) {
+				i_size_write(inode, oldsize);
+				goto out;
+			}
 
-		ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
-		i_size_write(inode, newsize);
+			ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
+			ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
+		}
 	}
 
 	setattr_copy(idmap, inode, attr);
@@ -1333,6 +1218,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
+	loff_t vbo, endbyte;
 	ssize_t ret, err;
 
 	if (!inode_trylock(inode)) {
@@ -1367,15 +1253,30 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	ret = ntfs_extend(inode, iocb->ki_pos, ret, file);
-	if (ret)
-		goto out;
+	vbo = iocb->ki_pos;
+	endbyte = vbo + ret;
+
+	if (endbyte > inode->i_size) {
+		/*
+		 * Normal files: increase file size, allocate space.
+		 * Sparse/Compressed: increase file size. No space allocated.
+		 */
+		ret = ntfs_set_size(inode, endbyte);
+		if (ret)
+			goto out;
+	}
 
 	if (is_compressed(ni)) {
 		ret = ntfs_compress_write(iocb, from);
 		goto out;
 	}
 
+	if (vbo > ni->i_valid) {
+		ret = ntfs_extend_initialized_size(file, ni, vbo);
+		if (ret)
+			goto out;
+	}
+
 	/* Fallback to buffered I/O if the inode does not support direct I/O. */
 	if (!(iocb->ki_flags & IOCB_DIRECT) ||
 	    !ntfs_should_use_dio(iocb, from)) {
@@ -1408,7 +1309,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	if (ret >= 0 && iov_iter_count(from)) {
-		loff_t offset = iocb->ki_pos, endbyte;
+		vbo = iocb->ki_pos;
 
 		iocb->ki_flags &= ~IOCB_DIRECT;
 		err = iomap_file_buffered_write(iocb, from, &ntfs_iomap_ops,
@@ -1426,15 +1327,15 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		* to complete off the I/O request.
 		*/
 		ret += err;
-		endbyte = offset + err - 1;
-		err = filemap_write_and_wait_range(inode->i_mapping, offset,
+		endbyte = vbo + err - 1;
+		err = filemap_write_and_wait_range(inode->i_mapping, vbo,
 						   endbyte);
 		if (err) {
 			ret = err;
 			goto out;
 		}
 
-		invalidate_mapping_pages(inode->i_mapping, offset >> PAGE_SHIFT,
+		invalidate_mapping_pages(inode->i_mapping, vbo >> PAGE_SHIFT,
 					 endbyte >> PAGE_SHIFT);
 	}
 
@@ -1515,8 +1416,9 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 		down_write(&ni->file.run_lock);
 
 		/* Deallocate preallocated. */
-		err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
-				    inode->i_size, &ni->i_valid, false);
+		err = attr_set_size_ex(ni, ATTR_DATA, NULL, 0, &ni->file.run,
+				       inode->i_size, &ni->i_valid, false, NULL,
+				       true);
 
 		up_write(&ni->file.run_lock);
 		ni_unlock(ni);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 9a75c2d832ca..2d3aad60caa4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -693,17 +693,18 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 		return -EFBIG;
 	}
 
+	/* Mark rw ntfs as dirty. It will be cleared at umount. */
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
+
 	ni_lock(ni);
 	down_write(&ni->file.run_lock);
+	if (new_size < ni->i_valid)
+		ni->i_valid = new_size;
 
+	/* last 'true' means keep preallocated. */
 	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
 			    &ni->i_valid, true);
 
-	if (!err) {
-		i_size_write(inode, new_size);
-		mark_inode_dirty(inode);
-	}
-
 	up_write(&ni->file.run_lock);
 	ni_unlock(ni);
 
@@ -778,11 +779,6 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return err;
 	}
 
-	if (!clen) {
-		/* broken file? */
-		return -EINVAL;
-	}
-
 	if (lcn == EOF_LCN) {
 		/* request out of file. */
 		if (flags & IOMAP_REPORT) {
@@ -816,6 +812,11 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
+	if (!clen) {
+		/* broken file? */
+		return -EINVAL;
+	}
+
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = offset;
 	iomap->length = ((loff_t)clen << cluster_bits) - off;
-- 
2.43.0

