Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB453ECBF3;
	Tue, 31 Mar 2026 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948348; cv=none; b=FmjFOiBx6udajv7OaOXhnbvcZeAv4hsls0QIBWQp3iHGdwkEzIxwPLRDINhu9Yx1idXMAmBOFYymYCrbvjUISvqSptOT0QYxgs3jTxcL77UV+qT/SmGG1wSi0QYE18+Mg8J8UgwL/4/lCG4px/j6igFWkVPgA+iunh8W6LWcPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948348; c=relaxed/simple;
	bh=Hzi7QI0MjFR+00hDT1WJfqj2/XOv4/m9Z99ISdI3jp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCRxL8HiIeZuQJsABuZzuukBAgykf9o2UfY0Ss/ZAOc3GNqRmUSnkqJ0oyCyci+pcmag+5L8Kn7Ob/osMjeGjmApDWwYSdWmvNIVz7grCb4j6JYHIhVTtJkmtuwOVUSI6YxOc1p4K/TePG2fbI/I+qzJ/z/gl89U206eNDpL74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=COQ4Qnd1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="COQ4Qnd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n6
	bPhhXb8I2/V20ZXRI8m7mImL5UZIwvzwNnhJkmkM8=; b=COQ4Qnd1rg53XZyFn9
	JQ2KLXUU9Ordwc6Nv8KdeTmZCiz0gs06YUIwH0lm9Zb7MWzCkBwgkm/GBaVfL026
	lfFmkQV9KybVBPuo+jXsYdA6VkhxQOUMJzF52ICI6WgJ+pfHNf/q3ryxIo1Ahtiy
	UoiYK9BvhhBfTswR/Li+bi6Cc=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXetTUj8tpdt0MCg--.18595S6;
	Tue, 31 Mar 2026 17:11:56 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 4/6] exfat: remove NULL cache pointer case in exfat_ent_get
Date: Tue, 31 Mar 2026 17:11:11 +0800
Message-ID: <20260331091113.20882-5-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331091113.20882-1-chizhiling@163.com>
References: <20260331091113.20882-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXetTUj8tpdt0MCg--.18595S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4kCw43tw17trWrKr47twb_yoW8KFWDpr
	ZIka97tr4Ut3ZF93ZFyrs3Z3WfC397JFykGa1rCF93Ar1UtFn5XFyxtFyFyF48Ca97uFWY
	vF4UKF15C3srWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2ZXOUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xxoBmnLj9w4SAAA3o

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

