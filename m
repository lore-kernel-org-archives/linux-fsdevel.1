Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967376;
	b=n5zs7bul8ZyPPfgDy3KgAtjhr1izMYNFlg7fQLIhEVoJ3hwRNFRRF4zUHQDhGuwsj2Kf
	 Dx6ZVdio4iXRkOY+zAccOCz7AsDPxhne/xcymmsQBFy1XNeTZLXKzhnqmT9zTjIXHiijl
	 SmSVIwfjIshONRm9TkCK3zRRaEkp6eE8DWpREwgYA9IeBSPctqZ8Y4JIC3q9DxCVPdoDV
	 3sQTecnQn45SG+CzKlUDHjCk5kk+P4pIYeBryUwlJASxEeid7UgxUK9O81VpVFhX1yexO
	 syGtTXe8Va/btF3/8XeL6rBHv787uToSzo6Hce1WvQ+32dmlY4MpLBiMeKn1ZUhgBGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967376;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r2ZwkzBF1RbyvA4zB0tEixqDOdcD7qR8h94bWgj2HyA=;
	b=zgFJIt5DrClpDMkXp7IKD5iNZ0yVdMoIoqT73vefsK1+Xf3bR8Ggt8qPwCpp7S8zlJCe
	 I1xI3uftVnR21KeK6v0KTZ1StfDFi/QI0J2IlphagyzdEIKBkbHGIEmR43VgPcVFcs+R0
	 am8u+SfDxOQvXlYtgXniCn7cR/0Io1OL4purQp1DtLxZQcuNcMczD/svQHvqu94lWY/Fe
	 Zo3Bbk4OgLvkwVB2agzRpIs2bEE+hxilq155S6cyOyNEQvlsm6/4Vn/fYfo0owi6/Sr/M
	 /ce28KaAt+9dO607/8/85MOCqiTzFZrBuq5krb/8TFSLDFadajk2wXJi3SNDT00G2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=OrT7ewHs;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69855606A31C;
	Wed, 18 Nov 2026 02:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69855606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=OrT7ewHs
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 900BA1210F5;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2ZwkzBF1RbyvA4zB0tEixqDOdcD7qR8h94bWgj2HyA=;
	b=OrT7ewHse0EmNQmNvOLoKSx7dBA605ExGZp1lq9LKG0WRouoK3nM2pm7BxJ09h0IEOVp6/
	QCNrqLVonexdsU4nvHa6hp0QUSJAzyFZlortLeF8pQE2mneR2Qhnbh1diFIB6cbz6QIdON
	btpWENNr5Ux8eI8Ak65Fr3sCYdPQ0QYKWRXZfQRSyHTkTBUD41Up70HFc/IVx1E8+Bvfxt
	rMo4KJVIK+rNQF+b3Q2mtIebeX6FBDx3pU/MxkaZVQY1IqIhJaCnK+tf3bR7KMpeJU0Iya
	B4RT8DwxvBd/C2qJXYflBVREqzwEjZGkgmytTySsgje7FSpsyfgpjl4JG5MKQQ==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 8/8] fat: add multi-cluster allocation for write
Date: Tue, 17 Nov 2026 23:01:48 -0300
Message-ID: <20261118020150.1023865-9-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
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
index 00041fa11..b527693de 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -394,7 +394,8 @@ extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
 			 int new, int old, int wait);
 extern int fat_alloc_clusters(struct inode *inode, int *cluster,
 			      int nr_cluster);
-int fat_alloc_chain(struct inode *inode, int *cluster, int nr_cluster);
+int fat_alloc_chain(struct inode *inode, int *cluster, int *nr_cluster,
+		    bool allow_partial);
 extern int fat_free_clusters(struct inode *inode, int cluster);
 extern int fat_count_free_clusters(struct super_block *sb);
 extern int fat_trim_fs(struct inode *inode, struct fstrim_range *range);
@@ -440,7 +441,8 @@ static inline unsigned long fat_dir_hash(int logstart)
 {
 	return hash_32(logstart, FAT_HASH_BITS);
 }
-extern int fat_add_clusters(struct inode *inode, int nr_cluster);
+
+int fat_add_clusters(struct inode *inode, int nr_cluster, bool allow_partial);
 
 /* fat/misc.c */
 extern __printf(3, 4) __cold
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index cdbc15465..9578b1ae9 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -552,8 +552,8 @@ static void fat_clean_bdev_aliases(struct super_block *sb,
 			   (sector_t)count * sbi->sec_per_clus);
 }
 
-static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
-				bool return_all)
+static int __fat_alloc_clusters(struct inode *inode, int *cluster, int *nr_cluster,
+				bool return_all, bool allow_partial)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -561,12 +561,18 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
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
@@ -620,7 +626,7 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 				}
 				fat_collect_bhs(bhs, &nr_bhs, &fatent);
 
-				if (idx_clus == nr_cluster)
+				if (idx_clus == nr_alloc)
 					goto out;
 
 				/*
@@ -641,7 +647,8 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 	/* Couldn't allocate the free entries */
 	sbi->free_clusters = 0;
 	sbi->free_clus_valid = 1;
-	err = -ENOSPC;
+	if (!allow_partial || !idx_clus)
+		err = -ENOSPC;
 
 out:
 	unlock_fat(sbi);
@@ -661,17 +668,21 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
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
index 90be24bfa..3ba734cae 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -366,7 +366,7 @@ int fat_preallocate(struct inode *inode, loff_t new_size)
 		     sbi->cluster_bits;
 
 	/* Allocate the clusters. We are not zeroing them out */
-	return fat_add_clusters(inode, nr_cluster);
+	return fat_add_clusters(inode, nr_cluster, false);
 }
 
 static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 76755c2b4..49de04fa1 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -102,11 +102,11 @@ static struct fat_floppy_defaults {
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
index f73076230..dc34b33dc 100644
--- a/fs/fat/iomap.c
+++ b/fs/fat/iomap.c
@@ -100,6 +100,7 @@ static int fat_iomap_begin_write(struct inode *inode, loff_t offset,
 				 loff_t length, unsigned int flags,
 				 struct iomap *iomap, struct iomap *srcmap)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	loff_t curr_size = i_size_read(inode);
 	loff_t old_alloc = inode_get_bytes(inode);
 	int err;
@@ -108,12 +109,11 @@ static int fat_iomap_begin_write(struct inode *inode, loff_t offset,
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

