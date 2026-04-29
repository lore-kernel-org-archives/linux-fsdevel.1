Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822B3E639A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478930; cv=none; b=m+2pxvsUf16LqyKzmYQvkhajBBx9k4c3D3kbGe9m9M+9AjE48Kj3jU/JUOHX5XAZRsFUBNqXsgfEws2hyntG7EOiPSbc/olKwzra+CM45E41zIqH35IXmbkIss9XL6IZ0bXlilVYMDeHk4iVn0c9wjrLFrTdB/yQTataSKGYGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478930; c=relaxed/simple;
	bh=uOxgq2dmeFzaAbheoUFXOCan57xhWs10fC8umBHmLpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muBp6FKwUxyVbhwhc/8hIcEXHfez11GyYEL8Tx6N4Uf2MRRm2oQnSCPZoHj5lAkG04ekNAHtSCqqy+A5PJ/kfINXFLrv2lW0jguFSIFtJOLLuNoDwy2lPOFL5zJfW+LWQe6UeWHNAcb0FaGcE3vw+Y3prd49mz5phpoNY1k4CQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 2D7C61D459;
	Wed, 29 Apr 2026 16:08:39 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id P2wgMgYt8mnfmwUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 29 Apr 2026 16:08:38 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 1/2] exfat: add volume limit bounds checks
Date: Thu, 30 Apr 2026 01:08:23 +0900
Message-ID: <20260429160824.409881-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user inadvertenly truncates an exFAT volume(mistakenly shrinks
the partition or simply dd'ing from a larger removable device to a
smaller one. eg: device marketed as having 8GB capatity < 8GiB), the
kernel exFAT obliviously mounts the volume and operates on it. No error
is reported to userspace unless the filesystem is accessed with O_SYNC
or O_DIRECT.

Off by one sector test:

	# truncate -s 1073741824 img
	# mkfs.exfat img
	# truncate -s 1073741312 img
	# mount -t exfat img ...

The existing filesystem implementations, prime examples being XFS and
ext*, refuse to mount the volume with such condition. Introduce the
checks similar checks in-place to exFAT.

Also, to prevent UB, add checks against exFAT volumes with maliciously
a crafted main boot sectors with the ClusterCount field equal to or
larger than (2^32 - 11) as per format spec.

Link: https://github.com/exfatprogs/exfatprogs/issues/353
Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/super.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 95d87e2d7717..075130fd992a 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -431,6 +431,7 @@ static int exfat_read_boot_sector(struct super_block *sb)
 {
 	struct boot_sector *p_boot;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int nb_clusters;
 
 	/* set block size to read super block */
 	if (!sb_min_blocksize(sb, 512)) {
@@ -501,8 +502,17 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
 	sbi->num_sectors = le64_to_cpu(p_boot->vol_length);
 	/* because the cluster index starts with 2 */
-	sbi->num_clusters = le32_to_cpu(p_boot->clu_count) +
-		EXFAT_RESERVED_CLUSTERS;
+	nb_clusters = le32_to_cpu(p_boot->clu_count);
+	/*
+	 * The inclusive comparison in the following check seems a bit off(quite
+	 * literally), but the exFAT format section 3.1.9 says
+	 * "lesser of the following". Aye, aye, captain.
+	 */
+	if (nb_clusters >= EXFAT_MAX_NUM_CLUSTER) {
+		exfat_err(sb, "bogus number of clusters : %u", nb_clusters);
+		return -EINVAL;
+	}
+	sbi->num_clusters = nb_clusters + EXFAT_RESERVED_CLUSTERS;
 
 	sbi->root_dir = le32_to_cpu(p_boot->root_cluster);
 	sbi->dentries_per_clu = 1 <<
@@ -591,6 +601,33 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_check_volume_sizes(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	/* sector to start of last cluster */
+	const sector_t lc_start = exfat_cluster_to_sector(sbi, sbi->num_clusters - 1);
+	const sector_t lc_end = lc_start + sbi->sect_per_clus;
+	const sector_t last_sector = lc_end - 1;
+	struct buffer_head *bh;
+
+	/* Volume length(metadata in boot sector) bounds */
+	if (sbi->num_sectors < (unsigned long long)lc_end) {
+		exfat_err(sb, "number of cluster out of volume length bounds : %llu < %lld",
+			  sbi->num_sectors, lc_end);
+		return -EINVAL;
+	}
+
+	/* Actually try reading the last sector to see if it's within the blockdev bounds */
+	bh = sb_bread(sb, last_sector);
+	if (bh == NULL) {
+		exfat_err(sb, "last sector read failed : %lld", last_sector);
+		return -EIO;
+	}
+	brelse(bh);
+
+	return 0;
+}
+
 /* mount the file system volume */
 static int __exfat_fill_super(struct super_block *sb,
 		struct exfat_chain *root_clu)
@@ -610,6 +647,12 @@ static int __exfat_fill_super(struct super_block *sb,
 		goto free_bh;
 	}
 
+	ret = exfat_check_volume_sizes(sb);
+	if (ret) {
+		exfat_warn(sb, "volume bounds check failed. Please run fsck");
+		goto free_bh;
+	}
+
 	/*
 	 * Call exfat_count_num_cluster() before searching for up-case and
 	 * bitmap directory entries to avoid infinite loop if they are missing
-- 
2.53.0.1.ga224b40d3f.dirty

