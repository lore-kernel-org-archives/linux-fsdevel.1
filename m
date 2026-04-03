Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1825311C32;
	Fri,  3 Apr 2026 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203622; cv=none; b=JsanMDZbEDJHVOzIMrm+VXlWHt/88TqB0+YTeMeSI0A4H9YNVirZn1agoFbgPIrtF2+ssbPI7hfEVx2M+uKaOEokq1sJp31wOsspSl84VFQYXShiuTsQbrumGJtx4wZS5FPzxuGJoVC/axhCZvfT0UWuFQYXcub55d1Z52Tvm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203622; c=relaxed/simple;
	bh=oeZOKBE1VUbPdhRxvr7y7onYWsDHmOHJYC/N/JXksYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq+IaLUjgpZnxA5yMVDRVYoLXNiewFtX1VBnHI/Pe+23ahz4We/Wqhwldyztx2lNrfqRfzIMzyafnkp6klqFVPdz7tYmHsv5FT4nlOCepcqKi9Uvsl5fNVT6WKhll133kVGmjNdKqDtn1856At8fGTz+aracUDWO9TLGaz8Dknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jas2XIpT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jas2XIpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ow
	mM8/gIcl1tt6ElQgY8wj/vutoa/bCpaIzHu7o+Pmo=; b=jas2XIpTI+HC0LjdlW
	lvcQIRBQEY1c1pEe1zzxPbAyyLvrbgdDd+rdH6WAsrnvorHKKx+igoRGJWmg3ODS
	k5rpZWXRuoKGuea0WZnQUbPHeLv0d9Wi7uADkba8hKZiOaeK1tj16WnHO+by+3vN
	NzEiCI11thzY0xzO/VHQB13so=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHW13+dM9pkhS7Cw--.58982S8;
	Fri, 03 Apr 2026 16:06:27 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 6/6] exfat: use exfat_chain_advance helper
Date: Fri,  3 Apr 2026 16:05:38 +0800
Message-ID: <20260403080538.361663-7-chizhiling@163.com>
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
X-CM-TRANSID:_____wDHW13+dM9pkhS7Cw--.58982S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry8CrWrZw47XFWUGr4xtFb_yoW7Jr17pF
	47Ga93JFyDJayqk3W8t3ZFva4Y9ws3GFyUXFn7uw1F9rZFyr1rC3s7CryIqF95C395Zw12
	qw1Utr1jgFsxWFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URHqxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AOrSWnPdQO4YgAA3T

From: Chi Zhiling <chizhiling@kylinos.cn>

Replace open-coded cluster chain walking logic with exfat_chain_advance()
across exfat_readdir, exfat_find_dir_entry, exfat_count_dir_entries,
exfat_search_empty_slot and exfat_check_dir_empty.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/dir.c   | 71 ++++++++++++------------------------------------
 fs/exfat/namei.c | 28 +++++--------------
 2 files changed, 25 insertions(+), 74 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ca5827046a1f..ac008ccaa97d 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -93,25 +93,19 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 	clu_offset = EXFAT_DEN_TO_CLU(dentry, sbi);
 	exfat_chain_dup(&clu, &dir);
 
-	if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-		clu.dir += clu_offset;
-		clu.size -= clu_offset;
-	} else {
+	if (clu.flags == ALLOC_FAT_CHAIN) {
 		/* hint_information */
 		if (clu_offset > 0 && ei->hint_bmap.off != EXFAT_EOF_CLUSTER &&
 		    ei->hint_bmap.off > 0 && clu_offset >= ei->hint_bmap.off) {
 			clu_offset -= ei->hint_bmap.off;
 			clu.dir = ei->hint_bmap.clu;
-		}
-
-		while (clu_offset > 0 && clu.dir != EXFAT_EOF_CLUSTER) {
-			if (exfat_get_next_cluster(sb, &(clu.dir)))
-				return -EIO;
-
-			clu_offset--;
+			clu.size -= ei->hint_bmap.off;
 		}
 	}
 
+	if (exfat_chain_advance(sb, &clu, clu_offset))
+		return -EIO;
+
 	while (clu.dir != EXFAT_EOF_CLUSTER && dentry < max_dentries) {
 		i = dentry & (dentries_per_clu - 1);
 
@@ -160,15 +154,8 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 			return 0;
 		}
 
-		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
-				clu.dir++;
-			else
-				clu.dir = EXFAT_EOF_CLUSTER;
-		} else {
-			if (exfat_get_next_cluster(sb, &(clu.dir)))
-				return -EIO;
-		}
+		if (exfat_chain_advance(sb, &clu, 1))
+			return -EIO;
 	}
 
 out:
@@ -1085,19 +1072,12 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			step = DIRENT_STEP_FILE;
 		}
 
-		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
-				clu.dir++;
-			else
-				clu.dir = EXFAT_EOF_CLUSTER;
-		} else {
-			if (exfat_get_next_cluster(sb, &clu.dir))
-				return -EIO;
+		if (exfat_chain_advance(sb, &clu, 1))
+			return -EIO;
 
-			/* break if the cluster chain includes a loop */
-			if (unlikely(++clu_count > EXFAT_DATA_CLUSTER_COUNT(sbi)))
-				goto not_found;
-		}
+		/* break if the cluster chain includes a loop */
+		if (unlikely(++clu_count > EXFAT_DATA_CLUSTER_COUNT(sbi)))
+			goto not_found;
 	}
 
 not_found:
@@ -1132,14 +1112,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	if (!((dentry + 1) & (dentries_per_clu - 1))) {
 		int ret = 0;
 
-		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
-				clu.dir++;
-			else
-				clu.dir = EXFAT_EOF_CLUSTER;
-		} else {
-			ret = exfat_get_next_cluster(sb, &clu.dir);
-		}
+		ret = exfat_chain_advance(sb, &clu, 1);
 
 		if (ret || clu.dir == EXFAT_EOF_CLUSTER) {
 			/* just initialized hint_stat */
@@ -1184,20 +1157,12 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 			count++;
 		}
 
-		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
-				clu.dir++;
-			else
-				clu.dir = EXFAT_EOF_CLUSTER;
-		} else {
-			if (exfat_get_next_cluster(sb, &(clu.dir)))
-				return -EIO;
-
-			if (unlikely(++clu_count > sbi->used_clusters)) {
-				exfat_fs_error(sb, "FAT or bitmap is corrupted");
-				return -EIO;
-			}
+		if (exfat_chain_advance(sb, &clu, 1))
+			return -EIO;
 
+		if (unlikely(++clu_count > sbi->used_clusters)) {
+			exfat_fs_error(sb, "FAT or bitmap is corrupted");
+			return -EIO;
 		}
 	}
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index d0ea1ff81c09..2c5636634b4a 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -246,15 +246,8 @@ static int exfat_search_empty_slot(struct super_block *sb,
 		i += ret;
 
 		while (i >= dentries_per_clu) {
-			if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-				if (--clu.size > 0)
-					clu.dir++;
-				else
-					clu.dir = EXFAT_EOF_CLUSTER;
-			} else {
-				if (exfat_get_next_cluster(sb, &clu.dir))
-					return -EIO;
-			}
+			if (exfat_chain_advance(sb, &clu, 1))
+				return -EIO;
 
 			i -= dentries_per_clu;
 		}
@@ -925,19 +918,12 @@ static int exfat_check_dir_empty(struct super_block *sb,
 			return -ENOTEMPTY;
 		}
 
-		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
-				clu.dir++;
-			else
-				clu.dir = EXFAT_EOF_CLUSTER;
-		} else {
-			if (exfat_get_next_cluster(sb, &(clu.dir)))
-				return -EIO;
+		if (exfat_chain_advance(sb, &clu, 1))
+			return -EIO;
 
-			/* break if the cluster chain includes a loop */
-			if (unlikely(++clu_count > EXFAT_DATA_CLUSTER_COUNT(sbi)))
-				break;
-		}
+		/* break if the cluster chain includes a loop */
+		if (unlikely(++clu_count > EXFAT_DATA_CLUSTER_COUNT(sbi)))
+			break;
 	}
 
 	return 0;
-- 
2.43.0

