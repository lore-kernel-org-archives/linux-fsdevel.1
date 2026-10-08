Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12451F936;
	Thu,  8 Oct 2026 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425447; cv=none; b=Mym5LmhaAbUMmz5y2Vh+FSExw9YwuOQh2SYlhzJPomgEjgwDUOoLexaY6xtibDTZ5RCVlksISMnYBGUeiK1wrKV/C3eLM5ZmVu/sU1r41iAAK5uAjlZ0+km/xLAGQsGB4wMWQSSbLUhbB+kgR5Sq5rTLu9eov5S7huhAtMCtqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425447; c=relaxed/simple;
	bh=kcEj6icCoI810XMKVwVTLKKPuAQMJaJ6tTfZuivBDn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHK0kFKhvS2Gwoq689C2DAWp588mMXrVuK+Aloh39JcxHVhB0CQMIjpEWyyKn00adWggokFSZdvtGTkDpGRG1MP4hr/3JOLtaFtNs2Jhax7/vt6zKoSX0EEP3JbwFD4O6U2u3Z+EvZnVq+87cgA0pR4waDEjTU0pa+vYdssfpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=kQK1taTY; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="kQK1taTY"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id B2EB21210F5;
	Wed,  7 Oct 2026 23:10:19 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791425419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ex5pApzJ7lEwwGm1ITLCcPCrVhdMabVZvUH5e8RLp4=;
	b=kQK1taTYswM9qanDiIQnjd+IkmnBmKQC8zBmbYVl4cyXrelln9d4jIOw3+5QUGTSn91psr
	JmJtoObRTfXlWh6trksehRb30b+uRnFlMfCoSHMFqBflCOxXseUvkIntAa6TFiSrGr/VmW
	kUqbBtcycRewhMGZWeMJCAz07qzWXm/7uSguXzevqsVMVTKYklfACm0/05tSpE8PWmu9Zv
	yoSEpWsX4PF8MP+MSZ4SrbNyIZJPnEHcCrGLvSoQ9tEllNlqKpky8VkCbQugaLonOvdayD
	T2bNg0J7VKrk72SzdP4hzM1VYGrlGyrWFBthJOeNfdb4j/ke65WHJapDlr05jg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 2/4] fat: return only first cluster when allocating
Date: Wed,  7 Oct 2026 23:09:38 -0300
Message-ID: <20261008020941.55784-3-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fat_alloc_clusters() returns every allocated cluster number in an array.
For larger allocations, like growing a file, this array would need to be
very large.

Make fat_alloc_clusters() return only the first allocated cluster in the
chain. Update fat_add_new_entries() to follow the chain when it needs
the second cluster.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/dir.c    | 20 +++++++++++++++++++-
 fs/fat/fat.h    |  2 +-
 fs/fat/fatent.c | 17 +++++++++--------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 35bdb6294..672d5e392 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1245,6 +1245,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 	sector_t blknr, start_blknr, last_blknr;
 	unsigned long size, copy;
 	int err, i, n, offset, cluster[2];
+	struct fat_entry fatent;
 
 	/*
 	 * The minimum cluster size is 512bytes, and maximum entry
@@ -1255,10 +1256,26 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 	*nr_cluster = (size + (sbi->cluster_size - 1)) >> sbi->cluster_bits;
 	BUG_ON(*nr_cluster > 2);
 
-	err = fat_alloc_clusters(dir, cluster, *nr_cluster);
+	err = fat_alloc_clusters(dir, &cluster[0], *nr_cluster);
 	if (err)
 		goto error;
 
+	if (*nr_cluster > 1) {
+		fatent_init(&fatent);
+		cluster[1] = fat_ent_read(dir, &fatent, cluster[0]);
+		fatent_brelse(&fatent);
+		if (cluster[1] == FAT_ENT_EOF || cluster[1] == FAT_ENT_FREE) {
+			fat_fs_error(sb,
+				     "%s: invalid cluster chain (i_pos %lld)",
+				     __func__, MSDOS_I(dir)->i_pos);
+			cluster[1] = -EIO;
+		}
+		if (cluster[1] < 0) {
+			err = cluster[1];
+			goto error_ent;
+		}
+	}
+
 	/*
 	 * First stage: Fill the directory entry.  NOTE: This cluster
 	 * is not referenced from any inode yet, so updates order is
@@ -1313,6 +1330,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 error_nomem:
 	for (i = 0; i < n; i++)
 		bforget(bhs[i]);
+error_ent:
 	fat_free_clusters(dir, cluster[0]);
 error:
 	return err;
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 61338413d..75ac0239a 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -393,7 +393,7 @@ extern int fat_ent_read(struct inode *inode, struct fat_entry *fatent,
 			int entry);
 extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
 			 int new, int wait);
-extern int fat_alloc_clusters(struct inode *inode, int *cluster,
+extern int fat_alloc_clusters(struct inode *inode, int *first_cluster,
 			      int nr_cluster);
 extern int fat_free_clusters(struct inode *inode, int cluster);
 extern int fat_count_free_clusters(struct super_block *sb);
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index bfab8eab5..4970b1f14 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -488,14 +488,14 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
 	return 0;
 }
 
-int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
+int fat_alloc_clusters(struct inode *inode, int *first_cluster, int nr_cluster)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent, prev_ent;
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
-	int i, count, err, nr_bhs, idx_clus;
+	int i, count, err, nr_bhs, clusters_done;
 
 	lock_fat(sbi);
 	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
@@ -504,7 +504,7 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 		return -ENOSPC;
 	}
 
-	err = nr_bhs = idx_clus = 0;
+	err = nr_bhs = clusters_done = 0;
 	count = FAT_START_ENT;
 	fatent_init(&prev_ent);
 	fatent_init(&fatent);
@@ -531,8 +531,9 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 				if (sbi->free_clusters != -1)
 					sbi->free_clusters--;
 
-				cluster[idx_clus] = entry;
-				idx_clus++;
+				if (!clusters_done)
+					*first_cluster = entry;
+				clusters_done++;
 
 				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
 					err = fat_flush_bhs(sb, bhs, &nr_bhs,
@@ -542,7 +543,7 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 				}
 				fat_collect_bhs(bhs, &nr_bhs, &fatent);
 
-				if (idx_clus == nr_cluster)
+				if (clusters_done == nr_cluster)
 					goto out;
 
 				/*
@@ -575,8 +576,8 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 	for (i = 0; i < nr_bhs; i++)
 		brelse(bhs[i]);
 
-	if (err && idx_clus)
-		fat_free_clusters(inode, cluster[0]);
+	if (err && clusters_done)
+		fat_free_clusters(inode, *first_cluster);
 
 	return err;
 }
-- 
2.43.0

