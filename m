Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465055;
	b=XDRRczMLDYUHcQFVKBF+/he2uk8RuseNDj6ajOQx4qezurA/G0OtlsgIB5ASTIhuaK8/
	 DMnPS0/drPCAb1etIpOJTvOFfWdC3iSyj+uZVzpI20BcWGOEvWanLz7vV9r3s6JS+MWEm
	 TUvtcbHypfmGRepbSzksL1ipBYyzJ1bWxBWoM33QzFujeU+DsJP9mDiy2cZh54q6NryUC
	 6JH+0dAyEO3/F1XpDCzatnyYCW2kQGjjChWaN1pJsgCAVk6CxhIF1nPupCrjlJszECecF
	 mGXKcuzZLIb3ovK3YSCkZnq4QqBwflPZ5VjIcZBihf0Xudyx0xv+u+O2C0Op+sYBsGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465055;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y5kGJgaPGLkDdtKNEhQvwj0VFZ66SbjhczVs6BeoDp0=;
	b=nVFO/V1eSk/577kSP3XQzOYXQ9ljU+nB2+SpLsSf5IKorIlGRPUcWPGPFmrdNwsQCffq
	 BwkLGMbjwjVn/99k4g04cRci43K5XYwnFPCrF3S1obe0fzFE+31hFKwVOo4eAj8JlA8vN
	 XFcZd1ksM+K74scZmsI6nW2kIT4Xk6x3wHAe8EuyIAt5bgknqbaL+8iGr/T/yQ1uCw5r0
	 CbRDphXsfpSE7Sbt/LncL1HZQnrbXaOhBSqEZA48xsllaKogpbAZPhGBKyhBIlmRMBKTg
	 yEKSYfjQ2eFZZ2Oj6c2VXzQnz42LnhDd8FtBrOhip99odAcRzw4IHuWywJ4TUTNMWKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=KKxB8J72;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216E606A31D;
	Sat, 31 Oct 2026 16:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8216E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=KKxB8J72
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 3FF69120369;
	Sat, 31 Oct 2026 13:43:49 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5kGJgaPGLkDdtKNEhQvwj0VFZ66SbjhczVs6BeoDp0=;
	b=KKxB8J72TlC/zc6+wJZUKlpbXLT4shm2XyUzold/HK973zvdEb6RQupWsusOXPjKQyPzG0
	0T6WWJ+0xy244g5HS1zBAfIphp9AJqnX/ZOR44rlaLeepPo4BSuHh3kOHr+H5kfLfFelnK
	COzmxBKsE4ZY/+O0KsFVR5u6xA0nz1cI1NXwPbQ5cQdSZ/CfFJafCaTXC6Glrr7zXT0Awx
	7wUEYECv+WiFl4bDO3NWNC8jBsyfxGyt+LmzPMjIysNt7rAHC/dsAIdqiQTZT5P7g/QeLw
	q+WIU2fZOIYJ45tZxVvWuGL8hqYZTreR/imhfdu13vY4E86CBWmbXNSNn4tmbQ==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 3/8] fat: add iomap direct I/O support
Date: Sat, 31 Oct 2026 13:43:21 -0300
Message-ID: <20261031164326.278125-4-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
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
 fs/fat/file.c  | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fat/inode.c |  36 ---------------
 fs/fat/iomap.c |  24 ++++++++++
 5 files changed, 142 insertions(+), 39 deletions(-)

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index d31d7866ce19..7989c6bf0fb6 100644
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
index 81c454f8a78a..e14d6d9a6ac1 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -492,6 +492,7 @@ extern const struct export_operations fat_export_ops_nostale;
 /* fat/iomap.c */
 extern const struct iomap_ops fat_iomap_ops;
 extern const struct iomap_ops fat_iomap_bmap_ops;
+extern const struct iomap_dio_ops fat_iomap_write_dio_ops;
 
 /* helper for printk */
 typedef unsigned long long	llu;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index c27d4e7f698c..177a26186ddc 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -201,11 +201,126 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
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
+	ret = iomap_dio_rw(iocb, iter, &fat_iomap_ops, NULL, 0, NULL, 0);
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
+	ret = iomap_dio_rw(iocb, iter, &fat_iomap_ops,
+			   &fat_iomap_write_dio_ops, dio_flags, NULL, 0);
+out:
+	inode_unlock(inode);
+	return ret;
+}
+
+static ssize_t fat_file_write_iter_buffered_fallback(struct kiocb *iocb,
+						     struct iov_iter *iter)
+{
+	ssize_t ret;
+	loff_t end, offset;
+	int err;
+
+	iocb->ki_flags &= ~IOCB_DIRECT;
+	ret = generic_file_write_iter(iocb, iter);
+	if (ret <= 0)
+		return ret;
+
+	offset = iocb->ki_pos - ret;
+	end = iocb->ki_pos - 1;
+	err = filemap_write_and_wait_range(iocb->ki_filp->f_mapping, offset,
+					   end);
+	if (err)
+		return err;
+
+	invalidate_mapping_pages(iocb->ki_filp->f_mapping,
+				 offset >> PAGE_SHIFT,
+				 end >> PAGE_SHIFT);
+
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
+	else if (ret < 0)
+		return ret;
+
+	/* Fall back to buffered I/O if we could not do DIO */
+	if (iov_iter_count(iter)) {
+		ssize_t done;
+
+		done = fat_file_write_iter_buffered_fallback(iocb, iter);
+		if (done < 0)
+			return done;
+		ret += done;
+	}
+
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
index 3885ddb916bd..953706aab68b 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -253,41 +253,6 @@ static int fat_write_end(const struct kiocb *iocb,
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
@@ -328,7 +293,6 @@ static const struct address_space_operations fat_aops = {
 	.writepages	= fat_writepages,
 	.write_begin	= fat_write_begin,
 	.write_end	= fat_write_end,
-	.direct_IO	= fat_direct_IO,
 	.bmap		= _fat_bmap,
 	.migrate_folio	= buffer_migrate_folio,
 	.swap_activate  = fat_swap_activate,
diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
index 7977147889bb..8a697deba9d4 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -26,6 +26,10 @@ static int __fat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
+	/* Keep the same behavior of syncing metadata on direct writes */
+	if (flags & IOMAP_WRITE)
+		iomap->flags |= IOMAP_F_DIRTY;
+
 	/*
 	 * We need to separate normal data clusters and
 	 * uninitialized FALLOC_FL_KEEP_SIZE clusters.
@@ -93,3 +97,23 @@ static DEFINE_IOMAP_ITER_NEXT(fat_iomap_next_bmap, fat_iomap_begin_bmap);
 const struct iomap_ops fat_iomap_bmap_ops = {
 	.iomap_next = fat_iomap_next_bmap
 };
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

