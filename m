Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDF223336
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149354; cv=none; b=nJivUDF+8fY/v7lq1yXUELPeWV43a6dM1tmXOBE4nN8pLzeGDgrFkGsGjUeeUfg+xq3XsaiavRfTot7Ypym4plRMKtjsQ47t2lWVfNq+UWkg6LprS42Xmqr9+wKUvyjZIMFd4A0DKL4EguWYPjELxvb+oh04hRnjyqOUjXFkYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149354; c=relaxed/simple;
	bh=59RWqJsio1nPj2W1r+lB1kt+zvnkFT4OfxTo1o6d3I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6QT7VuJVuZ9N5pDaPiWVzr6PSn13lGZscPAWVMvbANQ1YzvYHfZEey5Lkx4S6qtfECAP9r1ANNP9lCc7Yhza6PCh0uNAyE7KEYklraYxu/PI89N3gwNiG7Jfb+CU5j0ecZmYWv/7A/afPcdjgvv65trfIcOs8IlnrA4pF4yw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=is6MzIpX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="is6MzIpX"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81dfdbd86d1so819297b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Aug 2026 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786149352; x=1786754152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vx6j+PNuXPtNCAhHvs/xK91ts4OMPwcyyq+VucjW0hU=;
        b=is6MzIpXQY6iWjnmLgT/URW0bfC0FPnznQMEwBDtTBHOrJTkGM+F+XFTzC9LxwROOD
         xyhoo23zsWl6aE8nj2MECOw99Bhiz+EAhQe9yt8zEBTTXvt9Glm5MIT571fSX2pngtua
         jU0TM3yKtHwf0qI0rYjTR06mKO6wqT/Jp/5wHPJoU11OKpzB9Syol5DEuvrSWkQ/cxmO
         zU9a56i+Fxxta451WMHiI2hCLKnscFjgSlUX72Ptne/RMNgYhkSd4l5JbP8Zi5s7myY2
         4GM+5ZrQk14+aZOBV1n6KYZ8gMceEZIrW4YVzyMlpcUNZoNGxmg4SddfY2D7rQkJguAI
         VqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149352; x=1786754152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vx6j+PNuXPtNCAhHvs/xK91ts4OMPwcyyq+VucjW0hU=;
        b=m73jI4WZGJbKnmZs5LYuAuMjWHFdlqiUoF8UZlzu/WlZnMkez/t0Eput5R5rkhbu/K
         u0hM6ICnhA7mremqeq7v8LjNbX0LLm/UamZsQVvEXx+L9w/E8ZB8O3X3vGwi6x8ikG4k
         9kWLlZgehcMeMW2IMzzchlXdagBafQKaojv/f0Jf73Ill4cXLyRZK2r2yhyDI9Mrk18q
         4n2ousJSvxQ79pTm3rlii7Ozu5h9l3tUG/VcZfhLrk+L0pXCdSXsCcpiVySvTIvMa7UG
         s42o28FMUAmw/Ys3Fg9cHsDu/TtbK5gSQYMZDHQJLO8K17kXX+tZSdQoP2HYyOC67tIl
         GgLw==
X-Forwarded-Encrypted: i=1; AHgh+RqhF7GWr5puc9GNKNaYehOHuI2YAaoYbOIh6Isz9Hx4UMlVtEHWm8Q0Uf99W5hYlAFkfbcNm18F0ZGYwIDC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhlf8jBqb46s1bZOlqhzMsc+IBMM5054lsIO3+Uei6X4VjZGCb
	LqZ9htnXpd61/StfIGxQSf6Tq3y+GMYbfY9oSOUKny7Fa4Tzj6d+AwFXuGIfCqrSz/s=
X-Gm-Gg: AR+sD11PzyQka4N1wUlRaLYYiiWN7ZWFm8Jd7mXaq3Eb+2WtGeTwULbzgtaBlyKsvxZ
	waGklyEPu0qVp4+WMyWg1DrD+TfPUACbn8iUcFya2KWEhPfQCSfs78svrAr0rBIXUV0h89GZWOc
	Cs62i6lcAnsQGT4ctx9z1TxarXfs5QbN5GRWLRX8rWcPtn0gYBk+2FQ8Eu5eDlhYqnGFPZUlaR0
	6gOX95pUpk8g7XHR2dhn4CojAia4kaEuUH8eZjefLixmXjqRRZhB0uh93ophYTphWN5Lr4DOFlh
	XcgBmxNWtsh1uH1Dz5cZ3vhBCejTau1iFpHabCf5GYHmQ7/kQ9wXQwW3XiyLLO4R8/ZxIvaAyqN
	dPX0BwPWNBgAnK5Gz1WOos7Ir7Qj9inJzvoubJwhWWbfOnV0LMXEy1eb08Xj0PbAmjTYfbAgAUE
	Gqd9vmvyq9SbYfeF0UTVPbcMbmCt4UGezkyH0dzaGJZGdOqsU1ZyfMdqQFHac2widVIcFIE5SJN
	9huwHVR/KiKtWciJjh9E6hkyQ90x9yIT0mAU1MExk2W/A/wHknBm5QykVHoCcfkzsc1/fwNfybR
	s75kVCrnZeTzn2AM6w==
X-Received: by 2002:a05:690c:2783:b0:81e:6fd:93b4 with SMTP id 00721157ae682-824443f51e5mr43249297b3.19.1786149351485;
        Fri, 07 Aug 2026 17:35:51 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:891e:7b31:87a7:701f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f577c580sm19024407b3.27.2026.08.07.17.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:35:50 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: konishi.ryusuke@gmail.com,
	hch@lst.de
Cc: linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	lilinmao@kylinos.cn,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 1/2] nilfs2: add iomap operations for direct I/O
Date: Fri,  7 Aug 2026 17:35:22 -0700
Message-ID: <20260808003523.2760509-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808003523.2760509-1-slava@dubeyko.com>
References: <20260808003523.2760509-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds iomap.h with declaration of iomaps
operations and iomap.c with implementation of
nilfs_iomap_begin(). This method is based on calling
the nilfs_bmap_lookup_contig() method. It resolves
the file's block-mapping to find the sequence of
physically-contiguous blocks starting at starting
block. Offsets at or beyond i_size are reported
as a hole. For offsets within i_size, the requested
length is first clamped to the block-aligned end of the file.
Both the hole and mapped cases then report iomap->offset
aligned to the containing block (blkoff << i_blkbits)
rather than the raw request offset.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Co-developed-by: Linmao Li <lilinmao@kylinos.cn>
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
cc: Christoph Hellwig <hch@lst.de>
cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
cc: linux-nilfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/nilfs2/Makefile |  2 +-
 fs/nilfs2/iomap.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/iomap.h  | 13 +++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
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
index 000000000000..e130ed63abd9
--- /dev/null
+++ b/fs/nilfs2/iomap.c
@@ -0,0 +1,72 @@
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
+	loff_t iomap_offset = (loff_t)blkoff << inode->i_blkbits;
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
+		iomap->offset = iomap_offset;
+		iomap->length = i_blocksize(inode);
+		return 0;
+	} else if (ret < 0)
+		return ret;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = iomap_offset;
+	iomap->length = (loff_t)ret << inode->i_blkbits;
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

