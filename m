Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E94DE737
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646818; cv=none; b=E9lmS5P/CRIv0zGU8QiWanNn+TTUDlIIdZ/qUATuh2OwHF+LT4yoL/hhEcKKkKTDQxfYtsvOlJBLtJ8NlsIRw4t+mM79PBxlhfHg3gbV6d6hdHeD+HDF9cO8Ljt8ob4601KTOKGEaYVtTYEWMhtEi0jcub06U2eSV7IrnaGc4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646818; c=relaxed/simple;
	bh=StBpJWd/VVZadMemPg0N6ly9UjpENDNlvjIjrr7PqdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyiXrbrH+OVJJbAbNr3Kb7Oc/MnQrKJnzarPMa18MggnmqB+jxcK2aQnxtGofOChHHLqK1RRCsoUmQ/gO8Jl1YICQ3i0O1AmTIinEkfVHkQVBjLj4w9ejeOCzMCsZP9AQQ7KAbd5zleFD+PeNDykvuadpJINFGatcB5gaOAzpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJRWd3nE; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJRWd3nE"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so915984b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789646803; x=1790251603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tD8UqmnCVELsxGnBEoprB+Biz+rR68f6UG50cm0VM2g=;
        b=sJRWd3nEeZSuC51B3W3DPFy4zz5KlL7HyX7afGCDHu0OKWtNafKvZdCAQ8Gqqa8Xb8
         T+mYolaaxESdbg+vwEa+xxOXhdkjQQhTPZcIGlp7CwX+FB3Km1WawLbHj/el9P3lTOFh
         UUW6ywKnmvBRq+O1TS39ksWqNugPU3P64KbzVCKOOHELjkQXlad2sf8Y79E9HioJRG+N
         2lt5LLgIUFlPv9ylrMWoptWEh0YFu6UVq/ikhcbtly6HKI4bNy2SgZp+FlHjhnRlGrHl
         OqvvWUj9lePgWd8xjLP+hkGWRclrKlh8V368WAwimdebtztXNehTiEZZGELHomhm0eKy
         Of1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789646803; x=1790251603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tD8UqmnCVELsxGnBEoprB+Biz+rR68f6UG50cm0VM2g=;
        b=DoXrwmJwFqm7zialHsrrUofKKGvXO93XJ7BLqsHkK6gPu+wlr36En8ZaxNBdAs2W/y
         0LThMlK7bq09oxC59TGtw5FG8eYxlWuju5CcnW0uA7H4NKhx42R8ztar4LqmkR/nV53s
         BQCI499iRcOVYB9wJDEADOc377qCmX5x5YrRsNTvLc2Fj8i3GMzdtYS3whkwrS68Y8sn
         oN3x7kbGVK9yJZrPmmP0cxdoOPm8A0b3sbot/26B5Fk8ZMH0xReXpA0sFmrAORMd7spb
         Un9PVMfYOt19NzNJMjJld+8RYcKFoCB8pXdpWKriMpQVdRTX5ifUiCJ1oEswq9CFIRa3
         AeWg==
X-Forwarded-Encrypted: i=1; AKwUvBx0W/uJpenkGJjkuBRItRAMZVlQdWAK0c+nnreeigTO9h4yZ4boEiluvAy/TviAZwdbZA73684XiMrFc6yW@vger.kernel.org
X-Gm-Message-State: AFuF++lIq2E+VHLbks49TNO1QZH0FdnIU2I8CMOCJJive04DqknKNazr
	IB+qwNGmtlOs17eNLv1+IE2dlm8ykppee3+9ejxWh1JtsFZjvazutbh3
X-Gm-Gg: AYBFou2eahLQRlXiDBjtoPQBYTF/UUw4x5rYyvmU584y2GJda1KcHcK7PaJYnXRYvsV
	CS2vHOAsObF63nkRKrtnG8/SNE8lFMo7PURGmjcKzLb1ncuDoGQJ6/W9ZUiiE36Ll1ODaxT8SoV
	K2cmnXUsEgYbZDljz+W3xuW0YXN1eBzaOi4EVoM4PZNcXmLuS6RKTbF0dcDi8VrXmXXTovwX2pe
	nQ8RwOE2Rq0x0QGcxTpqMZP0lZrl8i/JV9oRcA/jjXSL7Cp6yjb4b7k77IBPuWPi54tIr+g69bk
	jRqIYuyl9NYilvjNNmv7VWlZcOxAypvv7SI375nRvq8B9HeFPo/g9RfgubK03nAWtquBPgvm83H
	lww6ocxZIkUYleH0wgtQtMDAPM5P8l79aC1UiNrUuupRTlOSMBqbwd7Ls6we+ZeJzj58QkOIV4I
	vbls4RhJMqmkAAJqXeHbtCxvHBVinOFVuXNwOJWZ4Uq6yujNdRpzm0P6ZhA5evz79bePIwPCvzQ
	TgHY4zCe8IfDaingg==
X-Received: by 2002:a05:6a00:440e:b0:874:708d:b640 with SMTP id d2e1a72fcca58-874708db9e3mr82833b3a.33.1789646803076;
        Thu, 17 Sep 2026 05:06:43 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:1f83:29c5:6e01:c73a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201b2ad8fsm2728031b3a.46.2026.09.17.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:06:42 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v5] hfsplus: fix recursive tree_lock and validate b-tree fork extents at mount
Date: Thu, 17 Sep 2026 19:06:37 +0700
Message-ID: <20260917120637.18959-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bmap_reserve() calls hfsplus_file_extend() on tree->inode with
tree->tree_lock already held. For the extents overflow B-tree's own
inode, growing it can call hfsplus_ext_read_extent() -> hfs_find_init()
on that same tree, taking tree_lock a second time (lockdep: "possible
recursive locking ... &tree->tree_lock/1"). This happens two ways:

 - the fork already claims more blocks than its eight extents
   describe (a corrupted on-disk fork), so hfsplus_ext_read_extent()
   is called immediately to look up the rest; or
 - the fork's eight extents get exhausted during this call, and
   inserting a new overflow extent record for the file would need
   the same lookup.

Per the HFS+ format the extents overflow file is fully described by
its eight fork extents and can never legitimately have overflow
extents of its own, so both cases mean it cannot grow any further.

Add is_extents_btree() and use it at the one place that actually
re-enters hfs_find_init(), hfsplus_ext_read_extent(), to report
-ENOSPC instead of recursing.

For the second case, don't allocate blocks on the chance the fork
still has room and undo it if not: hfsplus_fork_full() tests the
fork first (its last extent is occupied). If it does have a free
slot, any free space works, same as before. If it's already full,
the only way to grow is a contiguous extension of the last extent,
so only search for free space starting exactly at the block right
after it, and fail with -ENOSPC immediately if that block isn't
free. A WARN_ON_ONCE() backstop stays at the insert_extent label:
the fork-full check below should make it unreachable for this
inode, so warn loudly if that invariant ever breaks instead of
recursing on tree_lock again.

To back that invariant, hfsplus_check_fork() now validates each
b-tree's fork extents at mount time, from hfs_btree_open(). It
catches:

 - block_count == 0 but start_block != 0: garbage left in a slot
   that should be blank (this is what the syzbot-reported image has
   in the extents overflow file's fork, slots 3 and 6);
 - start_block + block_count > sbi->total_blocks: an extent pointing
   past the end of the volume, or overflowing u32;
 - a non-zero extent following a zero one: a hole in the used range;
 - the sum of the used extents' block_count disagreeing with the
   fork's own declared total_blocks.

If the first extent itself fails these checks, the b-tree's location
on disk is unknown and there is nothing to recover, so hfs_btree_open()
fails as it already does for the other structural checks in that
function, and the mount fails.

If only a later extent is affected, the tree can still be opened (its
first extent, and hence its root node, is fine); mark it corrupt and
let the caller decide. hfsplus_fill_super() forces the volume
read-only in that case, and hfsplus_reconfigure() checks the same
per-tree flag on remount instead of re-deriving it, refusing to go
back to read-write. attr_tree may be NULL (volumes without an
attributes fork), so both checks guard for that. The corruption state
is tracked as a HFSPLUS_I_CORRUPT_TREE bit on the b-tree's own inode,
next to the existing per-tree HFSPLUS_I_*_DIRTY flags, since one inode
already maps to one tree.

This mount-time check is what makes the WARN_ON_ONCE() above
unreachable in practice: a fuzzed or damaged fork like the one in the
syzbot report is now caught here before any write ever reaches it.

Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 fs/hfsplus/btree.c      | 13 +++++++
 fs/hfsplus/extents.c    | 83 +++++++++++++++++++++++++++++++++++++++--
 fs/hfsplus/hfsplus_fs.h |  6 +++
 fs/hfsplus/super.c      | 13 +++++++
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd5658e1..7f922e424a36 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -274,6 +274,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	struct inode *inode;
 	struct page *page;
 	unsigned int size;
+	int res;
 
 	tree = kzalloc_obj(*tree);
 	if (!tree)
@@ -293,6 +294,18 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		goto free_inode;
 	}
 
+	res = hfsplus_check_fork(sb, HFSPLUS_I(tree->inode)->first_extents,
+				 HFSPLUS_I(tree->inode)->alloc_blocks);
+	if (res == -EIO) {
+		pr_err("%s (cnid 0x%x) fork's first extent is corrupt\n",
+		       hfs_btree_name(id), id);
+		goto free_inode;
+	} else if (res) {
+		pr_warn("%s (cnid 0x%x) fork has corrupt extents, forcing read-only.\n",
+			hfs_btree_name(id), id);
+		set_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I(tree->inode)->flags);
+	}
+
 	mapping = tree->inode->i_mapping;
 	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d18..5b6839918eef 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -84,6 +84,54 @@ static u32 hfsplus_ext_lastblock(struct hfsplus_extent *ext)
 	return be32_to_cpu(ext->start_block) + be32_to_cpu(ext->block_count);
 }
 
+static inline bool is_extents_btree(struct inode *inode)
+{
+	return inode->i_ino == HFSPLUS_EXT_CNID;
+}
+
+static bool hfsplus_extent_valid(struct hfsplus_extent *ext, u32 total_blocks)
+{
+	u32 start = be32_to_cpu(ext->start_block);
+	u32 count = be32_to_cpu(ext->block_count);
+
+	if (!count)
+		return start == 0;
+
+	return start + count > start && start + count <= total_blocks;
+}
+
+/*
+ * Returns 0 if the fork's extents are consistent, -EUCLEAN if only
+ * extents past the first are corrupt (safe to mount read-only), or
+ * -EIO if the first extent is corrupt or the fork has no used extent.
+ */
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext,
+		       u32 total_blocks)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	bool seen_hole = false;
+	u32 used_blocks = 0;
+	int i;
+
+	for (i = 0; i < 8; i++, ext++) {
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
+	return used_blocks == total_blocks ? 0 : -EUCLEAN;
+}
+
 static int __hfsplus_ext_write_extent(struct inode *inode,
 		struct hfs_find_data *fd)
 {
@@ -217,6 +265,9 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 	    block < hip->cached_start + hip->cached_blocks)
 		return 0;
 
+	if (is_extents_btree(inode))
+		return -ENOSPC;
+
 	res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);
 	if (!res) {
 		res = __hfsplus_ext_cache_extent(&fd, inode, block);
@@ -392,6 +443,11 @@ static int hfsplus_free_extents(struct super_block *sb,
 	}
 }
 
+static bool hfsplus_fork_full(struct hfsplus_extent *ext)
+{
+	return ext[7].block_count != 0;
+}
+
 int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		struct hfsplus_fork_raw *fork, int type)
 {
@@ -465,13 +521,23 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	}
 
 	len = hip->clump_blocks;
-	start = hfsplus_block_allocate(sb, sbi->total_blocks, goal, &len);
-	if (start >= sbi->total_blocks) {
-		start = hfsplus_block_allocate(sb, goal, 0, &len);
-		if (start >= goal) {
+	if (is_extents_btree(inode) && hip->alloc_blocks == hip->first_blocks &&
+	    hfsplus_fork_full(hip->first_extents)) {
+		/* Full fork, no overflow extent possible: goal or nothing */
+		start = hfsplus_block_allocate(sb, goal + len, goal, &len);
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
@@ -526,6 +592,15 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	return res;
 
 insert_extent:
+	/* Can't happen: the fork-full check above rules this out */
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
index 1e5b58e6a13f..af36f2faf286 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -227,10 +227,14 @@ struct hfsplus_inode_info {
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
@@ -440,6 +444,8 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		      struct hfsplus_fork_raw *fork, int type);
 int hfsplus_file_extend(struct inode *inode, bool zeroout);
 void hfsplus_file_truncate(struct inode *inode);
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext,
+		       u32 total_blocks);
 
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

