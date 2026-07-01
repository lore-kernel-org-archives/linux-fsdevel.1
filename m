Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5A18C02E;
	Wed,  1 Jul 2026 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867310; cv=none; b=sujxYNnhTDvOzicnUB+9bAEKxaJHg7qtvy0NDpGpvLwGaJySfIf2Vs+P49AQA4DT4bWiMlxiCsYOAYE8OE0mDdq1TbP9XrzfRm+bfNDhBUYc8ok6uH18BkkoxHHUYRAtC+IJfgcMnLH+G5AB/EvFpiZI16xIiHwWY/enfbImveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867310; c=relaxed/simple;
	bh=zlRU8k43xxPeauY9ORP6dZUdXaAVxHr1Y64Gb68EKUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDBtKcFG8GjCSPnBs+ugjssh/+cAhVp9jvMvG6vg3leu+jsa3shvGEjvnlZWj4bY7P85Wo9Wx6Atmq6tQ2YKhm8Hf0xLlKRXmFfGZJNiQwrSdcNQqlbpvr5D92gp0lZTN4Zpzfq5ucBq42/mt27hNqvCPRciTEpXXNGrszw/XDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d69lzQcd; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d69lzQcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=V6
	aurOX2olWoi4OwHEM5E87X76kujE7WVqVvxd+NyJ8=; b=d69lzQcdLuUS77EoKp
	1hADq28+mtaYpuIPn5SC2f3gnzwpfdD5wlnLE2j864j3evQCDXwM8GWUGqSeUY4m
	1RX1dga/WyWo3ZE6gPYFLblsGHFSvx1c8Im1cmxrCx/vwik/i2AOb71Nk7uAn4Um
	HoAfFJpZVXw7lsDJf9Z5tpE/Y=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD39zZRZURqfnD3Ew--.11070S2;
	Wed, 01 Jul 2026 08:54:42 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] exfat: validate cached iomaps during buffered writes and writeback
Date: Wed,  1 Jul 2026 08:54:18 +0800
Message-ID: <20260701005418.735715-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD39zZRZURqfnD3Ew--.11070S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy7ZFWrXry3KF1DWFW5Awb_yoWrAr18p3
	yDK3W3GrZ7X3W7Ww1UGFyUZ3WFk3s3KFW7J34rGws0vryqv342ka4UKFy29F15J3s7Cr42
	vF4F9ryUGrs7CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnxhdUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xMZtmpEZVMjVQAA3l

From: Chi Zhiling <chizhiling@kylinos.cn>

Writeback does not hold i_rwsem and can race with truncate or other
operations that change the file's block mapping. This may leave cached
iomaps stale, causing writeback to write data to blocks that no longer
belong to the file.

Track iomap validity with exfat's cache_valid_id and implement
iomap_valid() so cached iomaps are revalidated after the folio is locked.
If the mapping has changed, a new iomap is obtained before writeback
continues.

This matches the iomap validity model used by XFS and prevents data
corruption from stale cached iomaps.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c |  7 ++++---
 fs/exfat/file.c  |  4 ++--
 fs/exfat/iomap.c | 15 +++++++++++++--
 fs/exfat/iomap.h |  1 +
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 7c8b4182f5de..71631bab182c 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -228,9 +228,10 @@ static void __exfat_cache_inval_inode(struct inode *inode)
 		exfat_cache_free(cache);
 	}
 	/* Update. The copy of caches before this id is discarded. */
-	ei->cache_valid_id++;
-	if (ei->cache_valid_id == EXFAT_CACHE_VALID)
-		ei->cache_valid_id++;
+	if (ei->cache_valid_id + 1 == EXFAT_CACHE_VALID)
+		ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
+	else
+		ei->cache_valid_id = ei->cache_valid_id + 1;
 }
 
 void exfat_cache_inval_inode(struct inode *inode)
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 5fc13378d35f..4258398ca641 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -772,8 +772,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		ret = exfat_dio_write_iter(iocb, iter);
 	else
-		ret = iomap_file_buffered_write(iocb, iter,
-				&exfat_write_iomap_ops, NULL, NULL);
+		ret = iomap_file_buffered_write(iocb, iter, &exfat_write_iomap_ops,
+						&exfat_iomap_write_ops, NULL);
 	if (ret < 0)
 		goto unlock;
 
diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 1aac38e63fe6..efced320a5ef 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -56,6 +56,7 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 			iomap->addr = IOMAP_NULL_ADDR;
 			iomap->offset = offset;
 			iomap->length = length;
+			iomap->validity_cookie = ei->cache_valid_id;
 			return 0;
 		}
 
@@ -133,7 +134,7 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 		}
 	}
 
-	iomap->flags |= IOMAP_F_MERGED;
+	iomap->validity_cookie = ei->cache_valid_id;
 out:
 	mutex_unlock(&sbi->s_lock);
 	return err;
@@ -155,6 +156,15 @@ const struct iomap_ops exfat_iomap_ops = {
 	.iomap_begin = exfat_iomap_begin,
 };
 
+static bool exfat_iomap_valid(struct inode *inode, const struct iomap *iomap)
+{
+	return EXFAT_I(inode)->cache_valid_id == iomap->validity_cookie;
+}
+
+const struct iomap_write_ops exfat_iomap_write_ops = {
+	.iomap_valid = exfat_iomap_valid,
+};
+
 /*
  * exfat_write_iomap_end - Update the state after write
  *
@@ -201,7 +211,8 @@ static ssize_t exfat_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
 {
 	if (offset < wpc->iomap.offset ||
-	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+	    offset >= wpc->iomap.offset + wpc->iomap.length ||
+	    !exfat_iomap_valid(wpc->inode, &wpc->iomap)) {
 		int error;
 
 		error = __exfat_iomap_begin(wpc->inode, offset, len,
diff --git a/fs/exfat/iomap.h b/fs/exfat/iomap.h
index fd8a913f7794..39c93f8cd790 100644
--- a/fs/exfat/iomap.h
+++ b/fs/exfat/iomap.h
@@ -9,6 +9,7 @@
 extern const struct iomap_dio_ops exfat_write_dio_ops;
 extern const struct iomap_ops exfat_iomap_ops;
 extern const struct iomap_ops exfat_write_iomap_ops;
+extern const struct iomap_write_ops exfat_iomap_write_ops;
 extern const struct iomap_writeback_ops exfat_writeback_ops;
 extern const struct iomap_read_ops exfat_iomap_bio_read_ops;
 
-- 
2.43.0

