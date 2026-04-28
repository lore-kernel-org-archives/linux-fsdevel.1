Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80513909A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420576; cv=none; b=Bb4YHDd/29RWut/E5dzq9PWrsh5hne2yJXodxURYwPpBmeDsD11n+mBLQF/4mE3en7zXkmG4XMMSqN3DB2yKN/A3NR2cVrl+fYC7CAJ/2sf6Oon6zGHSnjDij2jVlmcsaasrsbgXMFaeZJQY3veSgjZMtdEWoalZVG7xWxlijAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420576; c=relaxed/simple;
	bh=9qLrUHPFT8GCWG6o5eRuiZhoPW4eTTmMA7NsU5V/B8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkasPnG2Dbyd8M8TTI1qzFcLv+WxLwqrg7YEIrazon9oz38dkM0krsjtZz7ykhFdO5h+o35rvBfXyu4G+d+IqgwdOyRIumwzBHOlwIaNk64JbxGp0Nyf8yw37oyzEjUNa1vjLZYmD+3/Sz5QwUm8tujcwTFjSfkCaFxxkraYTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 113D61CBE6;
	Tue, 28 Apr 2026 23:51:05 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id i9TZBuRH8WmjWgUA8KYfjw:T5
	(envelope-from <dxdt@dev.snart.me>); Tue, 28 Apr 2026 23:51:05 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 4/4] exfat: more pedantic upcase table validity check
Date: Wed, 29 Apr 2026 08:50:37 +0900
Message-ID: <20260428235038.93816-5-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260428235038.93816-1-dxdt@dev.snart.me>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is observed that most exFAT implementations reject a volume with an
upcase table whose index of the last entry is not 0xFFFF and treat the
volume as damaged.

Upon encoutering an incomplete or malformed upcase table:

  - whose the index of last entry is not 0xFFFF
  - that has extra data after the end of the table

Raise exfat_fs_error() to mark the volume read-only.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/nls.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index c56d501659b3..3ce5165094bf 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -260,17 +260,16 @@ int exfat_nls_to_utf16(struct super_block *sb, const unsigned char *p_cstring,
 }
 
 static int exfat_load_upcase_table(struct super_block *sb,
-		sector_t sector, unsigned long long num_sectors,
-		unsigned int utbl_checksum)
+		unsigned long long tbl_size, sector_t sector,
+		unsigned long long num_sectors, unsigned int utbl_checksum)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	unsigned int sect_size = sb->s_blocksize;
 	unsigned int i, index = 0;
 	u32 chksum = 0;
-	unsigned char skip = false;
+	bool skip = false, is_default = true;
 	struct exfat_upcase_ptable *upcase_table;
 	unsigned short def_upcase;
-	bool is_default;
 	unsigned int entries = 0;
 	int ret = -EINVAL;
 
@@ -279,9 +278,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		return -ENOMEM;
 
 	num_sectors += sector;
-	is_default = sector < num_sectors;
 
-	while (sector < num_sectors) {
+	while (tbl_size > 1 && sector < num_sectors) {
 		struct buffer_head *bh;
 
 		bh = sb_bread(sb, sector);
@@ -292,7 +290,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 			goto err;
 		}
 		sector++;
-		for (i = 0; i < sect_size && index <= 0xFFFF; i += 2) {
+		for (i = 0; i < sect_size && index <= 0xFFFF && tbl_size > 1;
+				i += 2, tbl_size -= 2) {
 			unsigned short uni = get_unaligned_le16(bh->b_data + i);
 
 			if (skip) {
@@ -319,9 +318,13 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		}
 		chksum = exfat_calc_chksum32(bh->b_data, i, chksum, CS_DEFAULT);
 		brelse(bh);
+
+		/* the contents of the table went out of bounds with still more data to read */
+		if (tbl_size > 0 && index >= 0x10000)
+			goto err;
 	}
 
-	if (index >= 0xFFFF && utbl_checksum == chksum) {
+	if (index == 0x10000 && utbl_checksum == chksum) {
 		/*
 		 * is_default being set does not necessarily mean the contents are exact same as the
 		 * upcase table loaded from the volume may be missing some entries. The checksum
@@ -339,10 +342,9 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		return 0;
 	}
 
-	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
-		  index, chksum, utbl_checksum);
-
 err:
+	exfat_fs_error(sb, "damaged upcase table. Please run fsck (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
+		       index, chksum, utbl_checksum);
 	exfat_free_upcase_ptable(upcase_table);
 	kvfree(upcase_table);
 
@@ -390,7 +392,7 @@ int exfat_create_upcase_table(struct super_block *sb)
 			if (tbl_size) {
 				sector = exfat_cluster_to_sector(sbi, tbl_clu);
 				num_sectors = ((tbl_size - 1) >> blksize_bits) + 1;
-				ret = exfat_load_upcase_table(sb, sector, num_sectors,
+				ret = exfat_load_upcase_table(sb, tbl_size, sector, num_sectors,
 					le32_to_cpu(ep->dentry.upcase.checksum));
 			} else
 				exfat_fs_error(sb,
-- 
2.53.0.1.ga224b40d3f.dirty

