Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940342122F
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785012; cv=none; b=jntiRrG9QRerHRLt66rX4zmcgylTk51kdAKoIc35SS7JPgULaAHfCpGuJNw1hyRSThOhSCK21x49U5F/f2PrvAN/gZnHjgScwshMGfGco5m8jzXAFuj9MitkJmVYW8ANkMJkSmN1PttJ8DjEuQjj6Cy8IqWGsiOquo19M0gqvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785012; c=relaxed/simple;
	bh=e0Znmj16dD19TfEFJydvxq36l+PfTmr89oU5nx9uLww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPFLJiEa3ZrBP5iM7a8rA1KAUuQktQlwRT0td+jZ7a6s/ZGPgs7kOUDW3zMHiFVE2dWV2QTpgcTVvDceJobVtIHvYp0yewCz0Pmb0NO895d7X8FD+WJ0ih/8qOT+yM60/aBniYUzsQvRdvbHRMCqXKsrr+KxIN+XlQFrWkFvalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=bvizs5V+; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="bvizs5V+"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c70cff944so1454227d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787785006; x=1788389806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhw0ACKBS82tmoTH9z7AvbvIYqPn9PMTWXu7tRK5z4o=;
        b=bvizs5V+0TQz0/LuhdUs8et2skoCu+5DayKYIW2j/ZprecvTkdE6cVm2JWhWpSZ1Uy
         bxLAfNqYg2/OYRkq6MeWwo/bzsFO4uGLWnt7AqBLEfplI60jsolg7E6MhMMz7riKsxcR
         zM2bIIh3qj2bLi+mr9O5nZ1CWIgKe9BthpEesKf6p8QqDmtZXmMvXrSF/xDx6kMDd8vX
         /1oiIjkvgts59nIWGMJr/pvNcU/yktYL+gVIoqgsKAE5uLIF23AZWKko8wPR2Od3zPxN
         srcVJNBP10+wyWtDhgnIYEWWh267a7x0uE6y6PpV7R/LHnXt08vfsbNDRCS3gPtm88Vm
         4anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785006; x=1788389806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhw0ACKBS82tmoTH9z7AvbvIYqPn9PMTWXu7tRK5z4o=;
        b=S+w3vyUfdLIkp6A7a8bq/4Pt+BIfZIZ4w7PFn/6KacGtwUXbBerRj91jSIO1ntX/bI
         iHtQbTggvEzAVilBTcLzpb0qA6vjF5cxcXZE7k77jg0y9oZQT6MxkX4Iv9LXu4fJL3NI
         iN/kQoOYv6jPKvrgyPln+yW+A2H251JCqxQTv1gcRL6Ds4TSLJKg1K+Tq6vWyOKTkxMU
         0oH8e5mcKB8YbC1yNyeMgOIavpvTfVjLbWsyt1d25ameZJQPiXMkZA9oRz9mXbCD7DUz
         kmoc9ZqMoRZiYDZKvpDJgvPg/yxXwdUcT1Tb26JkrigMT1pxbIdo3I1ghCHoj0UvQKgY
         X1Aw==
X-Gm-Message-State: AFuF++m7cMztnZNsrDt3m1aKLhLSzg23SbeUPS8wTliUmKd45WTLwhor
	HMQ3dYLetaMFKfNahaATQEFIFDLggG53cJT4Ld7CaCzH/lPkS6OVOxegk+udbWu4AdVee9dcPGa
	p3wrx
X-Gm-Gg: AR+sD10Z+OGtPj72Y4Ueows6Fyj9ASQLaRbeBNqtbX4SE/R9+BZBaGN8Mokv93avjBV
	IqVcVsJD1K4CVnzdoMGgl0dmxF4yMtGLLKj99RevxKkZJPcytSySi3ZMjCe1xs93/+7Ib29SEDc
	W/iSv7OVDx7PxvSJ7OidaiZ3mxWcFIeT1yOL8L8Ejvhp2lrQVXVk3gQL1wYDAHM3z7G9IW+07nX
	OqzrAfv/IjxbL92Nn5eSNoc28RFKgpUm1Pyd6YN2SMNsJMNJA6AxvnnoDEVZApRKhXjljvyFvWT
	mhQYaPZ0aMf9WVh0+s2jYSUrp6ag5uNnYV6jhdiZefbLz4NkphSMhM5psoKs2pe/PFdrJxI3+l9
	Gry6UinfywuuGd3yFi4RvkkR4pFk2LkJejDXNPR6z9cK/tGKhjBLUf8xSiNfOetjSW/bJQ96mRy
	0PMxDR3EHK/7/A9lcf2voZ+/Ck211P8V9nMls8NwiJ8tYrtuHtegV3KICZeBZmH88KTyDSD7103
	xd6wKHMBtfiavcTcpQ6API/avulgLqK2p9xm3H6yJ22W2EmINGdOL2+H93V6X4ipjteNMvQYApL
	iJwvpAiDAOU2h6iFFA==
X-Received: by 2002:a05:690e:386:b0:668:9f36:5482 with SMTP id 956f58d0204a3-66d256c0650mr2808586d50.21.1787785006455;
        Wed, 26 Aug 2026 15:56:46 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:46 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 4/7] hfsplus: add iomap operations for regular file data
Date: Wed, 26 Aug 2026 15:56:11 -0700
Message-ID: <20260826225614.486112-5-slava@dubeyko.com>
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

This patch adds iomap.h and iomap.c files. The iomap.h contains
declarations of hfsplus_iomap_ops, hfsplus_write_iomap_ops,
hfsplus_writeback_ops, and hfsplus_write_dio_ops operations.
The iomap.c implements __hfsplus_iomap_begin(),
hfsplus_write_iomap_end(), hfsplus_iomap_cont_expand(),
hfsplus_writeback_range() methods that become the basis of
HFS+ iomap operations.

v2
Christoph Hellwig suggested to introduce a generalized version
of iomap_dio_end_io() that was placed into include/linux/iomap.h.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/Kconfig      |   1 +
 fs/hfsplus/Makefile     |   5 +-
 fs/hfsplus/hfsplus_fs.h |  16 ++++
 fs/hfsplus/iomap.c      | 189 ++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/iomap.h      |  18 ++++
 include/linux/iomap.h   |  20 +++++
 6 files changed, 247 insertions(+), 2 deletions(-)
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
index 67586382269b..0a0df0388e7b 100644
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
index 000000000000..1e6dfa693526
--- /dev/null
+++ b/fs/hfsplus/iomap.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
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
+
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
+const struct iomap_dio_ops hfsplus_write_dio_ops = {
+	.end_io		= iomap_dio_end_io,
+};
+
+int hfsplus_iomap_swap_activate(struct swap_info_struct *sis,
+				 struct file *file, sector_t *span)
+{
+	return iomap_swapfile_activate(sis, file, span, &hfsplus_iomap_ops);
+}
diff --git a/fs/hfsplus/iomap.h b/fs/hfsplus/iomap.h
new file mode 100644
index 000000000000..dac07a9d25f8
--- /dev/null
+++ b/fs/hfsplus/iomap.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
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
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3582ed1fe236..5746807553eb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -560,6 +560,26 @@ struct iomap_dio_ops {
 	struct bio_set *bio_set;
 };
 
+/*
+ * Direct I/O completion handler
+ */
+static inline
+int iomap_dio_end_io(struct kiocb *iocb, ssize_t size,
+		     int error, unsigned int flags)
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
 /*
  * Wait for the I/O to complete in iomap_dio_rw even if the kiocb is not
  * synchronous.
-- 
2.43.0

