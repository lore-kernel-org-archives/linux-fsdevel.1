Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4737CD41;
	Tue,  3 Mar 2026 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507752; cv=none; b=shz2UuD+gfajtA47Zt3giPZj9eKJFdds4W/YcuozQNlViYmUHICIhhYYoOHxHQaWmhn1NMSvXKFmLYmevKKwJLASu91XTKII2uNIMxiWG9T0494ad/U5KX6rNo8tB6sZG/WJvEnnYFBuPvg18w48/yOKxndvQVJ8N6jXvJsTV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507752; c=relaxed/simple;
	bh=Q8mE89/Jp69yE2eovKWfvlU+V33ogRISgTFjxR7k1PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb0D4CxzYsq+zWqBhsbixVUydsJlHn3PjLNw01Xky0MLj6Y0FeKxegXCJ3WNCpCPANHzh14FGrBSVvkPe5FzXIkc4yAB3AwegThhPUhWsQe7zNiS4SRpGB3sR1OCnJIfdARvLcYuZxmoncneDBzgNxsO4/M6n70kPwai23zMQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B483pwfl; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B483pwfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gS
	CSHyxPm901Iut4Y6cl6bKalR2BhcwxVsIC28ds/rg=; b=B483pwfl3O0zxx8Pfs
	2JWrkEu2pzrArvPISpH5DMFUtqhoGCDDyqOJeIi0HSlhhxC0osOfiBDmage2mgwy
	sm77Hri6/vEUyhZeJcm38I4fE5bRQjPHPj+10mti1uCp+LKpQQU/bsse6/C8WTp+
	hdgnnPgFB00kT8GLWYGMXmImw=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXh6xQUqZpOLCWQw--.188S3;
	Tue, 03 Mar 2026 11:15:33 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 1/6] exfat: add block readahead in exfat_chain_cont_cluster
Date: Tue,  3 Mar 2026 11:14:04 +0800
Message-ID: <20260303031409.129136-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303031409.129136-1-chizhiling@163.com>
References: <20260303031409.129136-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXh6xQUqZpOLCWQw--.188S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr17KrW7GF4rKr43Jr43ZFb_yoWrGFWfpa
	n8AayftrWUGa47Ww4fKF1kG3WfC3s7GFyrGrW3uryrAryavrs3urZrKryFqFykt3y5WF1j
	qF1YvFWUCrnxW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzhFxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BWtS2mmUlWaqwAA3W

From: Chi Zhiling <chizhiling@kylinos.cn>

When a file cannot allocate contiguous clusters, exfat converts the file
from NO_FAT_CHAIN to FAT_CHAIN format. For large files, this conversion
process can take a significant amount of time.

Add simple readahead to read all the FAT blocks in advance, as these
blocks are consecutive, significantly improving the conversion performance.

Test in an empty exfat filesystem:
  dd if=/dev/zero of=/mnt/file bs=1M count=30k
  dd if=/dev/zero of=/mnt/file2 bs=1M count=1
  time cat /mnt/file2 >> /mnt/file

| cluster size | before patch | after patch |
| ------------ | ------------ | ----------- |
| 512          | 47.667s      | 4.316s      |
| 4k           | 6.436s       | 0.541s      |
| 32k          | 0.758s       | 0.071s      |
| 256k         | 0.117s       | 0.011s      |

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h | 11 +++++++++--
 fs/exfat/fatent.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 2dbed5f8ec26..090f25d1a418 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -10,6 +10,7 @@
 #include <linux/ratelimit.h>
 #include <linux/nls.h>
 #include <linux/blkdev.h>
+#include <linux/backing-dev.h>
 #include <uapi/linux/exfat.h>
 
 #define EXFAT_ROOT_INO		1
@@ -79,6 +80,10 @@ enum {
 #define EXFAT_HINT_NONE		-1
 #define EXFAT_MIN_SUBDIR	2
 
+#define EXFAT_BLK_RA_SIZE(sb)		\
+	(min_t(blkcnt_t, (sb)->s_bdi->ra_pages, (sb)->s_bdi->io_pages) \
+	<< (PAGE_SHIFT - (sb)->s_blocksize_bits))
+
 /*
  * helpers for cluster size to byte conversion.
  */
@@ -117,9 +122,9 @@ enum {
 #define FAT_ENT_SIZE (4)
 #define FAT_ENT_SIZE_BITS (2)
 #define FAT_ENT_OFFSET_SECTOR(sb, loc) (EXFAT_SB(sb)->FAT1_start_sector + \
-	(((u64)loc << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
+	(((u64)(loc) << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
 #define FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc)	\
-	((loc << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
+	(((loc) << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
 
 /*
  * helpers for bitmap.
@@ -448,6 +453,8 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		unsigned int *ret_clu);
 int exfat_count_num_clusters(struct super_block *sb,
 		struct exfat_chain *p_chain, unsigned int *ret_count);
+int exfat_blk_readahead(struct super_block *sb, sector_t sec,
+		sector_t *ra, blkcnt_t *ra_cnt, sector_t end);
 
 /* balloc.c */
 int exfat_load_bitmap(struct super_block *sb);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index f87576ca7032..9a4143f3fc0c 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -142,13 +142,50 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 	return -EIO;
 }
 
+int exfat_blk_readahead(struct super_block *sb, sector_t sec,
+		sector_t *ra, blkcnt_t *ra_cnt, sector_t end)
+{
+	struct blk_plug plug;
+
+	if (sec < *ra)
+		return 0;
+
+	*ra += *ra_cnt;
+
+	/* No blocks left (or only the last block), skip readahead. */
+	if (*ra >= end)
+		return 0;
+
+	*ra_cnt = min(end - *ra + 1, EXFAT_BLK_RA_SIZE(sb));
+	if (*ra_cnt == 0) {
+		/* Move 'ra' to the end to disable readahead. */
+		*ra = end;
+		return 0;
+	}
+
+	blk_start_plug(&plug);
+	for (unsigned int i = 0; i < *ra_cnt; i++)
+		sb_breadahead(sb, *ra + i);
+	blk_finish_plug(&plug);
+	return 0;
+}
+
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 		unsigned int len)
 {
+	sector_t sec, end, ra;
+	blkcnt_t ra_cnt = 0;
+
 	if (!len)
 		return 0;
 
+	ra = FAT_ENT_OFFSET_SECTOR(sb, chain);
+	end = FAT_ENT_OFFSET_SECTOR(sb, chain + len - 1);
+
 	while (len > 1) {
+		sec = FAT_ENT_OFFSET_SECTOR(sb, chain);
+		exfat_blk_readahead(sb, sec, &ra, &ra_cnt, end);
+
 		if (exfat_ent_set(sb, chain, chain + 1))
 			return -EIO;
 		chain++;
-- 
2.43.0

