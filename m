Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEF3F7886
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525883; cv=none; b=Z/whZKmPWK/XvVMr/xi9Vat7ZmLAqAEGUHirjusrKMFVO+42aZ23YRpZMZncXBoorf6MojT9dYlr+fJADAKXKrVhKEKT7a5pUQSaFOx5hUzsdx5ZMKT4R9W2SLXdC4ehZ1G9dSPUl0BWXFYxSHtHXl+2QughFpFtwC1IPR7RHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525883; c=relaxed/simple;
	bh=cYmwijRSWEkChjZB3A69pHDwuOKBI1NSXYm+q51eIVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uABE6ePOytVxDFNSNTFgam0wz3gUYlP1vLznuBMHXcX+a7Mi0IxlcalGKMOXlle9MEsmhWAN6Bf+M/akzz3jX+syEailamVCkpY3JERjYUcMeC9r4h3qN2/7fjOLiiDI6QpnFrvyYNHd9l3D0vR+aIvqpSYl9o+Du8AXbEVJSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad617d5b80so5553495ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 04:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525879; x=1775130679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XuQRbSv3z47aU2fC0981YNK/SPU9uEYyAX2yAfH9TH0=;
        b=jy22JD8rSFlIlXeElseltQrwaMMcEHUDJtIp2PipUejko9MsqjMmcRHklislrYxtl5
         Tj4mO58J8lf0kf8VNvU7zZqQX44Kws9SRpYo5jO84xgreMenxaPpaK1An5DhbJdEjYzS
         nOFN6XJMi/4+s6Y2HIrN+y9OI1P6wSl0EyK6wy1xJXEEdSIC2wxNlxLVOnmJYXkxyuGU
         5hUeEAaMPE7K0z+YkFbVJiV9CIgA7HFI47M2xxAjtwegMXhtypRC9fUHYA/7AgjkLtL+
         APRMXWWDMXLxVfWL2HHs/Lj1JP/cQZUUbznc7JrP3jBBqpGkBm8r2WAXUFCDPh4MhuXi
         QQZw==
X-Gm-Message-State: AOJu0Yz1eAHPaiJw8c7G0GymGpkQsK6cMAADzsYF/3/PcTBAYSc5aG31
	vgHfGzislMopvEbFBnCOI4rVwvlLq+5/EGJyWgXzm0ZDFYC+KscQvdaI3nH8fw==
X-Gm-Gg: ATEYQzx1KXsih0oBWctiHboF9oBdzY8Asjiy2T9RB/Kt/kW2onvqsu8qROfXAkD3HQl
	Js5Mk72N9Ul786yvdh/L5FO5U4UohM8qOzsvc/OitVeQ/puONtlGodasRHqaMtc2V+ZNICzBouv
	pVjc4ZC5/bRyub36TFNCSy3UyXu8liin+N1vHBgYjvcXz0nzg0SbYuKWnVOFO9XKkRAu2zHu9QO
	QHQIZwXFCf3sXTyfyylalnhbcS2a+vXkBpUWKeDQAXkMC7NcxWY5aBpIUzYnfytmS5cz6UjFP7c
	tS0ebZNxdzxGeeJH9p1K8a7bPkh9pIHNh/mQ4K09epVHMwO7S3DrUt0T6AKcEsY61ftOJJFnmR1
	tADySMHFq2cfjQi1I1IGCqCY2mfUzT7oLAQfbF6sQPuVHHKY0Xd4VaxsAdYA3M9ckc0qrNOmctQ
	zseiJRRBs/Qx85z3AaT1fxzhV2V2XxGyIE5HlpwA==
X-Received: by 2002:a17:903:230c:b0:2b0:b41e:c5c3 with SMTP id d9443c01a7336-2b0b41ed524mr67713565ad.29.1774525878712;
        Thu, 26 Mar 2026 04:51:18 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm28425285ad.2.2026.03.26.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:51:18 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	hch@lst.de,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 3/5] exfat: add iomap buffered I/O support
Date: Thu, 26 Mar 2026 20:50:43 +0900
Message-Id: <20260326115045.9525-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260326115045.9525-1-linkinjeon@kernel.org>
References: <20260326115045.9525-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add full buffered I/O support using the iomap framework to the exfat
filesystem. This replaces the old exfat_get_block(), exfat_write_begin(),
exfat_write_end(), and exfat_block_truncate_page() functions with their
iomap equivalents. Buffered writes now use iomap_file_buffered_write(),
read uses iomap_bio_read_folio() and iomap_bio_readahead(), and writeback
is handled through iomap_writepages().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/exfat_fs.h |   3 +-
 fs/exfat/file.c     | 160 +++++++++++++++++++--------
 fs/exfat/inode.c    | 261 ++++----------------------------------------
 3 files changed, 142 insertions(+), 282 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 860f2e438b63..54da001a8f55 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -87,7 +87,7 @@ enum {
 /*
  * helpers for cluster size to byte conversion.
  */
-#define EXFAT_CLU_TO_B(b, sbi)		((b) << (sbi)->cluster_size_bits)
+#define EXFAT_CLU_TO_B(b, sbi)		((loff_t)(b) << (sbi)->cluster_size_bits)
 #define EXFAT_B_TO_CLU(b, sbi)		((b) >> (sbi)->cluster_size_bits)
 #define EXFAT_B_TO_CLU_ROUND_UP(b, sbi)	\
 	(((b - 1) >> (sbi)->cluster_size_bits) + 1)
@@ -551,7 +551,6 @@ struct inode *exfat_iget(struct super_block *sb, loff_t i_pos);
 int __exfat_write_inode(struct inode *inode, int sync);
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
 void exfat_evict_inode(struct inode *inode);
-int exfat_block_truncate_page(struct inode *inode, loff_t from);
 int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		unsigned int *clu, unsigned int *count, int create,
 		bool *balloc);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 2a9263b4433b..5f85e2e0a71e 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -337,7 +337,18 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    attr->ia_size > i_size_read(inode)) {
+		loff_t old_size = i_size_read(inode);
+
 		error = exfat_cont_expand(inode, attr->ia_size);
+		if (!error && attr->ia_size > old_size &&
+		    old_size % PAGE_SIZE != 0) {
+			loff_t len = min_t(loff_t,
+					round_up(old_size, PAGE_SIZE) - old_size,
+					attr->ia_size - old_size);
+			error = iomap_zero_range(inode, old_size, len,
+					NULL, &exfat_read_iomap_ops,
+					&exfat_iomap_folio_ops, NULL);
+		}
 		if (error || attr->ia_valid == ATTR_SIZE)
 			return error;
 		attr->ia_valid &= ~ATTR_SIZE;
@@ -384,7 +395,10 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	exfat_truncate_inode_atime(inode);
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		error = exfat_block_truncate_page(inode, attr->ia_size);
+		inode_dio_wait(inode);
+		error = iomap_truncate_page(inode, attr->ia_size, NULL,
+				&exfat_read_iomap_ops,
+				&exfat_iomap_folio_ops, NULL);
 		if (error)
 			goto out;
 
@@ -619,10 +633,14 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-	err = __generic_file_fsync(filp, start, end, datasync);
+	err = file_write_and_wait_range(filp, start, end);
 	if (err)
 		return err;
 
+	if (!datasync)
+		err = __exfat_write_inode(inode, 1);
+	write_inode_now(inode, !datasync);
+
 	err = sync_blockdev(inode->i_sb->s_bdev);
 	if (err)
 		return err;
@@ -648,12 +666,56 @@ int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsync)
 				NULL);
 		if (!ret && bsync)
 			ret = filemap_write_and_wait_range(inode->i_mapping,
-					old_valid_size, off - 1);
+							   old_valid_size,
+							   off - 1);
 	}
 
 	return ret;
 }
 
+static ssize_t exfat_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t ret;
+
+	ret = iomap_dio_rw(iocb, from, &exfat_write_iomap_ops,
+			&exfat_write_dio_ops, 0, NULL, 0);
+	if (ret == -ENOTBLK)
+		ret = 0;
+	else if (ret < 0)
+		goto out;
+
+	if (iov_iter_count(from)) {
+		loff_t offset, end;
+		ssize_t written;
+		int ret2;
+
+		offset = iocb->ki_pos;
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		written = iomap_file_buffered_write(iocb, from,
+				&exfat_write_iomap_ops, &exfat_iomap_folio_ops,
+				NULL);
+		if (written < 0) {
+			ret = written;
+			goto out;
+		}
+
+		ret += written;
+		end = iocb->ki_pos + written - 1;
+		ret2 = filemap_write_and_wait_range(iocb->ki_filp->f_mapping,
+				offset, end);
+		if (ret2) {
+			ret = -EIO;
+			goto out;
+		}
+		if (!ret2)
+			invalidate_mapping_pages(iocb->ki_filp->f_mapping,
+					offset >> PAGE_SHIFT,
+					end >> PAGE_SHIFT);
+	}
+out:
+	return ret;
+}
+
 static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
@@ -662,6 +724,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	loff_t pos = iocb->ki_pos;
 	loff_t valid_size;
+	int err;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
@@ -677,34 +740,18 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret <= 0)
 		goto unlock;
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		unsigned long align = pos | iov_iter_alignment(iter);
-
-		if (!IS_ALIGNED(align, i_blocksize(inode)) &&
-		    !IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev))) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-	}
-
-	if (pos > valid_size) {
-		ret = exfat_extend_valid_size(inode, pos, false);
-		if (ret < 0 && ret != -ENOSPC) {
-			exfat_err(inode->i_sb,
-				"write: fail to zero from %llu to %llu(%zd)",
-				valid_size, pos, ret);
-		}
-		if (ret < 0)
-			goto unlock;
+	err = file_modified(iocb->ki_filp);
+	if (err) {
+		ret = err;
+		goto unlock;
 	}
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		ret = iomap_dio_rw(iocb, iter, &exfat_write_iomap_ops,
-				&exfat_write_dio_ops, 0, NULL, 0);
-		if (ret == -ENOTBLK)
-			ret = 0;
-	} else
-		ret = __generic_file_write_iter(iocb, iter);
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = exfat_dio_write_iter(iocb, iter);
+	else
+		ret = iomap_file_buffered_write(iocb, iter,
+				&exfat_write_iomap_ops, &exfat_iomap_folio_ops,
+				NULL);
 	if (ret < 0)
 		goto unlock;
 
@@ -737,6 +784,7 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		return -EIO;
 
 	inode_lock_shared(inode);
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		size_t count = iov_iter_count(iter);
 
@@ -760,28 +808,22 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
 {
-	int err;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t new_valid_size;
+	vm_fault_t ret;
 
 	if (!inode_trylock(inode))
 		return VM_FAULT_RETRY;
 
-	new_valid_size = ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
-	new_valid_size = min(new_valid_size, i_size_read(inode));
-
-	if (ei->valid_size < new_valid_size) {
-		err = exfat_extend_valid_size(inode, new_valid_size, false);
-		if (err < 0) {
-			inode_unlock(inode);
-			return vmf_fs_error(err);
-		}
-	}
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vmf->vma->vm_file);
 
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	ret = iomap_page_mkwrite(vmf, &exfat_mkwrite_iomap_ops, NULL);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+	sb_end_pagefault(inode->i_sb);
 	inode_unlock(inode);
 
-	return filemap_page_mkwrite(vmf);
+	return ret;
 }
 
 static const struct vm_operations_struct exfat_file_vm_ops = {
@@ -797,6 +839,21 @@ static int exfat_file_mmap_prepare(struct vm_area_desc *desc)
 	if (unlikely(exfat_forced_shutdown(file_inode(desc->file)->i_sb)))
 		return -EIO;
 
+	if (vma_desc_test_flags(desc, VMA_WRITE_BIT)) {
+		struct inode *inode = file_inode(file);
+		loff_t from, to;
+		int err;
+
+		from = ((loff_t)desc->pgoff << PAGE_SHIFT);
+		to = min_t(loff_t, i_size_read(inode),
+				from + vma_desc_size(desc));
+		if (EXFAT_I(inode)->valid_size < to) {
+			err = exfat_extend_valid_size(inode, to, false);
+			if (err)
+				return err;
+		}
+	}
+
 	file_accessed(file);
 	desc->vm_ops = &exfat_file_vm_ops;
 	return 0;
@@ -811,7 +868,24 @@ static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,
 	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 
+static int exfat_file_open(struct inode *inode, struct file *filp)
+{
+	int err;
+
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	err = generic_file_open(inode, filp);
+	if (err)
+		return err;
+
+	filp->f_mode |= FMODE_CAN_ODIRECT;
+
+	return 0;
+}
+
 const struct file_operations exfat_file_operations = {
+	.open		= exfat_file_open,
 	.llseek		= generic_file_llseek,
 	.read_iter	= exfat_file_read_iter,
 	.write_iter	= exfat_file_write_iter,
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 2985b5d736f6..c53ae9293cfe 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -13,9 +13,11 @@
 #include <linux/uio.h>
 #include <linux/random.h>
 #include <linux/iversion.h>
+#include <linux/iomap.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
+#include "iomap.h"
 
 int __exfat_write_inode(struct inode *inode, int sync)
 {
@@ -76,15 +78,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
 		on_disk_size = 0;
 
 	ep2->dentry.stream.size = cpu_to_le64(on_disk_size);
-	/*
-	 * mmap write does not use exfat_write_end(), valid_size may be
-	 * extended to the sector-aligned length in exfat_get_block().
-	 * So we need to fixup valid_size to the writren length.
-	 */
-	if (on_disk_size < ei->valid_size)
-		ep2->dentry.stream.valid_size = ep2->dentry.stream.size;
-	else
-		ep2->dentry.stream.valid_size = cpu_to_le64(ei->valid_size);
+	ep2->dentry.stream.valid_size = cpu_to_le64(ei->valid_size);
 
 	if (on_disk_size) {
 		ep2->dentry.stream.flags = ei->flags;
@@ -246,155 +240,10 @@ int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	return 0;
 }
 
-static int exfat_get_block(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh_result, int create)
-{
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct super_block *sb = inode->i_sb;
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
-	int err = 0;
-	unsigned long mapped_blocks = 0;
-	unsigned int cluster, sec_offset, count;
-	sector_t last_block;
-	sector_t phys = 0;
-	sector_t valid_blks;
-	loff_t i_size;
-	bool balloc;
-
-	mutex_lock(&sbi->s_lock);
-	i_size = i_size_read(inode);
-	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size, sb);
-	if (iblock >= last_block && !create)
-		goto done;
-
-	/* Is this block already allocated? */
-	count = EXFAT_B_TO_CLU_ROUND_UP(bh_result->b_size, sbi);
-	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
-			&cluster, &count, create, &balloc);
-	if (err) {
-		if (err != -ENOSPC)
-			exfat_fs_error_ratelimit(sb,
-				"failed to bmap (inode : %p iblock : %llu, err : %d)",
-				inode, (unsigned long long)iblock, err);
-		goto unlock_ret;
-	}
-
-	if (cluster == EXFAT_EOF_CLUSTER)
-		goto done;
-
-	/* sector offset in cluster */
-	sec_offset = iblock & (sbi->sect_per_clus - 1);
-
-	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
-	mapped_blocks = ((unsigned long)count << sbi->sect_per_clus_bits) - sec_offset;
-	max_blocks = min(mapped_blocks, max_blocks);
-
-	map_bh(bh_result, sb, phys);
-	if (buffer_delay(bh_result))
-		clear_buffer_delay(bh_result);
-
-	/*
-	 * In most cases, we just need to set bh_result to mapped, unmapped
-	 * or new status as follows:
-	 *  1. i_size == valid_size
-	 *  2. write case (create == 1)
-	 *  3. direct_read (!bh_result->b_folio)
-	 *     -> the unwritten part will be zeroed in exfat_direct_IO()
-	 *
-	 * Otherwise, in the case of buffered read, it is necessary to take
-	 * care the last nested block if valid_size is not equal to i_size.
-	 */
-	if (i_size == ei->valid_size || create || !bh_result->b_folio)
-		valid_blks = EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb);
-	else
-		valid_blks = EXFAT_B_TO_BLK(ei->valid_size, sb);
-
-	/* The range has been fully written, map it */
-	if (iblock + max_blocks < valid_blks)
-		goto done;
-
-	/* The range has been partially written, map the written part */
-	if (iblock < valid_blks) {
-		max_blocks = valid_blks - iblock;
-		goto done;
-	}
-
-	/* The area has not been written, map and mark as new for create case */
-	if (create) {
-		set_buffer_new(bh_result);
-		ei->valid_size = EXFAT_BLK_TO_B(iblock + max_blocks, sb);
-		mark_inode_dirty(inode);
-		goto done;
-	}
-
-	/*
-	 * The area has just one block partially written.
-	 * In that case, we should read and fill the unwritten part of
-	 * a block with zero.
-	 */
-	if (bh_result->b_folio && iblock == valid_blks &&
-	    (ei->valid_size & (sb->s_blocksize - 1))) {
-		loff_t size, pos;
-		void *addr;
-
-		max_blocks = 1;
-
-		/*
-		 * No buffer_head is allocated.
-		 * (1) bmap: It's enough to set blocknr without I/O.
-		 * (2) read: The unwritten part should be filled with zero.
-		 *           If a folio does not have any buffers,
-		 *           let's returns -EAGAIN to fallback to
-		 *           block_read_full_folio() for per-bh IO.
-		 */
-		if (!folio_buffers(bh_result->b_folio)) {
-			err = -EAGAIN;
-			goto done;
-		}
-
-		pos = EXFAT_BLK_TO_B(iblock, sb);
-		size = ei->valid_size - pos;
-		addr = folio_address(bh_result->b_folio) +
-			offset_in_folio(bh_result->b_folio, pos);
-
-		/* Check if bh->b_data points to proper addr in folio */
-		if (bh_result->b_data != addr) {
-			exfat_fs_error_ratelimit(sb,
-					"b_data(%p) != folio_addr(%p)",
-					bh_result->b_data, addr);
-			err = -EINVAL;
-			goto done;
-		}
-
-		/* Read a block */
-		err = bh_read(bh_result, 0);
-		if (err < 0)
-			goto done;
-
-		/* Zero unwritten part of a block */
-		memset(bh_result->b_data + size, 0, bh_result->b_size - size);
-		err = 0;
-		goto done;
-	}
-
-	/*
-	 * The area has not been written, clear mapped for read/bmap cases.
-	 * If so, it will be filled with zero without reading from disk.
-	 */
-	clear_buffer_mapped(bh_result);
-done:
-	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
-	if (err < 0)
-		clear_buffer_mapped(bh_result);
-unlock_ret:
-	mutex_unlock(&sbi->s_lock);
-	return err;
-}
-
 static int exfat_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_read_folio(folio, exfat_get_block);
+	iomap_bio_read_folio(folio, &exfat_read_iomap_ops);
+	return 0;
 }
 
 static void exfat_readahead(struct readahead_control *rac)
@@ -410,108 +259,46 @@ static void exfat_readahead(struct readahead_control *rac)
 	    ei->valid_size < pos + readahead_length(rac))
 		return;
 
-	mpage_readahead(rac, exfat_get_block);
+	iomap_bio_readahead(rac, &exfat_read_iomap_ops);
 }
 
 static int exfat_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
-		return -EIO;
-
-	return mpage_writepages(mapping, wbc, exfat_get_block);
-}
-
-static void exfat_write_failed(struct address_space *mapping, loff_t to)
-{
-	struct inode *inode = mapping->host;
-
-	if (to > i_size_read(inode)) {
-		truncate_pagecache(inode, i_size_read(inode));
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-		exfat_truncate(inode);
-	}
-}
-
-static int exfat_write_begin(const struct kiocb *iocb,
-			     struct address_space *mapping,
-			     loff_t pos, unsigned int len,
-			     struct folio **foliop, void **fsdata)
-{
-	int ret;
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &exfat_writeback_ops,
+	};
 
 	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
 		return -EIO;
 
-	ret = block_write_begin(mapping, pos, len, foliop, exfat_get_block);
-
-	if (ret < 0)
-		exfat_write_failed(mapping, pos+len);
-
-	return ret;
-}
-
-static int exfat_write_end(const struct kiocb *iocb,
-			   struct address_space *mapping,
-			   loff_t pos, unsigned int len, unsigned int copied,
-			   struct folio *folio, void *fsdata)
-{
-	struct inode *inode = mapping->host;
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-	int err;
-
-	err = generic_write_end(iocb, mapping, pos, len, copied, folio, fsdata);
-	if (err < len)
-		exfat_write_failed(mapping, pos+len);
-
-	if (!(err < 0) && pos + err > ei->valid_size) {
-		ei->valid_size = pos + err;
-		mark_inode_dirty(inode);
-	}
-
-	if (!(err < 0) && !(ei->attr & EXFAT_ATTR_ARCHIVE)) {
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-		ei->attr |= EXFAT_ATTR_ARCHIVE;
-		mark_inode_dirty(inode);
-	}
-
-	return err;
+	return iomap_writepages(&wpc);
 }
 
 static sector_t exfat_aop_bmap(struct address_space *mapping, sector_t block)
 {
 	sector_t blocknr;
 
-	/* exfat_get_cluster() assumes the requested blocknr isn't truncated. */
 	down_read(&EXFAT_I(mapping->host)->truncate_lock);
-	blocknr = generic_block_bmap(mapping, block, exfat_get_block);
+	blocknr = iomap_bmap(mapping, block, &exfat_read_iomap_ops);
 	up_read(&EXFAT_I(mapping->host)->truncate_lock);
 	return blocknr;
 }
 
-/*
- * exfat_block_truncate_page() zeroes out a mapping from file offset `from'
- * up to the end of the block which corresponds to `from'.
- * This is required during truncate to physically zeroout the tail end
- * of that block so it doesn't yield old data if the file is later grown.
- * Also, avoid causing failure from fsx for cases of "data past EOF"
- */
-int exfat_block_truncate_page(struct inode *inode, loff_t from)
-{
-	return block_truncate_page(inode->i_mapping, from, exfat_get_block);
-}
-
 static const struct address_space_operations exfat_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= exfat_read_folio,
-	.readahead	= exfat_readahead,
-	.writepages	= exfat_writepages,
-	.write_begin	= exfat_write_begin,
-	.write_end	= exfat_write_end,
-	.direct_IO	= noop_direct_IO,
-	.bmap		= exfat_aop_bmap,
-	.migrate_folio	= buffer_migrate_folio,
+	.read_folio		= exfat_read_folio,
+	.readahead		= exfat_readahead,
+	.writepages		= exfat_writepages,
+	.direct_IO		= noop_direct_IO,
+	.dirty_folio		= iomap_dirty_folio,
+	.bmap			= exfat_aop_bmap,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
 };
 
 static inline unsigned long exfat_hash(loff_t i_pos)
-- 
2.25.1

