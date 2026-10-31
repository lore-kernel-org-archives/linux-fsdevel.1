Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465080;
	b=UOVzABSIo0fZt9wQ6O7imdyMMgiSx1yQfUCUV309hitcflCSIbxfTly0XosOpXYBfCpG
	 NR7XCu5vU45BF4MKSdCESEBqJcPsJXG2v+VjSUbYXq0WhzPqls8zA0+sM2+c5zayB4d32
	 46MFCx9ES5Ph7GmYIbxi0/v9YKSgT8+A1dImTBUutrZRu+h5kM9bpkV9aD3godVpzbUba
	 SGPyCkrs3I8g8t/RBJzZAQYG+pK2q10BljlMdYgPRt676eWBWvBdYHLfsjt5HUkobsA7S
	 y0YL66yCAQJV6OFUjXu2B9PXEB2u7PG/+fT2791RIw9c1N8opiQpKKu1YKp8cVr7RQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465080;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zJZkpdmi2tH4fCEb0bpGohfZGhw5gIhc9fCiRV6mO+4=;
	b=I8e0G8SVau853ax5jNgWAZxueQSlbwMeLduZREOZXc8/svT5pJOQwpx+hj05NcWpkcZ8
	 njf0u6H4STZbg51x0mH6bHpqW1u+rNX3bJw+bGAq1ZXal7abYW1uFa/sLp7aH2Q36ddgo
	 7gffXBqrYCnHR1zhldAi0zodar5D60XB9g20iGjUZG3oWMZSGOs3SaRpI4RF5adEb6L7m
	 8oJWyEuU8P444jqQbcjbwIkj8y7TqusOixgDAYbIczwF0MmX2PlriTnBhkthwkd0Av8S3
	 fP4W36UZMZRn0PM2EKU7PubpiwuiFwq+Zv7yeHz5b6Mz6XtAPLSDVEahSZGgF0h1cbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=6XopIw+P;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C9606A324;
	Sat, 31 Oct 2026 16:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 525C9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=6XopIw+P
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 78DC0121044;
	Sat, 31 Oct 2026 13:43:50 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJZkpdmi2tH4fCEb0bpGohfZGhw5gIhc9fCiRV6mO+4=;
	b=6XopIw+PTD7iHfBrzJlQC1Acpgo0zL57rplQ6IciZ3qQpDgYJQprcXtchPgSkMPqeWnesf
	rMpNNERHe4eOtfgSy9udprQPzELmmyL2hcmS7YLn/cVIa/SHgvmWff4Oe5EjPzrCpmAvxA
	E9eEFvjNF8d8nmzqsyHzjMgDIrbQakOqNJc6ZIK3ZEF4g5Am37un6xiGB33+b2p1l0O0sm
	Um474/ShFvuRkT8/Jq2pGK/ipQjhVufSoCrQXeuPp1J7ozm5/U4L0N3DF4EXNemfaVo1KY
	ElDZnnd7XRJIGb/kqPXGUmnqRK9UNmasqwzn1ebhfiqz8TUia1nLEimsdGzzqA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 8/8] fat: add multi-cluster allocation for write
Date: Sat, 31 Oct 2026 13:43:26 -0300
Message-ID: <20261031164326.278125-9-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iomap code expands the file cluster-by-cluster, requiring many calls
into the allocator.

Implement multi-cluster allocation on write. To preserve short write
semantics, allow allocations of chains smaller than the requested size
in fat_alloc_chain().

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fat.h    |  6 ++++--
 fs/fat/fatent.c | 33 ++++++++++++++++++++++-----------
 fs/fat/file.c   |  2 +-
 fs/fat/inode.c  |  4 ++--
 fs/fat/iomap.c  | 12 ++++++------
 5 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 962f6f6b7717..c953b2fd9c69 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -393,7 +393,8 @@ extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
 			 int new, int wait);
 extern int fat_alloc_clusters(struct inode *inode, int *cluster,
 			      int nr_cluster);
-int fat_alloc_chain(struct inode *inode, int *cluster, int nr_cluster);
+int fat_alloc_chain(struct inode *inode, int *cluster, int *nr_cluster,
+		    bool allow_partial);
 extern int fat_free_clusters(struct inode *inode, int cluster);
 extern int fat_count_free_clusters(struct super_block *sb);
 extern int fat_trim_fs(struct inode *inode, struct fstrim_range *range);
@@ -439,7 +440,8 @@ static inline unsigned long fat_dir_hash(int logstart)
 {
 	return hash_32(logstart, FAT_HASH_BITS);
 }
-extern int fat_add_clusters(struct inode *inode, int nr_cluster);
+
+int fat_add_clusters(struct inode *inode, int nr_cluster, bool allow_partial);
 
 /* fat/misc.c */
 extern __printf(3, 4) __cold
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 46899efa3cf8..6fb99a8759b8 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -538,8 +538,8 @@ static void fat_clean_bdev_aliases(struct super_block *sb,
 			   (sector_t)count * sbi->sec_per_clus);
 }
 
-static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
-				bool return_all)
+static int __fat_alloc_clusters(struct inode *inode, int *cluster, int *nr_cluster,
+				bool return_all, bool allow_partial)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -547,12 +547,18 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 	struct fat_entry fatent, prev_ent;
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
 	int i, count, err, nr_bhs, idx_clus, cont_start, cont_len;
+	int nr_alloc = *nr_cluster;
 
 	lock_fat(sbi);
-	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
-	    sbi->free_clusters < nr_cluster) {
-		unlock_fat(sbi);
-		return -ENOSPC;
+	if (sbi->free_clusters != -1 && sbi->free_clus_valid) {
+		if (sbi->free_clusters == 0 ||
+		    (!allow_partial && sbi->free_clusters < nr_alloc)) {
+			unlock_fat(sbi);
+			return -ENOSPC;
+		}
+		if (allow_partial)
+			nr_alloc = min_t(unsigned int, nr_alloc,
+					 sbi->free_clusters);
 	}
 
 	cont_len = 0;
@@ -606,7 +612,7 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 				}
 				fat_collect_bhs(bhs, &nr_bhs, &fatent);
 
-				if (idx_clus == nr_cluster)
+				if (idx_clus == nr_alloc)
 					goto out;
 
 				/*
@@ -627,7 +633,8 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 	/* Couldn't allocate the free entries */
 	sbi->free_clusters = 0;
 	sbi->free_clus_valid = 1;
-	err = -ENOSPC;
+	if (!allow_partial || !idx_clus)
+		err = -ENOSPC;
 
 out:
 	if (cont_len)
@@ -647,17 +654,21 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 	if (err && idx_clus)
 		fat_free_clusters(inode, cluster[0]);
 
+	if (!err)
+		*nr_cluster = idx_clus;
 	return err;
 }
 
 int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 {
-	return __fat_alloc_clusters(inode, cluster, nr_cluster, true);
+	return __fat_alloc_clusters(inode, cluster, &nr_cluster, true, false);
 }
 
-int fat_alloc_chain(struct inode *inode, int *cluster, int nr_cluster)
+int fat_alloc_chain(struct inode *inode, int *cluster, int *nr_cluster,
+		    bool allow_partial)
 {
-	return __fat_alloc_clusters(inode, cluster, nr_cluster, false);
+	return __fat_alloc_clusters(inode, cluster, nr_cluster, false,
+				    allow_partial);
 }
 
 int fat_free_clusters(struct inode *inode, int cluster)
diff --git a/fs/fat/file.c b/fs/fat/file.c
index ac6329d36062..a7349b2b94ee 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -395,7 +395,7 @@ int fat_preallocate(struct inode *inode, loff_t new_size)
 		     sbi->cluster_bits;
 
 	/* Allocate the clusters. We are not zeroing them out */
-	return fat_add_clusters(inode, nr_cluster);
+	return fat_add_clusters(inode, nr_cluster, false);
 }
 
 static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index cb2316062bb3..6896c0c0dec9 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -101,11 +101,11 @@ static struct fat_floppy_defaults {
 },
 };
 
-int fat_add_clusters(struct inode *inode, int nr_cluster)
+int fat_add_clusters(struct inode *inode, int nr_cluster, bool allow_partial)
 {
 	int err, cluster;
 
-	err = fat_alloc_chain(inode, &cluster, nr_cluster);
+	err = fat_alloc_chain(inode, &cluster, &nr_cluster, allow_partial);
 	if (err)
 		return err;
 	/* FIXME: this cluster should be added after data of this
diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
index 893d94f6b70c..581fa609ae18 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -98,6 +98,7 @@ static int fat_iomap_begin_write(struct inode *inode, loff_t offset,
 				 loff_t length, unsigned int flags,
 				 struct iomap *iomap, struct iomap *srcmap)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	loff_t curr_size = i_size_read(inode);
 	loff_t old_alloc = inode_get_bytes(inode);
 	int err;
@@ -106,12 +107,11 @@ static int fat_iomap_begin_write(struct inode *inode, loff_t offset,
 	if (WARN_ONCE(offset > curr_size, "Write starting past EOF"))
 		return -EOPNOTSUPP;
 
-	if (offset == curr_size) {
-		/*
-		 * TODO: allocate multiple blocks while allowing
-		 * short writes
-		 */
-		err = fat_preallocate(inode, offset + 1);
+	if (offset == curr_size && offset >= old_alloc) {
+		int nr_cluster = (offset + length - old_alloc +
+				  sbi->cluster_size - 1) >> sbi->cluster_bits;
+
+		err = fat_add_clusters(inode, nr_cluster, true);
 		if (err)
 			goto err_truncate;
 	}
-- 
2.43.0

