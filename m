Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DE33F8C1;
	Fri,  3 Apr 2026 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203621; cv=none; b=tu0R5bmOBhDdEnNVlwInBSQCDrqEdeRjBl+au6cN27+Q/VhiDQ58hsmdHu8GC56Z0D1IbI92RPqNbNqD0cTSo7IqDrGYGljUQWUxRxEiiSLa4ugpjW+VXakE5XtJSQRrNJDf5R7z9RiWUtgE3fLNs2pi3CDJ6JUfCcLinCX87fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203621; c=relaxed/simple;
	bh=Hzi7QI0MjFR+00hDT1WJfqj2/XOv4/m9Z99ISdI3jp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTet8xiFIuyZzEh24/GCIE/udnInsC6Le2c9RcCvmvqGPUbRvd6Li4BWm4c/fu50/P8GWmhaN/e/iwbg7vHogb+ppjJAFOiYk5uL7DG0+UhEuX6vKBCrvooPT8gV9opjzIjDz7kh2TTZRgOFrvmY/YMVXohYibZIpc5zT6RFr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DXL9gSWv; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DXL9gSWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n6
	bPhhXb8I2/V20ZXRI8m7mImL5UZIwvzwNnhJkmkM8=; b=DXL9gSWvIzQhJilfn5
	qxfQhjHZQ3giwQET7+n7C3qENDFBa5AEldSW7uUHfDaylCouA0WstV6gF1aVcvRO
	5eGbZrIZTSMjNkcsGaYc1LcH43AbfVc5aWzn6Rqt8LxYWUFzCBkNzET58w24zTbq
	+saInDQgzje/nVrJ0CABj6jk8=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHW13+dM9pkhS7Cw--.58982S6;
	Fri, 03 Apr 2026 16:06:26 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 4/6] exfat: remove NULL cache pointer case in exfat_ent_get
Date: Fri,  3 Apr 2026 16:05:36 +0800
Message-ID: <20260403080538.361663-5-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403080538.361663-1-chizhiling@163.com>
References: <20260403080538.361663-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHW13+dM9pkhS7Cw--.58982S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4kCw43tw17trWrKr47twb_yoW8KFWDpr
	ZIka97tr4Ut3ZF93ZFyrs3Z3WfC397JFykGa1rCF93Ar1UtFn5XFyxtFyFyF48Ca97uFWY
	vF4UKF15C3srWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2ZXOUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wKrSWnPdQKwMgAA3E

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_get_next_cluster has been updated, no callers pass a NULL
pointer to exfat_ent_get, so remove the handling logic for this case.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index f2e5d5dde393..dce0955e689a 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -44,11 +44,11 @@ static int exfat_end_bh(struct super_block *sb, struct buffer_head *bh)
 }
 
 static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
-		unsigned int *content, struct buffer_head **last)
+		unsigned int *content, struct buffer_head **cache)
 {
 	unsigned int off;
 	sector_t sec;
-	struct buffer_head *bh = last ? *last : NULL;
+	struct buffer_head *bh = *cache;
 
 	sec = FAT_ENT_OFFSET_SECTOR(sb, loc);
 	off = FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc);
@@ -56,8 +56,7 @@ static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 	if (!bh || bh->b_blocknr != sec || !buffer_uptodate(bh)) {
 		brelse(bh);
 		bh = sb_bread(sb, sec);
-		if (last)
-			*last = bh;
+		*cache = bh;
 		if (unlikely(!bh))
 			return -EIO;
 	}
@@ -68,8 +67,6 @@ static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 	if (*content > EXFAT_BAD_CLUSTER)
 		*content = EXFAT_EOF_CLUSTER;
 
-	if (!last)
-		brelse(bh);
 	return 0;
 }
 
@@ -111,7 +108,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
  * Caller must release the buffer_head if no error return.
  */
 int exfat_ent_get(struct super_block *sb, unsigned int loc,
-		unsigned int *content, struct buffer_head **last)
+		unsigned int *content, struct buffer_head **cache)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
@@ -122,7 +119,7 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 		goto err;
 	}
 
-	if (unlikely(__exfat_ent_get(sb, loc, content, last))) {
+	if (unlikely(__exfat_ent_get(sb, loc, content, cache))) {
 		exfat_fs_error_ratelimit(sb,
 			"failed to access to FAT (entry 0x%08x)",
 			loc);
@@ -151,13 +148,11 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 	}
 
 	return 0;
-err:
-	if (last) {
-		brelse(*last);
 
-		/* Avoid double release */
-		*last = NULL;
-	}
+err:
+	/* Avoid double release */
+	brelse(*cache);
+	*cache = NULL;
 	return -EIO;
 }
 
-- 
2.43.0

