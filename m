Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465061;
	b=XIXge9rpAOonOrrMW8u0kEGKd2U4YpK/WwaTiQVgHMHRVqpOtDc9IL/pDb2qq+vD2ZIi
	 /WkWCCv2vJLF1f/9hNssSvn7T8Evnih+kqw+X3bngEgpXanepG9xYzAG2fY7kpWbrlunP
	 aMv3RUbozkzFRKYfsv9/FNJ6Jkxip1jzKJzcSCvaiZs5BQEOUHao3QDMn6P2IGO3O41J7
	 lBme7IN12Z0kiauCgVY/shByj3uZif0vcOK2r4bolW66wciDDgceZKnN/+SYpToFb8ete
	 GMJ+ocszLpHIMK5+2NheKlyxOpNoBGRsw8ZUJBfJuBQwkuEXB6Y25Hv70PpCBjjyU9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465061;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M8Nl236YKSq0tyko9K/yd/+3eYIzgStIpLyIOErNh1o=;
	b=uymV7/hpih5JY4EeeX7Wxq93EQufzWmK/yxYdewcmivEhpGX8xVg3kmUbnldbH06+AbN
	 Mw3V9hE+ct+UK0h6IsRAWy7FfDffcninORBqohshubUjFITH04ey1NuO2Iexu/EpPAdb8
	 MKgecKvgbSz+2KSr/3d0r5zkCdH1wLvKnsqr9MZHDC2y/85UxBMsU2BMefPUA8+CMnJPs
	 8XQHmlF9DFXrCzCthAS/sjLw1bkqkaQ/neOxbo+5lI6XPa7SIzhgYnjgXen4u8QZDI66Z
	 e+2e/qX56p/jeEsaH7gt9sFyn26VtASgguIuJZlZeNqkYLv38DHN0y0WAu82KU7Aw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=Le5YejSq;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE67606A324;
	Sat, 31 Oct 2026 16:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAE67606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=Le5YejSq
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 917701203BC;
	Sat, 31 Oct 2026 13:43:49 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8Nl236YKSq0tyko9K/yd/+3eYIzgStIpLyIOErNh1o=;
	b=Le5YejSqhLAeQPUEjwV16ozUBKW7bcVBEX1eTkmh8RsbLBVWIiN8GLwpXI4VYbawNFs0wN
	vy2FBAWTd0y5qx3yr7eQIwU/+RpFDzl77FrFcjBxP/I2mWbZRHL4exLPtHO7oafpokxQIz
	v7j5JEWS0etb0X+EaAHSE01X7/4861tbDD5yEBRf7JSMdi59RdBucPWfm+fMRM2+y4TkAz
	HLJDGo/FykPbbq6h8NZPLCu7HLryEJe8ZDJZSay0YGmzkwUxjaUg+eGateumtPc7dz97GC
	Lcwp+4O5p7ISdh2uC4U9/iIOYokYZU1o9IT3dctOxLPGvUhTmRwQYVhpJtMXyg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 4/8] fat: clean stale bdev buffers of newly allocated clusters
Date: Sat, 31 Oct 2026 13:43:22 -0300
Message-ID: <20261031164326.278125-5-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Directory I/O uses buffer_heads on the block device, which may leave
stale buffers behind when clusters are freed and reused. The buffer_head
I/O paths currently call clean_bdev_aliases() for newly allocated blocks,
preventing stale buffers from overwriting new data.

Buffered iomap I/O does not provide this protection. In preparation for
the buffered iomap conversion, clean bdev aliases on newly allocated
clusters, like exfat patch "exfat: clean stale bdev buffers of newly
allocated clusters".

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fatent.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 4fa1fae5abf9..46899efa3cf8 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -523,6 +523,21 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
 	return 0;
 }
 
+/*
+ * Newly allocated clusters may still have dirty buffer_heads in the block
+ * device mapping, e.g. the dentries of a directory that was just removed.
+ * File data does not go through those buffers, so drop them; otherwise a
+ * later flush of the block device writes them over the new data.
+ */
+static void fat_clean_bdev_aliases(struct super_block *sb,
+				   unsigned int clu, unsigned int count)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	clean_bdev_aliases(sb->s_bdev, fat_clus_to_blknr(sbi, clu),
+			   (sector_t)count * sbi->sec_per_clus);
+}
+
 static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
 				bool return_all)
 {
@@ -531,7 +546,7 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent, prev_ent;
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
-	int i, count, err, nr_bhs, idx_clus;
+	int i, count, err, nr_bhs, idx_clus, cont_start, cont_len;
 
 	lock_fat(sbi);
 	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
@@ -540,14 +555,20 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 		return -ENOSPC;
 	}
 
+	cont_len = 0;
 	err = nr_bhs = idx_clus = 0;
 	count = FAT_START_ENT;
 	fatent_init(&prev_ent);
 	fatent_init(&fatent);
 	fatent_set_entry(&fatent, sbi->prev_free + 1);
 	while (count < sbi->max_cluster) {
-		if (fatent.entry >= sbi->max_cluster)
+		if (fatent.entry >= sbi->max_cluster) {
+			if (cont_len) {
+				fat_clean_bdev_aliases(sb, cont_start, cont_len);
+				cont_len = 0;
+			}
 			fatent.entry = FAT_START_ENT;
+		}
 		fatent_set_entry(&fatent, fatent.entry);
 		err = fat_ent_read_block(sb, &fatent);
 		if (err)
@@ -573,6 +594,10 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 					*cluster = entry;
 				idx_clus++;
 
+				if (cont_len == 0)
+					cont_start = entry;
+				cont_len++;
+
 				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
 					err = fat_flush_bhs(sb, bhs, &nr_bhs,
 							    inode_needs_sync(inode));
@@ -589,6 +614,9 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 				 * so we can still use the prev_ent.
 				 */
 				prev_ent = fatent;
+			} else if (cont_len) {
+				fat_clean_bdev_aliases(sb, cont_start, cont_len);
+				cont_len = 0;
 			}
 			count++;
 			if (count == sbi->max_cluster)
@@ -602,6 +630,8 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 	err = -ENOSPC;
 
 out:
+	if (cont_len)
+		fat_clean_bdev_aliases(sb, cont_start, cont_len);
 	unlock_fat(sbi);
 	mark_fsinfo_dirty(sb);
 	fatent_brelse(&fatent);
-- 
2.43.0

