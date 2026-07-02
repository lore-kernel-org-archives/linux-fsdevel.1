Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D279181334;
	Thu,  2 Jul 2026 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960364; cv=none; b=l3fnO9CEdsDQCxK+lSgI1JLuDqcnEKrtb4ErBGyDLnML/KDFNbxJnXnOk4iy0qgJ8HYhbBN9izMQwUMCRTFh/lgwosRKjsEGCgAazUmlLX+qCzmNVUrJWz6+T+M5Lq0vBDzuGLdGd+K9GkJAcBfTj0yTNNBgC7A8Jq7CmZqxc5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960364; c=relaxed/simple;
	bh=av09hoQiRE/q22gUERL6ezzzQ4NdCNvybCFurrtebnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBBSiLPdk3ywtJ/YUNurHNr7RaNFFUwKLa4Edi08r4UMBdWtIG0ruhVoJVFRkGG6CmXpHl6KoCePGs9f9FJewrVHOT7NEuqFdoLTUX79jFkWmDOFjavh96AWCTMzM7tMmj+fcpt1RHn0eg43mRUJP0t15HyFPefh5hzshRt7OHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kjBfLHx2; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kjBfLHx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=XJ
	O/O6bMHtmyZPOb/2ot5e9QujA1cRbhy/fKMslRVWk=; b=kjBfLHx2X7BLjDh97v
	+EvEfolCC7DIDtEmN8P02IZOxNOSbAFLoYWwy+xXXKZKmsSYyfihXu5k7ECXgkjc
	28F5gO8YfB8ePa8fTwWaV2UqQQjv0cH3VA0moDJmpIBYSacMaGMrJWS35DVXrxU2
	rs+dl4mrkbNoFQM9edI3lNM/U=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXn__U0EVqY1M6HQ--.54484S2;
	Thu, 02 Jul 2026 10:45:41 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3] exfat: validate cached iomaps during buffered writes and writeback
Date: Thu,  2 Jul 2026 10:45:34 +0800
Message-ID: <20260702024534.847681-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXn__U0EVqY1M6HQ--.54484S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy7ZFWrXryfJrWDGr4xtFb_yoW5KFWxp3
	98K3W7GFs7X3W7Wr1UGFyUZ3WFk34fKFW7JryrGwn0vryqvrWIka47KFy29F15J3srCr4j
	qFsY9ry8Jrs7Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnmiiUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xVV8mpF0NWTCgAA32

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

IOMAP_F_MERGED is set twice in __exfat_iomap_begin(), this patch
also drops the redundant setting.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/file.c  |  4 ++--
 fs/exfat/iomap.c | 15 +++++++++++++--
 fs/exfat/iomap.h |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

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
index 1aac38e63fe6..76e05cec4fe1 100644
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
@@ -191,6 +192,15 @@ const struct iomap_ops exfat_write_iomap_ops = {
 	.iomap_end	= exfat_write_iomap_end,
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
  * exfat_writeback_range - Map folio during writeback
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
index fd8a913f7794..2ea387f2b179 100644
--- a/fs/exfat/iomap.h
+++ b/fs/exfat/iomap.h
@@ -11,6 +11,7 @@ extern const struct iomap_ops exfat_iomap_ops;
 extern const struct iomap_ops exfat_write_iomap_ops;
 extern const struct iomap_writeback_ops exfat_writeback_ops;
 extern const struct iomap_read_ops exfat_iomap_bio_read_ops;
+extern const struct iomap_write_ops exfat_iomap_write_ops;
 
 int exfat_iomap_swap_activate(struct swap_info_struct *sis,
 			       struct file *file, sector_t *span);
-- 
2.43.0

