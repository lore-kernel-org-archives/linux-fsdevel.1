Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E036998C;
	Wed,  1 Apr 2026 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027554; cv=none; b=QPg2MHOPa7yah2YuYfXCRWWXI3ZeoyjykB5o3fwVujL9M0mR2y/XKAU0wX6ym2D9gd+z5rIelZw7PIexdGd2+oKdkY3fdajcZmQTFZ0CmXSiYqTF5RcUjDoi8t/DhoZNs9SxnAG0J6sEEI6wWG7MMVghXSPPdYCSldpHcbj0yAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027554; c=relaxed/simple;
	bh=m6L1EZDojc4EimSxu0sg9rOKnRQPzE6DXm5qmVqC7mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McXQKO9QWd7cHvv4CgY0a48X6ULBLVwl/DgiCDMhRMarnsBciI004hu2tU5u7TrBdAy7OIANSXx83NbMOYJkz1Qeu//DU/0yNcj29QHed6zIAUXa4c10+nHXpopBNqVi3pI+5kby8aocQRhuqA8lzC9Nz/cBfqfCrOLPi/T9RIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eAqIS25V; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eAqIS25V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=d7
	gqt0VpacPWl4qG2W1JkG9/jpFuq9OVSqtAKhxyWmE=; b=eAqIS25V3mGTASEaw2
	4K77mLBkz2jkM5iWHjmW1Y+h1NgqoU99uiU2FrNLjd9K2h0Ef7/bt1s0at852efR
	/2TsyVSwzlZiDHG8qF4BwdWyRbKtRZLjDqTIcjjeh/ACG+PGf0Y9ZwyNZ7HjUL0Q
	SrhUrNoBkGNWX+XaYZh1WVNPk=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v9ZFxcxpADvDCg--.24371S4;
	Wed, 01 Apr 2026 15:12:08 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 2/6] exfat: introduce exfat_fat_walk helper
Date: Wed,  1 Apr 2026 15:11:34 +0800
Message-ID: <20260401071138.114836-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401071138.114836-1-chizhiling@163.com>
References: <20260401071138.114836-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v9ZFxcxpADvDCg--.24371S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4xZrW8ArW5JF1fGry8Krg_yoW8ArW8pF
	4UGw4rJrW5Wa47u3W3JFs3u3Wa9ws7GFyDArWxu3s0yrWDtF95uF98KryayF1Iqw40g3W5
	KF1Ygr18urnxGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwGYLUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3AgRrmnMxUgw9gAA3F

From: Chi Zhiling <chizhiling@kylinos.cn>

Introduce exfat_fat_walk() to walk the FAT chain by a given step,
handling both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes. Also
redefine exfat_get_next_cluster as a thin wrapper around it for
backward compatibility.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 9fed9fb33cae..530459ab9acc 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -437,7 +437,8 @@ int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
 
 /* fatent.c */
-#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu, NULL)
+#define exfat_get_next_cluster(sb, pclu) \
+	exfat_fat_walk(sb, (pclu), 1, ALLOC_FAT_CHAIN)
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		struct exfat_chain *p_chain, bool sync_bmap);
@@ -456,6 +457,26 @@ int exfat_count_num_clusters(struct super_block *sb,
 int exfat_blk_readahead(struct super_block *sb, sector_t sec,
 		sector_t *ra, blkcnt_t *ra_cnt, sector_t end);
 
+static inline int
+exfat_fat_walk(struct super_block *sb, unsigned int *clu,
+		unsigned int step, int flags)
+{
+	struct buffer_head *bh = NULL;
+
+	if (flags == ALLOC_NO_FAT_CHAIN) {
+		(*clu) += step;
+		return 0;
+	}
+
+	while (step--) {
+		if (exfat_ent_get(sb, *clu, clu, &bh))
+			return -EIO;
+	}
+	brelse(bh);
+
+	return 0;
+}
+
 /* balloc.c */
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
-- 
2.43.0

