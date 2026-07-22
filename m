Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291193E3177
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756310; cv=none; b=HkDlN7KJUoUkaCQUYPHwuuMLKzMeySB4/M42UvPj3pxGvvxu9oLmz0U08xsDHDiCUMt6GwgEUr7Cw2fpSZw8jqUgN1lnlQIiCao2glxv7z3N59joteCK1fvehKzm6iTcHWP0Fam5AytYtcKJj7U/dm46O+7IZ2Udb8uf9ncMEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756310; c=relaxed/simple;
	bh=7tk8gpaJT4StAFjun937r/uDty4cpbBXdRY/BQA3obU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMPzJSwZ4G64b0rnL2k3Po4DS9TcaRpJiNpPxILGkiuejFe/t8hzZUIdwAd3UeSZtwsW3Z6C7Hz/Io7M4vctayRZdZBox2oVJ7SED2+Xo25IVUqUeJgFJY8VRlQH2aRoW/Gc0nRyUysJVqVsjYJyc0veSZdKC62A7ieVQ8/rue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=JeAjf7UX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="JeAjf7UX"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81f36179d72so13704497b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784756308; x=1785361108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xC/aUsHCt3C3fFH42vsqh0FG1PhEjD5Ko1+F10b8jg=;
        b=JeAjf7UXj5KfHCNZqn2rRc2SJUuBNE+25nIKciQq95aYb88C6V1e6OVlz9i34QTGjy
         iGxV/GvKrc6U24C0cpcvhtP+wzfnq3HJcnGw4Uk8CSgp39aDrF28zHvAy2519p+YccXS
         S/LYNN//2vCPbPAE3i+FyH8p6MRfZQOHZodGtLFEJwEhU6J28Q5/zpw+yBvXVQfqPGQk
         GX4Uj9mJOQ7MapRRk7EOcSJPkWpmrcguqP/lwyv0JFUc8itHWMpq+3N/oT0A5G1aT/YR
         54TjXnvQSkL3sueAEKIXg/zrhfwnZH35HY0vfEn51tn+tqxFelNn/ZL4CdmUuZXgo0gp
         vbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756308; x=1785361108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/xC/aUsHCt3C3fFH42vsqh0FG1PhEjD5Ko1+F10b8jg=;
        b=pZgAnRqcIOYlljKfCLNCGFVoQm4Frug9St9S2TzajpV83wy0e+YA9FuBP/Z20xQ451
         i8yugSkdblYq4nc+GO+VAS27eMpzxex87/3m5Lkr1FKp9CUc0sCGcIVcndfcrtcxnLeg
         Wtr9m4rJH0Y36DmbBBUVEeykLUbjhzobseknOFZBa8DFt+7RidvHAzKgl7Gz7pitAmNH
         zXoMUF0FMwRN2R3JAfni69d+IFclr52RWfeBgwTNjQP4NiocCvb9Xy8L4mzXnVGENXFV
         grXyQA9Y3eymtF1AOi+i8iUxG+WFyG6gSWLcqAzePn9AHREfuCi6dRnwUXNqoOaCWWI1
         VGvg==
X-Gm-Message-State: AOJu0Yw9cgaTT0q17CiOV67EzMTrk/+iyau1IkWLkrgKB1I5LLqxjYMI
	fnim9eBSniZuYJV76Np7apsjCJkTEWmjgVEijk9gdpWYGE3PXTOZbYp9oZmVU3G3214=
X-Gm-Gg: AR+sD11D+Kd5HeUtZELWN+n2HESkt2muljZowaiqLqVJ48O0YUtanDwJWcEU1NU4CVz
	5NYpBcMCwmajZjA+69s468Tc8yBjttYhdWZSNHgsb89KIV6PNh7NEIpgbCA/9dBOo68qjwBM+Ib
	xbgZLtPP8wdaYIVRD+6jw9tCGH4lIoO8GxYouDC/ihSWpXBEIJGBB58951iCol9/u7AJrdrptDb
	KmYALCJP+60UFrgGvQH310o+wzIdGhTB5y6f6nmcneP8AjIR9tAHcr3YhjCJBdUluYxfNh4X2As
	35P2S0WatPIhLwOQF8b/UGtvuU8vPNLgtlgeIp0uWVU9ZsM1yB2jaXyDZGKF3F0Oyo+dtiJN1A3
	2q7S7fzCBVVBCPl2hlOhqlE2czc7cSNp23VWGcN8Cn/NfNATOXExeEdsbq/jtYzHbimNeTH4MzZ
	lZr7JX4cS0G5cPLRuB+X9qI6Kud3CxIviORQD+E7OmedMqdUGLns0qMwhDns28uo4ydK7fenNsc
	6987Ox5lD6uWxa42AyPvCuQ6EKoyS/+EZtqALrJk1Agbg==
X-Received: by 2002:a05:690c:6c81:b0:81d:5155:213b with SMTP id 00721157ae682-81f4c1a0b78mr1345787b3.14.1784756308199;
        Wed, 22 Jul 2026 14:38:28 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c7706dsm20034827b3.21.2026.07.22.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:38:27 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 4/6] hfsplus: add iomap operations for regular file data
Date: Wed, 22 Jul 2026 14:37:56 -0700
Message-ID: <20260722213759.1360225-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722213759.1360225-1-slava@dubeyko.com>
References: <20260722213759.1360225-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch switches regular file operations on
iomap based approach.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/Kconfig      |   1 +
 fs/hfsplus/Makefile     |   5 +-
 fs/hfsplus/hfsplus_fs.h |  16 +++
 fs/hfsplus/iomap.c      | 209 ++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/iomap.h      |  20 ++++
 5 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 fs/hfsplus/iomap.c
 create mode 100644 fs/hfsplus/iomap.h

diff --git a/fs/hfsplus/Kconfig b/fs/hfsplus/Kconfig
index ca8401cb6954..865a1966f395 100644
--- a/fs/hfsplus/Kconfig
+++ b/fs/hfsplus/Kconfig
@@ -6,6 +6,7 @@ config HFSPLUS_FS
 	select NLS
 	select NLS_UTF8
 	select LEGACY_DIRECT_IO
+	select FS_IOMAP
 	help
 	  If you say Y here, you will be able to mount extended format
 	  Macintosh-formatted hard drive partitions with full read-write access.
diff --git a/fs/hfsplus/Makefile b/fs/hfsplus/Makefile
index f2a9ae697e81..2416dfdc3190 100644
--- a/fs/hfsplus/Makefile
+++ b/fs/hfsplus/Makefile
@@ -5,8 +5,9 @@
 
 obj-$(CONFIG_HFSPLUS_FS) += hfsplus.o
 
-hfsplus-objs := super.o options.o inode.o ioctl.o extents.o catalog.o dir.o btree.o \
-		bnode.o brec.o bfind.o tables.o unicode.o wrapper.o bitmap.o part_tbl.o \
+hfsplus-objs := super.o options.o inode.o iomap.o ioctl.o extents.o catalog.o \
+		dir.o btree.o bnode.o brec.o bfind.o tables.o unicode.o \
+		wrapper.o bitmap.o part_tbl.o \
 		attributes.o xattr.o xattr_user.o xattr_security.o xattr_trusted.o
 
 # KUnit tests
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 428f56ebccb0..5c8ec0076bb4 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -175,6 +175,22 @@ static inline struct hfsplus_sb_info *HFSPLUS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+/*
+ * Physical byte offset of allocation block 'dblock' on the volume.
+ */
+static inline loff_t hfsplus_ablock_to_phys_bytes(struct super_block *sb,
+						  u32 dblock)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	loff_t phys_bytes;
+
+	phys_bytes = dblock;
+	phys_bytes <<= sbi->fs_shift;
+	phys_bytes += sbi->blockoffset;
+	phys_bytes <<= sb->s_blocksize_bits;
+
+	return phys_bytes;
+}
 
 struct hfsplus_inode_info {
 	atomic_t opencnt;
diff --git a/fs/hfsplus/iomap.c b/fs/hfsplus/iomap.c
new file mode 100644
index 000000000000..e00144b27c18
--- /dev/null
+++ b/fs/hfsplus/iomap.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/hfsplus/iomap.c
+ *
+ * iomap callback functions for the hfsplus filesystem
+ */
+
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
+
+#include "hfsplus_fs.h"
+#include "hfsplus_raw.h"
+#include "iomap.h"
+
+static int __hfsplus_iomap_begin(struct inode *inode, loff_t offset,
+				 loff_t length, unsigned int flags,
+				 struct iomap *iomap, bool may_alloc)
+{
+	struct super_block *sb = inode->i_sb;
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	u32 ablock, dblock, max_blocks;
+	loff_t ablock_offset, ablock_bytes;
+	loff_t block_start;
+	bool is_new;
+	int err;
+
+	if (!may_alloc) {
+		/* Completely beyond EOF. Treat as hole */
+		if (i_size_read(inode) <= offset) {
+			iomap->type = IOMAP_HOLE;
+			iomap->addr = IOMAP_NULL_ADDR;
+			iomap->offset = offset;
+			iomap->length = length;
+			return 0;
+		}
+
+		/* Clamp length if the requested range goes beyond i_size */
+		if (offset + length > i_size_read(inode)) {
+			loff_t i_size = i_size_read(inode);
+			unsigned int blocksize = i_blocksize(inode);
+			length = round_up(i_size, blocksize) - offset;
+		}
+	}
+
+	ablock = offset >> sbi->alloc_blksz_shift;
+
+	err = hfsplus_map_extent(inode, ablock, may_alloc, &dblock,
+				 &max_blocks, NULL);
+	if (err)
+		return err;
+
+	ablock_offset = offset & (sbi->alloc_blksz - 1);
+	ablock_bytes = (loff_t)max_blocks << sbi->alloc_blksz_shift;
+
+	length = min_t(loff_t, length, ablock_bytes - ablock_offset);
+	block_start = round_down(offset, i_blocksize(inode));
+	is_new = may_alloc && block_start >= hip->phys_size;
+	if (may_alloc && !is_new && offset < hip->phys_size)
+		length = min_t(loff_t, length, hip->phys_size - offset);
+
+	iomap->bdev = sb->s_bdev;
+	iomap->offset = offset;
+	iomap->length = length;
+	iomap->addr = hfsplus_ablock_to_phys_bytes(sb, dblock) + ablock_offset;
+	iomap->type = IOMAP_MAPPED;
+	iomap->flags = IOMAP_F_MERGED;
+
+	if (is_new)
+		iomap->flags |= IOMAP_F_NEW;
+
+	return 0;
+}
+
+static int hfsplus_iomap_begin(struct inode *inode, loff_t offset,
+				loff_t length, unsigned int flags,
+				struct iomap *iomap, struct iomap *srcmap)
+{
+	return __hfsplus_iomap_begin(inode,
+				     offset, length, flags,
+				     iomap, false);
+}
+
+static int hfsplus_write_iomap_begin(struct inode *inode, loff_t offset,
+				     loff_t length, unsigned int flags,
+				     struct iomap *iomap, struct iomap *srcmap)
+{
+	return __hfsplus_iomap_begin(inode,
+				     offset, length, flags,
+				     iomap, true);
+}
+
+const struct iomap_ops hfsplus_iomap_ops = {
+	.iomap_begin = hfsplus_iomap_begin,
+};
+
+/*
+ * hfsplus_write_iomap_end()
+ *
+ * Advance the allocated-and-zeroed high-water mark
+ * (hip->phys_size / hip->fs_blocks) to cover the newly written range.
+ */
+static int hfsplus_write_iomap_end(struct inode *inode, loff_t pos,
+				   loff_t length, ssize_t written,
+				   unsigned int flags, struct iomap *iomap)
+{
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	loff_t end;
+	bool dirtied = false;
+
+	if (!written)
+		return 0;
+
+	end = round_up(pos + written, sb->s_blocksize);
+
+	if (hip->phys_size < end) {
+		inode_add_bytes(inode, end - hip->phys_size);
+		hip->phys_size = end;
+		hip->fs_blocks = end >> sb->s_blocksize_bits;
+		dirtied = true;
+	}
+
+	if (dirtied)
+		mark_inode_dirty(inode);
+
+	return written;
+}
+
+const struct iomap_ops hfsplus_write_iomap_ops = {
+	.iomap_begin	= hfsplus_write_iomap_begin,
+	.iomap_end	= hfsplus_write_iomap_end,
+};
+
+/*
+ * hfsplus_iomap_cont_expand()
+ *
+ * Zero-extend the backing store from the current phys_size up to 'size'.
+ * Used both by hfsplus_setattr() and by hfsplus_file_truncate().
+ */
+int hfsplus_iomap_cont_expand(struct inode *inode, loff_t size)
+{
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	loff_t start = hip->phys_size;
+
+	if (size <= start)
+		return 0;
+
+	return iomap_zero_range(inode, start, size - start, NULL,
+				&hfsplus_write_iomap_ops, NULL, NULL);
+}
+
+/*
+ * hfsplus_writeback_range() - map folio during writeback
+ *
+ * Called for each folio during writeback. If the folio falls outside
+ * the current iomap, remaps by calling __hfsplus_iomap_begin() again.
+ */
+static ssize_t hfsplus_writeback_range(struct iomap_writepage_ctx *wpc,
+					struct folio *folio, u64 offset,
+					unsigned int len, u64 end_pos)
+{
+	int err;
+
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		err = __hfsplus_iomap_begin(wpc->inode,
+					    offset, len, 0,
+					    &wpc->iomap, false);
+		if (err)
+			return err;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+}
+
+const struct iomap_writeback_ops hfsplus_writeback_ops = {
+	.writeback_range	= hfsplus_writeback_range,
+	.writeback_submit	= iomap_ioend_writeback_submit,
+};
+
+/*
+ * hfsplus_file_write_dio_end_io() - Direct I/O write completion handler
+ */
+static int hfsplus_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
+					 int error, unsigned int flags)
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
+const struct iomap_dio_ops hfsplus_write_dio_ops = {
+	.end_io		= hfsplus_file_write_dio_end_io,
+};
+
+int hfsplus_iomap_swap_activate(struct swap_info_struct *sis,
+				 struct file *file, sector_t *span)
+{
+	return iomap_swapfile_activate(sis, file, span, &hfsplus_iomap_ops);
+}
diff --git a/fs/hfsplus/iomap.h b/fs/hfsplus/iomap.h
new file mode 100644
index 000000000000..1ea3333c1e07
--- /dev/null
+++ b/fs/hfsplus/iomap.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/fs/hfsplus/iomap.h
+ *
+ * iomap callback declarations for the hfsplus filesystem
+ */
+
+#ifndef _LINUX_HFSPLUS_IOMAP_H
+#define _LINUX_HFSPLUS_IOMAP_H
+
+extern const struct iomap_ops hfsplus_iomap_ops;
+extern const struct iomap_ops hfsplus_write_iomap_ops;
+extern const struct iomap_writeback_ops hfsplus_writeback_ops;
+extern const struct iomap_dio_ops hfsplus_write_dio_ops;
+
+int hfsplus_iomap_cont_expand(struct inode *inode, loff_t size);
+int hfsplus_iomap_swap_activate(struct swap_info_struct *sis,
+				struct file *file, sector_t *span);
+
+#endif /* _LINUX_HFSPLUS_IOMAP_H */
-- 
2.43.0

