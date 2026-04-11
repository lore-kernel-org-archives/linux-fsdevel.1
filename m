Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED781213E7A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775950382; cv=none; b=Su5YawFxD7kK0vQVnf+KuSxlXwrT1nK6NjZed5E+yJyEi9OouVePB/c1y6xdU8lwUyS76BTimXJU1USUcTgiR+eY0gYTsXlfOsDqmDZczmYmNiYzyM+6kqDBLuM6Y1npa62Rr2+x9hqpq6z/tzXYvUH92jmP4ZASrd3izItl5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775950382; c=relaxed/simple;
	bh=MUYZ02mLWmiMs/YnBEJIp/1HN1JmXwl+TnJYYcbfW7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/m4pZGCuGkdSAUHyoIANe3qSrIoNQLuPd48gvLnayY0Lje0YCS/in/IEWlDu7WbNeLoWE8Xrg14P/iah2tvaXTM0xpfuxLqng5C4rznlvuK3IdbJwMAa5TtFhdEIIlFwOs0quoJMM8RXdxkSF5ITuUyqXdIaAesWd5DAHdG5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B5FF6302F1;
	Sat, 11 Apr 2026 23:32:58 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id RTbiGyra2mnxMgcA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 11 Apr 2026 23:32:58 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1] exfat: fix handling of damaged volume in exfat_create_upcase_table()
Date: Sun, 12 Apr 2026 08:32:51 +0900
Message-ID: <20260411233251.330698-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the size of the upcase table is set to zero in the dentry for any
reason(e.g. corrupted media or misbehaving device), an integer overflow
causes the module to loop indefinitely.

If the size of the upcase table is read zero, do not attempt to load the
table. Instead, fallback to loading the default upcase table. If the
size of the upcase table is zero or no upcase table is found, raise
exfat_fs_error() to mark the volume read-only.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/nls.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 57db08a5271c..055447edcf9a 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -769,13 +769,18 @@ int exfat_create_upcase_table(struct super_block *sb)
 
 			tbl_clu  = le32_to_cpu(ep->dentry.upcase.start_clu);
 			tbl_size = le64_to_cpu(ep->dentry.upcase.size);
-
-			sector = exfat_cluster_to_sector(sbi, tbl_clu);
-			num_sectors = ((tbl_size - 1) >> blksize_bits) + 1;
-			ret = exfat_load_upcase_table(sb, sector, num_sectors,
-				le32_to_cpu(ep->dentry.upcase.checksum));
-
+			if (tbl_size) {
+				sector = exfat_cluster_to_sector(sbi, tbl_clu);
+				num_sectors = ((tbl_size - 1) >> blksize_bits) + 1;
+				ret = exfat_load_upcase_table(sb, sector, num_sectors,
+					le32_to_cpu(ep->dentry.upcase.checksum));
+			} else {
+				exfat_fs_error(sb,
+					       "bad upcase table size (0 bytes). Please run fsck");
+				ret = -EINVAL;
+			}
 			brelse(bh);
+
 			if (ret && ret != -EIO) {
 				/* free memory from exfat_load_upcase_table call */
 				exfat_free_upcase_table(sbi);
@@ -790,6 +795,8 @@ int exfat_create_upcase_table(struct super_block *sb)
 			return -EIO;
 	}
 
+	exfat_fs_error(sb, "no upcase table entry. Please run fsck");
+
 load_default:
 	/* load default upcase table */
 	return exfat_load_default_upcase_table(sb);
-- 
2.53.0.1.ga224b40d3f.dirty

