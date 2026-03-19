Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66328030E;
	Thu, 19 Mar 2026 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894978; cv=none; b=f4QvNHZxRLwhwSLFinP0s1dd0oPGKeBxSJjXqdWoamSxX4Y/XOegNAmzZpnA4YZ07JwaVjiANxE0SurwauNnT5GFCWWWwU3k+Ys4DE9NCsn1HCm11Rhb0/RkHuxLMyICLqkMCf/stNOUh7a37zzgt4TPsqGpMl+QXP9X93qLknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894978; c=relaxed/simple;
	bh=7SHq1xQlnDRQLA/yrIbA2oGFiRoP6Ihyaz7IgdfZPxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSu4yG5/8h8DEajK7RX7Jv3qZFphGNDx3e/2ocqSLAn/Wj4ae6ejqr2CJyq6AU8x0TfzyLhlJn73HciU3KLb3ZYixPKpo5YOu+FVdDrsgjnXr27KPgjwN+EF318KuNdhD720RKBTyXtc8Y/N0a1SNdN5gyWqxS8/SuEq/ijlOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=Op3K8av+; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="Op3K8av+"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id C94AF1CBC3;
	Thu, 19 Mar 2026 04:36:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me C94AF1CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773894976; bh=7SHq1xQlnDRQLA/yrIbA2oGFiRoP6Ihyaz7IgdfZPxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Op3K8av+U8p8LtMXi4BTOgK/PQguwVdIq26KtcQ1ireu2sG/fnjVBPjn2iJXAWelC
	 Q/YYN+VSg56LzheZCpPfOMyj/q3YDQvrQLKJmr2QVLkFnJIL8q2Qowfvh2zQRKq8R4
	 As9YrlIenmoa0pkn2GkRFt+a20K3uINo5RwYJPfs=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id DDFLGTp9u2kIhQcA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Thu, 19 Mar 2026 04:36:14 +0000
From: David Timber <dxdt@dev.snart.me>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
Date: Thu, 19 Mar 2026 13:35:53 +0900
Message-ID: <20260319043553.301185-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260319043553.301185-1-dxdt@dev.snart.me>
References: <20260319043553.301185-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As means of truncating the VDL of a regular file while maintaining the
layout of the allocated clusters, allow the use fallocate mode
FALLOC_FL_ZERO_RANGE with the range that covers EOF, with the support
of optional FALLOC_FL_KEEP_SIZE flag.

To reset the VDL to 0, userspace may use fallocate() like so:

	fallocate(fd, FALLOC_FL_ZERO_RANGE|FALLOC_FL_KEEP_SIZE,
                  lseek(fd, 0, SEEK_END));

FALLOC_FL_KEEP_SIZE flag is for multiple users to guard the file from
TOCTOU conditions. Without the flag, the behaviour is the same as
FALLOC_FL_ZERO_RANGE.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/file.c | 75 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 2daf0dbabb24..cff61d1a9f68 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -36,7 +36,8 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	num_clusters = EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);
 	new_num_clusters = EXFAT_B_TO_CLU_ROUND_UP(size, sbi);
 
-	if (new_num_clusters == num_clusters)
+	WARN_ON(new_num_clusters < num_clusters);
+	if (new_num_clusters <= num_clusters)
 		goto out;
 
 	if (num_clusters) {
@@ -94,35 +95,87 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 /*
  * Preallocate space for a file. This implements exfat's fallocate file
  * operation, which gets called from sys_fallocate system call. User space
- * requests len bytes at offset. In contrary to fat, we only support
- * FALLOC_FL_ALLOCATE_RANGE because by leaving the valid data length(VDL)
- * field, it is unnecessary to zero out the newly allocated clusters.
+ * requests len bytes at offset.
+ *
+ * In contrary to fat, FALLOC_FL_ALLOCATE_RANGE can be done without zeroing out
+ * the newly allocated clusters by leaving the valid data length(VDL) field
+ * unchanged.
+ *
+ * Due to the inherent limitation of the VDL scheme, FALLOC_FL_ZERO_RANGE is
+ * only possible when the requested range covers EOF.
  */
 static long exfat_fallocate(struct file *file, int mode,
 			  loff_t offset, loff_t len)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t newsize = offset + len;
+	loff_t newsize, isize;
 	int err = 0;
 
 	/* No support for other modes */
-	if (mode != FALLOC_FL_ALLOCATE_RANGE)
+	switch (mode) {
+	case FALLOC_FL_ALLOCATE_RANGE:
+	case FALLOC_FL_ZERO_RANGE:
+	case FALLOC_FL_ZERO_RANGE|FALLOC_FL_KEEP_SIZE:
+		break;
+	default:
 		return -EOPNOTSUPP;
+	}
 
 	/* No support for dir */
 	if (!S_ISREG(inode->i_mode))
-		return -EOPNOTSUPP;
+		return mode & FALLOC_FL_ZERO_RANGE ? -EINVAL : -EOPNOTSUPP;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	inode_lock(inode);
 
-	if (newsize <= i_size_read(inode))
-		goto error;
+	newsize = offset + len;
+	isize = i_size_read(inode);
+
+	if (mode & FALLOC_FL_ZERO_RANGE) {
+		struct exfat_inode_info *ei = EXFAT_I(inode);
+		loff_t saved_validsize = ei->valid_size;
+
+		/* The requested range must span to or past EOF */
+		if (newsize < isize) {
+			err = -EOPNOTSUPP;
+			goto error;
+		}
+
+		/* valid_size can only be truncated */
+		if (offset < ei->valid_size)
+			ei->valid_size = offset;
+		/* If offset >= ei->valid_size, the range is already zeroed so that'd be no-op */
+
+		if (!(mode & FALLOC_FL_KEEP_SIZE) && isize < newsize) {
+			err = exfat_cont_expand(inode, newsize);
+			if (err) {
+				/* inode unchanged - revert valid_size */
+				ei->valid_size = saved_validsize;
+				goto error;
+			}
+			/* inode invalidated in exfat_cont_expand() */
+		} else {
+			/* update inode */
+			inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
-	/* This is just an expanding truncate */
-	err = exfat_cont_expand(inode, newsize);
+			mark_inode_dirty(inode);
+
+			if (IS_SYNC(inode))
+				return write_inode_now(inode, 1);
+		}
+
+		/* drop cache after the new valid_size */
+		if (ei->valid_size != saved_validsize)
+			truncate_pagecache(inode, ei->valid_size);
+	} else { /* mode == FALLOC_FL_ALLOCATE_RANGE */
+		if (newsize <= isize)
+			goto error;
+
+		/* This is just an expanding truncate */
+		err = exfat_cont_expand(inode, newsize);
+	}
 
 error:
 	inode_unlock(inode);
-- 
2.53.0.1.ga224b40d3f.dirty

