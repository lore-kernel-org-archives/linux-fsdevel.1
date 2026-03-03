Received: from lgeamrelo13.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C5382398
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526613; cv=none; b=eKA3tp2JDEhhL64N0AypjkgluRc347UoB2RMjt99W2Se6ZO42R9ySkItNv7HPpUE1CH8DUUijGXFcaFQWguFRG4oXO31dVoOxJa1GA3qO6PLv9G9vOneSJiAdek4+HRgkiTEo+yIAzREQA8oTH2uTxaSpZmXw3u+z3ydfNwqCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526613; c=relaxed/simple;
	bh=G2IGR9gNph6Q5iOaLhO3exspOvBvq/3N3sHkTTdDCLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBLYgRcspkL3mFxWfC42dSHV/7Z82+ubtnLcp9WsZ2Ge9PLid+5qohydgX37sofWB+wSPgdtqNIz0p14mqeQcjADWTwFAvEmUvChixLgefF/TTq3Z0JdTsi43WFH3GYSN+mFGfcI9G32gJ5akQAhUS69edsdf+WWU1GyVgmLweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.53 with ESMTP; 3 Mar 2026 17:28:28 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO hyunchul-PC02.lge.net) (10.177.111.62)
	by 156.147.1.125 with ESMTP; 3 Mar 2026 17:28:28 +0900
X-Original-SENDERIP: 10.177.111.62
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cheol.lee@lge.com
Subject: [PATCH] hfsplus: limit sb_maxbytes to partition size
Date: Tue,  3 Mar 2026 17:28:07 +0900
Message-ID: <20260303082807.750679-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s_maxbytes currently is set to MAX_LFS_FILESIZE,
which allows writes beyond the partition size. As a result,
large-offset writes on small partitions can fail late
with ENOSPC.

Set s_maxbytes to the partition size.

With this change, the large-offset writes are rejected
early by `generic_write_check_limit()` with EFBIG.

This patch also fixes generic/268.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/hfsplus/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 7229a8ae89f9..18350abc659b 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -500,7 +500,8 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Set up operations so we can load metadata */
 	sb->s_op = &hfsplus_sops;
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_maxbytes = (loff_t)min(MAX_LFS_FILESIZE,
+				     (u64)sbi->total_blocks << sbi->alloc_blksz_shift);
 
 	if (!(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
 		pr_warn("Filesystem was not cleanly unmounted, running fsck.hfsplus is recommended.  mounting read-only.\n");
-- 
2.43.0

