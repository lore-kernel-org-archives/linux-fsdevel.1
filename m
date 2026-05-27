Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953F30DD2A;
	Wed, 27 May 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871810; cv=none; b=UD2FR15lZ5/gRlygVxnvZ6E0xuTGkr+4LAwsUnIFo9WKAC7ixAaqq2SMuThmIpRzu0hVEHbNutfjgYhND8LV6EoYZie2+nMTuZaIl4KWhkIwYf5vIfiCTdlUH28kafQQP7A5GyEay38q0PoAmq1kH1I+P+/2WGegNK3yDWcGMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871810; c=relaxed/simple;
	bh=JELhhMH2jlVCZ5nrhJmF5el6YyGR7YMkHZ18xVC3fBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m5hspt20idbLp4TJ7U1EPIOCB/W4ZTQbfI4o6eht9B+5d+9cxu6hUSD2STCmZkSLiAYfAD26OQsXxLb1eaQ67SLTXfZBwfjMdJ0DTZtHz9AOQqAk32ny7ZjV8bV6bmQBCLgijO8EU2c1fyZusl8YkZQpifwL02sOmSbIKhLQHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=alty5Gk0; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="alty5Gk0"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 467D0C4;
	Wed, 27 May 2026 08:50:09 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=alty5Gk0;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A70D32159;
	Wed, 27 May 2026 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779871806;
	bh=1SbsYGiZVggmXBdSEJ85KsIURe1tYY/RgS73PHZJhlI=;
	h=From:To:CC:Subject:Date;
	b=alty5Gk0n90p9FWwSxggcK+RaLfWKomNQicaCDESDFl7ByyeuD/7UW6Q2yo6eNIrM
	 NZiHm63rU0BmUp6qIGxZs/nm1Fh8KN+o3ZuG29JhPb98cnN8DL6e4gflrpQipV8c1V
	 Ep8zbmvRRuFNRu4tL1P2zfHtJWbzAKQO4EIRiHn0=
Received: from localhost.localdomain (172.30.20.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 27 May 2026 11:50:05 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: format code, deal with comments
Date: Wed, 27 May 2026 10:49:58 +0200
Message-ID: <20260527084958.7959-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

format code according to .clang-format, add useful comments and remove
non-useful comments.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  |  2 +-
 fs/ntfs3/frecord.c |  4 ++--
 fs/ntfs3/fsntfs.c  |  1 -
 fs/ntfs3/index.c   | 32 ++++++++++++++++++--------------
 fs/ntfs3/inode.c   |  9 ++-------
 5 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 0caf2f8a8c1e..a85d3ee51091 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1152,7 +1152,7 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
 			struct ATTRIB *attr2;
 
 			attr2 = ni_find_attr(ni, attr_b, &le_b, ATTR_DATA, NULL,
-					       0, &vcn0, &mi);
+					     0, &vcn0, &mi);
 			if (!attr2) {
 				err = -EINVAL;
 				goto out;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 4b5dd3de327b..0d98bc932c24 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1855,8 +1855,8 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 static struct folio *ntfs_lock_new_page(struct address_space *mapping,
 					pgoff_t index, gfp_t gfp)
 {
-	struct folio *folio = __filemap_get_folio(mapping, index,
-			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	struct folio *folio = __filemap_get_folio(
+		mapping, index, FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
 
 	if (IS_ERR(folio))
 		return folio;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index d0434756029b..bc7469d0a34d 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2654,7 +2654,6 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 	struct ATTRIB *attr;
 	u32 uni_bytes;
 	struct ntfs_inode *ni = sbi->volume.ni;
-	/* Allocate PATH_MAX bytes. */
 	struct cpu_str *uni = kmalloc(PATH_MAX, GFP_KERNEL);
 
 	if (!uni)
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 85f674e9e361..7d6bb14893e9 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1623,7 +1623,8 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 				 const struct NTFS_DE *new_de,
 				 struct NTFS_DE *root_de, const void *ctx,
-				 struct ntfs_fnd *fnd, bool undo, NTFS_CMP_FUNC cmp)
+				 struct ntfs_fnd *fnd, bool undo,
+				 NTFS_CMP_FUNC cmp)
 {
 	int err = 0;
 	struct NTFS_DE *e, *e0, *re;
@@ -1848,13 +1849,15 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
  * Attempt to insert an entry into an Index Allocation Buffer.
  * If necessary, it will split the buffer.
  */
-static int
-indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
-			struct INDEX_ROOT *root, const struct NTFS_DE *new_de,
-			const void *ctx, int level, struct ntfs_fnd *fnd, NTFS_CMP_FUNC cmp)
+static int indx_insert_into_buffer(struct ntfs_index *indx,
+				   struct ntfs_inode *ni,
+				   struct INDEX_ROOT *root,
+				   const struct NTFS_DE *new_de,
+				   const void *ctx, int level,
+				   struct ntfs_fnd *fnd, NTFS_CMP_FUNC cmp)
 {
 	int err;
-	const struct NTFS_DE *sp;
+	const struct NTFS_DE *sp; /* split_point */
 	struct NTFS_DE *e, *de_t, *up_e;
 	struct indx_node *n2;
 	struct indx_node *n1 = fnd->nodes[level];
@@ -1880,10 +1883,9 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	 * No space to insert into buffer. Split it.
 	 * To split we:
 	 *  - Save split point ('cause index buffers will be changed)
-	 * - Allocate NewBuffer and copy all entries <= sp into new buffer
-	 * - Remove all entries (sp including) from TargetBuffer
-	 * - Insert NewEntry into left or right buffer (depending on sp <=>
-	 *     NewEntry)
+	 * - Allocate new buffer (up_e) and copy all entries <= sp into new buffer
+	 * - Remove all entries (sp including) from hdr1
+	 * - Insert new_de into left or right buffer (depending on sp <=> new_de)
 	 * - Insert sp into parent buffer (or root)
 	 * - Make sp a parent for new buffer
 	 */
@@ -1897,6 +1899,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return -ENOMEM;
 	memcpy(up_e, sp, sp_size);
 
+	/* Make a copy for undo. */
 	used1 = le32_to_cpu(hdr1->used);
 
 	/*
@@ -1960,8 +1963,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	 */
 	hdr_insert_de(indx,
 		      (*cmp)(new_de + 1, le16_to_cpu(new_de->key_size),
-				   up_e + 1, le16_to_cpu(up_e->key_size),
-				   ctx) < 0 ?
+			     up_e + 1, le16_to_cpu(up_e->key_size), ctx) < 0 ?
 			      hdr2 :
 			      hdr1,
 		      new_de, NULL, ctx, cmp);
@@ -1978,11 +1980,13 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	 * insert the promoted entry into the parent.
 	 */
 	if (!level) {
-		/* Insert in root. */
-		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0, cmp);
+		/* Insert split_point in root. */
+		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0,
+					    cmp);
 	} else {
 		/*
 		 * The target buffer's parent is another index buffer.
+		 * Insert split_point in parent index ( call itself recursively )
 		 * TODO: Remove recursion.
 		 */
 		err = indx_insert_into_buffer(indx, ni, root, up_e, ctx,
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 2d3aad60caa4..7423e8c89738 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -592,7 +592,6 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 		u32 f_size = folio_size(folio);
 		loff_t f_pos = folio_pos(folio);
 
-
 		if (valid < f_pos + f_size) {
 			u32 z_from = valid <= f_pos ?
 					     0 :
@@ -765,7 +764,7 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		clen_max = bytes_to_cluster(sbi, endbyte) - vcn;
 	}
 
-	/* 
+	/*
 	 * Force to allocate clusters if directIO(write) or writeback_range.
 	 * NOTE: attr_data_get_block allocates clusters only for sparse file.
 	 * Normal file allocates clusters in attr_set_size.
@@ -830,7 +829,6 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = IOMAP_DELALLOC;
 		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
-
 		/* Translate clusters into bytes. */
 		iomap->addr = ((loff_t)lcn << cluster_bits) + off;
 		if (length && iomap->length > length)
@@ -987,7 +985,6 @@ static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
 	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
 }
 
-
 static const struct iomap_writeback_ops ntfs_writeback_ops = {
 	.writeback_range = ntfs_writeback_range,
 	.writeback_submit = iomap_ioend_writeback_submit,
@@ -1000,7 +997,7 @@ static int ntfs_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	struct iomap_writepage_ctx wpc = {
-		.inode = mapping->host,
+		.inode = inode,
 		.wbc = wbc,
 		.ops = &ntfs_writeback_ops,
 	};
@@ -1280,7 +1277,6 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	if (!(mode & 0222))
 		fa |= FILE_ATTRIBUTE_READONLY;
 
-	/* Allocate PATH_MAX bytes. */
 	new_de = kzalloc(PATH_MAX, GFP_KERNEL);
 	if (!new_de) {
 		err = -ENOMEM;
@@ -1719,7 +1715,6 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
 	struct NTFS_DE *de;
 
-	/* Allocate PATH_MAX bytes. */
 	de = kzalloc(PATH_MAX, GFP_KERNEL);
 	if (!de)
 		return -ENOMEM;
-- 
2.43.0

