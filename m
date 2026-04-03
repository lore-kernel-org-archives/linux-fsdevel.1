Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7132C937;
	Fri,  3 Apr 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203621; cv=none; b=R2sclsErh5+TJ3ERl4Ukoh/OqS+nXDchL6flx6+RU/3gcT38ueli9dkyglYQZxk5jkWjsPcE7m6Td9Z9TkOPsPdHudvckpp6lD6y+hguWhG7o2YB2o6ggNPM4tEAvlXOe6sH8D7+46AdO4rRHkrOwUbwMnuyGyxX6fewjklrsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203621; c=relaxed/simple;
	bh=jqT45xLKQTInKV1ClycTE9qO/pcNFb7Vg9bW3BhvA+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIQgVEqpXL3hY5+ZfojLtpqoHtFLzKqrKbb4t7LmMWSeBDwYCsen+iQb3jKm2PYg1hurdLUDPm/WC6dYZdF/RHme/CdfSumzMgVzuk+zkDhp42DDZzWsW9Jp3uXnNFLHZKGhakxrJ10G7Np0CIs/eUWCjoEIYSF/k+kaO45uWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Bh/EmoeM; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Bh/EmoeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Se
	KkiVMXCoTVIiiAV5FG1qskkS7mt5L1Inv6oD9cdrw=; b=Bh/EmoeMPr6I8M8OMD
	h/QyJ3klJ5GNRMuE82H6peGpu8njLfDTzeJkagV2qrwbrLFC3aiA4R5a5F5ATun2
	gqr3XxPvwCFM7Edp5j4cP7Cl8rZQKLoe3mdTnB+rn9N6kQjaW2LOR0UXxImHsakS
	jvShLFOgHnPeM9744wpEsUzGU=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHW13+dM9pkhS7Cw--.58982S5;
	Fri, 03 Apr 2026 16:06:26 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 3/6] exfat: use exfat_cluster_walk helper
Date: Fri,  3 Apr 2026 16:05:35 +0800
Message-ID: <20260403080538.361663-4-chizhiling@163.com>
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
X-CM-TRANSID:_____wDHW13+dM9pkhS7Cw--.58982S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1xtry8GrW8tFW3Aw45trb_yoW5uw1fpr
	43Ka93tryrXayDWr4rtF4kZ3WS9ws7KFWkGrWxWw1xtF90vr10ka4Dtryxt34kG3y09FW5
	tF15Kr1Uu3ZxWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jT6wAUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wKrSWnPdQL4sgAA3g

From: Chi Zhiling <chizhiling@kylinos.cn>

Replace the custom exfat_walk_fat_chain() function and open-coded
FAT chain walking logic with the exfat_cluster_walk() helper across
exfat_find_location, __exfat_get_dentry_set, and exfat_map_cluster.

Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/dir.c   | 47 +++++++++++------------------------------------
 fs/exfat/inode.c | 11 ++---------
 2 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 7619410d668e..ca5827046a1f 100644
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
@@ -603,10 +571,19 @@ static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir
 
 	off = EXFAT_DEN_TO_B(entry);
 
-	ret = exfat_walk_fat_chain(sb, p_dir, off, &clu);
+	clu = p_dir->dir;
+	ret = exfat_cluster_walk(sb, &clu, EXFAT_B_TO_CLU(off, sbi), p_dir->flags);
 	if (ret)
 		return ret;
 
+	if (clu == EXFAT_EOF_CLUSTER) {
+		exfat_fs_error(sb,
+			"unexpected early break in cluster chain (clu : %u, len : %d)",
+			p_dir->dir,
+			EXFAT_B_TO_CLU(off, sbi));
+		return -EIO;
+	}
+
 	if (!exfat_test_bitmap(sb, clu)) {
 		exfat_err(sb, "failed to test cluster bit(%u)", clu);
 		return -EIO;
@@ -792,9 +769,7 @@ static int __exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
 			unsigned int clu = exfat_sector_to_cluster(sbi, sec);
 
-			if (p_dir->flags == ALLOC_NO_FAT_CHAIN)
-				clu++;
-			else if (exfat_get_next_cluster(sb, &clu))
+			if (exfat_cluster_walk(sb, &clu, 1, p_dir->flags))
 				goto put_es;
 			sec = exfat_cluster_to_sector(sbi, clu);
 		} else {
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index beb9ea7cca9f..cde2eb0f31ad 100644
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
+		if (exfat_cluster_walk(sb, clu, num_to_be_allocated - 1, ei->flags))
+			return -EIO;
 		*count = 1;
 	}
 
-- 
2.43.0

