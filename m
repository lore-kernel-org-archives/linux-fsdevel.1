Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967352;
	b=o2ClQlL9XcqMnDMkVSYWWP/na/mo34KSc/Yx3RAroUWjGO2jBWKk1DAs2JT3QURdqCnY
	 Nxdnd+y/e8RItnPw8mU5NEcaB4znCIEg4DmZXp8ieCWs+vAJbVTGR01Q0A0+3XjgiK8rz
	 tET1emLdPSSAn0npgCBx6rQ4YfC85TMygLwytnz8uFkilhNyqOUee0EqEKW+gc0kjyK35
	 I1wf2YNUIf7PVR7+yRdQsocE0OP11qZnVy85qC601X/6i3AnmlZb3sK7PeqhwkPi/G4Zi
	 UIx7v8O6Fj0iHFRdLMey5Usyzz+DZy7eaDn1NuGuuQXvzm7W3IQEhW1hXVsxSGzIUjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967352;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EBv9/G2gh0fgS596X/B5LROGc00k54iyDs123AgGdag=;
	b=oGcJxHl+wFGxR0Ct8Y4v8KDLA6PrHgeXAVD4SPNwg6yKQLaMIeh41m8QX8Ze5L+HIkhl
	 nmtROcfKsrMvVakWL4ralr0bJGsYdiyHwRE8uO1TidQ9MFPAqdxdckyjn8cmcBj+Grtbb
	 /sACssVSR4nmzwOQEfW5qW6/1d4MjCCvpe5F5Bl8FAfDxSJWPnN1d4winCGGpqtEpDKJN
	 TUNZDf5wlArUWSJEUADRf5Zepv200U4ubgZAd7lrxAlT9SK74RGjRvupvbyKvyy1PKtXk
	 Q/XsEFgFVsBGuGbTJ3De2ymCynJdEqPs0ChWcnvnMM9RkoRqqOBktClHM9A2NRHj2rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=UNasUyIQ;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D573606A31C;
	Wed, 18 Nov 2026 02:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D573606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=UNasUyIQ
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 351A71210E9;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBv9/G2gh0fgS596X/B5LROGc00k54iyDs123AgGdag=;
	b=UNasUyIQNzbvX1K99y5KklMDQwBtLvPJrvHzH9sMH/GeHh7uYu4KfGmfx5VpVi57Qd+R0I
	IUAYa4HWbUAaw2/71hJbECpFQlE2qd9hNc8HTeVk8BZBUBGvDELz6vNlX/LTqkn/5aCkkC
	P+6VHh6YkVaHY00PYBuQTLJD+Fdx6u6nMHz/XXUvHthKCs9sg+RaPAP+SL8CYmz8SNp4ih
	hmhfZMiCSPI9oiYUGTW+vsnwzKUrjPq85o49w5qf9DjVsRRx6gTCZ4OCJ5CgIhPjwh4tVh
	IgrLdD2u8gNi2xYWP6OGbp0OCoBewexZpnORSoFgdmQ65vBTWr/h6n+Ffz49rQ==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/8] fat: add iomap direct I/O support
Date: Tue, 17 Nov 2026 23:01:43 -0300
Message-ID: <20261118020150.1023865-4-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated ->direct_IO() path with ->{read,write}_iter() and
iomap_dio_rw(). Add fat_file_open() to advertise direct I/O support.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/Kconfig |   1 -
 fs/fat/fat.h   |   1 +
 fs/fat/file.c  | 108 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fat/inode.c |  36 -----------------
 fs/fat/iomap.c |  24 +++++++++++
 5 files changed, 131 insertions(+), 39 deletions(-)

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index d31d7866c..7989c6bf0 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -4,7 +4,6 @@ config FAT_FS
 	select BUFFER_HEAD
 	select FS_IOMAP
 	select NLS
-	select LEGACY_DIRECT_IO
 	help
 	  If you want to use one of the FAT-based file systems (the MS-DOS and
 	  VFAT (Windows 95) file systems), then you must say Y or M here
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index e0cc46130..7f0be1423 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -493,6 +493,7 @@ extern const struct export_operations fat_export_ops_nostale;
 /* fat/iomap.c */
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next);
 DECLARE_IOMAP_ITER_NEXT(fat_iomap_next_bmap);
+extern const struct iomap_dio_ops fat_iomap_write_dio_ops;
 
 /* helper for printk */
 typedef unsigned long long	llu;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 60bb8b544..17638f283 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -201,11 +201,115 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	return blkdev_issue_flush(inode->i_sb->s_bdev);
 }
 
+static int fat_file_open(struct inode *inode, struct file *file)
+{
+	int err;
+
+	err = generic_file_open(inode, file);
+	if (err)
+		return err;
+
+	file->f_mode |= FMODE_CAN_ODIRECT;
+	return 0;
+}
+
+static ssize_t fat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
+		return generic_file_read_iter(iocb, iter);
+
+	inode_lock_shared(inode);
+	file_accessed(iocb->ki_filp);
+	ret = iomap_dio_rw(iocb, iter, fat_iomap_next, NULL, 0, NULL, 0);
+	inode_unlock_shared(inode);
+	return ret;
+}
+
+static ssize_t fat_file_dio_write_iter(struct kiocb *iocb,
+				       struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct msdos_inode_info *mi = MSDOS_I(inode);
+	unsigned int dio_flags = 0;
+	ssize_t ret;
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, iter);
+	if (ret <= 0)
+		goto out;
+
+	/* We do not support DIO writes which would need zeroing */
+	if (iocb->ki_pos + iov_iter_count(iter) > mi->mmu_private) {
+		ret = -ENOTBLK;
+		goto out;
+	}
+
+	ret = file_modified(iocb->ki_filp);
+	if (ret)
+		goto out;
+
+	/* Wait under the inode lock for size updates and partial-block zeroing. */
+	if (iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode) ||
+	    !IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
+			i_blocksize(inode)))
+		dio_flags |= IOMAP_DIO_FORCE_WAIT;
+
+	ret = iomap_dio_rw(iocb, iter, fat_iomap_next,
+			   &fat_iomap_write_dio_ops, dio_flags, NULL, 0);
+out:
+	inode_unlock(inode);
+	return ret;
+}
+
+static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
+					    struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, iter);
+	if (ret <= 0)
+		goto out;
+
+	ret = file_modified(iocb->ki_filp);
+	if (ret)
+		goto out;
+
+	ret = generic_perform_write(iocb, iter);
+out:
+	inode_unlock(inode);
+	return ret;
+}
+
+static ssize_t fat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	ssize_t ret;
+
+	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
+		return generic_file_write_iter(iocb, iter);
+
+	ret = fat_file_dio_write_iter(iocb, iter);
+	if (ret == -ENOTBLK)
+		ret = 0;
+	else if (ret < 0 || !iov_iter_count(iter))
+		return ret;
+
+	ret = direct_write_fallback(iocb, iter, ret,
+				    fat_file_write_iter_buffered(iocb, iter));
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
 
 const struct file_operations fat_file_operations = {
+	.open		= fat_file_open,
 	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
+	.read_iter	= fat_file_read_iter,
+	.write_iter	= fat_file_write_iter,
 	.mmap_prepare	= generic_file_mmap_prepare,
 	.release	= fat_file_release,
 	.unlocked_ioctl	= fat_generic_ioctl,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index fa38dfb90..fd9d9ce0b 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -254,41 +254,6 @@ static int fat_write_end(const struct kiocb *iocb,
 	return err;
 }
 
-static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	size_t count = iov_iter_count(iter);
-	loff_t offset = iocb->ki_pos;
-	ssize_t ret;
-
-	if (iov_iter_rw(iter) == WRITE) {
-		/*
-		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
-		 * so we need to update the ->mmu_private to block boundary.
-		 *
-		 * But we must fill the remaining area or hole by nul for
-		 * updating ->mmu_private.
-		 *
-		 * Return 0, and fallback to normal buffered write.
-		 */
-		loff_t size = offset + count;
-		if (MSDOS_I(inode)->mmu_private < size)
-			return 0;
-	}
-
-	/*
-	 * FAT need to use the DIO_LOCKING for avoiding the race
-	 * condition of fat_get_block() and ->truncate().
-	 */
-	ret = blockdev_direct_IO(iocb, inode, iter, fat_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
-		fat_write_failed(mapping, offset + count);
-
-	return ret;
-}
-
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	sector_t blocknr;
@@ -329,7 +294,6 @@ static const struct address_space_operations fat_aops = {
 	.writepages	= fat_writepages,
 	.write_begin	= fat_write_begin,
 	.write_end	= fat_write_end,
-	.direct_IO	= fat_direct_IO,
 	.bmap		= _fat_bmap,
 	.migrate_folio	= buffer_migrate_folio,
 	.swap_activate  = fat_swap_activate,
diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
index c3b48a820..3ab40bb2d 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -34,6 +34,10 @@ static int __fat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
+	/* Keep the same behavior of syncing metadata on direct writes */
+	if (flags & IOMAP_WRITE)
+		iomap->flags |= IOMAP_F_DIRTY;
+
 	/*
 	 * We need to separate normal data clusters and
 	 * uninitialized FALLOC_FL_KEEP_SIZE clusters.
@@ -91,3 +95,23 @@ static int fat_iomap_begin_bmap(struct inode *inode, loff_t offset,
 }
 
 DEFINE_IOMAP_ITER_NEXT(fat_iomap_next_bmap, fat_iomap_begin_bmap);
+
+static int fat_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
+				unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error)
+		return error;
+
+	if (size && i_size_read(inode) < iocb->ki_pos + size) {
+		i_size_write(inode, iocb->ki_pos + size);
+		mark_inode_dirty(inode);
+	}
+
+	return 0;
+}
+
+const struct iomap_dio_ops fat_iomap_write_dio_ops = {
+	.end_io = fat_dio_write_end_io
+};
-- 
2.43.0

