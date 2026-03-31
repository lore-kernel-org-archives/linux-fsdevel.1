Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871373EC2C7;
	Tue, 31 Mar 2026 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948349; cv=none; b=lqdppoud8Ib3U0EKGUQD0tXcViwIkUm+jjPIlhCYe9D8iM05vM74iheAFgncZz8BzoYmlqDLBB7OmEIBiMsc4ICTuA11Y9F6bhwrB/+tUuQeyEJa6d49EoXAQyfnJ98qYAt47bN889FGIbgttM031ZAU+/bJYQxaQPtRvv2FkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948349; c=relaxed/simple;
	bh=m6L1EZDojc4EimSxu0sg9rOKnRQPzE6DXm5qmVqC7mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1IGsve72BRrgUdHWvfx834Ca3Z55U4P1M8bdmPlKyTX0bjHKIVDgtv8ixDoi40cEI1a9mhMHxQIR9OareNXR7hoyDHzbKe2U5JJdnAfacKLGOpcxitzD5aSAtbz4LDVlTE5ZTjL2qqmS/kFnFXCGTNRrB314RpDMPFW80D8kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ndwtD1Mb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ndwtD1Mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=d7
	gqt0VpacPWl4qG2W1JkG9/jpFuq9OVSqtAKhxyWmE=; b=ndwtD1Mb6qBOlAqklE
	yokqb0ua/8k1dfti8MvT7sBGOZzNisgiFW31T0pkbeTc3BlrB887vxs/KyE5XA+w
	hrie+yQSXuO1WO9IsFa85GPJv4MX8iKPPJWSB5mDSDfcGfGVAHRBa6UWdmNYwGUT
	j1k490I6hUC8pIJ8+Pye1u+eA=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXetTUj8tpdt0MCg--.18595S4;
	Tue, 31 Mar 2026 17:11:56 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 2/6] exfat: introduce exfat_fat_walk helper
Date: Tue, 31 Mar 2026 17:11:09 +0800
Message-ID: <20260331091113.20882-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331091113.20882-1-chizhiling@163.com>
References: <20260331091113.20882-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXetTUj8tpdt0MCg--.18595S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4xZrW8ArW5JF1fGry8Krg_yoW8ArW8pF
	4UGw4rJrW5Wa47u3W3JFs3u3Wa9ws7GFyDArWxu3s0yrWDtF95uF98KryayF1Iqw40g3W5
	KF1Ygr18urnxGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwGYLUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BxoBmnLj9zSYgAA3L

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

