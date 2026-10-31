Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465045;
	b=13pzEri0Dcii/i0Jji85mJ+uX8Sy/Agz7pDEvqEdUNlCCRKdiupFRzJbP8VpWe4E3xEj
	 UH7OlFjgfDnBat2x8MuibWoTqA34woNah7/KYFKhfTCDMHX6hRI9KxtjMu/ApdL2XdVPQ
	 ymPZDrnAfeHGMJudQC6Bvpqn+thhBCZGUGasduMDRgygno64Z/SyGU74JWmEdBJoRh8EC
	 WZDpNe4SGFo0a1mYVQGSB6mDQR82Uj6CSv/zok4nTY4yDmD4wSQhLi9NtWQDeOR6upkcZ
	 6o23/2hOMV7UBppezEwR0K+IZftwMk1aLjc8TMtYGnTq2duPfTP31swhTP6dIaPeHYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465045;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n+RZPiuoW04oyBYAE7OWVOfU9RUwVUdxfcD4XxlXfyA=;
	b=ahGTZndQ4Q8vBpFYgd6BiZV3MCRHDC3J0D/oGYbqNcn5BucvA3XPPvt2xPyJcvGqDsbv
	 zuIltJNExKvPJse9RO2eWGaV1WYZAxstf5RZcXunpCe0qmRp2ngrXxw+3DeWd/23tqfek
	 ve3QJV0lMUwlalS4XNQIjavGqEOZKyzzu5cHV0ghf+H7hX/1TMTS3gt1YTOuCoj+VylUs
	 Cbg7jnoDKUiQ3PfhqAbGeu0ySN4oteeoR9Rvw7AR/JFxqXnXfn9RmogW2+isMIbT+RrfL
	 xNM9xcxBplhefj0hNlb/0D6pHylO0kr3pZCXz+cnalLNbzJ+iuevYWVYPnY+6m7xTjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=iCfh4q7W;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1A606A31F;
	Sat, 31 Oct 2026 16:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED1A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=iCfh4q7W
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 02C98120357;
	Sat, 31 Oct 2026 13:43:49 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+RZPiuoW04oyBYAE7OWVOfU9RUwVUdxfcD4XxlXfyA=;
	b=iCfh4q7WaGJ2psCIgWgDBS/YkUXyjocRI2Hq3+PTvZkMx9pZhF/bN6tsGtaFHFeRKiW92h
	XBwyIiWHby+1yiwd586TZHgPRLWV3xjXjQaB18KM8dIXj4pB1GdSdPeppfcLl1vyjhIIQi
	jkz4cZzm4ftIiJqn/3y4c7XGMp1vIttPwNOHX4xJkwtUcnry0JlEJOBUoU1lAv8YGkxKs7
	C7GkCzGCojpAj644psvh8V0df/ap2RTfR+fJ1KB/JxMy5Wi1vnkKfrBbH8H1g4tB2CoiC1
	CqMTe4G270+ML9gk0bn60apOAV7UN9IL5+n76Uoo6fZEk++g1F+YTx6xvW5I8w==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 1/8] fat: support FIEMAP
Date: Sat, 31 Oct 2026 13:43:19 -0300
Message-ID: <20261031164326.278125-2-matheus.aalmeida@inf.ufrgs.br>
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

Implement support for ->fiemap() using iomap_fiemap(). Add a read-only
fat_iomap_begin() and a fat_get_cont_clusters() helper for finding
contiguous clusters.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/Kconfig  |  1 +
 fs/fat/Makefile |  2 +-
 fs/fat/cache.c  | 80 ++++++++++++++++++++++++++++++++++++++-----------
 fs/fat/fat.h    |  5 ++++
 fs/fat/file.c   | 12 ++++++++
 fs/fat/iomap.c  | 71 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 152 insertions(+), 19 deletions(-)
 create mode 100644 fs/fat/iomap.c

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 25fae1c83725..d31d7866ce19 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -2,6 +2,7 @@
 config FAT_FS
 	tristate
 	select BUFFER_HEAD
+	select FS_IOMAP
 	select NLS
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/fat/Makefile b/fs/fat/Makefile
index 2b034112690d..238668f03744 100644
--- a/fs/fat/Makefile
+++ b/fs/fat/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_FAT_FS) += fat.o
 obj-$(CONFIG_VFAT_FS) += vfat.o
 obj-$(CONFIG_MSDOS_FS) += msdos.o
 
-fat-y := cache.o dir.o fatent.o file.o inode.o misc.o nfs.o
+fat-y := cache.o dir.o fatent.o file.o inode.o misc.o nfs.o iomap.o
 vfat-y := namei_vfat.o
 msdos-y := namei_msdos.o
 
diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 1b87354e24ba..f545e1db1d47 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -76,7 +76,7 @@ static int fat_cache_lookup(struct inode *inode, int fclus,
 			    struct fat_cache_id *cid,
 			    int *cached_fclus, int *cached_dclus)
 {
-	static struct fat_cache nohit = { .fcluster = 0, };
+	static struct fat_cache nohit = { .fcluster = -1, };
 
 	struct fat_cache *hit = &nohit, *p;
 	int offset = -1;
@@ -217,14 +217,16 @@ static inline void cache_init(struct fat_cache_id *cid, int fclus, int dclus)
 	cid->nr_contig = 0;
 }
 
-int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
+static int __fat_get_cluster(struct inode *inode, int cluster, int *fclus,
+			     int *dclus, int *nr_cont)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const int limit = sb->s_maxbytes >> sbi->cluster_bits;
 	struct fat_entry fatent;
 	struct fat_cache_id cid;
-	int nr;
+	int last = nr_cont ? cluster + *nr_cont - 1 : cluster;
+	int fcluster, dcluster, nr;
 
 	BUG_ON(MSDOS_I(inode)->i_start == 0);
 
@@ -236,21 +238,27 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 			__func__, MSDOS_I(inode)->i_pos, *dclus);
 		return -EIO;
 	}
-	if (cluster == 0)
+	if (last == 0)
 		return 0;
 
 	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
-		/*
-		 * dummy, always not contiguous
-		 * This is reinitialized by cache_init(), later.
-		 */
-		cache_init(&cid, -1, -1);
+		/* Cache the contiguous prefix from the known first cluster. */
+		cache_init(&cid, 0, *dclus);
 	}
 
+	fcluster = *fclus;
+	dcluster = *dclus;
 	fatent_init(&fatent);
-	while (*fclus < cluster) {
+	while (fcluster < last) {
+		if (nr_cont && fcluster == cluster && cid.fcluster != -1) {
+			fcluster = min(last, cid.fcluster + cid.nr_contig);
+			dcluster = cid.dcluster + fcluster - cid.fcluster;
+			if (fcluster == last)
+				break;
+		}
+
 		/* prevent the infinite loop of cluster chain */
-		if (*fclus > limit) {
+		if (fcluster > limit) {
 			fat_fs_error_ratelimit(sb,
 				"%s: detected the cluster chain loop (i_pos %lld)",
 				__func__, MSDOS_I(inode)->i_pos);
@@ -258,31 +266,67 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 			goto out;
 		}
 
-		nr = fat_ent_read(inode, &fatent, *dclus);
+		nr = fat_ent_read(inode, &fatent, dcluster);
 		if (nr < 0)
 			goto out;
+		else if (nr == FAT_ENT_EOF)
+			goto cache_add;
 		else if (nr == FAT_ENT_FREE) {
 			fat_fs_error_ratelimit(sb,
 				"%s: invalid cluster chain (i_pos %lld)",
 				__func__, MSDOS_I(inode)->i_pos);
 			nr = -EIO;
 			goto out;
-		} else if (nr == FAT_ENT_EOF) {
+		}
+		if (nr_cont && fcluster >= cluster && nr != dcluster + 1) {
 			fat_cache_add(inode, &cid);
-			goto out;
+			cache_init(&cid, fcluster + 1, nr);
+			break;
+		}
+		fcluster++;
+		dcluster = nr;
+		if (!cache_contiguous(&cid, dcluster))
+			cache_init(&cid, fcluster, dcluster);
+		if (fcluster <= cluster) {
+			*fclus = fcluster;
+			*dclus = dcluster;
 		}
-		(*fclus)++;
-		*dclus = nr;
-		if (!cache_contiguous(&cid, *dclus))
-			cache_init(&cid, *fclus, *dclus);
 	}
 	nr = 0;
+	if (nr_cont)
+		*nr_cont = fcluster - cluster + 1;
+cache_add:
 	fat_cache_add(inode, &cid);
 out:
 	fatent_brelse(&fatent);
 	return nr;
 }
 
+int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
+{
+	return __fat_get_cluster(inode, cluster, fclus, dclus, NULL);
+}
+
+int fat_get_cont_clusters(struct inode *inode, int cluster, int *nr)
+{
+	int ret, fclus, dclus;
+
+	if (!MSDOS_I(inode)->i_start)
+		return -EIO;
+
+	ret = __fat_get_cluster(inode, cluster, &fclus, &dclus, nr);
+	if (ret < 0)
+		return ret;
+	if (ret == FAT_ENT_EOF) {
+		fat_fs_error(inode->i_sb,
+			     "%s: request beyond EOF (i_pos %lld)",
+			     __func__, MSDOS_I(inode)->i_pos);
+		return -EIO;
+	}
+	return dclus;
+}
+
+
 static int fat_bmap_cluster(struct inode *inode, int cluster)
 {
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 204c7b87108f..3d0f91fa11df 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -3,6 +3,7 @@
 #define _FAT_H
 
 #include <linux/buffer_head.h>
+#include <linux/iomap.h>
 #include <linux/nls.h>
 #include <linux/hash.h>
 #include <linux/ratelimit.h>
@@ -321,6 +322,7 @@ static inline void fatwchar_to16(__u8 *dst, const wchar_t *src, size_t len)
 extern void fat_cache_inval_inode(struct inode *inode);
 extern int fat_get_cluster(struct inode *inode, int cluster,
 			   int *fclus, int *dclus);
+int fat_get_cont_clusters(struct inode *inode, int cluster, int *nr);
 extern int fat_get_mapped_cluster(struct inode *inode, sector_t sector,
 				  sector_t last_block,
 				  unsigned long *mapped_blocks, sector_t *bmap);
@@ -488,6 +490,9 @@ void fat_cache_destroy(void);
 extern const struct export_operations fat_export_ops;
 extern const struct export_operations fat_export_ops_nostale;
 
+/* fat/iomap.c */
+extern const struct iomap_ops fat_iomap_ops;
+
 /* helper for printk */
 typedef unsigned long long	llu;
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index adc5554eeab6..531abf9e533c 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -636,9 +636,21 @@ int fat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(fat_setattr);
 
+static int fat_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 len)
+{
+	int err;
+
+	inode_lock_shared(inode);
+	err = iomap_fiemap(inode, fieinfo, start, len, &fat_iomap_ops);
+	inode_unlock_shared(inode);
+	return err;
+}
+
 const struct inode_operations fat_file_inode_operations = {
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
 	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
+	.fiemap		= fat_fiemap,
 };
diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
new file mode 100644
index 000000000000..7fb24d0296f7
--- /dev/null
+++ b/fs/fat/iomap.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FAT iomap support
+ *
+ * Copyright (C) 2026 Matheus Alves de Almeida
+ */
+
+#include "fat.h"
+
+static int __fat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			     unsigned int flags, struct iomap *iomap)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int start_cluster, end_cluster, nr_cluster, ret;
+	loff_t curr_size = i_size_read(inode);
+	loff_t aligned_offset;
+
+	iomap->flags = 0;
+	/* Return IOMAP_HOLE if we are beyond any kind of disk allocation */
+	if (inode_get_bytes(inode) <= offset) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->offset = offset;
+		iomap->length = length;
+		iomap->type = IOMAP_HOLE;
+		return 0;
+	}
+
+	/*
+	 * We need to separate normal data clusters and
+	 * uninitialized FALLOC_FL_KEEP_SIZE clusters.
+	 */
+	start_cluster = offset >> sbi->cluster_bits;
+	aligned_offset = (u64)start_cluster << sbi->cluster_bits;
+	if (curr_size <= aligned_offset) {
+		iomap->type = IOMAP_UNWRITTEN;
+		length = min(offset - aligned_offset + length,
+			     inode_get_bytes(inode) - aligned_offset);
+	} else {
+		iomap->type = IOMAP_MAPPED;
+		length = min(offset - aligned_offset + length,
+			     curr_size - aligned_offset);
+	}
+
+	end_cluster = (aligned_offset + length - 1) >> sbi->cluster_bits;
+	nr_cluster = end_cluster - start_cluster + 1;
+	ret = fat_get_cont_clusters(inode, start_cluster, &nr_cluster);
+	if (ret < 0)
+		return ret;
+
+	iomap->addr = (u64)fat_clus_to_blknr(sbi, ret) << sb->s_blocksize_bits;
+	iomap->offset = aligned_offset;
+	iomap->length = (u64)nr_cluster << sbi->cluster_bits;
+	iomap->flags |= IOMAP_F_MERGED;
+	iomap->bdev = sb->s_bdev;
+
+	return 0;
+}
+
+static int fat_iomap_begin(struct inode *inode, loff_t offset,
+			   loff_t length, unsigned int flags,
+			   struct iomap *iomap, struct iomap *srcmap)
+{
+	return __fat_iomap_begin(inode, offset, length, flags, iomap);
+}
+
+static DEFINE_IOMAP_ITER_NEXT(fat_iomap_next, fat_iomap_begin);
+
+const struct iomap_ops fat_iomap_ops = {
+	.iomap_next = fat_iomap_next
+};
-- 
2.43.0

