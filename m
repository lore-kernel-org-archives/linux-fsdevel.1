Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C64299923
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782623786; cv=none; b=PlN3o/9iqQhTcL3LngvePEpE862rLLnUMLzMrSRVgKLNBpZLIZWolSEl8XMdfvcpRw4fD8Go7Fz/ZFvwzWYNv1+Ep39/gT8SzTMiVoEAd5NfeSV8exEtNBGXhzf2SmqhawM9ErktW2ml0qKmklUbX1CutPFUBYc3Aw6yeEhsvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782623786; c=relaxed/simple;
	bh=JqgmsWUuRdzvwGnX/LftqEJqbBs6dwIQrUwVEoKtN7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSmHQpq+sZiRMMJNSFbU5BkKUeYREImugl5RNIJPhq/7qvBKluVjlixTnVLy74737Zh82mpmNbkxoih0PVKa/qifbwsszJtQMSYA30AWBSrdQIPtCudWiC4ccp5kdf6gqQjsLwAhDyz+tW4PPpn7r2JtP01fDQIyJMsR/+O6Ujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRHFQk86; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRHFQk86"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8deb37737dso746502a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 22:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782623781; x=1783228581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S8bRzJxBAeprTKinYbleVac8m0g3j4M+0B8UhmApPY=;
        b=cRHFQk86IwBYAy+LXI58XEN8otiz3/3EJi22nKvJYBGS9/PUUcw3iL9vAK1Rz9CdpA
         YCoI0nhmuS9E4VKfV31YmPBUbCr/o2BrWt1PiE86/ultMxDCohFVHqCixr6ZuLoEhhcW
         mPClhKaF0cGV6+DjjxZZqH7v/zbmSxI4G5wygpQnVcLIy9V16iiMXmXSkOn/g1p72WUD
         vF6ob27lVjSp0TB0ArgqlvnbGT/WW/fuPHJoRhFAtVdbNy7kUcYz0Le5WhgEI6DNid8E
         HbNioYrJ6YOQ9bQ3cK7SOVTk5MlZ4ycicJbBBDNj7/R/lZRHNOKC5MAxsTn9yXxeU0PT
         PsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782623781; x=1783228581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+S8bRzJxBAeprTKinYbleVac8m0g3j4M+0B8UhmApPY=;
        b=Q1b+OM1Vslfck6P14sf9zzVJPuPNnYPFfGJf1977vDKENW9JiMXGT6ky178o9Hbc2a
         Y8jX7FcaC4XxkMDi/PRvYUz2qIpF3B3Hv0h2eDpsfJwSBmWBZrnSJ2qO/m8f6yGtj9yr
         yMlhpbXLJmWm9dexgoqOZXmkYUXEZHJ9jreZd3BZ1iW0AuzeFKnopkVYYU8IYfPblb9A
         ZDQY376Bs3YGKmzEWKbWgwr3hzS3sv2YO9mCBuwQ0YJJ4SAtK42pDLIa57GsIKMyghU2
         uB6VsPJoqcQjZC4xMJ7LBloKgCeujIQD1WUIM9BQEV/oVkerTaf4S/50aAM+EJCtJ3I8
         ifmA==
X-Gm-Message-State: AOJu0YxmAN9bZ7IrmW16K728UZPmPeEheSN0uG2woWllSJGpS8e6SY2/
	g2RAFMuhEwjRkJ71MHHEBeLmPOv6KAjswG/VNaAnWua/1UxoPHsD/NqLQCiiVDtN
X-Gm-Gg: AfdE7cmyh+VnSGPeLw67EHSiZsCu21jIoDxHu+SEPshmP1GRK0qYV90kEcm0L8Ln/lD
	iyk7YI88nkggNPUey9NFnGpjJV08VYDfNMenVNQGIkn8mzy1NjFQnTytS05iR1sHetq4CFUfn9I
	XmLxMZIyLmOX/MeNwlQWSufmQu/Vbkfh8pc8ZKjn7AGi7ei+Jc/xs9s3TzlxqErmOCbjxOORDn6
	9fFrCt0xyOP2heoRTgDSWQxFigrMyj1E4DP7bmge2n25roat6fA7fqujfPNMqp1aC0SKapx07rL
	CpZUv9n9jIYqZC2N74KgbhfQlo3UgsOnsbJpJ1eK+99rQrnw4AFjUvPSEJ/GcEFy7ZsdiuXGUz6
	tKpSp76slxTLtplEVJhNJ39ak9QdFu9Y2Ig5HJCed/DSwEuLB3EsDYXrbJWC5ERk=
X-Received: by 2002:a05:6a21:3a87:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3bf7e2aecb1mr3158422637.1.1782623781160;
        Sat, 27 Jun 2026 22:16:21 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm5793263a12.9.2026.06.27.22.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:16:20 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	hch@infradead.org,
	viro@zeniv.linux.org.uk,
	syzkaller@googlegroups.com,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v2 3/4] minix: convert file operations to iomap and add
Date: Sat, 27 Jun 2026 22:15:55 -0700
Message-ID: <44e53f18f7bc7d190c2676e66a0b77a40a62d448.1782619718.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782619718.git.jbingham@gmail.com>
References: <cover.1782619718.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace generic_file_read_iter and generic_file_write_iter with custom
minix_file_read_iter and minix_file_write_iter that dispatch to iomap
for both buffered and direct I/O.

Buffered writes now go through iomap_file_buffered_write instead of
the aops write_begin/write_end path (which no longer exists for
regular files). Buffered reads still use generic_file_read_iter
for the non-DIO case.

Direct I/O is implemented via iomap_dio_rw for both reads and writes.
minix_dio_read_iter takes a shared inode lock; minix_dio_write_iter
takes an exclusive lock, does generic_write_checks, and falls back
to buffered writes via iomap_file_buffered_write for the tail of a
DIO write that is not block-aligned. The minix_dio_write_end_io
callback updates i_size and marks the inode dirty.

minix_file_open sets FMODE_CAN_ODIRECT so the VFS allows O_DIRECT
opens, and splice_write is added to the file operations.

minix_setattr is exported (made non-static) so it can be shared by
the symlink inode operations in a subsequent patch.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/file.c  | 157 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/minix/minix.h |   2 +
 2 files changed, 153 insertions(+), 6 deletions(-)

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
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 77e503cca97f..76718f789369 100644
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

