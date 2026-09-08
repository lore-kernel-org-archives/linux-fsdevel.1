Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583C3DB300
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901518; cv=none; b=Kau+VmrUDujO6ZvEsU93Zec5Ew+jLKUwPQs5g3eWkw21szLy4e5PqcxGBchCvV7w13xI0hgEeB0WZ6/6+/se6+fhIOKCey9jEW80JVZhhgQytpZ3cwaqZLkVI5zpk2u53L9loxZfcgTKskEb9HnlNoRy13KHnFJje/Na2hIrdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901518; c=relaxed/simple;
	bh=42I35uP+T2RKk6zm3JgzNzDDhA62OAJCoQgZDD/A9vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p99hRBpq8aLe0VRlT6rljzmwpY/KMiAFDc0YK7oJGEu2Zo4aMqd9WhB2Tay3yJGh41e7WXkmd3bYDQ5F33Rv5f43rtEWLPnpmDGHX5s3gFs5ZQMdJlMWsPu2NPVkAVdgYdvZ4ZbHHMN1r4k/Rje/idaWWBFmTIdKbE9V3rCi730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=VXSChhAG; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="VXSChhAG"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c7e3a2332so3944068d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788901515; x=1789506315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qge724P+XpXSfbtGHt9SyIYo0wf5keByX8rsQYDNqZk=;
        b=VXSChhAGk3iPNoc4/AkNVtJRWjFzmgulgV/Az2m6gdBnufHjEdirRAUFgcrcHZxYAC
         iHYkPrv+DqVsCYS8d5em4+2REI5zThczoYiNe54UCaX08EWUPe74va7hCnaKbHqkSFae
         9Lx1ZswgC0occT3z+dKun7UAuuWUmnhaTw0a9kJkPGaH+aMF0Dgqf494wie4EenFiVp0
         3x11SmRbUqGrYrDCb9gSc/pPeRLMOCt+F0aOGAzWRmN1pS5kx/QxVMALRC032SsEfSDv
         eCTFun7Wa2Rff0Z/FkXR+fzsjLhaHw6ScB4B73WhyyV9MraPJdRfm6mEOEgDDtQXCaxy
         AlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901515; x=1789506315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qge724P+XpXSfbtGHt9SyIYo0wf5keByX8rsQYDNqZk=;
        b=SXSGgm1LQYhgVPCVfSLsR08T6GNLdumegLSw7PmsNpMDpj+ml9ja94LmcIeoLPQlC5
         gUso+yGgEPln9iqtQe8RuyeTiQJKqq1Tozh8Vs7ooqVFaNh0CKjECh39j4vJLkXEdcJw
         PU0HXcScQdnzCeuhPW2iXE6Z0YuwWBO3f8itXeCtJN+vTqJbvv2lgQdjruzMM5AR46KD
         IZ6kFmVljJ8lbnXNMOx93vjFSkXGCKCDkbSlU3XwSGtdcYxeIKtwPNsDXiGp5AlJ9fR4
         RM/MYLIGeZg5wXG9IJRWmFJJWsB4s2ygArRW0BOCHxbpirf5UkRnZscmABGu92X2jP7c
         EXFg==
X-Gm-Message-State: AFuF++n+hYO8Yo/Jxk24aUuBPM/gjHJ1HAZ2vigWyt4+H92tnKFr7GMS
	Ck+2XVYM+2/JlUzK2/fpFgNRMYr2zh9nN34BQ2pYJFxc9S2XNWrW/Sp5ZygVCwWY6TY=
X-Gm-Gg: AYBFou2A6Q2ZB5AK791ahiMUxDvYYdQBkV/yMMkCQq7UsD+o9ao0yZaAgkBUf3uBtag
	MfDdEDAa9gUNh7ri6+j0kak8sIszqOeTy8FfebVUw61BjIwsqmQ2BDaC2tWqq0Xi9uNMXbCSjM2
	NAMWC9EyiQBOGLtkvr+wM9SZ5htBqKP2Fh7SEjXukYYr4wgIMT+kia2Q0nEFY9UT9IiTEe5E3+E
	8U8QaqvrzWgxPwE6VAa522eGHvvIOcBgVJsC5vj03nq4RP5X3oBtD4yqS/1RLx1sSTeGacStcAk
	n/PswL86tc+peySMoIICjyeyioo6jaX5p0S+vzdR5XX/mEV1yxcgqSs2H1O7Lcj/f+1DTjcXa7J
	Ha7R9aJ5rON3PsgYEyc2aR2L8tYogAnD2hPUoBE2jeISG4d96OV+0qNkHSWUh8acd4BoNhBrsX9
	yWo2xBjGDFJPs/HjAClSI4XynH1Os/045gEqHMKfhrjvYYmZD0AL2Hdx4XtXiboaREn/Y+wNKEn
	ek1hcj0sf6/ailsCpQ4jS2om9KWuCOxZ8thFOcBcsurkLhz7G4iQrVEFIoAUOr61HORSGW1I9NU
	r7HqEJOVa6zeSijf
X-Received: by 2002:a53:a9d2:0:b0:66f:c1bc:c094 with SMTP id 956f58d0204a3-66fc1bcc696mr5739900d50.92.1788901510601;
        Tue, 08 Sep 2026 14:05:10 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1eca:212:86d0:4e87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb495eccesm11078129d50.18.2026.09.08.14.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:05:09 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 6/7] hfsplus: introduce iomap-based file_operations
Date: Tue,  8 Sep 2026 14:04:47 -0700
Message-ID: <20260908210448.296772-7-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908210448.296772-1-slava@dubeyko.com>
References: <20260908210448.296772-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements specialized iomap-based
hfsplus_file_llseek(), hfsplus_file_read_iter(),
and hfsplus_file_write_iter() methods.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/file.c | 181 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 176 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/file.c b/fs/hfsplus/file.c
index 509046aad0c6..5a5776881c3e 100644
--- a/fs/hfsplus/file.c
+++ b/fs/hfsplus/file.c
@@ -6,9 +6,11 @@
 #include <linux/fs.h>
 #include <linux/uio.h>
 #include <linux/mount.h>
+#include <linux/iomap.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
+#include "iomap.h"
 
 static int hfsplus_file_open(struct inode *inode, struct file *file)
 {
@@ -17,6 +19,7 @@ static int hfsplus_file_open(struct inode *inode, struct file *file)
 	if (!(file->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
 		return -EOVERFLOW;
 	atomic_inc(&HFSPLUS_I(inode)->opencnt);
+	file->f_mode |= FMODE_CAN_ODIRECT;
 	return 0;
 }
 
@@ -55,7 +58,6 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	error = file_write_and_wait_range(file, start, end);
 	if (error)
 		return error;
-	inode_lock(inode);
 
 	/*
 	 * Sync inode metadata into the catalog and extent trees.
@@ -114,15 +116,184 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
 		blkdev_issue_flush(inode->i_sb->s_bdev);
 
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
+					struct iov_iter *from,
+					unsigned int dio_flags)
+{
+	ssize_t ret;
+
+	ret = iomap_dio_rw(iocb, from,
+			   &hfsplus_write_iomap_ops,
+			   &hfsplus_write_dio_ops,
+			   dio_flags, NULL, 0);
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
+
+		i_size_write(inode, iocb->ki_pos);
+		err = hfsplus_iomap_cont_expand(inode, iocb->ki_pos);
+		if (err) {
+			i_size_write(inode, old_size);
+			ret = err;
+			goto unlock;
+		}
+		mark_inode_dirty(inode);
+	}
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		unsigned int dio_flags = 0;
+
+		if (iocb->ki_pos + iov_iter_count(iter) >
+		    HFSPLUS_I(inode)->phys_size)
+			dio_flags |= IOMAP_DIO_FORCE_WAIT;
+
+		ret = hfsplus_dio_write_iter(iocb, iter, dio_flags);
+	} else {
+		ret = iomap_file_buffered_write(iocb, iter,
+						&hfsplus_write_iomap_ops,
+						NULL, NULL);
+	}
+
+unlock:
 	inode_unlock(inode);
 
-	return error;
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
 }
 
 const struct file_operations hfsplus_file_operations = {
-	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
+	.llseek		= hfsplus_file_llseek,
+	.read_iter	= hfsplus_file_read_iter,
+	.write_iter	= hfsplus_file_write_iter,
 	.mmap_prepare	= generic_file_mmap_prepare,
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
-- 
2.43.0

