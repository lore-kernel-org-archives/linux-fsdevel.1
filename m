Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D433311C32;
	Fri,  3 Apr 2026 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203609; cv=none; b=LYtskXpluZ/wxJuC10H6UsqRPTcgG8qQyzHXBAVAVVI6Mom0ZIbvttquKXdD/adLr3jQzQF8T8sO3lCzeOOXvlBfaudFiFEh2qeRccxPHC82dES07kQZqzcuTCjhxTcpcmVwClQH817TAO3m3npahBNPOXpA7fkPuOVYqNS8SL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203609; c=relaxed/simple;
	bh=qvyE7fTPW9hxsAsIdDB7RsZ5byNvzlfUqZdV6FrH0rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQRfTbsOswSLQlI5Ehw6OY/tmSpwadgObcwL/Ri1L3+2ma1/xtFLEA2vXh9FhZP/tlKnoBlu6TWlXoxBBbkOxjNjpR1XzPhQjYaNZ9cGLY1TcXjsUtm4/Z0a2dMQiI1zWMpKy4LZSmJTB73hl1QgSa4GoUY0rh14V2qXHE6J1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EnL8LkiJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EnL8LkiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=g3
	HWHWKBHXYVZdwbLJwhaJIwsvsTJkC9MBeECTg9tRo=; b=EnL8LkiJBU8KUDXeYC
	KrDSeiHwIHtGAiAKrcixbPdjOwRCxgJCxv5CsyiR6F0XMmAeM80CNmnk3yKK1Sl9
	1/gLZPd9UzLnqHSxVhUbeiVNvGd2YI1LkAT+V8C4RlcidT2cRmGgGxnq78mNPpmW
	jYOST2zeE4lWL6jLbakyUQVfo=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHW13+dM9pkhS7Cw--.58982S4;
	Fri, 03 Apr 2026 16:06:26 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 2/6] exfat: introduce exfat_cluster_walk helper
Date: Fri,  3 Apr 2026 16:05:34 +0800
Message-ID: <20260403080538.361663-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403080538.361663-1-chizhiling@163.com>
References: <20260403080538.361663-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHW13+dM9pkhS7Cw--.58982S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrykuryDGF47ur4xWw45Jrb_yoW8AF1rpF
	4UGayrJrW5Wa47u3WfJrs3uF4a9ws7GFykArWxuwn0yrZ8tFyv9F98KryYyF1I9w40g3WY
	gF4Ygr18urnxGFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwGYLUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AKrSWnPdQK4SAAA35

From: Chi Zhiling <chizhiling@kylinos.cn>

Introduce exfat_cluster_walk() to walk the FAT chain by a given step,
handling both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes. Also
redefine exfat_get_next_cluster as a thin wrapper around it for
backward compatibility.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 9fed9fb33cae..7f9d0cfa252b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -437,7 +437,8 @@ int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
 
 /* fatent.c */
-#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu, NULL)
+#define exfat_get_next_cluster(sb, pclu) \
+	exfat_cluster_walk(sb, (pclu), 1, ALLOC_FAT_CHAIN)
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		struct exfat_chain *p_chain, bool sync_bmap);
@@ -456,6 +457,26 @@ int exfat_count_num_clusters(struct super_block *sb,
 int exfat_blk_readahead(struct super_block *sb, sector_t sec,
 		sector_t *ra, blkcnt_t *ra_cnt, sector_t end);
 
+static inline int
+exfat_cluster_walk(struct super_block *sb, unsigned int *clu,
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

