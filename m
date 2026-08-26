Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A171495026
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785019; cv=none; b=ZOX9a7Jf2V1Gvqxwz96f09Y8Hq24nNNYwpVibxnY6xrRN8szRknIe99irnq5WbHxwRWwsBAapeJs87ml7r0e5nwPfuSTxtB3QZzqwT3534+Vbzut+yS/wiz5ahAYCKhJ0PZl54mjobmL4QsKuxnqFbhXojQJsXNyhd+IHTMYqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785019; c=relaxed/simple;
	bh=6vpLcQkgDI2tzjPlMKOVRnIQU9r42tPpnxYdp8U75og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO8Vm53dvL9G9kOlQLvlHrhCZ7+9yyHfxxEKopnI+GSwPd60f+l7dC+WSx7XfGFl6a9G3IDMzBPPHfu1xWy5A6PaeBqlawl33QTOCjfdvCFTQJH3I2TjkA9hZYMUtBeuoxPp32QGqAR/GiY8FrBUVMqQQRTaJTaoMV2G7Ec2p64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=JBhEJPIV; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="JBhEJPIV"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c711b7f2aso2400279d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787785013; x=1788389813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sjyfkm5WCr0LaWLrsLCSgH3Ca5DAAIcnacc2lE0s2iM=;
        b=JBhEJPIVmUHrqeBLvd3MQ9+Co1F2Xjwg2Wget2P4fMHt9zMMbLHuFHAX/8eej/XW8T
         Rzsnmhh0lrgItTh2AmNdnNqRSjVXFMJwtz3jzuynYPqVyR9EZ4IA4y+jljw9OZrEOWKJ
         WzMI8qh3fyD4W53VNFnZxGG/e3AW/nEgYxfv+tjFtvwmbdWR2xarmak0WluD4qqOgRhn
         xf59LIO5MdQzijKOLvwPovooOMXd1XVmAmvsj4f2pgzx+BU/orirMg9pDYjmuFszZxdw
         JatpEBGqHof8fPFr39KRx/U9W5+TulUXGhx9/SygjqUu5CjSc0+KEaooKYLcx99iqwn7
         NJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785013; x=1788389813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sjyfkm5WCr0LaWLrsLCSgH3Ca5DAAIcnacc2lE0s2iM=;
        b=EvO1C+kAuWreV3gxsr8SRjUOWjpd7VUOKE3lPhVEzYDnSN8/0Tvr5DRGcMfzGF0Z91
         z5zzHXn5T/ievhaTnoOadeHxloNklHBfEXqEJOjWoB7Kb4MvxF22HER1nYx5nnZMUALP
         +FXQx/pWhhpZxiQuq8Iq7HDNT2fofTwfB0ls5Y99MQMTJfr7fIZwezY0ZHzJbZiYETL7
         55X5p9cW+Pl0SeBx7tEFZ0uZDTMRZvPR9f1eq1a7EopKeBsA8gNJAmwfwkHmeuA5AShO
         7EXcHgru6C8vfCoh8mJE7YebubikhY4QJ2TKPyD6YNTvFftP3k1tVUiE6+ZSf+XVnjLh
         351w==
X-Gm-Message-State: AFuF++k7k2YQ2FlV+zYZXU77w1QcgmXTcosr97QVPeB8jTIop9yZAAz+
	WqqTRZIKvoSQga9+JAD17IHvXi2dwN4a3B1UbuiQaQqhGePVR8qprk8v+ALzOp5/vVI=
X-Gm-Gg: AR+sD11p2qB/GJim+ZSatCaFmpcAosZKdiK6UmmFTOUwf8Tdh88AfyVjAQFdxl7ieDL
	YgHzVkSypavCQFALz/VWc2SYe2E02qN++sXy4FpqwqEU2+0mnhWf2TLDEAyfOtl9H6YKJ5MYywe
	NlPLCxsRXrGcS81QOEd1uE6+fXkg+1wTo9LuRL1xEh3p7NAaZEBv/HiHPpzeGe3qJ/3BoITClHl
	wLA3ToSG/K8HcuCKb5gL01qOqu8tQnIJnKjity5xAWlO2DVDQ3eRsVbWOHXUeha2fz1rxUQ6gEz
	xroLH78LN/E06OzmC4uJkp0L51+/BY90y1wHOwvl68Ure5rlUvImyVjBNWWP8LnKiyTJIGI+9oE
	DsUqSla1AmLyWNvvxwDOT5Ao9MC/yrgO3KQIHpEkm50r0+K+HYIT0Hc559pcjhLgYEiGcgfI+dz
	XyEnCcscnUTYzNYAGMDNzSMV6HrMJUcCeUVwYtsndybHmtukjS176328LIGGr8Lf9SuO0p8bPzm
	szwQvzk0OAw9lfiIct0BsCKIArY5TnbHLz/u/3frgInHyBzqVGBnva9qsbP8u/WZwH+5uKS/490
	NQd/jBmxmKh/ElyBpHHmovTr0MS8
X-Received: by 2002:a05:690e:4888:10b0:66e:3fbc:8a49 with SMTP id 956f58d0204a3-66e3fbc8c9amr128279d50.22.1787785013229;
        Wed, 26 Aug 2026 15:56:53 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:52 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 6/7] hfsplus: introduce iomap-based file_operations
Date: Wed, 26 Aug 2026 15:56:13 -0700
Message-ID: <20260826225614.486112-7-slava@dubeyko.com>
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

This patch implements specialized iomap-based
hfsplus_file_llseek(), hfsplus_file_read_iter(),
and hfsplus_file_write_iter() methods.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/file.c | 184 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/file.c b/fs/hfsplus/file.c
index 509046aad0c6..82678488fb05 100644
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
@@ -114,15 +116,187 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
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
+					struct iov_iter *from)
+{
+	ssize_t ret;
+
+	ret = iomap_dio_rw(iocb, from,
+			   &hfsplus_write_iomap_ops,
+			   &hfsplus_write_dio_ops,
+			   0, NULL, 0);
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
+		loff_t new_size = iocb->ki_pos;
+
+		if (iocb->ki_flags & IOCB_DIRECT) {
+			new_size = max_t(loff_t, new_size,
+					  HFSPLUS_I(inode)->phys_size);
+		}
+
+		i_size_write(inode, new_size);
+		err = hfsplus_iomap_cont_expand(inode, iocb->ki_pos);
+		if (err) {
+			i_size_write(inode, old_size);
+			ret = err;
+			goto unlock;
+		}
+		mark_inode_dirty(inode);
+	} else if ((iocb->ki_flags & IOCB_DIRECT) &&
+		   HFSPLUS_I(inode)->phys_size > i_size_read(inode)) {
+		i_size_write(inode, HFSPLUS_I(inode)->phys_size);
+		mark_inode_dirty(inode);
+	}
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = hfsplus_dio_write_iter(iocb, iter);
+	else {
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

