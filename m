Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D05425882
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975798; cv=none; b=hTzjaoSaw9bT3gw6Qn5EuTdcrZ70FePjMlsavIktEOIQ4oqzbzidB9wpibOHbXc2e7wh9g4IfMJXpDzj0nEoR44+bWIclQzzU8YbmIiv89EkXfWk4LoFUdb6V06ChUgfVlfc6jRj66Bo0MR/RlPEAyqvky41/7HKLJwuLpc3LHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975798; c=relaxed/simple;
	bh=4D4aVPOSEl2A+owPYn+PFyy4iq7bP4clkJ3jbHNggNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUK5cxYMghUw0w4znHC3d85THS48dclEM2LglDRsmCxn/RBf9W+EAdy3XTdqrk6oPoKlLLkuuG1Bz3ZxZkDjrJzhjd02BM+k/Y+0NshUrSYHT/DMbV7Qe4lk8O+E1y8piIAjJ2lk05Y1hPpRoS6iRU9KaKxxItAGZasZj90l8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=R1gbvmoh; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="R1gbvmoh"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3d90ac37so1586312e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790975794; x=1791580594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZJBRY4CFdwM/oZuJvFUBIMnKMIGNgLTvno3oAn5Pmk=;
        b=R1gbvmoh3QCIpGDFBx6Xn8S+nCZEqmpPUDmBTcQKKlyTj/+KSm7ryGZ7EbtNxqh+wg
         ry/R+2gVZzSXlAsxghI9TPcEWT7OGgPk//ifuMztNJshC3g0FzaeD25Axs3TcMpiMqV+
         LTieJA07sGOV4ov4qn2VF6ZD1WjfxmyCXoKkeaoauIgSAY1ldVMOGb2AKnyDE6fJ3+AM
         BMy36HrYf+A+O9vO6LqmW+qRwbF4TU+XafWY/Ly/U8VTLVCLtlIoBguLKsO7TIWJ06J2
         RHcf1QhY4W1j7Zg9yV+fiSR1FLWMwNAkU9rmfbwGTiYg15vP7dgV3haIsQU8vOwWKNIa
         vGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975794; x=1791580594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZJBRY4CFdwM/oZuJvFUBIMnKMIGNgLTvno3oAn5Pmk=;
        b=ALplnIYBDp1iLtr/Xtio5zyDaRZVGe8pdyFHOqfPRkUG75hUcPtM+AO3u5QjEM25hu
         0zHFBfWWAXhZkrwQqekxsy+HeINcrhIzDnapzDeomqljmc9sWERI4n5jPtPZvH/b+C9k
         s5c50O94LOvgSZvQaxSvVuHFbp2abgnSTZloxW5jeS+I3A1VI6QCeNtwo4uZTUbFD10q
         SDjK2rlKKb5xtryl2YCtVsYPowb1qqFg5qGwRexwY86eSsbOt5Ma/LJjY376EdAYAUpm
         lyrkshHln+KA+iinmvwYYRO9Jrf1jVSPqo/LVtXsmBHvsSTcnfRMwCE+2ebEqcmzmR0N
         9hQQ==
X-Gm-Message-State: AFq9FYLGSdL/xYtiLQaFkoMuLOlJ85UgHqEVcGMVbFuDHUSdHD/I3Fsn
	HN9AY5V7e5vj7Klvp/oTT36DuvY2rceY11TWcq1yufqJFI837DtczqXbjFE+Fh+oZJOIKooeFWj
	at3PLjHSecMC5VQ==
X-Gm-Gg: AYBFou2D9JYrHXAqEI5ALyGtkdY5rLnaWhvEaXXUileyPO6ycJtZBeV+Qhp6zC4mmj+
	jb2P22TYROWn5EL1DCzthKsVSflDqbY7NzPZr6Av0/2wpJSObn2K8tHrAAC8yBy9qEL7KqVXZl5
	fqDm/37cUilo6q+M1PfJEx4McqootiOdJD/BSE6hyNBAao033xJoTfctEu4dwTGvImPkmrGoe0+
	c3jeqlukyQ3UtXhZkMsI5PLGVgJozC0ws6DwMSWmpne2QIiikkkuUcF7TTWdfKzvp4qtpeskonS
	9zP3fRyEDfZZpTZZtbLBR8AEHDrAk5+rgfjVmMyNCVI2rZy3p8PqrXf46MtwxSdfqVtufBYH5VE
	r4yF7kbx28/kPEzwi/+E9QBY/QQA6KWx8z7PH672ptkXuiuvBiapyuu3y+gjbGUEdgwaXH7+ApT
	fPqs2L2aNRMzhcwf5A51U0WHdMHwm1cnNKj7k6IPAUCs1EpWLpkYK87ws645HE+1Si9eUG4xvk
X-Received: by 2002:a05:6512:3d21:b0:5ba:4287:9372 with SMTP id 2adb3069b0e04-5bb9bc61684mr1343221e87.61.1790975794231;
        Fri, 02 Oct 2026 14:16:34 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c79f7easm1015600e87.57.2026.10.02.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:16:33 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: Slava Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Frank Li <frank.li@vivo.com>,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH v3] hfsplus: annotate extents_lock nesting to silence lockdep false positive
Date: Fri,  2 Oct 2026 23:16:26 +0200
Message-ID: <20261002211626.1576625-1-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8078649d8c1405e0a207d06efe4ec0189d3eef76.camel@dubeyko.com>
References: <8078649d8c1405e0a207d06efe4ec0189d3eef76.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lockdep reports a possible recursive locking on
HFSPLUS_I(inode)->extents_lock when truncating or extending a file on a
crafted image: the regular file holds its own extents_lock and, while
freeing or allocating blocks, reads the allocation file, whose
->get_block() takes the allocation file's extents_lock.  These are two
different inodes locked in a fixed order, so it is not a real deadlock,
only a missing nesting annotation.

tree->cnid and inode->i_ino share the CNID namespace, so fold the
B-tree tree_lock subclass helper and the extents_lock classification
into a single hfsplus_lock_class(cnid): the allocation file gets its own
subclass and every other inode uses the default, while the catalog,
extents and attributes B-trees keep the subclasses they had.  Take
extents_lock with mutex_lock_nested() at the sites that nest.  A genuine
recursion on one inode's extents_lock -- including the allocation
file on itself -- is still reported.

Found via coverage-guided fuzzing (syzkaller + lockdep) by Noroxi.

Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
---
Slava, this is the reworked version you suggested: one CNID-keyed
hfsplus_lock_class() serving both the B-tree tree_lock and the inode
extents_lock, instead of a second enum/function.

The B-tree tree_lock keeps CATALOG/EXTENTS/ATTR (same values as before).
For extents_lock the only real nesting is a regular file's extents_lock
(held in truncate/extend) over the allocation file's extents_lock (taken
from its ->get_block() during block alloc/free), so the allocation file
gets its own subclass and everything else uses the default.  That also
drops the FIRSTUSER file/folder ambiguity from v2.

One behaviour change worth flagging: hfsplus_lock_class() returns
HFSPLUS_DEFAULT_MUTEX for an unexpected CNID where the old
hfsplus_btree_lock_class() called BUG().  The B-tree callers still only
pass CAT/EXT/ATTR, so this affects only the now-shared default path.
Happy to keep a WARN there if you prefer.

v3:
 - rework hfsplus_btree_lock_class() into a single CNID-keyed
   hfsplus_lock_class() shared by tree_lock and extents_lock (Slava
   Dubeyko); drop the separate enum/function and the FIRSTUSER check
v2:
 - shorten the comment, rename the subclass, use FIRSTUSER (superseded)
 fs/hfsplus/bfind.c      |  2 +-
 fs/hfsplus/extents.c    | 18 +++++++++++-------
 fs/hfsplus/hfsplus_fs.h | 39 +++++++++++++++++++++------------------
 fs/hfsplus/super.c      |  2 +-
 fs/hfsplus/xattr.c      |  3 ++-
 5 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca9813f58a..ed72d61f64 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -27,7 +27,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	hfs_dbg("cnid %d, caller %ps\n",
 		tree->cnid, __builtin_return_address(0));
 	mutex_lock_nested(&tree->tree_lock,
-			hfsplus_btree_lock_class(tree));
+			hfsplus_lock_class(tree->cnid));
 	return 0;
 }
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d..ae1369a4cb 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -150,7 +150,8 @@ int hfsplus_ext_write_extent(struct inode *inode)
 {
 	int res;
 
-	mutex_lock(&HFSPLUS_I(inode)->extents_lock);
+	mutex_lock_nested(&HFSPLUS_I(inode)->extents_lock,
+			  hfsplus_lock_class(inode->i_ino));
 	res = hfsplus_ext_write_extent_locked(inode);
 	mutex_unlock(&HFSPLUS_I(inode)->extents_lock);
 
@@ -261,7 +262,8 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	if (inode->i_ino == HFSPLUS_EXT_CNID)
 		return -EIO;
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_lock_class(inode->i_ino));
 
 	/*
 	 * hfsplus_ext_read_extent will write out a cached extent into
@@ -430,7 +432,7 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 				     total_blocks);
 		total_blocks = start;
 		mutex_lock_nested(&fd.tree->tree_lock,
-			hfsplus_btree_lock_class(fd.tree));
+			hfsplus_lock_class(fd.tree->cnid));
 	} while (total_blocks > blocks);
 	hfs_find_exit(&fd);
 
@@ -454,7 +456,8 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 		return -ENOSPC;
 	}
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_lock_class(inode->i_ino));
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
@@ -576,7 +579,8 @@ void hfsplus_file_truncate(struct inode *inode)
 	blk_cnt = (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1) >>
 			HFSPLUS_SB(sb)->alloc_blksz_shift;
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_lock_class(inode->i_ino));
 
 	alloc_cnt = hip->alloc_blocks;
 	if (blk_cnt == alloc_cnt)
@@ -597,7 +601,7 @@ void hfsplus_file_truncate(struct inode *inode)
 			hfsplus_dump_extent(hip->first_extents);
 			hip->first_blocks = blk_cnt;
 			mutex_lock_nested(&fd.tree->tree_lock,
-				hfsplus_btree_lock_class(fd.tree));
+				hfsplus_lock_class(fd.tree->cnid));
 			break;
 		}
 		res = __hfsplus_ext_cache_extent(&fd, inode, alloc_cnt);
@@ -612,7 +616,7 @@ void hfsplus_file_truncate(struct inode *inode)
 				     alloc_cnt - start, alloc_cnt - blk_cnt);
 		hfsplus_dump_extent(hip->cached_extents);
 		mutex_lock_nested(&fd.tree->tree_lock,
-				hfsplus_btree_lock_class(fd.tree));
+				hfsplus_lock_class(fd.tree->cnid));
 		if (blk_cnt > start) {
 			hip->extent_state |= HFSPLUS_EXT_DIRTY;
 			break;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 916e6552e3..22b961b454 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -30,11 +30,19 @@ typedef int (*btree_keycmp)(const hfsplus_btree_key *,
 
 #define NODE_HASH_SIZE	256
 
-/* B-tree mutex nested subclasses */
-enum hfsplus_btree_mutex_classes {
-	CATALOG_BTREE_MUTEX,
-	EXTENTS_BTREE_MUTEX,
-	ATTR_BTREE_MUTEX,
+/*
+ * Nested-locking subclasses shared by the B-tree tree_lock and the inode
+ * extents_lock.  Both are keyed by CNID (tree->cnid or inode->i_ino), so one
+ * mapping serves both.  The allocation file gets its own subclass because a
+ * regular file's extents_lock is held across block alloc/free, which takes the
+ * allocation file's extents_lock in turn; every other inode uses the default.
+ */
+enum hfsplus_mutex_classes {
+	HFSPLUS_CATALOG_MUTEX,
+	HFSPLUS_EXTENTS_MUTEX,
+	HFSPLUS_ATTR_MUTEX,
+	HFSPLUS_ALLOC_MUTEX,
+	HFSPLUS_DEFAULT_MUTEX,
 };
 
 /* An HFS+ BTree held in memory */
@@ -547,25 +555,20 @@ static inline __be32 __hfsp_ut2mt(time64_t ut)
 	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
 }
 
-static inline enum hfsplus_btree_mutex_classes
-hfsplus_btree_lock_class(struct hfs_btree *tree)
+static inline unsigned int hfsplus_lock_class(u32 cnid)
 {
-	enum hfsplus_btree_mutex_classes class;
-
-	switch (tree->cnid) {
+	switch (cnid) {
 	case HFSPLUS_CAT_CNID:
-		class = CATALOG_BTREE_MUTEX;
-		break;
+		return HFSPLUS_CATALOG_MUTEX;
 	case HFSPLUS_EXT_CNID:
-		class = EXTENTS_BTREE_MUTEX;
-		break;
+		return HFSPLUS_EXTENTS_MUTEX;
 	case HFSPLUS_ATTR_CNID:
-		class = ATTR_BTREE_MUTEX;
-		break;
+		return HFSPLUS_ATTR_MUTEX;
+	case HFSPLUS_ALLOC_CNID:
+		return HFSPLUS_ALLOC_MUTEX;
 	default:
-		BUG();
+		return HFSPLUS_DEFAULT_MUTEX;
 	}
-	return class;
 }
 
 static inline
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index ff7d6b3336..49059bf3e7 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -152,7 +152,7 @@ static int hfsplus_system_write_inode(struct inode *inode)
 	hfsplus_inode_write_fork(inode, fork);
 	if (tree) {
 		mutex_lock_nested(&tree->tree_lock,
-				  hfsplus_btree_lock_class(tree));
+				  hfsplus_lock_class(tree->cnid));
 		int err = hfs_btree_write(tree);
 		mutex_unlock(&tree->tree_lock);
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 21a1c196c7..f540d4c382 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -264,7 +264,8 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 						    sbi->sect_count,
 						    HFSPLUS_ATTR_CNID);
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_lock_class(attr_file->i_ino));
 	hip->clump_blocks = clump_size >> sbi->alloc_blksz_shift;
 	mutex_unlock(&hip->extents_lock);
 
-- 
2.43.0

