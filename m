Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164194BB27A;
	Mon, 12 Oct 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825098; cv=none; b=dirqU4ts1cauFMr+FL6pRwc3ipHMjl6eIvbS9wnwgPHBGqvJzcgseFubi3CkjQ9ENwV2Je93rmE7wkNlCJFabEiwUQSGmSeqlASdSKjWW8x4yvli1O5xX5e604kRX/Nxvft6TSoMwdF56ZYp9IhW8m5509uHbVF6Xc0/MK52Irg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825098; c=relaxed/simple;
	bh=GV4k+oJytu3unsxaB1n6c0BZ5p0wwbj1G3B7v33tlQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDviY3MQgxVpbkkb4ru/lZvLCWLTZbdTZc66o+O0f+iKRrzeXXoctH/jhgRjxtmZC9mQfbuIZvrwx9Pv7LHrC3SK4a2cD1CL/AWXI1dg2hoqUMdpOyY7joY5p4jxA93GMDW+8spS69DDTNkHmL9QvkP6mRzdns+he1GKQuWwdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=ru1qrPv5; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="ru1qrPv5"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 1BAFF121123;
	Mon, 12 Oct 2026 14:11:15 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791825075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaz+YICxW/3jvQPhXV1zvc6ZlmXPj22FrpeWCJ05fz8=;
	b=ru1qrPv5xCXeVuzAHDJiXRJKVBv3nWblUYroHyzI0Qh69L4TRjLXxmIuGFmpM/d/l2enu+
	y7/GbLWXlnsNrVPY4tbjYBGAXHvpF5xu591omh+sqnfdakHWYrTp10HG/gw0Pssr+yDfQ6
	A+KJY8VHYbPrDv7cWKglIxswA+DKgY8eRDFZv1Th81cZ1rbVjpPRg97cQIuXvG+d7ej63r
	ZqZjDb1kjlTcQE2L3mO7ixmlkfZx3n5jszBGIU22XMFS2V4SDMYd78aUNcZS3m8LGujs+v
	ndgZV11gmpPnujCN0hNY/XQNM/BuGoaNHSf9CWG+euSKBVzY8cMO09Jw2Iwf7A==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2 2/3] fat: support adding multiple clusters
Date: Mon, 12 Oct 2026 14:11:05 -0300
Message-ID: <20261012171106.146243-3-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fat_add_cluster() currently adds only one cluster to a file's chain,
requiring multiple calls when adding more clusters.

Add a fat_alloc_chain() helper that allocates a cluster chain
but only returns the first cluster. Extend fat_add_cluster()
to add multiple clusters in a single call and rename it to
fat_add_clusters() to reflect the new behavior.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fat.h    |  3 ++-
 fs/fat/fatent.c | 18 ++++++++++++++++--
 fs/fat/file.c   |  2 +-
 fs/fat/inode.c  |  8 ++++----
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 61338413d..b18385461 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -395,6 +395,7 @@ extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
 			 int new, int wait);
 extern int fat_alloc_clusters(struct inode *inode, int *cluster,
 			      int nr_cluster);
+int fat_alloc_chain(struct inode *inode, int *cluster, int nr_cluster);
 extern int fat_free_clusters(struct inode *inode, int cluster);
 extern int fat_count_free_clusters(struct super_block *sb);
 extern int fat_trim_fs(struct inode *inode, struct fstrim_range *range);
@@ -440,7 +441,7 @@ static inline unsigned long fat_dir_hash(int logstart)
 {
 	return hash_32(logstart, FAT_HASH_BITS);
 }
-extern int fat_add_cluster(struct inode *inode);
+extern int fat_add_clusters(struct inode *inode, int nr_cluster);
 
 /* fat/misc.c */
 extern __printf(3, 4) __cold
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index bfab8eab5..8897a5dd5 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -488,7 +488,8 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
 	return 0;
 }
 
-int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
+static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
+				bool return_all)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -531,7 +532,10 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 				if (sbi->free_clusters != -1)
 					sbi->free_clusters--;
 
-				cluster[idx_clus] = entry;
+				if (return_all)
+					cluster[idx_clus] = entry;
+				else if (!idx_clus)
+					*cluster = entry;
 				idx_clus++;
 
 				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
@@ -581,6 +585,16 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 	return err;
 }
 
+int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
+{
+	return __fat_alloc_clusters(inode, cluster, nr_cluster, true);
+}
+
+int fat_alloc_chain(struct inode *inode, int *cluster, int nr_cluster)
+{
+	return __fat_alloc_clusters(inode, cluster, nr_cluster, false);
+}
+
 int fat_free_clusters(struct inode *inode, int cluster)
 {
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 1c835ca5f..41d49e9de 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -292,7 +292,7 @@ static long fat_fallocate(struct file *file, int mode,
 
 		/* Start the allocation.We are not zeroing out the clusters */
 		while (nr_cluster-- > 0) {
-			err = fat_add_cluster(inode);
+			err = fat_add_clusters(inode, 1);
 			if (err)
 				goto error;
 		}
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index f775a004c..141276fcf 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -101,16 +101,16 @@ static struct fat_floppy_defaults {
 },
 };
 
-int fat_add_cluster(struct inode *inode)
+int fat_add_clusters(struct inode *inode, int nr_cluster)
 {
 	int err, cluster;
 
-	err = fat_alloc_clusters(inode, &cluster, 1);
+	err = fat_alloc_chain(inode, &cluster, nr_cluster);
 	if (err)
 		return err;
 	/* FIXME: this cluster should be added after data of this
 	 * cluster is writed */
-	err = fat_chain_add(inode, cluster, 1);
+	err = fat_chain_add(inode, cluster, nr_cluster);
 	if (err)
 		fat_free_clusters(inode, cluster);
 	return err;
@@ -152,7 +152,7 @@ static inline int __fat_get_block(struct inode *inode, sector_t iblock,
 	 */
 	if (!offset && !(iblock < last_block)) {
 		/* TODO: multiple cluster allocation would be desirable. */
-		err = fat_add_cluster(inode);
+		err = fat_add_clusters(inode, 1);
 		if (err)
 			return err;
 	}
-- 
2.43.0

