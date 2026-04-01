Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3436897B;
	Wed,  1 Apr 2026 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027550; cv=none; b=o1psUD7KN9xDWChVspNzyLJZidE2P1S98pUVqtUSD4o+2kMuRzDvbMhy01PbHHhO+eDACoYzG7UKAivPBOkeNa/6ABjutOgFIOL/LkDK50Xu7enKVz2oWMys90r7uIhgnvkQZxYgDs3uSUUmzHjk17nbtE8UhUTbzYIon19zXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027550; c=relaxed/simple;
	bh=6NPbxzP+60lU2cyx5Y9tpVIwa87KJGwCEt9OLXBVYRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMC+tiJkBavsH0K/V+o8+VUdOaW3V3HyO133CxZ47xOOOvW+/YpnaDKrW/oHLeqbKBydyb9jcUtLU74EA+cjP25yJb/UsU7AhhCetC/U0/2Tww3Xx/l5KRx9HcGhyKtT5MisK49uxSFYb7/2qJZohiiiIwes2FrgaPa1YsR0a48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CjumoghS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CjumoghS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gr
	hLE04HdrhwK72nGwd5gy4sLrCuu7fBKaFItQ4mwrc=; b=CjumoghSOwz0FVkoZZ
	rWVzExXkE678IF4hObcGn1RZJFjK5B4ji0aefafPj6j/VETYZ6EUBJBb8HfocMaS
	n/gF8zCLDayoWzxTLrewNEV/dVWI1o3ZTDNCg271sAOmYvKbVC/OYFJTWlQYOsPx
	T4KDM6WJ/LQ1/m40OMfnyS/0U=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v9ZFxcxpADvDCg--.24371S5;
	Wed, 01 Apr 2026 15:12:08 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 3/6] exfat: use exfat_fat_walk helper to simplify fat entry walking
Date: Wed,  1 Apr 2026 15:11:35 +0800
Message-ID: <20260401071138.114836-4-chizhiling@163.com>
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
X-CM-TRANSID:_____wD3v9ZFxcxpADvDCg--.24371S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1xKF15JFWDGF4xCF1DGFg_yoW5AFWUpr
	43Ga93tryrXa1DGF4rta1ku3WS9w4kKFW8GrWxGw18tF90yr10ka4DtryxJ34kG3y09F45
	tr15Kr1UurnxGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jl9a9UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AgRrmnMxUgGIwAA3C

From: Chi Zhiling <chizhiling@kylinos.cn>

Replace the custom exfat_walk_fat_chain() function and open-coded
FAT chain walking logic with the exfat_fat_walk() helper across
exfat_find_location, __exfat_get_dentry_set, and exfat_map_cluster.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/dir.c   | 39 +++------------------------------------
 fs/exfat/inode.c | 11 ++---------
 2 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 7619410d668e..cfc6f16a5fb2 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -562,38 +562,6 @@ int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int sync)
 	return err;
 }
 
-static int exfat_walk_fat_chain(struct super_block *sb,
-		struct exfat_chain *p_dir, unsigned int byte_offset,
-		unsigned int *clu)
-{
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	unsigned int clu_offset;
-	unsigned int cur_clu;
-
-	clu_offset = EXFAT_B_TO_CLU(byte_offset, sbi);
-	cur_clu = p_dir->dir;
-
-	if (p_dir->flags == ALLOC_NO_FAT_CHAIN) {
-		cur_clu += clu_offset;
-	} else {
-		while (clu_offset > 0) {
-			if (exfat_get_next_cluster(sb, &cur_clu))
-				return -EIO;
-			if (cur_clu == EXFAT_EOF_CLUSTER) {
-				exfat_fs_error(sb,
-					"invalid dentry access beyond EOF (clu : %u, eidx : %d)",
-					p_dir->dir,
-					EXFAT_B_TO_DEN(byte_offset));
-				return -EIO;
-			}
-			clu_offset--;
-		}
-	}
-
-	*clu = cur_clu;
-	return 0;
-}
-
 static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 			       int entry, sector_t *sector, int *offset)
 {
@@ -603,7 +571,8 @@ static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir
 
 	off = EXFAT_DEN_TO_B(entry);
 
-	ret = exfat_walk_fat_chain(sb, p_dir, off, &clu);
+	clu = p_dir->dir;
+	ret = exfat_fat_walk(sb, &clu, EXFAT_B_TO_CLU(off, sbi), p_dir->flags);
 	if (ret)
 		return ret;
 
@@ -792,9 +761,7 @@ static int __exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
 			unsigned int clu = exfat_sector_to_cluster(sbi, sec);
 
-			if (p_dir->flags == ALLOC_NO_FAT_CHAIN)
-				clu++;
-			else if (exfat_get_next_cluster(sb, &clu))
+			if (exfat_fat_walk(sb, &clu, 1, p_dir->flags))
 				goto put_es;
 			sec = exfat_cluster_to_sector(sbi, clu);
 		} else {
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index beb9ea7cca9f..817d9a135bb6 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -225,15 +225,8 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		 * *clu = (the first cluster of the allocated chain) =>
 		 * (the last cluster of ...)
 		 */
-		if (ei->flags == ALLOC_NO_FAT_CHAIN) {
-			*clu += num_to_be_allocated - 1;
-		} else {
-			while (num_to_be_allocated > 1) {
-				if (exfat_get_next_cluster(sb, clu))
-					return -EIO;
-				num_to_be_allocated--;
-			}
-		}
+		if (exfat_fat_walk(sb, clu, num_to_be_allocated - 1, ei->flags))
+			return -EIO;
 		*count = 1;
 	}
 
-- 
2.43.0

