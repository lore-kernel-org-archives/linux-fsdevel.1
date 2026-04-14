Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A5271464
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776146244; cv=none; b=jjQuqLE4fiHOmumqTysIJcfpVy12GtmO6YjhE+VltAyp+uJVlB13qeKx1mCLYMju6/a3Kj3geRd4AKSMJbKO5epap0Jyd9xz01FFQCIYv0eHNSNWnK+KgZyKAkrkWYjRxr7A00lLthDboccBeYfDNyiQ4cvxEYjJ4jh+cjexoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776146244; c=relaxed/simple;
	bh=zT9I21tekaCj3dsY4CFQmsHpn5qTlOeTyd0SRZ7Y7HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPZLMmhSgvVMyxPP7LESlp1ldAfQ+2ey9wEhl7+srhVeuv3THBTslvAGFPVnxjFDxSRVEPDoj34w2okeo0/yELOWalRFlx2asWXUoWqQhWue8WaytHhMnvzaCwMhhlUChV9Od1TLscAc+hgNFy+KIyEK2RsQPFesF1Jj3eH1Pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B4275909BF;
	Tue, 14 Apr 2026 05:57:20 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id whsVFDnX3WnU8AcA8KYfjw:T5
	(envelope-from <dxdt@dev.snart.me>); Tue, 14 Apr 2026 05:57:20 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 4/4] exfat: more pedantic upcase table validity check
Date: Tue, 14 Apr 2026 14:56:43 +0900
Message-ID: <20260414055643.1833401-5-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260414055643.1833401-1-dxdt@dev.snart.me>
References: <20260414055643.1833401-1-dxdt@dev.snart.me>
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

Reject incomplete or malformed upcase table:

  - whose the index of last entry is not 0xFFFF
  - that has extra data after the end of the table

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/nls.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 901447a79d28..71f6a395e9ef 100644
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
 
+err:
 	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
 		  index, chksum, utbl_checksum);
-
-err:
 	exfat_free_upcase_ptable(upcase_table);
 	kvfree(upcase_table);
 
@@ -389,7 +391,7 @@ int exfat_create_upcase_table(struct super_block *sb)
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

