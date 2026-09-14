Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79C3B42CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429216; cv=none; b=inGFzJ7H2Fvw1bRG5vPehhhQOcpJfIZ/6sg8J8IFwF6hErX/teosmyDLD7Rk/8wfRzVeGHqEO8Yy5NldXmKg1HnlyLS/ncxY+KD34V25GwBJm338Botn8CbeZYF8bNn4Eog7zRM8YSlYeiMYEKGAqnAbUY7A4GF0I27HBqLQ7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429216; c=relaxed/simple;
	bh=3Ulc2WBAKnw9uLMXYN2L0ojgOG0vb99gojQX5iOnUW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB/kZCb5BP/HDyXlCGRBi/3iSD9xZ65uJ+FU3Pj+fwO/yM8igWqkPWDcmntIDU7A9hN+LhH60VearwsEMxNxdAqDglbzQAJawQsRJJ/zk5I/jIP2qbagCR14UKFPOXTez93IUhG6djRiMZkRfdgw8bBlhBySug6kH5h2+t0jaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=rAE8B7uH; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="rAE8B7uH"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-6713d20d375so2215370d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789429212; x=1790034012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4Iyv7bHUl+kWGpcVFy7sYXUvGwMMYmygnBiPAZFBG0=;
        b=rAE8B7uHR/icWInkDwCxM7dcVB2sVXxTDz4LSXrj1It3fRpx6ViuubjmNmIMd7VfKP
         6hYiuq6x+JdswyNOBtnEeG7GCjWgd4vjAP/T/w1HfSdJr9brmoK9BWG/AKtcMX10U/lC
         v+1o0jrNjHhV4IIHC09Az2Z3SWvDRQpr85oMvL+N9ZjvgLW5WBWMZyoVcFkWN654WSJP
         gMyf3yiw/8XZqLbAP6ocvTt65bNaoTh5QW2UzSq5WCS9skHxKVxPdc9YX+61solQy9HM
         /QafvhBsuxDdbzs0StEcY6oKjHqMjy4rWJqRnwOaA5uHQd7kWwrqONiQzkatTtwdf+Op
         V+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789429212; x=1790034012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4Iyv7bHUl+kWGpcVFy7sYXUvGwMMYmygnBiPAZFBG0=;
        b=aGvszgnOE1UnwH3yRaGRhiD3gXr6piWJsaQppNCQvEHp5S/hF12r9MxDBP2rbGp8jA
         YGmPi9VDJrx1PYp6Tn7gzhJguCU63PK5ecGslkDeeQi5vwCrIErgezd506gjTkuZf1bo
         UHwET4waMw9FfWnpabWlwgxMT2hSPLcpPUIAakqeQe85fF82tb66M1QllJEQUAvY1Cqb
         Amr7tYf0KhaRxxAriKM5V51/GdR7QGOKATQJvNmuTwLTfNcDGSzf/X9Omc8EeDxZm5iK
         QCde4M/BlIuZ6PToSR766yVu6qpivxJ6nOtiY9oE64blD7u3A24eVZOw2u4nY1hhjrFp
         liEw==
X-Gm-Message-State: AFuF++loQT3StjGswoJ7PysuhAcOClQk0TysW7wvA5V8gVXq1tGUPuE0
	M+96zshWgLCDYhanSZWUwS7kN9+0hPdB4fxIDMQpnkPAeXzjFmEfXYOSFgusRTIczs8=
X-Gm-Gg: AYBFou3efL9gRK8Swz4ESsL49C7DYH563MLneHwZ9A4v93k3eYjYygBvmwOOfF6lNEC
	Tv1E6COHz68xFAQN19O4eEiGeaxr2uzOaFUCza30FInDDmb8q9C5ANELwUX5dqKOZN6991HzZMp
	0QqYJdXtSMpvFf1vu2alNNH//mYoWrVijIZFSy+eT0EUlZWw/Uhz2aOp5dfMKuC8xc7Q4R8gyJi
	V4S7+WPeF4aI7pEqoY2rS9GOslz+6gzHWSTihOFVyDGR64G3dIyt6AzIZhT0pZZAtSJXSA5TrTf
	jYXoji1xdh8kaJnij95MjMErfZbFedw/O9+2pCgyU1GKPgVDv1E+pk+/clNn5NrATGJ0PsoSJGf
	tRh+c1zwHTVPG7f8NeYse3kU6K9T/WJSVX8krJfYAyLhrVC7TDPNnyC7aTyTCkWQH4mE3KgwTzh
	GTvdwF6FlfMfwfKtmi89jDF6x/iUgzi1cWN0NybDwxXhdXuOawDm0CL0+KQb5uudgGewU8iRg7W
	J9x9uu7SxCktQqXee4zgt7AE8nF8V5kIjXB/yXZ74/wYNtDcQTKan+T7pCCsIAnjZ4s1/tKUda5
	H1CWN8jGibkuEeNmoGY//LbP64/e
X-Received: by 2002:a05:690e:43c7:b0:671:1ae4:995a with SMTP id 956f58d0204a3-6714e03f648mr1171893d50.29.1789429211831;
        Mon, 14 Sep 2026 16:40:11 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:df87:8743:655b:3824])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e3fa87sm5207804d50.14.2026.09.14.16.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:40:10 -0700 (PDT)
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
Subject: [PATCH v4 4/7] hfsplus: add iomap operations for regular file data
Date: Mon, 14 Sep 2026 16:39:38 -0700
Message-ID: <20260914233941.2966421-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914233941.2966421-1-slava@dubeyko.com>
References: <20260914233941.2966421-1-slava@dubeyko.com>
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

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/hfsplus/Kconfig      |   1 +
 fs/hfsplus/Makefile     |   5 +-
 fs/hfsplus/hfsplus_fs.h |  16 ++++
 fs/hfsplus/iomap.c      | 192 ++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/iomap.h      |  18 ++++
 include/linux/iomap.h   |  20 +++++
 6 files changed, 250 insertions(+), 2 deletions(-)
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
index 000000000000..5723e854e58e
--- /dev/null
+++ b/fs/hfsplus/iomap.c
@@ -0,0 +1,192 @@
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
+	end = pos + written;
+
+	if (iomap->flags & IOMAP_F_NEW)
+		end = round_up(end, sb->s_blocksize);
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
index bc7ae6327dbf..66a6389c9c74 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -636,6 +636,26 @@ struct iomap_dio_ops {
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

