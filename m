Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771704;
	b=JtqSn9aJ8McGTxz0HjUkfd7e5+Gqsn1w/CqWWou9+VHLEQ0vsGYGeW9WOmJybO28T8S7
	 XGcZpUoSdgJxc1oQs3BoDABdLYryll8DkHsp1Upr0/OYk53V8R+emhmPRgUab6HPH+BRq
	 fG1Axaat7OGnPwKzM+hXUInoTKJZUJd+QxVobBgerl9Wf322TD0/ILK1OGnPeAgbprAV7
	 vgvcdTLSXhQCBuuwmDovV6+S5SXs0arurJxhXLhVvdO17lMZOrqJWB/lClc9xYNnxl/Sb
	 4QLzOBFkmCnDux/KJDCxyUFoc0oj5/t95rnzBWMaJhermRNtuvjsvRFDYSGB29iZgsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2UFEqIWk1ABImIlxjhgrNeYHYvHVVjBGryjvG31fmWs=;
	b=BpqCKivAaeqFTA3oAt3cEg67Gmk/QSmNIr8w5+e0z5YdSB8RFTPySTT1stwyschO4i4f
	 YbeqAHC47DdueUJbzf1tvtAqSS/f13QHaHOTWR1Ng03PJWjHPieTmNY9AcL92t4yLEoJo
	 y8WnHCqt7+L5/PLaqY0dp60E89crFdUMOKj2U4RyfBSw37FNk3fl/wwNSI7+vyHOLT8PA
	 HjLs62zmbgMQgRCHOk8iPBvgz4nK+HvgKpm8QlvbaKNgntddVi81wZ8sTLuPenvjNTLYh
	 H5Yh9HX09hb37Vs8qhamtfRJnroiC0yee12J+8Hx8immUnHuA422wFAvSQrD8hkPDxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YhX+D7SF;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A200606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 16:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A200606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YhX+D7SF
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9907a58f14dso312072241.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771701; x=1793376501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UFEqIWk1ABImIlxjhgrNeYHYvHVVjBGryjvG31fmWs=;
        b=YhX+D7SFeouSxmYDZQG70CRyQYgKpRBZJJSl6rd6R5qvaUaGKocsO9pBNW7QgWvzbr
         9c0rnmbElF8jHtNiPWWJGfsOOjOWESDh3ExWYRYPwdOISiDNSlV4+LxnopvMRd0HGFTb
         88VyabuEMr8pSlHw8cRS7JMlozKXHBXWm/tCIIMh00+Pm+qGNMfxCOMFZvl6wQKDtaGi
         ynp25oqzFtAU95qfrgoHtQzDTqRfNLMqqzcOyZDL2wbpsqiX6gHntxfIb/DA8Vikzksl
         GE+fUmdme0AdiyUifpyoOegT6uzg5W8vxDpRZX6N7VWxQyyv/bxJD+mditgnllkHnbJ9
         hI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771701; x=1793376501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UFEqIWk1ABImIlxjhgrNeYHYvHVVjBGryjvG31fmWs=;
        b=QNEQAf4zIkcWQHEW268PIMkoRJZ3iC9q1iBHKM26nEJ+bHVOLGeX+DCilJGRthFGgy
         9bg8WyS8asBLqYKLwNJY2Fhtal9FwnTxgIFNbbuOUOajvraRedsqZNu8w2T6Q7Mcylz8
         8SyK0t4sg0ZS1KC3+RF14GIYS1j1asvvO3xDJs4O+Ye+MBjUe0ycCXgPDnN7fQmbwyiO
         UiDDsFlLdvB7GhZKGP7cE5xpUQp70b8Dyv5SHKpGJeok4TmLahbdrXeRK5XVdEjBB2mb
         8HC+WYtgHQRZVQZ1WbuOzHsZCanAvD6OIUP0Vu44ulon4JWzP3RcAqHmnfK9sd20jJuN
         hP3A==
X-Gm-Message-State: AFq9FYKHXXtsy5cGVGfF0oxFcucQ0vZ0r1/H4mMyIDTVfRJ0y5SYULBJ
	kt8+/4QPybwd7Za0ao23+RDk3ki4prdj0rg+s1X+DP/wmAqvnZ07S2SbRZe79opM
X-Gm-Gg: AYBFou3g1jw/vgeQEYV6JAKq3Ae13qF5P2Vc7XEfHlrqfvJib7QWgXbBnvixYbQwj0l
	IEQQCK+D3F6/ZFYgfl3Gnl9iULAI4Qc4mEAyKuRb4Xmw6+SO3X8zfVDT6XTAakha+yid+647j2w
	GFdHQola0sSTeBw5969t7H2c2NE1Bqg0OboSD2AzzMUp3G/64TwHPoE15zS+ib1u1BWyMbClSsO
	uR+vCAc9eF47h0wLAZiTmnfi6AOwc1L0XCTOeZRndjFGWNMhQK9ALrtXUfHdvi2Tb9RMZV7vZgm
	iSEVE0ilUdhg159zbLxgiDZlvM3Z8stbGpQdhbzczQAVwd8cXuhiK7RtrLeMkqjO2VkuRix6mjC
	vVwhOQG3zrNH6ioF2o2M7poAH/qskjsPZstRpyw32a+VCAUY5EfKr6VMI2wU6Np7KXvNhrIGJHb
	L2G3mnlxSYpyGMbCyo37b3388FYfZXpEX1sa8MS8pPETq+pXZP1YPtCO2HOv+x2gZ1FktApA+PM
	5yglpTcJjTGfUYgwgafev06iirQD8Na+eKFYGLA82CbEZWuz0Dqz0FoV2DdjzUKvVTFDPdifhI4
	MOgu00oaXN4EFx8oMuD4LSo=
X-Received: by 2002:a05:6102:2b9c:b0:7a6:85d6:8ae0 with SMTP id ada2fe7eead31-7ccc307a284mr1053168137.1.1792771701250;
        Fri, 23 Oct 2026 09:08:21 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910c0112dasm745461241.9.2026.10.23.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:08:20 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	Anders Larsen <al@alarsen.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs: remove qnx4 filesystem
Date: Fri, 23 Oct 2026 13:08:05 -0300
Message-ID: <20261023160806.103901-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The qnx4 filesystem driver has been orphaned and unmaintained for
decades.  Write support was removed in 2009 as it was never fully
implemented and was broken.  The remaining code is read-only and has
no active users.

Remove the driver entirely, along with its Kconfig entry,
MAINTAINERS entry, and CREDITS entries.

The QNX4_SUPER_MAGIC value in include/uapi/linux/magic.h is kept for
userspace ABI compatibility.  The UAPI format headers (qnx4_fs.h,
qnxtypes.h) and defconfig cleanups will be sent separately.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 CREDITS          |   3 -
 MAINTAINERS      |   8 -
 fs/Kconfig       |   1 -
 fs/Makefile      |   1 -
 fs/qnx4/Kconfig  |  16 --
 fs/qnx4/Makefile |   8 -
 fs/qnx4/bitmap.c |  45 -----
 fs/qnx4/dir.c    |  81 ---------
 fs/qnx4/inode.c  | 436 -----------------------------------------------
 fs/qnx4/namei.c  | 115 -------------
 fs/qnx4/qnx4.h   | 106 ------------
 fs/qnx6/Makefile |   2 +-
 12 files changed, 1 insertion(+), 821 deletions(-)
 delete mode 100644 fs/qnx4/Kconfig
 delete mode 100644 fs/qnx4/Makefile
 delete mode 100644 fs/qnx4/bitmap.c
 delete mode 100644 fs/qnx4/dir.c
 delete mode 100644 fs/qnx4/inode.c
 delete mode 100644 fs/qnx4/namei.c
 delete mode 100644 fs/qnx4/qnx4.h

diff --git a/CREDITS b/CREDITS
index 882aad786df9..49296288adf4 100644
--- a/CREDITS
+++ b/CREDITS
@@ -947,7 +947,6 @@ S: France
 
 N: Frank "Jedi/Sector One" Denis
 E: j@pureftpd.org
-D: QNX4 filesystem
 
 N: Peter Denison
 E: peterd@pnd-pc.demon.co.uk
@@ -1341,7 +1340,6 @@ E: mid@zigamorph.net
 
 N: Richard "Scuba" A. Frowijn
 E: scuba@wxs.nl
-D: QNX4 filesystem
 
 N: Fernando Fuganti
 E: fuganti@conectiva.com.br
@@ -2392,7 +2390,6 @@ D: Scalability, Time subsystem
 
 N: Anders Larsen
 E: al@alarsen.net
-D: QNX4 filesystem
 
 N: Paul Laufer
 E: paul@laufernet.com
diff --git a/MAINTAINERS b/MAINTAINERS
index 943135302225..9e0354177307 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22352,14 +22352,6 @@ F:	drivers/leds/leds-qnap-mcu.c
 F:	drivers/mfd/qnap-mcu.c
 F:	include/linux/mfd/qnap-mcu.h
 
-QNX4 FILESYSTEM
-M:	Anders Larsen <al@alarsen.net>
-S:	Maintained
-W:	http://www.alarsen.net/linux/qnx4fs/
-F:	fs/qnx4/
-F:	include/uapi/linux/qnx4_fs.h
-F:	include/uapi/linux/qnxtypes.h
-
 QNX6 FILESYSTEM
 S:	Orphan
 F:	Documentation/filesystems/qnx6.rst
diff --git a/fs/Kconfig b/fs/Kconfig
index ca84ee8a85ee..58cbeb507402 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -321,7 +321,6 @@ source "fs/cramfs/Kconfig"
 source "fs/squashfs/Kconfig"
 source "fs/minix/Kconfig"
 source "fs/omfs/Kconfig"
-source "fs/qnx4/Kconfig"
 source "fs/qnx6/Kconfig"
 source "fs/resctrl/Kconfig"
 source "fs/romfs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index a741172ac6d4..b98c05dbffa1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -94,7 +94,6 @@ obj-$(CONFIG_JFFS2_FS)		+= jffs2/
 obj-$(CONFIG_UBIFS_FS)		+= ubifs/
 obj-$(CONFIG_AFFS_FS)		+= affs/
 obj-$(CONFIG_ROMFS_FS)		+= romfs/
-obj-$(CONFIG_QNX4FS_FS)		+= qnx4/
 obj-$(CONFIG_QNX6FS_FS)		+= qnx6/
 obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
diff --git a/fs/qnx4/Kconfig b/fs/qnx4/Kconfig
deleted file mode 100644
index a2eb826e76c6..000000000000
--- a/fs/qnx4/Kconfig
+++ /dev/null
@@ -1,16 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config QNX4FS_FS
-	tristate "QNX4 file system support (read only)"
-	depends on BLOCK
-	select BUFFER_HEAD
-	help
-	  This is the file system used by the real-time operating systems
-	  QNX 4 and QNX 6 (the latter is also called QNX RTP).
-	  Further information is available at <http://www.qnx.com/>.
-	  Say Y if you intend to mount QNX hard disks or floppies.
-
-	  To compile this file system support as a module, choose M here: the
-	  module will be called qnx4.
-
-	  If you don't know whether you need it, then you don't need it:
-	  answer N.
diff --git a/fs/qnx4/Makefile b/fs/qnx4/Makefile
deleted file mode 100644
index 42d4fc263a3d..000000000000
--- a/fs/qnx4/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the linux qnx4-filesystem routines.
-#
-
-obj-$(CONFIG_QNX4FS_FS) += qnx4.o
-
-qnx4-objs := inode.o dir.o namei.o bitmap.o
diff --git a/fs/qnx4/bitmap.c b/fs/qnx4/bitmap.c
deleted file mode 100644
index 163afc4ba4b2..000000000000
--- a/fs/qnx4/bitmap.c
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * QNX4 file system, Linux implementation.
- *
- * Version : 0.2.1
- *
- * Using parts of the xiafs filesystem.
- *
- * History :
- *
- * 28-05-1998 by Richard Frowijn : first release.
- * 20-06-1998 by Frank Denis : basic optimisations.
- * 25-06-1998 by Frank Denis : qnx4_is_free, qnx4_set_bitmap, qnx4_bmap .
- * 28-06-1998 by Frank Denis : qnx4_free_inode (to be fixed) .
- */
-
-#include <linux/buffer_head.h>
-#include <linux/bitops.h>
-#include "qnx4.h"
-
-unsigned long qnx4_count_free_blocks(struct super_block *sb)
-{
-	int start = le32_to_cpu(qnx4_sb(sb)->BitMap->di_first_xtnt.xtnt_blk) - 1;
-	int total = 0;
-	int total_free = 0;
-	int offset = 0;
-	int size = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size);
-	struct buffer_head *bh;
-
-	while (total < size) {
-		int bytes = min(size - total, QNX4_BLOCK_SIZE);
-
-		if ((bh = sb_bread(sb, start + offset)) == NULL) {
-			printk(KERN_ERR "qnx4: I/O error in counting free blocks\n");
-			break;
-		}
-		total_free += bytes * BITS_PER_BYTE -
-				memweight(bh->b_data, bytes);
-		brelse(bh);
-		total += bytes;
-		offset++;
-	}
-
-	return total_free;
-}
diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
deleted file mode 100644
index a9038d231be4..000000000000
--- a/fs/qnx4/dir.c
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * QNX4 file system, Linux implementation.
- *
- * Version : 0.2.1
- *
- * Using parts of the xiafs filesystem.
- *
- * History :
- *
- * 28-05-1998 by Richard Frowijn : first release.
- * 20-06-1998 by Frank Denis : Linux 2.1.99+ & dcache support.
- */
-
-#include <linux/buffer_head.h>
-#include <linux/filelock.h>
-#include "qnx4.h"
-
-static int qnx4_readdir(struct file *file, struct dir_context *ctx)
-{
-	struct inode *inode = file_inode(file);
-	unsigned int offset;
-	struct buffer_head *bh;
-	unsigned long blknum;
-	int ix, ino;
-	int size;
-
-	QNX4DEBUG((KERN_INFO "qnx4_readdir:i_size = %ld\n", (long) inode->i_size));
-	QNX4DEBUG((KERN_INFO "pos                 = %ld\n", (long) ctx->pos));
-
-	while (ctx->pos < inode->i_size) {
-		blknum = qnx4_block_map(inode, ctx->pos >> QNX4_BLOCK_SIZE_BITS);
-		bh = sb_bread(inode->i_sb, blknum);
-		if (bh == NULL) {
-			printk(KERN_ERR "qnx4_readdir: bread failed (%ld)\n", blknum);
-			return 0;
-		}
-		ix = (ctx->pos >> QNX4_DIR_ENTRY_SIZE_BITS) % QNX4_INODES_PER_BLOCK;
-		for (; ix < QNX4_INODES_PER_BLOCK; ix++, ctx->pos += QNX4_DIR_ENTRY_SIZE) {
-			union qnx4_directory_entry *de;
-			const char *fname;
-
-			offset = ix * QNX4_DIR_ENTRY_SIZE;
-			de = (union qnx4_directory_entry *) (bh->b_data + offset);
-
-			fname = get_entry_fname(de, &size);
-			if (!fname)
-				continue;
-
-			if (!(de->de_status & QNX4_FILE_LINK)) {
-				ino = blknum * QNX4_INODES_PER_BLOCK + ix - 1;
-			} else {
-				ino = ( le32_to_cpu(de->link.dl_inode_blk) - 1 ) *
-					QNX4_INODES_PER_BLOCK +
-					de->link.dl_inode_ndx;
-			}
-
-			QNX4DEBUG((KERN_INFO "qnx4_readdir:%.*s\n", size, fname));
-			if (!dir_emit(ctx, fname, size, ino, DT_UNKNOWN)) {
-				brelse(bh);
-				return 0;
-			}
-		}
-		brelse(bh);
-	}
-	return 0;
-}
-
-const struct file_operations qnx4_dir_operations =
-{
-	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
-	.iterate_shared	= qnx4_readdir,
-	.fsync		= simple_fsync,
-	.setlease	= generic_setlease,
-};
-
-const struct inode_operations qnx4_dir_inode_operations =
-{
-	.lookup		= qnx4_lookup,
-};
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
deleted file mode 100644
index 42fcd500fad2..000000000000
--- a/fs/qnx4/inode.c
+++ /dev/null
@@ -1,436 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * QNX4 file system, Linux implementation.
- *
- * Version : 0.2.1
- *
- * Using parts of the xiafs filesystem.
- *
- * History :
- *
- * 01-06-1998 by Richard Frowijn : first release.
- * 20-06-1998 by Frank Denis : Linux 2.1.99+ support, boot signature, misc.
- * 30-06-1998 by Frank Denis : first step to write inodes.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/highuid.h>
-#include <linux/pagemap.h>
-#include <linux/buffer_head.h>
-#include <linux/writeback.h>
-#include <linux/statfs.h>
-#include <linux/fs_context.h>
-#include "qnx4.h"
-
-#define QNX4_VERSION  4
-#define QNX4_BMNAME   ".bitmap"
-
-static const struct super_operations qnx4_sops;
-
-static struct inode *qnx4_alloc_inode(struct super_block *sb);
-static void qnx4_free_inode(struct inode *inode);
-static int qnx4_statfs(struct dentry *, struct kstatfs *);
-static int qnx4_get_tree(struct fs_context *fc);
-
-static const struct super_operations qnx4_sops =
-{
-	.alloc_inode	= qnx4_alloc_inode,
-	.free_inode	= qnx4_free_inode,
-	.statfs		= qnx4_statfs,
-};
-
-static int qnx4_reconfigure(struct fs_context *fc)
-{
-	struct super_block *sb = fc->root->d_sb;
-	struct qnx4_sb_info *qs;
-
-	sync_filesystem(sb);
-	qs = qnx4_sb(sb);
-	qs->Version = QNX4_VERSION;
-	fc->sb_flags |= SB_RDONLY;
-	return 0;
-}
-
-static const struct fs_context_operations qnx4_context_opts = {
-	.get_tree	= qnx4_get_tree,
-	.reconfigure	= qnx4_reconfigure,
-};
-
-static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_head *bh, int create )
-{
-	unsigned long phys;
-
-	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%llu] iblock=[%ld]\n", inode->i_ino, iblock));
-
-	phys = qnx4_block_map( inode, iblock );
-	if ( phys ) {
-		// logical block is before EOF
-		map_bh(bh, inode->i_sb, phys);
-	}
-	return 0;
-}
-
-static inline u32 try_extent(qnx4_xtnt_t *extent, u32 *offset)
-{
-	u32 size = le32_to_cpu(extent->xtnt_size);
-	if (*offset < size)
-		return le32_to_cpu(extent->xtnt_blk) + *offset - 1;
-	*offset -= size;
-	return 0;
-}
-
-unsigned long qnx4_block_map( struct inode *inode, long iblock )
-{
-	int ix;
-	long i_xblk;
-	struct buffer_head *bh = NULL;
-	struct qnx4_xblk *xblk = NULL;
-	struct qnx4_inode_entry *qnx4_inode = qnx4_raw_inode(inode);
-	u16 nxtnt = le16_to_cpu(qnx4_inode->di_num_xtnts);
-	u32 offset = iblock;
-	u32 block = try_extent(&qnx4_inode->di_first_xtnt, &offset);
-
-	if (block) {
-		// iblock is in the first extent. This is easy.
-	} else {
-		// iblock is beyond first extent. We have to follow the extent chain.
-		i_xblk = le32_to_cpu(qnx4_inode->di_xblk);
-		ix = 0;
-		while ( --nxtnt > 0 ) {
-			if ( ix == 0 ) {
-				// read next xtnt block.
-				bh = sb_bread(inode->i_sb, i_xblk - 1);
-				if ( !bh ) {
-					QNX4DEBUG((KERN_ERR "qnx4: I/O error reading xtnt block [%ld])\n", i_xblk - 1));
-					return -EIO;
-				}
-				xblk = (struct qnx4_xblk*)bh->b_data;
-				if ( memcmp( xblk->xblk_signature, "IamXblk", 7 ) ) {
-					QNX4DEBUG((KERN_ERR "qnx4: block at %ld is not a valid xtnt\n", qnx4_inode->i_xblk));
-					return -EIO;
-				}
-			}
-			block = try_extent(&xblk->xblk_xtnts[ix], &offset);
-			if (block) {
-				// got it!
-				break;
-			}
-			if ( ++ix >= xblk->xblk_num_xtnts ) {
-				i_xblk = le32_to_cpu(xblk->xblk_next_xblk);
-				ix = 0;
-				brelse( bh );
-				bh = NULL;
-			}
-		}
-		if ( bh )
-			brelse( bh );
-	}
-
-	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %llu = %ld\n", iblock, inode->i_ino, block));
-	return block;
-}
-
-static int qnx4_statfs(struct dentry *dentry, struct kstatfs *buf)
-{
-	struct super_block *sb = dentry->d_sb;
-	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
-
-	buf->f_type    = sb->s_magic;
-	buf->f_bsize   = sb->s_blocksize;
-	buf->f_blocks  = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size) * 8;
-	buf->f_bfree   = qnx4_count_free_blocks(sb);
-	buf->f_bavail  = buf->f_bfree;
-	buf->f_namelen = QNX4_NAME_MAX;
-	buf->f_fsid    = u64_to_fsid(id);
-
-	return 0;
-}
-
-/*
- * Check the root directory of the filesystem to make sure
- * it really _is_ a qnx4 filesystem, and to check the size
- * of the directory entry.
- */
-static const char *qnx4_checkroot(struct super_block *sb,
-				  struct qnx4_super_block *s)
-{
-	struct buffer_head *bh;
-	struct qnx4_inode_entry *rootdir;
-	int rd, rl;
-	int i, j;
-
-	if (s->RootDir.di_fname[0] != '/' || s->RootDir.di_fname[1] != '\0')
-		return "no qnx4 filesystem (no root dir).";
-	QNX4DEBUG((KERN_NOTICE "QNX4 filesystem found on dev %s.\n", sb->s_id));
-	rd = le32_to_cpu(s->RootDir.di_first_xtnt.xtnt_blk) - 1;
-	rl = le32_to_cpu(s->RootDir.di_first_xtnt.xtnt_size);
-	for (j = 0; j < rl; j++) {
-		bh = sb_bread(sb, rd + j);	/* root dir, first block */
-		if (bh == NULL)
-			return "unable to read root entry.";
-		rootdir = (struct qnx4_inode_entry *) bh->b_data;
-		for (i = 0; i < QNX4_INODES_PER_BLOCK; i++, rootdir++) {
-			QNX4DEBUG((KERN_INFO "rootdir entry found : [%s]\n", rootdir->di_fname));
-			if (strcmp(rootdir->di_fname, QNX4_BMNAME) != 0)
-				continue;
-			qnx4_sb(sb)->BitMap = kmemdup(rootdir,
-						      sizeof(struct qnx4_inode_entry),
-						      GFP_KERNEL);
-			brelse(bh);
-			if (!qnx4_sb(sb)->BitMap)
-				return "not enough memory for bitmap inode";
-			/* keep bitmap inode known */
-			return NULL;
-		}
-		brelse(bh);
-	}
-	return "bitmap file not found.";
-}
-
-static int qnx4_fill_super(struct super_block *s, struct fs_context *fc)
-{
-	struct buffer_head *bh;
-	struct inode *root;
-	const char *errmsg;
-	struct qnx4_sb_info *qs;
-	int silent = fc->sb_flags & SB_SILENT;
-
-	qs = kzalloc_obj(struct qnx4_sb_info);
-	if (!qs)
-		return -ENOMEM;
-	s->s_fs_info = qs;
-
-	if (!sb_set_blocksize(s, QNX4_BLOCK_SIZE))
-		return -EINVAL;
-
-	s->s_op = &qnx4_sops;
-	s->s_magic = QNX4_SUPER_MAGIC;
-	s->s_flags |= SB_RDONLY;	/* Yup, read-only yet */
-	s->s_time_min = 0;
-	s->s_time_max = U32_MAX;
-
-	/* Check the superblock signature. Since the qnx4 code is
-	   dangerous, we should leave as quickly as possible
-	   if we don't belong here... */
-	bh = sb_bread(s, 1);
-	if (!bh) {
-		printk(KERN_ERR "qnx4: unable to read the superblock\n");
-		return -EINVAL;
-	}
-
- 	/* check before allocating dentries, inodes, .. */
-	errmsg = qnx4_checkroot(s, (struct qnx4_super_block *) bh->b_data);
-	brelse(bh);
-	if (errmsg != NULL) {
-		if (!silent)
-			printk(KERN_ERR "qnx4: %s\n", errmsg);
-		return -EINVAL;
-	}
-
- 	/* does root not have inode number QNX4_ROOT_INO ?? */
-	root = qnx4_iget(s, QNX4_ROOT_INO * QNX4_INODES_PER_BLOCK);
-	if (IS_ERR(root)) {
-		printk(KERN_ERR "qnx4: get inode failed\n");
-		return PTR_ERR(root);
- 	}
-
- 	s->s_root = d_make_root(root);
- 	if (s->s_root == NULL)
- 		return -ENOMEM;
-
-	return 0;
-}
-
-static int qnx4_get_tree(struct fs_context *fc)
-{
-	return get_tree_bdev(fc, qnx4_fill_super);
-}
-
-static int qnx4_init_fs_context(struct fs_context *fc)
-{
-	fc->ops = &qnx4_context_opts;
-
-	return 0;
-}
-
-static void qnx4_kill_sb(struct super_block *sb)
-{
-	struct qnx4_sb_info *qs = qnx4_sb(sb);
-	kill_block_super(sb);
-	if (qs) {
-		kfree(qs->BitMap);
-		kfree(qs);
-	}
-}
-
-static int qnx4_read_folio(struct file *file, struct folio *folio)
-{
-	return block_read_full_folio(folio, qnx4_get_block);
-}
-
-static sector_t qnx4_bmap(struct address_space *mapping, sector_t block)
-{
-	return generic_block_bmap(mapping,block,qnx4_get_block);
-}
-
-static const struct address_space_operations qnx4_aops = {
-	.read_folio	= qnx4_read_folio,
-	.bmap		= qnx4_bmap
-};
-
-struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
-{
-	struct buffer_head *bh;
-	struct qnx4_inode_entry *raw_inode;
-	int block;
-	struct qnx4_inode_entry *qnx4_inode;
-	struct inode *inode;
-
-	inode = iget_locked(sb, ino);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
-	if (!(inode_state_read_once(inode) & I_NEW))
-		return inode;
-
-	qnx4_inode = qnx4_raw_inode(inode);
-	inode->i_mode = 0;
-
-	QNX4DEBUG((KERN_INFO "reading inode : [%d]\n", ino));
-	if (!ino) {
-		printk(KERN_ERR "qnx4: bad inode number on dev %s: %lu is "
-				"out of range\n",
-		       sb->s_id, ino);
-		iget_failed(inode);
-		return ERR_PTR(-EIO);
-	}
-	block = ino / QNX4_INODES_PER_BLOCK;
-
-	if (!(bh = sb_bread(sb, block))) {
-		printk(KERN_ERR "qnx4: major problem: unable to read inode from dev "
-		       "%s\n", sb->s_id);
-		iget_failed(inode);
-		return ERR_PTR(-EIO);
-	}
-	raw_inode = ((struct qnx4_inode_entry *) bh->b_data) +
-	    (ino % QNX4_INODES_PER_BLOCK);
-
-	inode->i_mode    = le16_to_cpu(raw_inode->di_mode);
-	i_uid_write(inode, (uid_t)le16_to_cpu(raw_inode->di_uid));
-	i_gid_write(inode, (gid_t)le16_to_cpu(raw_inode->di_gid));
-	set_nlink(inode, le16_to_cpu(raw_inode->di_nlink));
-	inode->i_size    = le32_to_cpu(raw_inode->di_size);
-	inode_set_mtime(inode, le32_to_cpu(raw_inode->di_mtime), 0);
-	inode_set_atime(inode, le32_to_cpu(raw_inode->di_atime), 0);
-	inode_set_ctime(inode, le32_to_cpu(raw_inode->di_ctime), 0);
-	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
-
-	memcpy(qnx4_inode, raw_inode, QNX4_DIR_ENTRY_SIZE);
-	if (S_ISREG(inode->i_mode)) {
-		inode->i_fop = &generic_ro_fops;
-		inode->i_mapping->a_ops = &qnx4_aops;
-		qnx4_i(inode)->mmu_private = inode->i_size;
-	} else if (S_ISDIR(inode->i_mode)) {
-		inode->i_op = &qnx4_dir_inode_operations;
-		inode->i_fop = &qnx4_dir_operations;
-	} else if (S_ISLNK(inode->i_mode)) {
-		inode->i_op = &page_symlink_inode_operations;
-		inode_nohighmem(inode);
-		inode->i_mapping->a_ops = &qnx4_aops;
-		qnx4_i(inode)->mmu_private = inode->i_size;
-	} else {
-		printk(KERN_ERR "qnx4: bad inode %lu on dev %s\n",
-			ino, sb->s_id);
-		iget_failed(inode);
-		brelse(bh);
-		return ERR_PTR(-EIO);
-	}
-	brelse(bh);
-	unlock_new_inode(inode);
-	return inode;
-}
-
-static struct kmem_cache *qnx4_inode_cachep;
-
-static struct inode *qnx4_alloc_inode(struct super_block *sb)
-{
-	struct qnx4_inode_info *ei;
-	ei = alloc_inode_sb(sb, qnx4_inode_cachep, GFP_KERNEL);
-	if (!ei)
-		return NULL;
-	return &ei->vfs_inode;
-}
-
-static void qnx4_free_inode(struct inode *inode)
-{
-	kmem_cache_free(qnx4_inode_cachep, qnx4_i(inode));
-}
-
-static void init_once(void *foo)
-{
-	struct qnx4_inode_info *ei = (struct qnx4_inode_info *) foo;
-
-	inode_init_once(&ei->vfs_inode);
-}
-
-static int init_inodecache(void)
-{
-	qnx4_inode_cachep = kmem_cache_create("qnx4_inode_cache",
-					     sizeof(struct qnx4_inode_info),
-					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_ACCOUNT),
-					     init_once);
-	if (qnx4_inode_cachep == NULL)
-		return -ENOMEM;
-	return 0;
-}
-
-static void destroy_inodecache(void)
-{
-	/*
-	 * Make sure all delayed rcu free inodes are flushed before we
-	 * destroy cache.
-	 */
-	rcu_barrier();
-	kmem_cache_destroy(qnx4_inode_cachep);
-}
-
-static struct file_system_type qnx4_fs_type = {
-	.owner			= THIS_MODULE,
-	.name			= "qnx4",
-	.kill_sb		= qnx4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV,
-	.init_fs_context	= qnx4_init_fs_context,
-};
-MODULE_ALIAS_FS("qnx4");
-
-static int __init init_qnx4_fs(void)
-{
-	int err;
-
-	err = init_inodecache();
-	if (err)
-		return err;
-
-	err = register_filesystem(&qnx4_fs_type);
-	if (err) {
-		destroy_inodecache();
-		return err;
-	}
-
-	printk(KERN_INFO "QNX4 filesystem 0.2.3 registered.\n");
-	return 0;
-}
-
-static void __exit exit_qnx4_fs(void)
-{
-	unregister_filesystem(&qnx4_fs_type);
-	destroy_inodecache();
-}
-
-module_init(init_qnx4_fs)
-module_exit(exit_qnx4_fs)
-MODULE_DESCRIPTION("QNX4 file system");
-MODULE_LICENSE("GPL");
-
diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
deleted file mode 100644
index bb8db6550ca5..000000000000
--- a/fs/qnx4/namei.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* 
- * QNX4 file system, Linux implementation.
- * 
- * Version : 0.2.1
- * 
- * Using parts of the xiafs filesystem.
- * 
- * History :
- * 
- * 01-06-1998 by Richard Frowijn : first release.
- * 21-06-1998 by Frank Denis : dcache support, fixed error codes.
- * 04-07-1998 by Frank Denis : first step for rmdir/unlink.
- */
-
-#include <linux/buffer_head.h>
-#include "qnx4.h"
-
-
-/*
- * check if the filename is correct. For some obscure reason, qnx writes a
- * new file twice in the directory entry, first with all possible options at 0
- * and for a second time the way it is, they want us not to access the qnx
- * filesystem when whe are using linux.
- */
-static int qnx4_match(int len, const char *name,
-		      struct buffer_head *bh, unsigned long *offset)
-{
-	union qnx4_directory_entry *de;
-	const char *fname;
-	int fnamelen;
-
-	if (bh == NULL) {
-		printk(KERN_WARNING "qnx4: matching unassigned buffer !\n");
-		return 0;
-	}
-	de = (union qnx4_directory_entry *) (bh->b_data + *offset);
-	*offset += QNX4_DIR_ENTRY_SIZE;
-
-	fname = get_entry_fname(de, &fnamelen);
-	if (!fname || len != fnamelen)
-		return 0;
-
-	if (strncmp(name, fname, len) == 0)
-		return 1;
-
-	return 0;
-}
-
-static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
-	   const char *name, struct qnx4_inode_entry **res_dir, int *ino)
-{
-	unsigned long block, offset, blkofs;
-	struct buffer_head *bh;
-
-	*res_dir = NULL;
-	bh = NULL;
-	block = offset = blkofs = 0;
-	while (blkofs * QNX4_BLOCK_SIZE + offset < dir->i_size) {
-		if (!bh) {
-			block = qnx4_block_map(dir, blkofs);
-			if (block)
-				bh = sb_bread(dir->i_sb, block);
-			if (!bh) {
-				blkofs++;
-				continue;
-			}
-		}
-		*res_dir = (struct qnx4_inode_entry *) (bh->b_data + offset);
-		if (qnx4_match(len, name, bh, &offset)) {
-			*ino = block * QNX4_INODES_PER_BLOCK +
-			    (offset / QNX4_DIR_ENTRY_SIZE) - 1;
-			return bh;
-		}
-		if (offset < bh->b_size) {
-			continue;
-		}
-		brelse(bh);
-		bh = NULL;
-		offset = 0;
-		blkofs++;
-	}
-	brelse(bh);
-	*res_dir = NULL;
-	return NULL;
-}
-
-struct dentry * qnx4_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
-{
-	int ino;
-	struct qnx4_inode_entry *de;
-	struct qnx4_link_info *lnk;
-	struct buffer_head *bh;
-	const char *name = dentry->d_name.name;
-	int len = dentry->d_name.len;
-	struct inode *foundinode = NULL;
-
-	if (!(bh = qnx4_find_entry(len, dir, name, &de, &ino)))
-		goto out;
-	/* The entry is linked, let's get the real info */
-	if ((de->di_status & QNX4_FILE_LINK) == QNX4_FILE_LINK) {
-		lnk = (struct qnx4_link_info *) de;
-		ino = (le32_to_cpu(lnk->dl_inode_blk) - 1) *
-                    QNX4_INODES_PER_BLOCK +
-		    lnk->dl_inode_ndx;
-	}
-	brelse(bh);
-
-	foundinode = qnx4_iget(dir->i_sb, ino);
-	if (IS_ERR(foundinode))
-		QNX4DEBUG((KERN_ERR "qnx4: lookup->iget -> error %ld\n",
-			   PTR_ERR(foundinode)));
-out:
-	return d_splice_alias(foundinode, dentry);
-}
diff --git a/fs/qnx4/qnx4.h b/fs/qnx4/qnx4.h
deleted file mode 100644
index 5c2b1fb6b952..000000000000
--- a/fs/qnx4/qnx4.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/fs.h>
-#include <linux/qnx4_fs.h>
-
-#define QNX4_DEBUG 0
-
-#if QNX4_DEBUG
-#define QNX4DEBUG(X) printk X
-#else
-#define QNX4DEBUG(X) (void) 0
-#endif
-
-struct qnx4_sb_info {
-	unsigned int		Version;	/* may be useful */
-	struct qnx4_inode_entry	*BitMap;	/* useful */
-};
-
-struct qnx4_inode_info {
-	struct qnx4_inode_entry raw;
-	loff_t mmu_private;
-	struct inode vfs_inode;
-};
-
-extern struct inode *qnx4_iget(struct super_block *, unsigned long);
-extern struct dentry *qnx4_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags);
-extern unsigned long qnx4_count_free_blocks(struct super_block *sb);
-extern unsigned long qnx4_block_map(struct inode *inode, long iblock);
-
-extern const struct inode_operations qnx4_dir_inode_operations;
-extern const struct file_operations qnx4_dir_operations;
-extern int qnx4_is_free(struct super_block *sb, long block);
-
-static inline struct qnx4_sb_info *qnx4_sb(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
-static inline struct qnx4_inode_info *qnx4_i(struct inode *inode)
-{
-	return container_of(inode, struct qnx4_inode_info, vfs_inode);
-}
-
-static inline struct qnx4_inode_entry *qnx4_raw_inode(struct inode *inode)
-{
-	return &qnx4_i(inode)->raw;
-}
-
-/*
- * A qnx4 directory entry is an inode entry or link info
- * depending on the status field in the last byte. The
- * first byte is where the name start either way, and a
- * zero means it's empty.
- *
- * Also, due to a bug in gcc, we don't want to use the
- * real (differently sized) name arrays in the inode and
- * link entries, but always the 'de_name[]' one in the
- * fake struct entry.
- *
- * See
- *
- *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578#c6
- *
- * for details, but basically gcc will take the size of the
- * 'name' array from one of the used union entries randomly.
- *
- * This use of 'de_name[]' (48 bytes) avoids the false positive
- * warnings that would happen if gcc decides to use 'inode.di_name'
- * (16 bytes) even when the pointer and size were to come from
- * 'link.dl_name' (48 bytes).
- *
- * In all cases the actual name pointer itself is the same, it's
- * only the gcc internal 'what is the size of this field' logic
- * that can get confused.
- */
-union qnx4_directory_entry {
-	struct {
-		const char de_name[48];
-		u8 de_pad[15];
-		u8 de_status;
-	};
-	struct qnx4_inode_entry inode;
-	struct qnx4_link_info link;
-};
-
-static inline const char *get_entry_fname(union qnx4_directory_entry *de,
-					  int *size)
-{
-	/* Make sure the status byte is in the same place for all structs. */
-	BUILD_BUG_ON(offsetof(struct qnx4_inode_entry, di_status) !=
-			offsetof(struct qnx4_link_info, dl_status));
-	BUILD_BUG_ON(offsetof(struct qnx4_inode_entry, di_status) !=
-			offsetof(union qnx4_directory_entry, de_status));
-
-	if (!de->de_name[0])
-		return NULL;
-	if (!(de->de_status & (QNX4_FILE_USED|QNX4_FILE_LINK)))
-		return NULL;
-	if (!(de->de_status & QNX4_FILE_LINK))
-		*size = sizeof(de->inode.di_fname);
-	else
-		*size = sizeof(de->link.dl_fname);
-
-	*size = strnlen(de->de_name, *size);
-
-	return de->de_name;
-}
diff --git a/fs/qnx6/Makefile b/fs/qnx6/Makefile
index bd4e6c8efbc6..8cbb75199aa8 100644
--- a/fs/qnx6/Makefile
+++ b/fs/qnx6/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Makefile for the linux qnx4-filesystem routines.
+# Makefile for the linux qnx6-filesystem routines.
 #
 
 obj-$(CONFIG_QNX6FS_FS) += qnx6.o
-- 
2.56.0

