Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F538175A6B
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775947820; cv=none; b=EVOxqI21m7sEf6/qZegRKQQIf4XhSuCWvCUuL/n4pnyM1o8ivBZnRVzxfIcrJqABsFHg/IrgLNUIHvHTqYXSi7CQ3jT5V8V+ZT2Wner8yKi3WueD6imJKFY2U8B80Li1Nz6rsxwdA5RPZ8AufdrQ9QQLwHHZFVj6cwZSOvomwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775947820; c=relaxed/simple;
	bh=2LdA8/X+eilPnRyfsAPMHNqiLbGSV2Atqt8/ZUfoJto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5IkrI5yD82J8JttmirmdAWoWs8pX0MCjyTC6jrdp31682VvnVb0tWIz3CpRosoj04KbRuUK9a3+hVHbNIwCz+8lvY8Hx2ZWhVQ7u87bIOuGp/XQk/arIWduaSYmJp6WaKHEN41gz4nF1lShsjwXMpiKn7ryZvoYjbC15K9/A9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id D2AFC302F1;
	Sat, 11 Apr 2026 22:50:10 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id ugaLICLQ2mkzMAcA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 11 Apr 2026 22:50:10 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH] exfat: fix integer overflow in exfat_create_upcase_table()
Date: Sun, 12 Apr 2026 07:49:47 +0900
Message-ID: <20260411224947.296754-1-dxdt@dev.snart.me>
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
table. Instead, fallback to loading the default upcase table and raise
exfat_fs_error() to mark the volume read-only. This is also the
behaviour of MS Windows.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/nls.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 57db08a5271c..fe5230cae377 100644
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
-- 
2.53.0.1.ga224b40d3f.dirty

