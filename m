Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00537DE96;
	Tue,  3 Mar 2026 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507756; cv=none; b=O5UtqDRpzTn5AZlckf7r0kNd0+OLUgh0GQvVSAPK1pWl15p06qTKgHG0scKA4ZD2OAJqwLODE5myHmFfcYwst8B0vx0bMps44vyF1CtkXvY7+K9UAHMV1YUeWWFDKv4CN79sinIFjmeQg+UxC45iIgRwwSYiehFI+vR8tOI5Olw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507756; c=relaxed/simple;
	bh=DY/ty8QPMP9TkL8L3X5ZNyfeA542cemeI2M3dZXpF6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R71GuyGSLMrvwHLpuCVgGP+e9DT4eEwJrjG0Z4wy1w2VH4nZ4IT6OklE6dRIQDOImCH12rcl41xVOSTaj1vJk4Hu601DmJcNnXOhAP4eSBejvFC99k3gRV97kRd+5n4apHRS+14rtoJ179HIAZSCxSr0r0xm8PBRxz42oErxdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UAfOaVVM; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UAfOaVVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VA
	mBZgXf9g7iYFbDrSLHZzoP+KeydS6WcJLEuSOLAlk=; b=UAfOaVVM7lnyIDvCxN
	zR64/zVIcxlT5ioK9bS5f0iYedPMSLuE/jBOzW0BLkgY5q5QXGaGaoLgLY3ht/Eh
	rzS6QZJ0AO2gq7CM71dClhvoydq7LzCfFh+IwoN2w4bAEm2x+wefbaN30R18WFSV
	rDv4BpeatoTAUpirq+psGJwk8=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXh6xQUqZpOLCWQw--.188S5;
	Tue, 03 Mar 2026 11:15:33 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 3/6] exfat: use readahead helper in exfat_get_dentry
Date: Tue,  3 Mar 2026 11:14:06 +0800
Message-ID: <20260303031409.129136-4-chizhiling@163.com>
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
X-CM-TRANSID:PygvCgAXh6xQUqZpOLCWQw--.188S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1fXr1rWw4xGrWDCF4fAFb_yoW5Ww47pF
	4fJ39rtr48J34DXwsxJ3yruw1Sk3y8AF45JrWxZ34fJFsY9rnxury0qry0qFW7K3y09F1j
	va9Ygr15uanrW3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jl9a9UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xatS2mmUlaL-AAA37

From: Chi Zhiling <chizhiling@kylinos.cn>

Replace the custom exfat_dir_readahead() function with the unified
exfat_blk_readahead() helper in exfat_get_dentry(). This removes
the duplicate readahead implementation and uses the common interface,
also reducing code complexity.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/dir.c | 52 ++++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3a4853693d8b..5e59c2a7853e 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -623,44 +623,11 @@ static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir
 	return 0;
 }
 
-#define EXFAT_MAX_RA_SIZE     (128*1024)
-static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
-{
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct buffer_head *bh;
-	unsigned int max_ra_count = EXFAT_MAX_RA_SIZE >> sb->s_blocksize_bits;
-	unsigned int page_ra_count = PAGE_SIZE >> sb->s_blocksize_bits;
-	unsigned int adj_ra_count = max(sbi->sect_per_clus, page_ra_count);
-	unsigned int ra_count = min(adj_ra_count, max_ra_count);
-
-	/* Read-ahead is not required */
-	if (sbi->sect_per_clus == 1)
-		return 0;
-
-	if (sec < sbi->data_start_sector) {
-		exfat_err(sb, "requested sector is invalid(sect:%llu, root:%llu)",
-			  (unsigned long long)sec, sbi->data_start_sector);
-		return -EIO;
-	}
-
-	/* Not sector aligned with ra_count, resize ra_count to page size */
-	if ((sec - sbi->data_start_sector) & (ra_count - 1))
-		ra_count = page_ra_count;
-
-	bh = sb_find_get_block(sb, sec);
-	if (!bh || !buffer_uptodate(bh)) {
-		unsigned int i;
-
-		for (i = 0; i < ra_count; i++)
-			sb_breadahead(sb, (sector_t)(sec + i));
-	}
-	brelse(bh);
-	return 0;
-}
-
 struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, struct buffer_head **bh)
 {
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int sect_per_clus = sbi->sect_per_clus;
 	unsigned int dentries_per_page = EXFAT_B_TO_DEN(PAGE_SIZE);
 	int off;
 	sector_t sec;
@@ -673,9 +640,18 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 	if (exfat_find_location(sb, p_dir, entry, &sec, &off))
 		return NULL;
 
-	if (p_dir->dir != EXFAT_FREE_CLUSTER &&
-			!(entry & (dentries_per_page - 1)))
-		exfat_dir_readahead(sb, sec);
+	if (sect_per_clus > 1 &&
+	    (entry & (dentries_per_page - 1)) == 0) {
+		sector_t ra = sec;
+		blkcnt_t cnt = 0;
+		unsigned int ra_count = sect_per_clus;
+
+		/* Not sector aligned with ra_count, resize ra_count to page size */
+		if ((sec - sbi->data_start_sector) & (ra_count - 1))
+			ra_count = PAGE_SIZE >> sb->s_blocksize_bits;
+
+		exfat_blk_readahead(sb, sec, &ra, &cnt, sec + ra_count - 1);
+	}
 
 	*bh = sb_bread(sb, sec);
 	if (!*bh)
-- 
2.43.0

