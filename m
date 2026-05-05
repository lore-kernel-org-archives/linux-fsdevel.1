Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3F42980A
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984336; cv=none; b=I7A6A23qUxcPrxcEuxeWlCfyY1vI9j7/HEyXHTDPRBEYhq+TFIiDkvEcrlHBrK26+IXUUGBKhbvaj96aunDyV3Z7djtKoOlsKPFkGVDpLCXbVOXGxxcWxpzysjhsHzCMtvMlAaYJ4E5NonfhWN4utC8eDsXroSIx73+a/8DdEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984336; c=relaxed/simple;
	bh=OP0o3z9omzfFfZDmG04a/maWDjC0yGYAuB4mDDedkYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQ3g+tKmQgGeoRdLzKDVEK4Zj+hw9Y1KvjhTw66UDxMNQcBclwxSWEhUQ7vt/Q68bbV1yD7cs9XxWVAEByPh+FzRTZsvQxzJ9XUT9rRZrvBi/mQgyE2XSWGsquIEZqJ4nuqxLdLvrqKHBjo+S/cqm+9PWICfVQSL7MK3ea7Qv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 3D5D81D490;
	Tue,  5 May 2026 12:32:13 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id na7IHUfj+WmAZAEA8KYfjw:T5
	(envelope-from <dxdt@dev.snart.me>); Tue, 05 May 2026 12:32:13 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v2 4/4] exfat: more pedantic upcase table validity check
Date: Tue,  5 May 2026 21:31:44 +0900
Message-ID: <20260505123144.730782-5-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260505123144.730782-1-dxdt@dev.snart.me>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
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

  - whose index of last entry is not 0xFFFF
  - that has extra data after the end of the table

Raise exfat_fs_error() to mark the volume read-only.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/nls.c | 90 +++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 68b09a99f8be..61b191a79fb6 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -283,42 +283,45 @@ int exfat_nls_to_utf16(struct super_block *sb, const unsigned char *p_cstring,
 	return exfat_nls_to_ucs2(sb, p_cstring, len, uniname, p_lossy);
 }
 
-static int exfat_load_upcase_table(struct super_block *sb,
-		sector_t sector, unsigned long long num_sectors,
-		unsigned int utbl_checksum)
+static int exfat_load_upcase_table(struct super_block *sb, sector_t sector,
+		unsigned long long tbl_size, unsigned int utbl_checksum)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	unsigned int sect_size = sb->s_blocksize;
+	struct buffer_head *bh = NULL;
 	unsigned int i, index = 0;
 	u32 chksum = 0;
-	unsigned char skip = false;
-	struct exfat_upcase_ptable *upcase_table;
+	bool skip = false, is_default = true;
+	struct exfat_upcase_ptable *upcase_table = NULL;
 	unsigned short def_upcase;
-	bool is_default;
 	unsigned int entries = 0;
 	int ret = -EINVAL;
 
+	if (tbl_size == 0 || tbl_size % 2 != 0 || tbl_size > EXFAT_UPTBL_SIZE * 2) {
+		exfat_fs_error(sb, "bogus upcase table size(%llu bytes). Please run fsck", tbl_size);
+		return -EINVAL;
+	}
+
 	upcase_table = kvcalloc(1, sizeof(struct exfat_upcase_ptable), GFP_KERNEL);
 	if (!upcase_table)
 		return -ENOMEM;
 
-	num_sectors += sector;
-	is_default = sector < num_sectors;
-
-	while (sector < num_sectors) {
-		struct buffer_head *bh;
-
+	for (; tbl_size > 1; sector++) {
+		brelse(bh);
 		bh = sb_bread(sb, sector);
 		if (!bh) {
-			exfat_err(sb, "failed to read sector(0x%llx)",
+			exfat_err(sb, "failed to read upcase table sector(0x%llx)",
 				  (unsigned long long)sector);
 			ret = -EIO;
 			goto err;
 		}
-		sector++;
-		for (i = 0; i < sect_size && index <= 0xFFFF; i += 2) {
+		chksum = exfat_calc_chksum32(bh->b_data, MIN(tbl_size, sb->s_blocksize),
+					     chksum, CS_DEFAULT);
+
+		for (i = 0; i < sb->s_blocksize && tbl_size > 1; i += 2) {
 			unsigned short uni = get_unaligned_le16(bh->b_data + i);
 
+			tbl_size -= 2;
+
 			if (skip) {
 				index += uni;
 				skip = false;
@@ -328,10 +331,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 				skip = true;
 			} else { /* uni != index , uni != 0xFFFF */
 				ret = exfat_set_upcase_ptable(upcase_table, index, uni);
-				if (ret) {
-					brelse(bh);
+				if (ret)
 					goto err;
-				}
 
 				def_upcase = exfat_lookup_upcase_ptable(&exfat_def_upcase_ptable,
 									index);
@@ -340,12 +341,14 @@ static int exfat_load_upcase_table(struct super_block *sb,
 				entries++;
 				index++;
 			}
+
+			if (index > 0xFFFF)
+				goto indexed;
 		}
-		chksum = exfat_calc_chksum32(bh->b_data, i, chksum, CS_DEFAULT);
-		brelse(bh);
 	}
 
-	if (index >= 0xFFFF && utbl_checksum == chksum) {
+indexed:
+	if (index == 0x10000 && utbl_checksum == chksum && tbl_size == 0) {
 		/*
 		 * is_default being set does not necessarily mean the contents are exact same as the
 		 * upcase table loaded from the volume may be missing some entries. The checksum
@@ -356,17 +359,22 @@ static int exfat_load_upcase_table(struct super_block *sb,
 			kvfree(upcase_table);
 		} else {
 			sbi->vol_utbl = sbi->vol_utbl_own = upcase_table;
-			exfat_info(sb, "using non-default upcase table (chksum: 0x%08x, entries: %u, memsize: %zu+)",
-				   chksum, entries, upcase_table->cnt * EXFAT_UPTBL_PAGESIZE);
+			exfat_info(sb, "using non-default upcase table "
+				   "(chksum: 0x%08x, entries: %u, memsize: %zu+ bytes)",
+				   chksum, entries, upcase_table->cnt * EXFAT_UPTBL_PAGESIZE * 2);
 		}
 
-		return 0;
-	}
-
-	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
-		  index, chksum, utbl_checksum);
+		upcase_table = NULL;
+		ret = 0;
+	} else
+		ret = -EINVAL;
 
 err:
+	if (ret == -EINVAL)
+		exfat_fs_error(sb, "damaged upcase table. Please run fsck "
+				"(idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x, rem : %llu bytes)",
+				index, chksum, utbl_checksum, tbl_size);
+	brelse(bh);
 	exfat_free_upcase_ptable(upcase_table);
 	kvfree(upcase_table);
 
@@ -377,8 +385,8 @@ int exfat_create_upcase_table(struct super_block *sb)
 {
 	unsigned int tbl_clu, type;
 	sector_t sector;
-	unsigned long long tbl_size, num_sectors;
-	unsigned char blksize_bits = sb->s_blocksize_bits;
+	unsigned long long tbl_size;
+	unsigned int chksum;
 	struct exfat_chain clu;
 	struct exfat_dentry *ep;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -411,18 +419,18 @@ int exfat_create_upcase_table(struct super_block *sb)
 
 			tbl_clu  = le32_to_cpu(ep->dentry.upcase.start_clu);
 			tbl_size = le64_to_cpu(ep->dentry.upcase.size);
-			if (tbl_size) {
-				sector = exfat_cluster_to_sector(sbi, tbl_clu);
-				num_sectors = ((tbl_size - 1) >> blksize_bits) + 1;
-				ret = exfat_load_upcase_table(sb, sector, num_sectors,
-					le32_to_cpu(ep->dentry.upcase.checksum));
-			} else
-				exfat_fs_error(sb,
-					       "bad upcase table size (0 bytes). Please run fsck");
+			sector = exfat_cluster_to_sector(sbi, tbl_clu);
+			chksum = le32_to_cpu(ep->dentry.upcase.checksum);
+
+			ret = exfat_load_upcase_table(sb, sector, tbl_size, chksum);
 
 			brelse(bh);
-			if (ret && ret != -EIO)
-				ret = 0;
+			/*
+			 * Continue w/ damaged table(EINVAL) in read-only mode, unless overridden.
+			 * Treat ENOMEM and EIO as fatal.
+			 */
+			if (ret == -EINVAL)
+				return 0;
 			return ret;
 		}
 
-- 
2.53.0.1.ga224b40d3f.dirty

