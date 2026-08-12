Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00E401A18
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572767; cv=none; b=JGzLDKH/Zo9XtNLKslW8KeVTPO9bEmgHwdUnYOFrhO7zqaKdgxB1Q2nRcJbKKsJsPQc5MOewl4NnMskvz3cXCcvv2eoSHuakBHGfLN4PKR/9wXUs+pUjNV9hq/p0jMq2ztjQCZJMVLXlktrW6yHZRYBHrmTgI3vA3/MTCDAvkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572767; c=relaxed/simple;
	bh=Is376u66NJUVEICdZZjhQwQBbazkaX1ZEK94fGGowVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRDqt2TZ3Qft1V0uNvqNzQ77h3yWxoN/UoB+yJD4byS8j1fqDfA5knrUtfPPy+PwmWEluzPm6IsJ/VCycmlzB8Z5FU5UVS6EvZEw8j2UKNwIQIdRqJtuA2NHZLXNPod5y4szSk0aUKif+4vR3U6CI2tPKmIpvuVTMfrEJPN+N3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qFcl04QA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qFcl04QA"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81e6f0b4610so17507857b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786572765; x=1787177565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wEHrc7cVeGQDhtOs+7YjJxGekyx66Vw8oTm0JbZT1ss=;
        b=qFcl04QAb15RjFeJ1JsSVShTZYcsRZXo+W5CJ2s34/c1FPVOrWmRwC+Ko91tYcu+cA
         gcU7jjNPqYP2IBF+h4KRcnm8FqES5XlyAsmi189adsSkdePcXfSdRsC3C4WTLaL6grW6
         +1J/M4NmIkE2xtorx4pzp/pSTFG87kWV4OZNtCSHxHy72lHHzkk5ny3SUzz/mTfeJyb2
         9Egx/1cXcgQdo5v4FyB65kHria5Tu25aSaOm1BGGLBqGZA80JNEP1O7MIek7QRcpQdnn
         xn6sV4dthroyz7GiC5iClASxdjfLfNJw3MSHxu3L4wjWA46pq+pSviNUwg3epVxQqSvJ
         0KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572765; x=1787177565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wEHrc7cVeGQDhtOs+7YjJxGekyx66Vw8oTm0JbZT1ss=;
        b=pv6MzMinb3YeX8h3d3di1Mf1DhPpilcrE2spQkKC+NIUdORwh5yIFajeXoNIL+dugq
         vqT6I4W5AjV8RvxDTwKWkc65iZL4I3x4XQHtPiLRoxCCVphnj3AmAQNiLJkY4tRCIGJz
         WSx5titRxF8uZ0/F6ePWRuAoNDt/DEATpfEX2XREUzFyMwVazz4Hn82pP0mMH8yfukBG
         l/IH11i+WV3qyIh7ANqT/1O/F1fVSDkrD0k229FoYujrW4Lp9t4UYQoRkpp/M74OpnqG
         vpULrtMCKBOe1ZWVmFyhk80FGNMB2Y5/pMMhYe5I2xYClsbPeoieL6412bOnuEdA64sE
         0a7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoR4h2VLRA3fddKxYf6LBXq4jypJCil89JWZIqsCYJUMLw8rQIyRtdM1aV+E4qi38JRm8p0Ns1Nz3xdxH4i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BrdWVP54p80GZFNKsVdKdxRZW1bRDrBXmJANFjmHthUUoRLi
	rveLxJgKvaYdJ2To+1y1CTtt60A4hjVnrEqTOmrF2feV2rX3BoDlLCSL2lKj5r6maTQ=
X-Gm-Gg: AR+sD13OdBrax2Ek7mZPBKuHQgffHVdnSmj3tW+dQIUm766vx+RPVTbHQ3SgYe39Y5V
	AmV95UX+EFpTtlxpJHKml9QPWFMTe8qc+0HEv5xKnSQPayEfeRS5EH4AkWCTSb2v7aJ53/bfNwL
	hBM04AOE9ppjYKC+/kpUu2aqYEiKHHukAFhGlIwqGHTfbCSlHyvLcBLKlgC+ilhTKfHhxMd25U0
	rp7sweETr6XXkYAkhTj7tFpnS5iF7II60jP+d24ZjK/I33WNeWQEllqoPEBOmS0SQdtnbQdYrAU
	t23aFG+1I0wRTtdrCarSDSnY8y0TbhjYxf4mQOJjZ5l0BbmxrA0rZPvKcNXWs/WOOqdOaSx7NT7
	1fqqE7mN8peY9Tnh4hkKKcAfXKO4rwgT+1W9e08rlmobxp7vVdwXFkxv6MnTR4EEtaG+M52g40p
	VmCcO4DAmj4FOpzSbc9Y4/jzo1DSPJWlR7NYrJx2UvRWHqkk3YA+6dbZDigXS0cLlFyCQCMVgeJ
	TKrVQgBQohICwm4mHZqAEAeMYRQGbneg2SDQ12/ADQsDvHvc5NXlAF/Fn6w62iqzbYbN61W+PP0
	FICHIejf/Ff+UOMOhA==
X-Received: by 2002:a05:690c:c510:b0:81f:4247:de16 with SMTP id 00721157ae682-83477c87641mr5117327b3.24.1786572764785;
        Wed, 12 Aug 2026 15:12:44 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:8bd1:139b:3c08:1f5b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8346e1a08b7sm2365367b3.37.2026.08.12.15.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:12:44 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: konishi.ryusuke@gmail.com,
	hch@lst.de,
	brauner@kernel.org
Cc: linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	lilinmao@kylinos.cn,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 2/2] nilfs2: switch O_DIRECT to iomap based operations
Date: Wed, 12 Aug 2026 15:11:54 -0700
Message-ID: <20260812221154.1119137-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812221154.1119137-1-slava@dubeyko.com>
References: <20260812221154.1119137-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch eliminates blockdev_direct_IO() from
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
 fs/nilfs2/file.c  | 42 +++++++++++++++++++++++++++++++++++++++---
 fs/nilfs2/inode.c | 13 -------------
 3 files changed, 40 insertions(+), 17 deletions(-)

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
index f93b68c4877c..30dd8e5ebe5b 100644
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
@@ -133,20 +136,53 @@ static int nilfs_file_mmap_prepare(struct vm_area_desc *desc)
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
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		inode_lock_shared(inode);
+		ret = iomap_dio_rw(iocb, to, &nilfs_iomap_ops,
+				   NULL, 0, NULL, 0);
+		inode_unlock_shared(inode);
+	} else
+		ret = generic_file_read_iter(iocb, to);
+
+	return ret;
+}
+
+static ssize_t nilfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	/*
+	 * NILFS2 lacks direct I/O write support: fall back to buffered writes.
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
index 34e6096069ad..cbe9658ae065 100644
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

