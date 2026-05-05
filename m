Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895B426EC5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984119; cv=none; b=edExKL5BLWJ/ssyruL8vbDSRjXdKNqhPI4/Q8WwjO0wap6dLzMt6v1+dG9w8cVFIW87yQZxBT2FpOkPe6C84L5e4Ftm53yqIjZXGksvanS1ceSh4OQ1fp6CY7Jpwvics4j5V+yn7FqOP1lNCQJ9hPE29J9pcTrTBEMZL6Gh692Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984119; c=relaxed/simple;
	bh=g3A+7C0OJqHzNIO4gY4OAfUvQh3Tf8t4E+x0q7RUKMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVWTNse/H6KamX4YCeU0QJSHZE9QxKaLDLOIOo/aaeWnzQvtlHj1glWOPtCHQhHyfHx+igVsjc00CzvpGCHV+Hn+kYDjinpke6XRCbThF1LJ56WxKZcwE8/sNVMkVal/djXyLwyKZD1DLcgWaT9B0W8V4cqyz92qBcSUBxv5GJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 39D3F1D490;
	Tue,  5 May 2026 12:28:35 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id L3/cOHLi+WkgZAEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 05 May 2026 12:28:35 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 1/3] exfat: add volume limit bounds checks
Date: Tue,  5 May 2026 21:28:06 +0900
Message-ID: <20260505122808.728020-1-dxdt@dev.snart.me>
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
 fs/exfat/super.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 95d87e2d7717..15e99766cb8c 100644
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
@@ -591,6 +601,34 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	return 0;
 }
 
+static inline int exfat_check_volume_sizes(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	/* last sector of exFAT volume == end of last cluster */
+	const sector_t lc_end = exfat_cluster_to_sector(sbi, sbi->num_clusters);
+	/*
+	 * Do the calculations in bytes because the blocksize may have been
+	 * calibrated in exfat_calibrate_blocksize(), and bdev_nr_sectors()
+	 * always reports in 512-byte units.
+	 */
+	const unsigned long long vol_size = EXFAT_BLK_TO_B(sbi->num_sectors, sb);
+	const unsigned long long bdev_size = (unsigned long long)bdev_nr_bytes(sb->s_bdev);
+
+	if (sbi->num_sectors < (unsigned long long)lc_end) {
+		exfat_err(sb, "number of clusters out of volume length bounds : num_sectors=%llu, last_cluster_sector=%lld",
+			  sbi->num_sectors, lc_end);
+		return -EINVAL;
+	}
+
+	if (bdev_size < vol_size) {
+		exfat_err(sb, "volume length out of bounds : dev=%llu, vol=%lld",
+			  bdev_size, vol_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* mount the file system volume */
 static int __exfat_fill_super(struct super_block *sb,
 		struct exfat_chain *root_clu)
@@ -610,6 +648,12 @@ static int __exfat_fill_super(struct super_block *sb,
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

