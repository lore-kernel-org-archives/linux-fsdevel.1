Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9530F540
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803573; cv=none; b=snMsDjpHY3Gv6cZeY57rdaDC9/cjijmak4Rw1NDo/aJunsn8g6vdo1ojjfdxTHk/l/ryHSSXbzFQqkxxAXQwarYtlqaY1NIF9paHZUJ+Hw06UsUVjuHPnZht5xiw6851a34BAeVf+53KhL/DizcP6UhiVSVF0w8VKXT5gZTk+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803573; c=relaxed/simple;
	bh=MApZ9+VcV1CU1S6+9jaQdIXj3M5h5hU/HWXnTz4jg34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4SOkKyBgcgWQogugAfJwiyWMMq7juGs0sRoKD21zAHcKW0TXyAY/mTLK9EGd8H7398annYKRRlv+UblxjinIdVNo4bU1stSpA9eLMf4QqshuOG4GzBoTcvXaOPLlYh8rbH6cCGAF/DZP8IWGrAFaX1A/x0Z3uS2+FI97O6YUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgaqRhiA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgaqRhiA"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so976621a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 13:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783803571; x=1784408371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tB4aNIIl+6I/pIezbew7L22hRSnHScEtRtcn7y/r0w=;
        b=WgaqRhiAyl0lktGNB8DmqR0dUW51lWyuV1Lw+eQi0Db+Jkubixl1h/NaXuzgtlXHxX
         QSriUwuj5AmI0XFsFqAxPZZTzgBzs+KoJgqB18J5PiOOp6isEa/lb2wibEeqar44dwZs
         NL9/F2CKAyeQ63bbP3EWg5DZOCZY9alcRyFR4QyOjr15w+R55wUzt6eQCKZtj//rm2Gl
         h6b9BqdkEBiGB0VyXN7/iDkiH3NrWuTVzzKedzmWKzfe18IpEP6+URDiwHWqDvbPfZ2T
         c0+Tsaomtq2Qu7HPi+EoDTpsbDww3YW9fUFIyNkeBQqboLZ4WHnx5w8keQpBtxeSePnf
         iy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783803571; x=1784408371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7tB4aNIIl+6I/pIezbew7L22hRSnHScEtRtcn7y/r0w=;
        b=mIjgnP93PrFQGX1kLSymvnenBvlEnpCJ1goAcDF6mepQuy7cPxTKXN78ZTiwrFXo85
         0B/AaR0+H/QWfiAcYgJoJ+9CGPBLjx+IMjxVLerBQlCJ9Yk2HvfpBQKCZCQuHg3F+zq4
         9gSjH0jF8CfUnShufbDWJeJ068egvVTtG/ewYLuCTgEFhlp8gxOQtLe238f37DTje2L5
         Au/j+R4a7l2lul6uP8aUINypVjeutzXK0W+VvSssnn4ykp8Y7LUgg8O5yfMnavYvXdol
         XpGXURKE0QJ38FfAeVHnnyE7p7MLWIrPluapkrphvDAcJPIxuqQooxWzXg7D02eSW/3O
         eZLg==
X-Gm-Message-State: AOJu0YwtrA9knZs094AcmfcoCiEDP3gZoa+TKBRrYr4+uXJhKvmF5h3Q
	OXJ5TyLIKplFepu5CB7wAaSNwY2CihUGYporKzwjDs8DJ2X6h4+/D9TbEyfelw==
X-Gm-Gg: AfdE7cn39VhX5r5mfZhyPN573HXTxIfb1ytt+Rom4WJLEWGQV+QYW92pwLl4U3D51qp
	QKQbdWhY24upK2xnWU6eaqlNjT7+HueWYvLD1S3x8jCOUzFHQM3m65GC8Z1Bxuw1ZDT8mAFS+n8
	Q2Acxc/pbgp/PpCyn57JqWc6TfSXaR+QkCewZ5vDtowLTALj41ktCwVsiPYs5RrC8BpXPqND/e/
	nghgCJIC3hIMGMm40A0BlFre5YjUrhvMP2an3M/wBXOVNhaxSfLOofZFcC/3yg5N0flTSCinE1B
	KM/b1QXLiO3WxxxEVozQmc6pypIwNs5hBFnYNl8HFcBfvlSeG71BrW31UTV722JAZcNHazTzY+Q
	BhjY6wx4Vsj/GJLCiOLrsAt7X6Oi/UPNfRpU6G+tsOhMNPmUe7te4voRULgW66f4=
X-Received: by 2002:a05:6a00:21ca:b0:845:d286:1fb4 with SMTP id d2e1a72fcca58-8488975b2b8mr3537838b3a.50.1783803571413;
        Sat, 11 Jul 2026 13:59:31 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a44feasm2092057b3a.20.2026.07.11.13.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:59:30 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v3 4/5] minix: add file operation functions
Date: Sat, 11 Jul 2026 13:59:08 -0700
Message-ID: <3f7e48122d2b280de63e7b901c7a1d7a99c0e063.1783707063.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783707063.git.jbingham@gmail.com>
References: <cover.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the minix iomap file operation functions, including direct I/O
functions, and updates the minix_file_operations struct to use them.
Previously, most of the function pointers in minix_file_operations were
the defaults. With the iomap changes, though, the defaults are no longer
sufficient and minix-specific functions are required.

The previously static minix_setattr function is also now exported; it will
be used by minix_symlink_inode_operations.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/file.c  | 153 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/minix/minix.h |   2 +
 2 files changed, 149 insertions(+), 6 deletions(-)

diff --git a/fs/minix/file.c b/fs/minix/file.c
index 86e5943cd2ff..88117c0e9f11 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -17,21 +17,162 @@ int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
+		iocb->ki_flags |= IOCB_DSYNC;
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
+		invalidate_mapping_pages(inode->i_mapping,
+			pos >> PAGE_SHIFT,
+			endbyte >> PAGE_SHIFT);
+		if (ret > 0)
+			ret = generic_write_sync(iocb, ret);
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
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index cf85edfb5bfa..45beadef0d8c 100644
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
 int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync);
-- 
2.47.3

