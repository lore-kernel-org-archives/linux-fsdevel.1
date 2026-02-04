Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020337D130;
	Wed,  4 Feb 2026 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189499; cv=none; b=WTeBnkKHvOdDfxEh6wufXqZfwN+nYj0GX0mdK++WloiFQ68xcaJRMLEAzxT59wo+P3SPGAigkNAhFPTeUtzf1w/GOFWILFWO0A96DzXv93YZonyIo++UIHEEuIsx3MfXkwdXqIOv8+8j/SI4aMIuGvB9nGlpy6HFwSZzofP2sMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189499; c=relaxed/simple;
	bh=QmUvrXA1CMnsiFhKY0S/1+xRcpqsYXAI4IggRRqoZGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nup6a//SpDrbnmWLuHDZYFG4sIlAw97osW71aeL70Ny4nTJkL5pufhSOPf/tz0TsTLh0uH0LdVqck6ghIlObkBG4JY8UKYKR92P+sc+oXtai/zDccfOGJ28ZAsjLe4uhrRmDSGeiAgKE/I2Dig+jOJfiPRTlj7dAIv1pOsfeMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GeIa5APP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GeIa5APP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hj
	wgeuDR24g0MAouNTQp5oxxHUQ9AC4uhSnrMBlNBP0=; b=GeIa5APPqRueTFX8sg
	9SP2aZ/zwrVrrzZhjys+Gw87L5b52E2vuBAFDBn5KvsJtVMSetQvuucreynqACdw
	DIgZLsEJZn5duTcQCXBPQOEK3g7xcXPs42FUtpNVVSlOX5hvhlk+nyvdMSv/mk0j
	qdUvi7jMT+wzGDrYd+pVWZ/Aw=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3TegF8oJpYIHPNw--.186S5;
	Wed, 04 Feb 2026 15:15:21 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 3/3] exfat: optimize exfat_chain_cont_cluster with cached buffer heads
Date: Wed,  4 Feb 2026 15:14:35 +0800
Message-ID: <20260204071435.602246-4-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204071435.602246-1-chizhiling@163.com>
References: <20260204071435.602246-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3TegF8oJpYIHPNw--.186S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy8tFyDXr48KF15tw1DKFg_yoWrJr1UpF
	ZIka93Kr4UJ3ZFv3Z7tw4kZr1fC397Ja4kGw43G34fAr90yFnYvry8Kryrtry0kayDuFyY
	vF4UtF15CwnrGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jl9a9UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wm5V2mC8glSbwAA3R

From: Chi Zhiling <chizhiling@kylinos.cn>

When converting files from NO_FAT_CHAIN to FAT_CHAIN format, significant time
spent in mark_buffer_dirty() and exfat_mirror_bh() operations.
This overhead occurs because each FAT entry modification triggers a full block
dirty marking and mirroring operation.

For consecutive clusters that reside in the same block, we can optimize
by caching the buffer head and performing dirty marking only once at
the end of the block's modifications.

Performance improvements for converting a 30GB file:

| Cluster Size | Before Patch | After Patch | Speedup |
|--------------|--------------|-------------|---------|
| 512 bytes    | 4.316s       | 1.866s      | 2.31x   |
| 4KB          | 0.541s       | 0.236s      | 2.29x   |
| 32KB         | 0.071s       | 0.034s      | 2.09x   |
| 256KB        | 0.011s       | 0.006s      | 1.83x   |

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 49 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 0bc54aa5d122..30d88071e97f 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -32,6 +32,17 @@ static int exfat_mirror_bh(struct super_block *sb, struct buffer_head *bh)
 	return err;
 }
 
+static int exfat_end_bh(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
+	err = exfat_mirror_bh(sb, bh);
+	brelse(bh);
+
+	return err;
+}
+
 static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 		unsigned int *content, struct buffer_head **last)
 {
@@ -62,29 +73,40 @@ static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 	return 0;
 }
 
-int exfat_ent_set(struct super_block *sb, unsigned int loc,
-		unsigned int content)
+static int __exfat_ent_set(struct super_block *sb, unsigned int loc,
+		unsigned int content, struct buffer_head **cache)
 {
-	unsigned int off;
 	sector_t sec;
 	__le32 *fat_entry;
-	struct buffer_head *bh;
+	struct buffer_head *bh = cache ? *cache : NULL;
+	unsigned int off;
 
 	sec = FAT_ENT_OFFSET_SECTOR(sb, loc);
 	off = FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc);
 
-	bh = sb_bread(sb, sec);
-	if (!bh)
-		return -EIO;
+	if (!bh || bh->b_blocknr != sec || !buffer_uptodate(bh)) {
+		if (bh)
+			exfat_end_bh(sb, bh);
+		bh = sb_bread(sb, sec);
+		if (cache)
+			*cache = bh;
+		if (unlikely(!bh))
+			return -EIO;
+	}
 
 	fat_entry = (__le32 *)&(bh->b_data[off]);
 	*fat_entry = cpu_to_le32(content);
-	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
-	exfat_mirror_bh(sb, bh);
-	brelse(bh);
+	if (!cache)
+		exfat_end_bh(sb, bh);
 	return 0;
 }
 
+int exfat_ent_set(struct super_block *sb, unsigned int loc,
+		unsigned int content)
+{
+	return __exfat_ent_set(sb, loc, content, NULL);
+}
+
 /*
  * Caller must release the buffer_head if no error return.
  */
@@ -170,6 +192,7 @@ static int exfat_blk_readahead(struct super_block *sb, sector_t sec,
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 		unsigned int len)
 {
+	struct buffer_head *bh = NULL;
 	sector_t sec, end, ra;
 	blkcnt_t ra_cnt;
 
@@ -184,14 +207,16 @@ int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 		sec = FAT_ENT_OFFSET_SECTOR(sb, chain);
 		exfat_blk_readahead(sb, sec, &ra, &ra_cnt, end);
 
-		if (exfat_ent_set(sb, chain, chain + 1))
+		if (__exfat_ent_set(sb, chain, chain + 1, &bh))
 			return -EIO;
 		chain++;
 		len--;
 	}
 
-	if (exfat_ent_set(sb, chain, EXFAT_EOF_CLUSTER))
+	if (__exfat_ent_set(sb, chain, EXFAT_EOF_CLUSTER, &bh))
 		return -EIO;
+
+	exfat_end_bh(sb, bh);
 	return 0;
 }
 
-- 
2.43.0

