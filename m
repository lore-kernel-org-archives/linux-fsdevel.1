Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBE19A2A3
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768329; cv=none; b=Kxfvo+0cpjgGVdJIPYYiR5bz4TdiuMZ+5V8hdFUnkOc6toDSVmHGsPRFxSzZMjSUwdkmKPVgsJFlLMyFWDRrgxrUy0gIPaegnm0ROFFmzDCk7Vl+HaaTnt3V8fuIlYrvviHpkHYTrOZZC4uCbv/pmioizHNWQ7UqY3uyii6Q5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768329; c=relaxed/simple;
	bh=v7sbO8DyNs+joZ7B14ykL2r9xFws9di0WNwBv2bVd8U=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GPMmEUSc2VNfCRzw8H9Al2D/M+e3OnocCacv+Zx5Q+zmycZgdJJN6q6Dh4GoiGb7Z5+YvvEgOVOWFQpKTpsF3G+gefDMwCttndKB+ZEts1qW7IOsnqrAlW2oGc0U2IjnqOH4vlRw0GjoSnJVyixLLZ8yidXdGfJlXc04mVrQ/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w1TKQdn0; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w1TKQdn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774768321; bh=wfxkopMEf8snz7GDylx0uY/ZNTSwEcdRJVxehXkEdKU=;
	h=From:To:Cc:Subject:Date;
	b=w1TKQdn0Qaom410u1Ub6+1eIelobKkXBVmtF9U/4E74j33Fci07GtgE/G3je90gWE
	 ZH5i3iIcBE2LSuNZjQFPMQ//Q8PA2mGi1sIlAmv+w/9cluaqHCFL8g32/5nAlSvmxq
	 xQvk4TVtFTq3ifo4WAdCnUh3WpenIHhvc1lWK/Fw=
Received: from shy-Super-Server.. ([220.168.100.40])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 2FB1885A; Sun, 29 Mar 2026 15:11:59 +0800
X-QQ-mid: xmsmtpt1774768319tmifb0gwf
Message-ID: <tencent_623D72C80E4BD5CC991C29AA31C751E23B05@qq.com>
X-QQ-XMAILINFO: MStTOrhA1CLVKFvdPqSqfGzUo0PLJxE7XKcH7vmknxujNDmRtAmfu6ujCemCPi
	 wIW6roJa+tG+Tpjh5LCZq4UHXDJ7lsOhIrYa9AJQPbISJM9HTprCp+ACh1Fz0n+aDoJ5zRo/JdfG
	 n2uVEmXkqRJC/eghzo4/731gbllJWgeV89J+D5FSsapLk6NIsC40i5ltJyZE3pNdn+44oxQ67lIz
	 HA/fItgXcbxuSS/94bTMRL3PbNsAnCWrav/EDGj0k0bK7TRg3icemTLKdav4vpyFVDbIvvb6xyuB
	 j4R91uIRsh2yPWN8H07Ac2LfIwquQqbKtsfHPWptPjuUPBjUeNKNhvLbIFksUCalGjpELEaQI9xA
	 lBfyKTEzOxxVK7hBvzc4YOUyNZ9E8MDzCJ0Y/LhUMMCXB+2vvvnOg7m4TTknC+VnhpBuarYW8Lul
	 1nfzdiPozkISRhflNeyCXGrcxlb+HRRo6gZAW9YwKd6U6qu8/4ySPtQfWRaf0cS1qtgZGJr8gyXW
	 eMbtHum+Mq9HAp28sXwCP+O2EmWyMDmEc+gBk15uu4eQX0dY/ZRYzyi5777mYG+73zbDPT11fBVw
	 kLls7og77UV/h8vkHvFY9rF6i6d0z32fwfTgGGW48Q2/q9KIHuatXR+oCA9Lx8gWAjuFqwRGQelk
	 igxo7B7ssTIijya3cwaaLjQAd/QpA1f6n5d2syyrd5DrDDpI0eo3V6kcrzbAn75vkHwsp143dgJ8
	 uqC4QpU18rk/Xl9bwKrqVQmZRPeiFBJL5BA+9EbWGhaKdNCsWaZF22GmUmGDSeOHJV5oNGtXg6sU
	 PEuSypKkjOVOSYdVE2Y7zKovBmyT0RTudAZCjbc0pJ/UZixEJuYDaajvGbzWxk5TXOzCg2rW/Iyl
	 Oqg1YP2zE0tTMZDIEOwhw959e6HXcg9v416wyULto4u5KjqHqmn4iJ2RZvyhJ+KDLs35YuN5u0zV
	 TGzEK6NSZsXx2HXggls1VCKWPIB91qiZkszQSHVNEFZd4HnKdurVrr+c7dVHV8oVVHb3fQts6bzY
	 yNqaudnw6O7DT0WDSgQ+pYqh9mWvnb8vs6+UmwXIFzpD1ewhSrwchCznuEdytTWqS+tgt0fKUpke
	 BaN2aupEHLYYJ6hjNMF3a6B9SiIMd/YgoOIwX97kLnDtGT+VZysC9cFL9uXQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Changjian Liu <driz2t@qq.com>
To: 1016331059@qq.com
Cc: liuchangjian@csu.edu.cn,
	Changjian Liu <driz2t@qq.com>,
	Wenzhi Wang <wenzhi.wang@uwaterloo.ca>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6.1.y] hfs: fix general protection fault in hfs_find_init()
Date: Sun, 29 Mar 2026 15:11:55 +0800
X-OQ-MSGID: <20260329071155.1439455-1-driz2t@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 736a0516a16268995f4898eded49bfef077af709 ]

The hfs_find_init() method can trigger a crash if tree pointer is NULL.

hfs_fill_super() calls hfs_mdb_get(), which tries to construct Extents
Tree and Catalog Tree. However, hfs_btree_open() calls read_mapping_page(),
which calls hfs_get_block(), and that in turn calls hfs_ext_read_extent().

The problem is that hfs_find_init() tries to use
HFS_SB(inode->i_sb)->ext_tree before it has been initialized. It will
only be initialized after hfs_btree_open() finishes.

Fix this by checking the tree pointer in hfs_find_init() and reworking
hfs_btree_open() to read the b-tree header directly from the volume.
Replace read_mapping_page() with filemap_grab_folio(), then use sb_bread()
to extract the b-tree header content and copy it into the folio.

Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250710213657.108285-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Changjian Liu <driz2t@qq.com>
---
 fs/hfs/bfind.c  |  3 +++
 fs/hfs/btree.c  | 33 +++++++++++++++++++++++----------
 fs/hfs/extent.c |  2 +-
 fs/hfs/hfs_fs.h |  1 +
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 6d37b4c75903..1b1cbb589f82 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 {
 	void *ptr;
 
+if (!tree || !fd)
+	return -EINVAL;
+
 	fd->tree = tree;
 	fd->bnode = NULL;
 	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2fa4b1f8cc7f..e46e961d40dd 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -21,8 +21,10 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
-	struct page *page;
+struct page *page;
+struct buffer_head *bh;
 	unsigned int size;
+u16 dblock;
 
 	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
 	if (!tree)
@@ -75,12 +77,22 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	unlock_new_inode(tree->inode);
 
 	mapping = tree->inode->i_mapping;
-	page = read_mapping_page(mapping, 0, NULL);
-	if (IS_ERR(page))
+page = read_mapping_page(mapping, 0, NULL);
+if (IS_ERR(page))
 		goto free_inode;
 
+dblock = hfs_ext_find_block(HFS_I(tree->inode)->first_extents, 0);
+bh = sb_bread(sb, HFS_SB(sb)->fs_start + dblock);
+if (!bh) {
+pr_err("unable to read tree header\n");
+goto put_page;
+}
+
+memcpy(kmap_local_page(page), bh->b_data, sb->s_blocksize);
+brelse(bh);
+
 	/* Load the header */
-	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
+head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
 					       sizeof(struct hfs_bnode_desc));
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
@@ -95,22 +107,22 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 
 	size = tree->node_size;
 	if (!is_power_of_2(size))
-		goto fail_page;
+goto fail_page;
 	if (!tree->node_count)
-		goto fail_page;
+goto fail_page;
 	switch (id) {
 	case HFS_EXT_CNID:
 		if (tree->max_key_len != HFS_MAX_EXT_KEYLEN) {
 			pr_err("invalid extent max_key_len %d\n",
 			       tree->max_key_len);
-			goto fail_page;
+goto fail_page;
 		}
 		break;
 	case HFS_CAT_CNID:
 		if (tree->max_key_len != HFS_MAX_CAT_KEYLEN) {
 			pr_err("invalid catalog max_key_len %d\n",
 			       tree->max_key_len);
-			goto fail_page;
+goto fail_page;
 		}
 		break;
 	default:
@@ -121,12 +133,13 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->pages_per_bnode = (tree->node_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	kunmap_local(head);
-	put_page(page);
+put_page(page);
 	return tree;
 
 fail_page:
 	kunmap_local(head);
-	put_page(page);
+put_page(page);
+put_page:
 free_inode:
 	tree->inode->i_mapping->a_ops = &hfs_aops;
 	iput(tree->inode);
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 3f7e9bef9874..070245f8c215 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -71,7 +71,7 @@ int hfs_ext_keycmp(const btree_key *key1, const btree_key *key2)
  *
  * Find a block within an extent record
  */
-static u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off)
+u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off)
 {
 	int i;
 	u16 count;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 68d0305880f7..1353af3169d5 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -190,6 +190,7 @@ extern const struct inode_operations hfs_dir_inode_operations;
 
 /* extent.c */
 extern int hfs_ext_keycmp(const btree_key *, const btree_key *);
+extern u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off);
 extern int hfs_free_fork(struct super_block *, struct hfs_cat_file *, int);
 extern int hfs_ext_write_extent(struct inode *);
 extern int hfs_extend_file(struct inode *);
-- 
2.43.0

