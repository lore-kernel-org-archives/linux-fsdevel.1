Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F245650E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094126; cv=none; b=OsItg0r/MME4dCM6TPtVh16hItrlC3p4T1Yi8xUHEnXM3JkcUg/ljApkBb7rSePA2na6pEyy7H81Lj4ajyuUcn/POpmBmQKEpe0hO3gYvplUcPoeV9rGqYCG7M2uGleXka4BR56HVRFs4NTU99yAHEYIJIiDV8bGJq7CVCk/Dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094126; c=relaxed/simple;
	bh=QPY/m7J0NLKJtwiEhBrXif7X5tOPvx88yF0XqLBp0Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSYV6GduxON1S2UcPlYtgcNKJWkXPkCOhcg8xoeMpAofquJRkfRQwCVEnaVwVDKlZ+4cAWADH0cvqZz9hMuSjz7XFv12rG8BUxaEdQwhj2KKxl89qSEeKAC6fEzJxbo6ksVpt+SWOTlBgEOLcAIfw+UUvbmX981sPytoWd2nUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl8fseOq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl8fseOq"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso80301a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790094123; x=1790698923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zntf4umr1eS7Ny1yGhjgKRrHwdgFRxoOc6Ks5T0x52k=;
        b=Jl8fseOqKW/4NK9TTf5xbqHfR3/dAlP88GKQ/R90HsIyZk1P3mlDoqiamR9tASMXqR
         +0SJOxMbIhr9h1ttIP6IOS1jZM2OLH84aG/or/uoet6C8bbKyzZoPWXhnq30P+G3Jzd6
         G+xtEiQY6Jrbd6pniaFqrh7XrwUY+K1YAYsAmDhQhJUa555dZIwqmk6Mwqra4zGEtf3m
         PwdthRZpZJK6VdkM1Trh7O6CPNj8N4N9m04NHqlYpkfdBZN9ByPGBeDMgXbIUN2FoP78
         jAk5hqirknaGodGf4fCcI1rLzXmog5/MzonoMIYaC/AtmZAn6BUlCrMAdT0zLl4i5spL
         5KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094123; x=1790698923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zntf4umr1eS7Ny1yGhjgKRrHwdgFRxoOc6Ks5T0x52k=;
        b=Kk4pZfDjTkM04EYu5YdLsWMAqBd5jrUu7vdRQzQfCi9EuuZVMaRr7I27cgpN+jXZHb
         8cv8ybp5zg3NVKlrJPZwwarfHdLs65Jpt11xCq18ao6nERy2rVqAlT1vASjn+KOsBA0y
         +DRuIRSBl1psUK1n4BbAz18zZ3ni+HDx9InyH8Ny93jC6qZ1YOjE8AAmm7Ha6yqe6cig
         tuGOKPIqW9PTjFMuX+1CjxPJ/wLxF8YD9QkypSoaIo3G/3QOUhWKqlDFrDHPev4ENVW4
         ztmMLKCecgslvyfeQ3y8Tc/o0Qc5fI3vMM6PHGDxGil3zQKyKhs+9Y9kiwzaL8EXHOz5
         TfKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH0H88bhdxKYoxm/1PyJcNjor2LxAlYFJpQ6bHC3CK0IPW93jalUqaEJEPkHf1vEEM5sjnul4BJBWMNsdb@vger.kernel.org
X-Gm-Message-State: AFuF++kN0PbiCR7eSGKCoEzEsTFODO/JKnwGOxtjRNtHECgBwhqK9x0v
	S9D4qrGJ4BMu3YhasgybgJ+qqstFzzvWaUVH74TfktuNWNXnRlzx/Ls6OVVV8Q==
X-Gm-Gg: AYBFou1H3vZmin124X0c+nV8aqOfKhHhXldXTqXgP9x6pvovj6IDyYMOTqqjNwcoXm4
	GZawDdu2JU0SCSau+QXsIihHV/YujULrLg34pk8Tx0aJuMbxdiqy+1WVW7s+LMYC+StJKeiIO+z
	ddn4Zra8Tk5KvpIjKqXxWesOfyLAsh7w/2nwf1IzJQQKkmztLD+w1m7fz3FyWaXsB/xNSRkxfkb
	IG4XqNoxrCe0dUxoGgS3F+ka2XfNYr+oqj2M9cfaEZAStRjzWLia3A6VIOrwe+aTeIju6kAqWxo
	+cdAF3cjWyzXgeayoYL24gty1rvOorcgzE4fML44Ecr42bA4mnxX8njfoOGDbhKVpR532ql8QWQ
	PDtWKwF+Sy+3Hl72mVf2aCvIe4qAC0hKVRCLmyh/Y0Nhd/LibFgLv0Q5n/WbQyjlcPFw439vW4/
	MjxsZn1OGlFQOdiysbwBiZoJUNFQJ5/TJJaWmnFePHKyTCTRBE355RMYtP1bVcZNb8Ekhy0v3ls
	uEmOf2LGN4b5E0J
X-Received: by 2002:a17:90b:4b44:b0:39e:14db:437c with SMTP id 98e67ed59e1d1-3a07e4f35e3mr2213a91.4.1790094123309;
        Tue, 22 Sep 2026 09:22:03 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:b024:bd81:d1dd:b7df])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddae723sm128296a91.5.2026.09.22.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:22:02 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Claude Sonnet 5 <noreply@anthropic.com>
Subject: [PATCH v7] hfsplus: fix recursive tree_lock and validate b-tree fork extents
Date: Tue, 22 Sep 2026 23:21:57 +0700
Message-ID: <20260922162157.31987-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a self-deadlock in the extents-overflow B-tree and validate b-tree
fork extents at mount time to catch on-disk corruption early.

hfs_bmap_reserve() can call hfsplus_file_extend() on tree->inode while
tree->tree_lock is already held. When the tree is the extents overflow
B-tree itself and its fork already claims more blocks than its eight
direct extents describe, hfsplus_file_extend() calls
hfsplus_ext_read_extent() -> hfs_find_init() on that same tree, taking
tree_lock a second time. Per the HFS+ format the extents overflow file
can never have overflow extents of its own, so this state only arises
from a corrupted image; refuse to grow the file in that case instead
of re-entering the lock.

Separately, validate each system b-tree's fork (extents, total_blocks,
total_size, clump_size) once at mount time in hfs_btree_open(), and
mount read-only if a fork is corrupt but still usable, or fail the
mount if the first extent itself is corrupt.

Thanks to Viacheslav Dubeyko for the thorough v6 review that caught
the missing lock fix and the other issues below.

v7:
 - Restore the tree_lock fix that was mistakenly dropped in v6 (I
   rebased off the wrong base and lost it; sorry for the noise).
 - Move HFSPLUS_EXTENT_LAST_IDX into hfsplus_fs.h.
 - Move fork validation out of hfsplus_inode_read_fork() and into
   hfs_btree_open(), where the error is actually checked and acted on.
 - Only set SB_RDONLY from hfsplus_fill_super()/hfsplus_reconfigure(),
   never from the fork checker itself.
 - Also validate total_size against the fork's block count, and
   reject a clump_size larger than the volume.

Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
---
 fs/hfsplus/btree.c      |  21 +++++++
 fs/hfsplus/extents.c    | 122 ++++++++++++++++++++++++++++++++++++++--
 fs/hfsplus/hfsplus_fs.h |  10 ++++
 fs/hfsplus/super.c      |  13 +++++
 4 files changed, 160 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd5658e1..a07ca8a477f7 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -274,6 +274,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	struct inode *inode;
 	struct page *page;
 	unsigned int size;
+	int res;
 
 	tree = kzalloc_obj(*tree);
 	if (!tree)
@@ -293,6 +294,26 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		goto free_inode;
 	}
 
+	res = hfsplus_check_fork(sb, HFSPLUS_I(tree->inode)->first_extents,
+				 HFSPLUS_I(tree->inode)->alloc_blocks,
+				 tree->inode->i_size);
+	if (res == -EIO) {
+		pr_err("%s (cnid 0x%x) fork's first extent is corrupt\n",
+		       hfs_btree_name(id), id);
+		goto free_inode;
+	} else if (res) {
+		pr_warn("%s (cnid 0x%x) fork has corrupt extents, forcing read-only.\n",
+			hfs_btree_name(id), id);
+		set_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I(tree->inode)->flags);
+	} else if (HFSPLUS_I(tree->inode)->clump_blocks > HFSPLUS_SB(sb)->total_blocks) {
+		/* clump_size is only ever a growth hint, but a value this
+		 * large can only come from a corrupt fork
+		 */
+		pr_warn("%s (cnid 0x%x) fork has bogus clump size, forcing read-only.\n",
+			hfs_btree_name(id), id);
+		set_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I(tree->inode)->flags);
+	}
+
 	mapping = tree->inode->i_mapping;
 	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d18..925bbc3b36dc 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -77,13 +77,68 @@ static u32 hfsplus_ext_lastblock(struct hfsplus_extent *ext)
 {
 	int i;
 
-	ext += 7;
-	for (i = 0; i < 7; ext--, i++)
+	ext += HFSPLUS_EXTENT_LAST_IDX;
+	for (i = 0; i < HFSPLUS_EXTENT_LAST_IDX; ext--, i++)
 		if (ext->block_count)
 			break;
 	return be32_to_cpu(ext->start_block) + be32_to_cpu(ext->block_count);
 }
 
+/* True for the extents overflow file's own inode */
+static inline bool is_extents_btree(struct inode *inode)
+{
+	return inode->i_ino == HFSPLUS_EXT_CNID;
+}
+
+static bool hfsplus_extent_valid(struct hfsplus_extent *ext, u32 volume_blocks)
+{
+	u32 start = be32_to_cpu(ext->start_block);
+	u32 count = be32_to_cpu(ext->block_count);
+
+	if (!count)
+		return start == 0;
+
+	return start + count > start && start + count <= volume_blocks;
+}
+
+/* 0 if the fork is consistent, -EUCLEAN if fixable, -EIO if unusable */
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext,
+		       u32 fork_blocks, u64 fork_size)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	bool seen_hole = false;
+	u32 used_blocks = 0;
+	loff_t max_size, min_size;
+	int i;
+
+	for (i = 0; i < HFSPLUS_EXTENT_COUNT; i++, ext++) {
+		u32 count = be32_to_cpu(ext->block_count);
+
+		if (!hfsplus_extent_valid(ext, sbi->total_blocks) ||
+		    (seen_hole && count))
+			return i ? -EUCLEAN : -EIO;
+
+		if (count)
+			used_blocks += count;
+		else
+			seen_hole = true;
+	}
+
+	if (!used_blocks)
+		return -EIO;
+
+	if (used_blocks != fork_blocks)
+		return -EUCLEAN;
+
+	/* fork_size must need exactly fork_blocks allocation blocks */
+	max_size = (loff_t)fork_blocks << sbi->alloc_blksz_shift;
+	min_size = max_size - (1 << sbi->alloc_blksz_shift);
+	if (fork_size <= min_size || fork_size > max_size)
+		return -EUCLEAN;
+
+	return 0;
+}
+
 static int __hfsplus_ext_write_extent(struct inode *inode,
 		struct hfs_find_data *fd)
 {
@@ -217,6 +272,10 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 	    block < hip->cached_start + hip->cached_blocks)
 		return 0;
 
+	/* The extents overflow file can't have overflow extents of its own */
+	if (is_extents_btree(inode))
+		return -ENOSPC;
+
 	res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);
 	if (!res) {
 		res = __hfsplus_ext_cache_extent(&fd, inode, block);
@@ -392,6 +451,35 @@ static int hfsplus_free_extents(struct super_block *sb,
 	}
 }
 
+/* True when all extents of a fork are in use (no free slot left) */
+static bool hfsplus_ext_fork_full(struct hfsplus_extent *ext)
+{
+	int i;
+
+	for (i = 0; i < HFSPLUS_EXTENT_COUNT; ext++, i++)
+		if (!ext->block_count)
+			return false;
+	return true;
+}
+
+/* True when the extents overflow file's fork has no free slot left */
+static bool hfsplus_ext_file_needs_contig_grow(struct inode *inode,
+					       struct hfsplus_inode_info *hip)
+{
+	return is_extents_btree(inode) &&
+	       hip->alloc_blocks == hip->first_blocks &&
+	       hfsplus_ext_fork_full(hip->first_extents);
+}
+
+/*
+ * Fork is full: only a contiguous extension of the last extent works.
+ * Search for up to *len free blocks starting exactly at goal.
+ */
+static u32 hfsplus_ext_file_grow(struct super_block *sb, u32 goal, u32 *len)
+{
+	return hfsplus_block_allocate(sb, goal + *len, goal, len);
+}
+
 int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		struct hfsplus_fork_raw *fork, int type)
 {
@@ -458,6 +546,11 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
+		/* Would re-enter ext_tree->tree_lock; corrupt fork */
+		if (is_extents_btree(inode)) {
+			res = -EIO;
+			goto out;
+		}
 		res = hfsplus_ext_read_extent(inode, hip->alloc_blocks);
 		if (res)
 			goto out;
@@ -465,13 +558,21 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	}
 
 	len = hip->clump_blocks;
-	start = hfsplus_block_allocate(sb, sbi->total_blocks, goal, &len);
-	if (start >= sbi->total_blocks) {
-		start = hfsplus_block_allocate(sb, goal, 0, &len);
-		if (start >= goal) {
+	if (hfsplus_ext_file_needs_contig_grow(inode, hip)) {
+		start = hfsplus_ext_file_grow(sb, goal, &len);
+		if (start != goal) {
 			res = -ENOSPC;
 			goto out;
 		}
+	} else {
+		start = hfsplus_block_allocate(sb, sbi->total_blocks, goal, &len);
+		if (start >= sbi->total_blocks) {
+			start = hfsplus_block_allocate(sb, goal, 0, &len);
+			if (start >= goal) {
+				res = -ENOSPC;
+				goto out;
+			}
+		}
 	}
 
 	if (zeroout) {
@@ -526,6 +627,15 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	return res;
 
 insert_extent:
+	/* Can't happen: the fork-full branch above rules this out */
+	if (WARN_ON_ONCE(is_extents_btree(inode))) {
+		if (hfsplus_block_free(sb, start, len))
+			pr_err("can't free extent: start %u, count %u\n",
+			       start, len);
+		res = -ENOSPC;
+		goto out;
+	}
+
 	hfs_dbg("insert new extent\n");
 	res = hfsplus_ext_write_extent_locked(inode);
 	if (res)
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1e5b58e6a13f..df636f2dbf1d 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -222,15 +222,23 @@ struct hfsplus_inode_info {
 #define HFSPLUS_EXT_DIRTY	0x0001
 #define HFSPLUS_EXT_NEW		0x0002
 
+/* Number of extent slots in a fork's hfsplus_extent_rec (hfs_common.h) */
+#define HFSPLUS_EXTENT_COUNT		8
+#define HFSPLUS_EXTENT_LAST_IDX	(HFSPLUS_EXTENT_COUNT - 1)
+
 #define HFSPLUS_I_RSRC		0	/* represents a resource fork */
 #define HFSPLUS_I_CAT_DIRTY	1	/* has changes in the catalog tree */
 #define HFSPLUS_I_EXT_DIRTY	2	/* has changes in the extent tree */
 #define HFSPLUS_I_ALLOC_DIRTY	3	/* has changes in the allocation file */
 #define HFSPLUS_I_ATTR_DIRTY	4	/* has changes in the attributes tree */
+#define HFSPLUS_I_CORRUPT_TREE	5	/* tree's fork had corrupt extents at open time */
 
 #define HFSPLUS_IS_RSRC(inode) \
 	test_bit(HFSPLUS_I_RSRC, &HFSPLUS_I(inode)->flags)
 
+#define HFSPLUS_TREE_IS_CORRUPT(tree) \
+	test_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I((tree)->inode)->flags)
+
 static inline struct hfsplus_inode_info *HFSPLUS_I(struct inode *inode)
 {
 	return container_of(inode, struct hfsplus_inode_info, vfs_inode);
@@ -440,6 +448,8 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		      struct hfsplus_fork_raw *fork, int type);
 int hfsplus_file_extend(struct inode *inode, bool zeroout);
 void hfsplus_file_truncate(struct inode *inode);
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext,
+		       u32 fork_blocks, u64 fork_size);
 
 /* inode.c */
 extern const struct address_space_operations hfsplus_aops;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index ff7d6b3336a6..b6a85c153cf3 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -400,6 +400,14 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			pr_warn("filesystem is marked journaled, leaving read-only.\n");
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
+		} else if (HFSPLUS_TREE_IS_CORRUPT(sbi->ext_tree) ||
+				HFSPLUS_TREE_IS_CORRUPT(sbi->cat_tree) ||
+				(sbi->attr_tree &&
+				 HFSPLUS_TREE_IS_CORRUPT(sbi->attr_tree))) {
+			/* Corruption is only ever detected at mount, in hfs_btree_open() */
+			pr_warn("a b-tree fork was corrupt at mount time, leaving read-only.\n");
+			sb->s_flags |= SB_RDONLY;
+			fc->sb_flags |= SB_RDONLY;
 		}
 	}
 	return 0;
@@ -564,6 +572,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_xattr = hfsplus_xattr_handlers;
 
+	if (HFSPLUS_TREE_IS_CORRUPT(sbi->ext_tree) ||
+	    HFSPLUS_TREE_IS_CORRUPT(sbi->cat_tree) ||
+	    (sbi->attr_tree && HFSPLUS_TREE_IS_CORRUPT(sbi->attr_tree)))
+		sb->s_flags |= SB_RDONLY;
+
 	inode = hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
 	if (IS_ERR(inode)) {
 		pr_err("failed to load allocation file\n");
-- 
2.43.0

