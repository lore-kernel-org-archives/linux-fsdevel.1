Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95B330659
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424100; cv=none; b=k7lmGj6o6TXkFbc/ZR9oxgWnwZHY5fwy8CGvgszsYhRMqbBtIq9f0Ey25NphyAJAUjjFo7sy6KUPhrjHdAykLIlMMCIfts+t0oNekw+Ntlqvry2rel7MFLt0eWDoNwh4/Y6/JiiMxV4zdyxvlO2ePv4qwZyfuxA3EYGN9ru/VwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424100; c=relaxed/simple;
	bh=yc/b0bj42Z4oPlHvetyL0VeC8AWKB381JYZ0kxX6ZcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNJ+pJwuH2eMnrWA+8IUkvmiWX+AubOWOdo3y96oO5jnvJ4dCN9Cv0ybo8l2wdqOOYvheEc/Fu590G98xcHVKYyaG740XOLwLtCMEFmG61BWNf9cxKdnhIhPVMctCcj0As3Ut3wySRMDq38uQO3ba60IZcDr+M5mb+YTvUGwZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/wEg4Rm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/wEg4Rm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845c38dee22so129893b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424097; x=1783028897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ACiaYAOt2dJJ7VRd/BTVPbeaQ8J4f1s9dNgnRb/KCU=;
        b=J/wEg4Rm4xSfjAe15tSybxZwHmxIyyLDfnCtvR1z1v5dubPjvrd/+FKIEZ5QWJL4Hg
         eSX9x4EExofLhaoDIKvQNlRjTW9ivQbk6HScCl+A6H6/dX9O7AmQTqEgt65P+xBuMIK6
         n+rU3AczmufuOKM02X9JOplMaFVEawq36WmS0+j7AoMQOPZ9FwxgF60wB89MH+icK6y8
         XFUOga70wOfUQnt02Rf21fYkhw+jXIzn2c6NtvEAr9CZh/sHaMGsnPRYTDbKi5/ztcc7
         N9DB3UgPLVSmWbxQbB6N+oYPtZqF4OPUjXJB+Ggz3Beuhwy4GxVhqVEC0Us8tkwC656k
         QPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424097; x=1783028897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ACiaYAOt2dJJ7VRd/BTVPbeaQ8J4f1s9dNgnRb/KCU=;
        b=hw2xEw6o2HqKOZwZoWI+fRr3ssIQWkLHq2puaAPvMSU2oFNx+PTYP2D7XV93mC1tyc
         l4P+eNTUJs82Po0md9TZy0LPRhAu4Ixe+XfQyVfJeBxtMFEXdob1i9vZKslnNrtyljhZ
         W0BBgykYl64uw+KfYdXhpNlIqIe2Dag/+DtZfUJDVvV9/u5jz3vAQ/azUkTDlozuFkew
         c6Xq+sqq+FUHUcMVeysfxPu6nDVkeLJuce6neT1tb4igWnnp5MoKp/P7Wi4kFqE7fwzK
         gYr76mGrOQgyJns2c77x/Jcgbvur8hma09mWH+ISSfwDMbJROBUGU/M82b+SyDb7kycO
         hc3A==
X-Gm-Message-State: AOJu0Yzg3ZgnuDSfPa1yGeyXoxccNMjIFoRN139Ut11AvgXcxc3VMcsK
	fHIhPFB8NUb17Ho4EZmAdQmORaq4swT+gc+OvO6iOp4T1K7ur5Aftygmwnj71A==
X-Gm-Gg: AfdE7cnn1YBFEgxV/fb3Y4LmnzIDzVXdf8kNJa7dDggq3HboEgRmFhOr+q4eVdnqcyl
	k9t53YzPHzVi0jK8I2xgz+eeA6W7yUf/KqHGnrRCua7zeDp5yZaveHyI/vopDzuCG1VSLdJz2sl
	JAraBIwQxn6BGkZuvIKnkLADbRHJJko8AuMwtUTBO4phJur9KmZK7hqTjDB+1Tp0WF0iiWazmlD
	azjYDJ1W4s6gZe3ht9HtNr9hjtshs7KtPfUJM0EAb8BH6mw0u9nkrkI4d+lPxWHBAvsyoTP/Lpj
	4adigBp+QVVCDSllUHqsKKnOZM6UFd0BLEl6U78cgdLjjTvNH6XDM4bZXeOwIUnG7h4YkECRZm4
	DOXyt3uUO2caoyHCVp7MX5h5JtYBCtqtcIHd1WKG1IJeJd/DLQ3XfF9pTJlOMk/Y=
X-Received: by 2002:a05:6a00:2295:b0:845:c5d5:3743 with SMTP id d2e1a72fcca58-845c5d53b22mr570229b3a.28.1782424097396;
        Thu, 25 Jun 2026 14:48:17 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c39fsm6192134b3a.55.2026.06.25.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:48:17 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH 3/3] minix: convert file operations to iomap and add direct I/O
Date: Thu, 25 Jun 2026 14:48:05 -0700
Message-ID: <7cfd66f4516a11fc06dbb18186538a0ef458f455.1782422707.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782422707.git.jbingham@gmail.com>
References: <cover.1782422707.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the generic file read/write iterators with iomap-aware
versions.  Buffered reads go through iomap_bio_read_folio (via the
aops read_folio), and buffered writes now use iomap_file_buffered_write
instead of the generic_file_write_iter path.

Add direct I/O support: minix_dio_read_iter and minix_dio_write_iter
implement DIO read and write paths using iomap_dio_rw, with a
write_end_io callback that updates i_size and marks the inode dirty.
Unaligned or extending DIO writes fall back to buffered I/O via
iomap_file_buffered_write after the DIO portion completes.

The minix_file_open hook sets FMODE_CAN_ODIRECT so that the VFS allows
O_DIRECT opens.  splice_write is added via iter_file_splice_write.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/file.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/fs/minix/file.c b/fs/minix/file.c
index 86e5943cd2ff..1f4217115401 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -17,17 +17,162 @@ int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
 
 static int minix_setattr(struct mnt_idmap *idmap,
-- 
2.47.3

