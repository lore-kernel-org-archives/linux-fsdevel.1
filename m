Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E291DFD96
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697326; cv=none; b=TO0HugMFnxhq3h4APsiV14f2IkRuX5p2B5jrsMBYUkk7BAqzTOGzwew4wAhqBq3eGwjaLpwjqc3rZdnmra9TGqsPrFJTsrqMxaVmkyG+2lnPDvmUxVfZA5SnwZJNqGToFkPqQxL2M0ZwgCYPuzSwZI3u4BE/KKBT9TjLMZZAzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697326; c=relaxed/simple;
	bh=NaFBertK/HrYV1u5GY4KHz6CmCGAkkV0oyej08gwKBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEnMs5C9o/EnhZnNYxTpDqeMv0KS6NO3Do+TgB5B+4HEAM0pvyGuSoJcz0058FTUowZfofARU/WhrsuT3BTK6QBWgXVnxac0onVGMP7tjcT/OS5pgenWr2Q8miQqLDtAcpb41CRIWpDgz0YNDqvCy6FjYPQzaXulsODRVGXLsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=ePhF3p+c; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="ePhF3p+c"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 5A8231CBC3;
	Mon, 16 Mar 2026 21:41:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 5A8231CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773697318; bh=NaFBertK/HrYV1u5GY4KHz6CmCGAkkV0oyej08gwKBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePhF3p+cZWjyeJ8loGvtAJHzoRti5IWrUwW5R2Cx0I7qd4Qwqwjjzc4f6DqqIoSKe
	 Rk2r+eiNcpzV79ULI7pNmECq8KXfDhluvhNZbMarzcc1Ouzen90q53/hLuFA9DH8Va
	 7Dgzq+V+A5+8XyBhhBWnXlQSj2dAdERLcKVbDg9w=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id eL6KLiF5uGltqAYA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Mon, 16 Mar 2026 21:41:57 +0000
From: David Timber <dxdt@dev.snart.me>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org
Cc: yuezhang.mo@sony.com,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 1/1] exfat: fix s_maxbytes
Date: Tue, 17 Mar 2026 06:41:37 +0900
Message-ID: <20260316214137.1490070-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260316214137.1490070-1-dxdt@dev.snart.me>
References: <20260316214137.1490070-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fallocate support, xfstest unit generic/213 fails with

   QA output created by 213
   We should get: fallocate: No space left on device
   Strangely, xfs_io sometimes says "Success" when something went wrong
  -fallocate: No space left on device
  +fallocate: File too large

because sb->s_maxbytes is set to the volume size.

To be in line with other non-extent-based filesystems, set to max volume
size possible with the cluster size of the volume.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/exfat_raw.h |  1 +
 fs/exfat/file.c      |  1 +
 fs/exfat/super.c     | 11 ++++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 4082fa7b8c14..ec70cd35bba0 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -25,6 +25,7 @@
 #define EXFAT_FIRST_CLUSTER	2
 #define EXFAT_DATA_CLUSTER_COUNT(sbi)	\
 	((sbi)->num_clusters - EXFAT_RESERVED_CLUSTERS)
+#define EXFAT_MAX_NUM_CLUSTER		(0xFFFFFFF5)
 
 /* AllocationPossible and NoFatChain field in GeneralSecondaryFlags Field */
 #define ALLOC_POSSIBLE		0x01
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 2daf0dbabb24..6fa720e99103 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -34,6 +34,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 		return ret;
 
 	num_clusters = EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);
+	/* integer overflow is already checked in inode_newsize_ok(). */
 	new_num_clusters = EXFAT_B_TO_CLU_ROUND_UP(size, sbi);
 
 	if (new_num_clusters == num_clusters)
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 83396fd265cd..95d87e2d7717 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -531,9 +531,14 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	if (sbi->vol_flags & MEDIA_FAILURE)
 		exfat_warn(sb, "Medium has reported failures. Some data may be lost.");
 
-	/* exFAT file size is limited by a disk volume size */
-	sb->s_maxbytes = (u64)(sbi->num_clusters - EXFAT_RESERVED_CLUSTERS) <<
-		sbi->cluster_size_bits;
+	/*
+	 * Set to the max possible volume size for this volume's cluster size so
+	 * that any integer overflow from bytes to cluster size conversion is
+	 * checked in inode_newsize_ok(). Clamped to MAX_LFS_FILESIZE for 32-bit
+	 * machines.
+	 */
+	sb->s_maxbytes = min(MAX_LFS_FILESIZE,
+			     EXFAT_CLU_TO_B((loff_t)EXFAT_MAX_NUM_CLUSTER, sbi));
 
 	/* check logical sector size */
 	if (exfat_calibrate_blocksize(sb, 1 << p_boot->sect_size_bits))
-- 
2.53.0.1.ga224b40d3f.dirty

