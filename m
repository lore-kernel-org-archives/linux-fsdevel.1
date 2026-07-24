Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2444C501
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932088; cv=none; b=r8iwZX/HQVzBGfxxIoYaSLKBMsI3paqdDpR01g66Soa/wbUSB1pA2lwQqJo19d66FHDe5AsoTJT1hurODSTxh8abMOv9VK0l/UqMV4jN9K43bSZ7uXfd9NrDeevxF1aTls2LWL3LbpUh+v+4pECpELctzAdBpK8tC45lsvYnsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932088; c=relaxed/simple;
	bh=nlChQcQrJXTwFLUuNGHfP/zPzy72HVspRm+dy+qeWRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTlBf4DeUdwm3wIq4fvQtvwGCWyVHayuxuUJkdsmrJVzbGkJ/5DtfdDfUUdCN3kQv4T0eWrpnqliH5dvdpWZ09YuNCR+nLzgOhjL7rzSWmI7KaPCTvSCKW1aUCjd8pS3Sg9kB+uO214LJpXIzuN3rPwKlOLWfHQcjULpjwLUJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=X2k978C9; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="X2k978C9"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6689f36ae56so929145d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784932086; x=1785536886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OsrwBFQOpazQ1OCfuB2NXT3UJnRkJ+I5qsH6JGePHbw=;
        b=X2k978C970nBPC+P3zzLXCx7Rfr14AI1X47kFo/Mi7TE49UuazonM6xmFwNJzib+Wp
         EILqwhy0dbyMZ6edg+M4fvjgY1dhs3nOrJrwYL81j8/d0ueARdse9F2TOrCy+aLZmhy3
         J9KMQuhLcj7M+AvpGeIOKu7+Re/MCdYnokiYwkB42+LOnyUw04fv/xcCymp1nCv6FYIU
         HFWX97M3WQm0HRPBFIN4GO3HivNPj0hkuyYF8y+Bx3n3drD66ECaS8ZBBUnFOEMukfJr
         euYQ3sYnpRcp6puXCNJA0woNOa7Sez1Bwh40XfxIymVSs5qN8f86iKE2g9MNUHV1jNsg
         1jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784932086; x=1785536886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OsrwBFQOpazQ1OCfuB2NXT3UJnRkJ+I5qsH6JGePHbw=;
        b=DWEybM6VWOg3OWMwRT+R3hCrJNImaCALs5DyS4lzSWpHbmczwZEpWhRL78+cV0txH1
         hxHFxfRZTfZJKvtDk/i1fKqMdDyl8ktve/MiTbwZWjQ9VqEdKL4Or/wv+nsgObPNTYLZ
         XaiRRJ/GxJvFQsoJoqwFB4z9FJMivR9WR6kh4vT5cggocY6iZi9TVPe+KrpRjXURJlXP
         Ncty6f+7utuEjNxgiJxqORvp98mhBMZKl7cdbT3ICiwjD8DDOj1Ea/bs+Oe7CEDjXFbO
         M0VvOU/BJKY2Kqvbk8twIN8Z+YG6o6Aw8sTNlXDNQb1eCGd80L0FnieSWa73CqpKib2E
         ig7g==
X-Forwarded-Encrypted: i=1; AHgh+Rr1xJVl5SMlUbOqb+W9+XL4T91c0wSLwdBHuahKsg+Nbw4jQbU3BvXI0/DCL13jbjD/o667SFVnhr+CBoff@vger.kernel.org
X-Gm-Message-State: AOJu0YynlJ5BM7lyKusvGGU03KxgKlL8S7V43xiUCFDp/yWCdG3lljH+
	TDn+0RZg63TYtUki39Txzqii0NmjuiE0G/aAzQz4WTP23IwmnM4FrCMXfkmJI11Zs7o=
X-Gm-Gg: AR+sD13xdLRy64nnW/kT9EpxddvyiveB82oYabvZ4Up6tngDbpTFmlKcGD1todC2fNo
	Qqk95Iu/3JjoFwyzhMK60tha325FmzL4LfmpvUthe6FpN7U1Pcf79wOOcVCS6af7nGN+qmuKYnO
	7wqMh8bm//yg9XtN7o4mniK038qfDPcj/7qOqkvSF8kP2smttAlf6/XA1U5E3sG01nq+3kXe9lE
	YCHV5NAYaZ7E86fGQWm27mn6/wHbjmcENsj82C7eFGxp+as9IyYhmXl7oi7gj7d0ZXNYytzmlS0
	dgvFjOEzysMMdaVESozjVd0YSoFExgFWwNLJonAWYGdjkXZQSYLqcAmCRr0rH427A7XiYgqXnbe
	SVbF013dG9tV+MTcPte+GgqemSStS0EPe2FCviwNlfVW43nqfnqjxOVlDNx8yQvcDpRDlLlamc1
	yw+vRInjH1EcVmwZnyvLr7bG4NCoN/eSKy3Uzg6xIWScwDolI4ffc8fp49C21jRLZcVNfqJIhFy
	T1o2UkibEmmlHmmnc5zmNsClBaENl+N5u0jyx25tghYuA==
X-Received: by 2002:a05:690e:440d:b0:668:10b6:fe78 with SMTP id 956f58d0204a3-668c7a1490fmr27078d50.27.1784932085993;
        Fri, 24 Jul 2026 15:28:05 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c7041256sm90525d50.19.2026.07.24.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:28:05 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: konishi.ryusuke@gmail.com,
	hch@lst.de
Cc: linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/2] nilfs2: switch O_DIRECT reads to iomap
Date: Fri, 24 Jul 2026 15:27:45 -0700
Message-ID: <20260724222745.2107464-3-slava@dubeyko.com>
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

Wire the read-only nilfs_iomap_ops added in the previous patch into
the O_DIRECT read path, and eliminate blockdev_direct_IO() from
nilfs2 entirely:

 - nilfs_file_open() now sets FMODE_CAN_ODIRECT explicitly, since
   permission to open the file O_DIRECT was previously implied by
   aops->direct_IO being non-NULL.
 - nilfs_file_read_iter() dispatches O_DIRECT reads to iomap_dio_rw()
   using nilfs_iomap_ops; everything else still goes through
   generic_file_read_iter() as before.
 - nilfs_file_write_iter() strips IOCB_DIRECT and falls through to
   generic_file_write_iter()'s ordinary buffered path. NILFS2 cannot
   perform true direct I/O writes: new blocks are delay-allocated and
   only given a real disk address by the segment constructor, which
   works on buffer_head lists, not iomap. This reproduces today's
   actual behavior: the old nilfs_direct_IO() already just returned 0
   for WRITE.
 - nilfs_direct_IO() and the .direct_IO callback on nilfs_aops are
   removed.
 - drop the unnecessary "select LEGACY_DIRECT_IO" from Kconfig
   in favor of "select FS_IOMAP".

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
cc: linux-nilfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/nilfs2/Kconfig |  2 +-
 fs/nilfs2/file.c  | 40 +++++++++++++++++++++++++++++++++++++---
 fs/nilfs2/inode.c | 13 -------------
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/nilfs2/Kconfig b/fs/nilfs2/Kconfig
index 7dae168e346e..0a5ace60e6ab 100644
--- a/fs/nilfs2/Kconfig
+++ b/fs/nilfs2/Kconfig
@@ -3,7 +3,7 @@ config NILFS2_FS
 	tristate "NILFS2 file system support"
 	select BUFFER_HEAD
 	select CRC32
-	select LEGACY_DIRECT_IO
+	select FS_IOMAP
 	help
 	  NILFS2 is a log-structured file system (LFS) supporting continuous
 	  snapshotting.  In addition to versioning capability of the entire
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index f93b68c4877c..ad2e87c049c9 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -10,9 +10,12 @@
 #include <linux/fs.h>
 #include <linux/filelock.h>
 #include <linux/mm.h>
+#include <linux/uio.h>
+#include <linux/iomap.h>
 #include <linux/writeback.h>
 #include "nilfs.h"
 #include "segment.h"
+#include "iomap.h"
 
 int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
@@ -133,20 +136,51 @@ static int nilfs_file_mmap_prepare(struct vm_area_desc *desc)
 	return 0;
 }
 
+static int nilfs_file_open(struct inode *inode, struct file *file)
+{
+	file->f_mode |= FMODE_CAN_ODIRECT;
+	return generic_file_open(inode, file);
+}
+
+static ssize_t nilfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		return iomap_dio_rw(iocb, to, &nilfs_iomap_ops,
+				    NULL, 0, NULL, 0);
+	} else
+		return generic_file_read_iter(iocb, to);
+}
+
+static ssize_t nilfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	/*
+	 * NILFS2 cannot perform true direct I/O writes: new blocks are
+	 * delay-allocated and are only given a real disk address when
+	 * the segment constructor writes them out as part of a log,
+	 * which works directly on buffer_head lists rather than
+	 * through iomap. Fall back to the ordinary buffered write path
+	 * for O_DIRECT writes.
+	 */
+	if (iocb->ki_flags & IOCB_DIRECT)
+		iocb->ki_flags &= ~IOCB_DIRECT;
+
+	return generic_file_write_iter(iocb, from);
+}
+
 /*
  * We have mostly NULL's here: the current defaults are ok for
  * the nilfs filesystem.
  */
 const struct file_operations nilfs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
+	.read_iter	= nilfs_file_read_iter,
+	.write_iter	= nilfs_file_write_iter,
 	.unlocked_ioctl	= nilfs_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= nilfs_compat_ioctl,
 #endif	/* CONFIG_COMPAT */
 	.mmap_prepare	= nilfs_file_mmap_prepare,
-	.open		= generic_file_open,
+	.open		= nilfs_file_open,
 	/* .release	= nilfs_release_file, */
 	.fsync		= nilfs_sync_file,
 	.splice_read	= filemap_splice_read,
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 51f7e125a311..f4a9d9ea9c3f 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -257,18 +257,6 @@ static int nilfs_write_end(const struct kiocb *iocb,
 	return err ? : copied;
 }
 
-static ssize_t
-nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-
-	if (iov_iter_rw(iter) == WRITE)
-		return 0;
-
-	/* Needs synchronization with the cleaner */
-	return blockdev_direct_IO(iocb, inode, iter, nilfs_get_block);
-}
-
 const struct address_space_operations nilfs_aops = {
 	.read_folio		= nilfs_read_folio,
 	.writepages		= nilfs_writepages,
@@ -277,7 +265,6 @@ const struct address_space_operations nilfs_aops = {
 	.write_begin		= nilfs_write_begin,
 	.write_end		= nilfs_write_end,
 	.invalidate_folio	= block_invalidate_folio,
-	.direct_IO		= nilfs_direct_IO,
 	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 };
-- 
2.43.0

