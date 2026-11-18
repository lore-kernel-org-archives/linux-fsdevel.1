Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967342;
	b=TFWZvRiMWvK5jwXVlGBhaNxIsp56KTB+j6f33Xq2fp2ijCBVRYJKwFE5hj5PwWB5Ggv+
	 pTwZezWii4hvlXnPlcsffxcu1xnv06F4MUTjAHJvlrCnxLXv16fhv8EvEB+cKMKpvrFCY
	 PUdr5pDK/6k36es5/1H79pqECoHkZ7rVZct8upewKQVLTVtPux7ORSzsiOFul3G4jkhN4
	 E0owBpbv6SPfwdbxdlPfML9lfGVid1hSesOqT4DN8zToP9GITvPa4U7JPUfnYo2p+vv77
	 2CZMfauiE2vE8vf3D3s2WmO9H9FP1J+ZjmLMnPv0/7jJcCsyAX6fsFLWVky/5MTdtvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967342;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uDrhGKdf9IAjbUgKwbDPsIAWyEYQ2WHcboRXI84KuUg=;
	b=NqbfX6uaz/oBjIxGTrL3rOP3vCbgkdT8Aun1aHn1kHtN0OfEiwtEqBKw+5jhi+HCdFvM
	 sTf7BYBUfkv20h5VXbLcAU365klM5sAvCFnJcxRkwebTQ/mE0W+hLnVsInKsmQA04yykg
	 iRkTmUSsQSNZ1g1S0RVbwYlRpNvjAHOvZYtOOdPmZ2m+yknJYVi/uH8H4IfBPNUFpGtxx
	 EeYIhOOXWOjDh/DFRS8baewAs4mRU+E2BDuI30n3J1JBB77ZgEu2m2Ovg8bH7RqC0KGgl
	 M3TLSoD2wfudNVU74MGO6JuDsG/VBRCLvCSg67sgwgBpzynXIJm9dnc1oSgeY1SbNtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=SYwgZA6N;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C80606A334;
	Wed, 18 Nov 2026 02:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C80606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=SYwgZA6N
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 0F9211210E5;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDrhGKdf9IAjbUgKwbDPsIAWyEYQ2WHcboRXI84KuUg=;
	b=SYwgZA6Nv+/tdjEo8zmVXo86qQqMfsZg9yUAg7KL+TzDPM1nzUg6dDnZqMSq92j+ZD2uHP
	rYx5vnFbXNcPBrFKrVGt0pgnivEPmf4NcwLU8FRaPRsmihAxKSZvRWhQy+opVWZ3FPIWCx
	TM3SF9ipVH0WGW8SRZMQHXspvAmOl8fAMwESvKShiJKFoUet3YHomhEe95ZpdPVC2ZPRw+
	Q/dObKJIleRE4A2A/kIpZLMv6xBqixcmR8sn5DMw67jRBwq13d8xOqx/tea63WbEEMB0D3
	fdQv+zlTGfexe2shUetc3kcpjHZRTO5g8xRnKwNPUxTzJZ3w0OWDyga4xr4aRA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/8] fat: support FIEMAP
Date: Tue, 17 Nov 2026 23:01:41 -0300
Message-ID: <20261118020150.1023865-2-matheus.aalmeida@inf.ufrgs.br>
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

Implement support for ->fiemap() using iomap_fiemap(). Add a read-only
fat_iomap_begin() and a fat_get_cont_clusters() helper for finding
contiguous clusters.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/Kconfig  |  1 +
 fs/fat/Makefile |  2 +-
 fs/fat/cache.c  | 85 +++++++++++++++++++++++++++++++++++++++++--------
 fs/fat/fat.h    |  5 +++
 fs/fat/file.c   | 12 +++++++
 fs/fat/iomap.c  | 73 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 163 insertions(+), 15 deletions(-)
 create mode 100644 fs/fat/iomap.c

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 25fae1c83..d31d7866c 100644
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
index 2b0341126..238668f03 100644
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
index 1b87354e2..18a0bb500 100644
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
@@ -130,9 +130,6 @@ static void fat_cache_add(struct inode *inode, struct fat_cache_id *new)
 {
 	struct fat_cache *cache, *tmp;
 
-	if (new->fcluster == -1) /* dummy cache */
-		return;
-
 	spin_lock(&MSDOS_I(inode)->cache_lru_lock);
 	if (new->id != FAT_CACHE_VALID &&
 	    new->id != MSDOS_I(inode)->cache_valid_id)
@@ -217,14 +214,32 @@ static inline void cache_init(struct fat_cache_id *cid, int fclus, int dclus)
 	cid->nr_contig = 0;
 }
 
-int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
+static int fat_cache_contig_end(struct inode *inode, int fclus, int dclus,
+				int end)
+{
+	struct fat_cache *p;
+
+	spin_lock(&MSDOS_I(inode)->cache_lru_lock);
+	list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
+		if (p->fcluster > fclus && p->fcluster <= end &&
+		    p->dcluster - p->fcluster != dclus - fclus)
+			end = p->fcluster - 1;
+	}
+	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
+
+	return end;
+}
+
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
 
@@ -236,16 +251,11 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 			__func__, MSDOS_I(inode)->i_pos, *dclus);
 		return -EIO;
 	}
-	if (cluster == 0)
+	if (last == 0)
 		return 0;
 
-	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
-		/*
-		 * dummy, always not contiguous
-		 * This is reinitialized by cache_init(), later.
-		 */
-		cache_init(&cid, -1, -1);
-	}
+	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0)
+		cache_init(&cid, 0, *dclus);
 
 	fatent_init(&fatent);
 	while (*fclus < cluster) {
@@ -276,6 +286,29 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 		if (!cache_contiguous(&cid, *dclus))
 			cache_init(&cid, *fclus, *dclus);
 	}
+
+	if (nr_cont) {
+		fcluster = min(last, cid.fcluster + cid.nr_contig);
+		if (fcluster < last)
+			last = fat_cache_contig_end(inode, cluster, *dclus, last);
+		dcluster = *dclus + fcluster - cluster;
+		while (fcluster < last) {
+			nr = fat_ent_read(inode, &fatent, dcluster);
+			if (nr < 0)
+				goto out;
+			if (nr != dcluster + 1) {
+				if (nr != FAT_ENT_EOF && nr != FAT_ENT_FREE) {
+					fat_cache_add(inode, &cid);
+					cache_init(&cid, fcluster + 1, nr);
+				}
+				break;
+			}
+			fcluster++;
+			dcluster++;
+			cid.nr_contig++;
+		}
+		*nr_cont = fcluster - cluster + 1;
+	}
 	nr = 0;
 	fat_cache_add(inode, &cid);
 out:
@@ -283,6 +316,30 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
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
 static int fat_bmap_cluster(struct inode *inode, int cluster)
 {
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 07ab49490..a21fbca12 100644
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
@@ -489,6 +491,9 @@ void fat_cache_destroy(void);
 extern const struct export_operations fat_export_ops;
 extern const struct export_operations fat_export_ops_nostale;
 
+/* fat/iomap.c */
+DECLARE_IOMAP_ITER_NEXT(fat_iomap_next);
+
 /* helper for printk */
 typedef unsigned long long	llu;
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 70583e791..7712cfa2b 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -637,9 +637,21 @@ int fat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(fat_setattr);
 
+static int fat_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 len)
+{
+	int err;
+
+	inode_lock_shared(inode);
+	err = iomap_fiemap(inode, fieinfo, start, len, fat_iomap_next);
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
index 000000000..4073dc996
--- /dev/null
+++ b/fs/fat/iomap.c
@@ -0,0 +1,73 @@
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
+	start_cluster = offset >> sbi->cluster_bits;
+	aligned_offset = (u64)start_cluster << sbi->cluster_bits;
+
+	/*
+	 * Return IOMAP_HOLE if we are beyond any kind of disk allocation, or
+	 * past EOF unless writing or reporting.
+	 */
+	if (inode_get_bytes(inode) <= offset ||
+	    (curr_size <= aligned_offset &&
+	     !(flags & (IOMAP_WRITE | IOMAP_REPORT)))) {
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
+DEFINE_IOMAP_ITER_NEXT(fat_iomap_next, fat_iomap_begin);
-- 
2.43.0

