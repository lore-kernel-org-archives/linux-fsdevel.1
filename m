Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D447F2C4
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219459; cv=none; b=UycETkYEB8y4qPbZraAEk298DAzcQMCKxfIvJGV1papV2KOMDBPvgUhyB9RuxDcF0yRTIjch5Si6hfME3YRHZIJ3QxPOJKDHThjNXBE0Mga85Faj2rAbocefrcrCSrsi4STtiCyFk3Z5zPcRC8oe9GIJ9O3oCODPiyHqxJyj98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219459; c=relaxed/simple;
	bh=OGnOLUANxAIKeUE2V8GE9FEBbxM0GNuhltrq3p8+tco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj7sIUBGUhJYl93wDCP2i/UPksYXRBDIEWSFJkEfXNDAy62wOyg6joCZDmWKOsUsmxFqJW7w45bi/lBzVgZok8D45zOXgauqDjq+27NtgCtMoVtn2uCfqHZr8bbkxDojiVk9dV6MeR13pr22fB2zGG0Ghfwfy92UjNBlbI2G2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEaWen8Q; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEaWen8Q"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1063023b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789219458; x=1789824258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4hkvii+G5WCvJx9xVx3ahKrNV+HTp+VsVBK0jsNMTU=;
        b=mEaWen8Q8lezvFby2whoKipBEOrNmLY7efLpcddu3yDZeOtyVXhQN5dm9L9n9VKwql
         6UJI2HhOCKkUju+QyL4PewFLaMv6B1N8MPTtcH50ELZeLQm3Od4ayNNU+9Qhd9iDUoQH
         wSnUUMKBV4vUHCooQEhWLIg6eBF2JCJ1WKB1TX0dhT9tLfv9O+8gdwoz6I94H0quDMWV
         3XA/q+bDVcLViD4RL1LfS+k9dakGTpdb8ZxVl05n1/Qqo014LRAp/XJjey4YUn2S6uDp
         l35SPpsfnlDFMpjPyTPuC1pgcjCkB1HXbpPK9aLJAp9QEB8mwiskScnc8m+poEXrf+Kj
         RhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219458; x=1789824258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4hkvii+G5WCvJx9xVx3ahKrNV+HTp+VsVBK0jsNMTU=;
        b=Km6Hd46xNtiw+00Lb259bFJL0skY2263qgTgDRlze+9sTEJ3Khk7xlH68DRXJdaZsH
         lLY4xuDCl/vudpuL35tuDgkx6wnvEtz6DSFAd3Guw0pB5BYvHi5SsTTSzNKc4b41qs8J
         iwwZdIxnOhmE86nKsaNT0W7M+2M6UwclaxZjKKsEn4jzHFKoZwDvPgYlW64soPkfniwR
         vyOex9dP7GDHwacr4mPev4cOhgBNTzBbUA5FYpe+fAJr5rtH9tseUQKDze9tIKs3r+R9
         kVbbTu5sWjn8WIrFFAMlJKZ4fNn/SGnAYvEQTBaxQBzUjT78lV0YFzJuOb2O2XrfNsF1
         VeWA==
X-Forwarded-Encrypted: i=1; AKwUvBwrMmNyhXs7Rk1s9EPy18o+ulmQ72Ovwd+jQX6ioIJwNninqKw/fkbABFdF5QWJHeWv4WA4GrdfEfMT+zZb@vger.kernel.org
X-Gm-Message-State: AFuF++muzADCrOKLQQsx3DWiGiSbPb/HAbKoQ6Ejr8BSqA9jA8UfGtDp
	putcK4uIMejnE+zaonvP51fJm4kI3/ToBqvOV6i5y90KQ893cd8quu/k
X-Gm-Gg: AYBFou2e9aOK0Bgcd8/sA9BSmGkD0TUE81eTni1edPEZ9nZG5g+Zy2HE6W/J/5UScGQ
	N/6JFX8D5Ngs4MdUZ2ya8zUpo5UiJgHp1W/1lwhn5rKnMr7b6HEey6ZVfRAkQKmIllNGsE2lnet
	qTp33AtZvj5bkb+jq8SPCUXkk6IoUhkPxTZmS6nqNJIYQuZGGVQT2EH1uoL4DyxJqIOGViFdby0
	wmzB36eewdJ0joZ/eVAf/JGcR0TLzubba0WN+cLgBoNACxm6jBPcODCPEE1aDpxoXvJkmVtApYR
	o+mfQurb6sN3gvnezKRhmerTZTlF2Vrb/6Wax+vFPAd47626g5U7p65G4hbDTz9T+0cPsGlhO5M
	M4t8OOXKc7jjfu53QKp6xZdswXnnqek/QaPtCk1y63+NggSYdiBajfUG9NxV/XwimXVUgyLcxtd
	3jcCrRKhUh5WWjE6VNmxlByIKWc+rnaDOyk/AWdDHGnefOWC2//UUFfqFf1bccpthFO5LpgBedl
	NTIa9el3hvHYYstCnAzpOgrElAY
X-Received: by 2002:a05:6a00:4c97:b0:869:c1c8:97 with SMTP id d2e1a72fcca58-86b338d0c45mr15147029b3a.17.1789219457776;
        Sat, 12 Sep 2026 06:24:17 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:dfd9:c41e:7c9b:c69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b292c9839sm2410819b3a.33.2026.09.12.06.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:24:17 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Subject: [PATCH v4 2/2] hfsplus: validate b-tree fork extents at mount time
Date: Sat, 12 Sep 2026 20:24:07 +0700
Message-ID: <20260912132407.16856-3-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912132407.16856-1-ngocthang2710.1999@gmail.com>
References: <c6b841becc5b1709a9f54a1c0efd0a14f02ad97b.camel@dubeyko.com>
 <20260912132407.16856-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hfsplus_check_fork() pass over a special file's eight fork extents,
called from hfs_btree_open() for the extents, catalog and attributes
trees:

 - block_count == 0 but start_block != 0: garbage left in a slot that
   should be blank (this is what the syzbot-reported image has in the
   extents overflow file's fork, slots 3 and 6);
 - start_block + block_count > sbi->total_blocks: an extent pointing
   past the end of the volume;
 - a non-zero extent following a zero one: a hole in the used range.

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
attributes fork), so both checks guard for that.

This also gives the previous patch's hfsplus_file_extend() fix a
mount-time backstop: a fuzzed or damaged extents overflow fork like
the one in the syzbot report is caught here before any write ever
reaches it.

Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
---
 fs/hfsplus/btree.c      | 12 ++++++++++++
 fs/hfsplus/extents.c    | 37 +++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h |  4 ++++
 fs/hfsplus/super.c      |  9 +++++++++
 4 files changed, 62 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd5658e1..0a05ade53070 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -293,6 +293,18 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		goto free_inode;
 	}
 
+	switch (hfsplus_check_fork(sb, HFSPLUS_I(tree->inode)->first_extents)) {
+	case -EIO:
+		pr_err("%s (cnid 0x%x) fork's first extent is corrupt\n",
+			hfs_btree_name(id), id);
+		goto free_inode;
+	case 1:
+		pr_warn("%s (cnid 0x%x) fork has corrupt extents, forcing read-only.\n",
+			hfs_btree_name(id), id);
+		tree->corrupt = true;
+		break;
+	}
+
 	mapping = tree->inode->i_mapping;
 	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 236f2d9a7a2d..a9303ce5bf8f 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -95,6 +95,43 @@ static bool hfsplus_ext_fork_full(struct hfsplus_extent *ext)
 	return true;
 }
 
+/*
+ * Check a fork's eight extents for the corruption a fuzzed or damaged
+ * volume header can contain: garbage in a slot that should be unused,
+ * an extent that runs past the end of the volume, or a used extent
+ * following an unused one.
+ *
+ * Returns 0 if the fork is fully consistent, 1 if only extents after
+ * the first are affected (the b-tree can still be located, so it's
+ * safe to mount read-only), or -EIO if the first extent itself is
+ * unusable.
+ */
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	bool seen_hole = false;
+	int i;
+
+	for (i = 0; i < 8; i++, ext++) {
+		u32 start = be32_to_cpu(ext->start_block);
+		u32 count = be32_to_cpu(ext->block_count);
+		bool bad;
+
+		if (!count) {
+			bad = start != 0;
+			seen_hole = true;
+		} else {
+			bad = seen_hole || start + count < start ||
+			      start + count > sbi->total_blocks;
+		}
+
+		if (bad)
+			return i ? 1 : -EIO;
+	}
+
+	return 0;
+}
+
 static int __hfsplus_ext_write_extent(struct inode *inode,
 		struct hfs_find_data *fd)
 {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1e5b58e6a13f..8d47219e67d3 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -56,6 +56,9 @@ struct hfs_btree {
 	unsigned int max_key_len;
 	unsigned int depth;
 
+	/* fork extents past the first were found corrupt at open time */
+	bool corrupt;
+
 	struct mutex tree_lock;
 
 	unsigned int pages_per_bnode;
@@ -440,6 +443,7 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		      struct hfsplus_fork_raw *fork, int type);
 int hfsplus_file_extend(struct inode *inode, bool zeroout);
 void hfsplus_file_truncate(struct inode *inode);
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext);
 
 /* inode.c */
 extern const struct address_space_operations hfsplus_aops;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index ff7d6b3336a6..b65edb8ee589 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -400,6 +400,11 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			pr_warn("filesystem is marked journaled, leaving read-only.\n");
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
+		} else if (sbi->ext_tree->corrupt || sbi->cat_tree->corrupt ||
+				(sbi->attr_tree && sbi->attr_tree->corrupt)) {
+			pr_warn("a b-tree fork was corrupt at mount time, leaving read-only.\n");
+			sb->s_flags |= SB_RDONLY;
+			fc->sb_flags |= SB_RDONLY;
 		}
 	}
 	return 0;
@@ -564,6 +569,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_xattr = hfsplus_xattr_handlers;
 
+	if (sbi->ext_tree->corrupt || sbi->cat_tree->corrupt ||
+	    (sbi->attr_tree && sbi->attr_tree->corrupt))
+		sb->s_flags |= SB_RDONLY;
+
 	inode = hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
 	if (IS_ERR(inode)) {
 		pr_err("failed to load allocation file\n");
-- 
2.43.0

