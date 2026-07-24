Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CF44E64F
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932086; cv=none; b=G46WbdBxGW8B2bE5+45SCWRDOkzUKxWZyEmFjEVFMwjLueh15M0ovElVveCcBwLo/gAHZA9o1HrDYxkvgXkBfhDfx4JcYftw7HOA8+q4xVG3tiK5KKwNXGJDB9JxJ92CCZojCLxwW2ohSewK31t9hrYbYu2uAxUQe9Qlxf9HMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932086; c=relaxed/simple;
	bh=KPv4KkbHpDLjFoMbEPupXdFgpw/p2FaSa2WoYX6AXAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfUbxkTf6HFd72izl4bFMK4Bj2eLowaps7b109S6uFE9pLN7poJgJ0A+iLgxRa5EHnumqtkY7jZyp36d1q5T7/2xgSU7jeX7y6OEtAHJ+P7Zi22pL4F2PREOOFhbDZRZtTLv7I5r7f0ksbRQcv6FVjzyMBqjhr0qHMmPP8zx4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=iq/jpDEl; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="iq/jpDEl"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664e3ed58bcso1767828d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784932084; x=1785536884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W5ucNxoq8oX/9er0chVBnOyqnwlgREIEe3hS2bG+kEw=;
        b=iq/jpDEltMYAxz2RcTjZ5It4p8lv2PhPz1wU2cB0BuINZ4zMA8au8tIgZjthmJ9rrO
         cCTG9LWDQ5HGZDHhwRe6ibvKAsTXT41P6HRmUEje8PCijUjx3XQ5rsdYrm9ujtRErDJ9
         f4WYVlB8hXwKATMY4eZw17vZZgSSjIdqp+bo+EKq5GuMV5aW9QjUIK66o1Wt79YiQkzZ
         PSanNwfSVNp3r3zZIOlA63ik3VxMBqqcKvAdEb10PM+SD8ZqUjtDdENRln+5Uu23+GBh
         Tnm1Qs4dWHn2c/hh4jinHzgiS6gKqCxqWGKTDC0kjpftgDTit/QaTpnM/5qkdp4CXnZY
         lKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784932084; x=1785536884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W5ucNxoq8oX/9er0chVBnOyqnwlgREIEe3hS2bG+kEw=;
        b=MItqTTDOcoydQEbukePKUvENguStNd5nHvfGabd3c1zgXL+tD72boh+v1CYrSrUoG8
         Zgc0sYSMmFcwUElJsbTMyD3yxHjigv4q3rjFFrPtDuDdf4W/9/DiZwY6GJMs7pOybJBr
         y3yNIDCq0qD4UsOJGyP7Tv3TjaGsD4HFQ5t02l8ufvnalry9atmGesg/LDcRU9i3yeqN
         oHHKfyedFEVcW9h2gO4ED8pc4U5RdHUk0Q5JHVuv4yfvA1ZvE+7+0wen9qUDTMz33A/K
         prO8gwvsRzZAnTOD4s1XUkSboaJ3BHuJsrzqMfIfUEA5EiFDrwSurelBeiWTCh3L4nKd
         CF2A==
X-Forwarded-Encrypted: i=1; AHgh+RodeYaoopSmxuCkZ5mXL/b1z2kjsDja+hWkEpoc7mcdUTLFc7mPgZe8uqPDGAd7lursCgBWl2CAQPtpEcjb@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqqCvHQDaTX3VdHb6lDOHeiWt8pPJcYh2h7cthchS4I2U46gF
	0B0iDrQ94lpncn5Mddq9/h9Fpng0fnYbMibAduZJ/3Dt5PhlzaXFyZPtTC9Qn3vVuOc=
X-Gm-Gg: AR+sD12ZjrXU6EpPqype6fBKiH7+CyIwnG5RBXR2t2dXECCRzunlD7YRU68k3Uf/6Eb
	bpSV+b7UVNYvxlfvJ+ZpfseZw1+DSJA0Bql1JPFGVSqCT9Umq3N52ryn+8VBaomc05NsepO3Eug
	CzPn2BA46YA4tEubfhmnM15iyb4pJeppcakZ1tuY674LlutOpD80QJ3UxwtP1N21YHVvHBtiukM
	MPTSif/ReIt1StZ2lZXbGcqOl3xV9NT5drSPlWkrilX4QzyvDFSKQpVETGEA/cthKSQFlRQdjjR
	ppK8t2SLZmRw8LuvdcmAacIN6tKDrAygpubJ3KskC5rX3Xz1hwtETqz7Vv/FfQAE2+H+W9OUOPK
	KyPifdr290qYDzT5pNjilQcbShmvz8U/PD80pXevsmXcJCH76/hQGQ6KlDeg0pppXF3M1A8DCFb
	ZSaHOxnkqj6btvfIB8T1MJeOE1EfbQ6AWqeg7KdxYxj4OXI0avMnVgSOnLZ53Z0l1kUMt25k4SJ
	ABphIO2TH8hPuAWR8+qtC9ihxVqjZ2pXca17RKjH3HDWg==
X-Received: by 2002:a53:ed01:0:b0:664:d5ff:2856 with SMTP id 956f58d0204a3-668bfd9f557mr534973d50.14.1784932084236;
        Fri, 24 Jul 2026 15:28:04 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c7041256sm90525d50.19.2026.07.24.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:28:03 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: konishi.ryusuke@gmail.com,
	hch@lst.de
Cc: linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/2] nilfs2: add iomap operations for direct I/O reads
Date: Fri, 24 Jul 2026 15:27:44 -0700
Message-ID: <20260724222745.2107464-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724222745.2107464-1-slava@dubeyko.com>
References: <20260724222745.2107464-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap.c and iomap.h with a read-only nilfs_iomap_ops,
wrapping the existing nilfs_bmap_lookup_contig() lookup
to report a mapped range, a real hole, or an EOF-clamped
range to iomap core.

NILFS2 is a log-structured, copy-on-write filesystem:
newly allocated blocks are only given a real disk address
when the segment constructor writes them out as part of a log,
which walks buffer_head lists directly and is not integrated
with the generic address_space writeback path. Because of that,
only the read-only side of the mapping is added - buffered writes,
writeback, and mmap's ->page_mkwrite() will stay on the existing
buffer_head based path (nilfs_get_block(), nilfs_write_begin/end(),
nilfs_writepages(), nilfs_dirty_folio(), block_page_mkwrite()).

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
cc: linux-nilfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/nilfs2/Makefile |  2 +-
 fs/nilfs2/iomap.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/iomap.h  | 13 +++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 fs/nilfs2/iomap.c
 create mode 100644 fs/nilfs2/iomap.h

diff --git a/fs/nilfs2/Makefile b/fs/nilfs2/Makefile
index 43b60b8a4d07..516e6b85a03c 100644
--- a/fs/nilfs2/Makefile
+++ b/fs/nilfs2/Makefile
@@ -3,4 +3,4 @@ obj-$(CONFIG_NILFS2_FS) += nilfs2.o
 nilfs2-y := inode.o file.o dir.o super.o namei.o page.o mdt.o \
 	btnode.o bmap.o btree.o direct.o dat.o recovery.o \
 	the_nilfs.o segbuf.o segment.o cpfile.o sufile.o \
-	ifile.o alloc.o gcinode.o ioctl.o sysfs.o
+	ifile.o alloc.o gcinode.o ioctl.o sysfs.o iomap.o
diff --git a/fs/nilfs2/iomap.c b/fs/nilfs2/iomap.c
new file mode 100644
index 000000000000..3ae3bf6ed368
--- /dev/null
+++ b/fs/nilfs2/iomap.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NILFS iomap support implementation.
+ *
+ * Written by Viacheslav Dubeyko.
+ */
+
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
+#include "nilfs.h"
+#include "mdt.h"
+#include "iomap.h"
+
+static int nilfs_iomap_begin(struct inode *inode, loff_t offset,
+			     loff_t length, unsigned int flags,
+			     struct iomap *iomap, struct iomap *srcmap)
+{
+	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct nilfs_inode_info *ii = NILFS_I(inode);
+	sector_t blkoff = offset >> inode->i_blkbits;
+	unsigned int maxblocks;
+	__u64 blknum = 0;
+	int ret;
+
+	/* Completely beyond EOF. Treat as hole */
+	if (i_size_read(inode) <= offset) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->offset = offset;
+		iomap->length = length;
+		return 0;
+	}
+
+	/* Clamp length if the requested range goes beyond i_size */
+	if (offset + length > i_size_read(inode)) {
+		loff_t i_size = i_size_read(inode);
+		unsigned int blocksize = i_blocksize(inode);
+
+		length = round_up(i_size, blocksize) - offset;
+	}
+
+	maxblocks = min_t(loff_t, length >> inode->i_blkbits, INT_MAX);
+	if (maxblocks == 0)
+		maxblocks = 1;
+
+	down_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
+	ret = nilfs_bmap_lookup_contig(ii->i_bmap, blkoff, &blknum, maxblocks);
+	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
+
+	if (ret == -ENOENT) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->offset = offset;
+		iomap->length = min_t(loff_t, length, i_blocksize(inode));
+		return 0;
+	} else if (ret < 0)
+		return ret;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = offset;
+	iomap->length = min_t(loff_t, length, (loff_t)ret << inode->i_blkbits);
+	iomap->addr = (loff_t)blknum << inode->i_blkbits;
+	iomap->type = IOMAP_MAPPED;
+	iomap->flags = IOMAP_F_MERGED;
+
+	return 0;
+}
+
+const struct iomap_ops nilfs_iomap_ops = {
+	.iomap_begin = nilfs_iomap_begin,
+};
diff --git a/fs/nilfs2/iomap.h b/fs/nilfs2/iomap.h
new file mode 100644
index 000000000000..adef3e22346d
--- /dev/null
+++ b/fs/nilfs2/iomap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * NILFS iomap support declarations.
+ *
+ * Written by Viacheslav Dubeyko.
+ */
+
+#ifndef _NILFS_IOMAP_H
+#define _NILFS_IOMAP_H
+
+extern const struct iomap_ops nilfs_iomap_ops;
+
+#endif /* _NILFS_IOMAP_H */
-- 
2.43.0

