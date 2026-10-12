Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0964446851;
	Mon, 12 Oct 2026 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791091; cv=none; b=JcDZvgGbNjMXXpDoC12UUl1666+VoSrnufl9NScpZPmqygg6OMFDrCwLSswIL9I/WqiRLHrdwiqmV6t7r2yTG1Peo1cK6YrkJoO/rCWJM2GS/rgp9L48xxjkqtVlt93nevkUqry4iUk8KljDTSg+ewiTDmaRwBsoDJUWKff986o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791091; c=relaxed/simple;
	bh=/fJi3QeK3l4UB5NVtuYuspU6YDU7/K4uM3vAMVEjSXU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2qe+oqOsTQ4xESBveXLA84Jo2V2QIFOs4N55Swz9NyMF8IaDJbWm9PNjTzTgMReOusVEUi02rDhB4j21KRYuboJV0m9kBS8cs7rgZ+3KXlVFnr2R3IC1Lrf699mXbPGeQswZmRxuv5pZFLHi203Tb/PGubHyDiwt4QauzrvIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GElKpd55; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GElKpd55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791791082; bh=JNbInwog42HZiUei8KOTqHeWPWDAxvtDmWsvnlmhOFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GElKpd55gtwMogIIepk1z+BxLMVZzTMonjuu7Wk/v2bWomU9KKUkLPtJCyKErnfzO
	 cCgTfjdCUsW/canXNvsDOUxLLEzMmjgsMCyFapP+mDwuhd07tYOPMYSIYzebcrQhoR
	 fgRae7lWznEhVTMjjnAz1ZGM2MbU+KPMHEIANt8g=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B2728EF6; Mon, 12 Oct 2026 15:44:39 +0800
X-QQ-mid: xmsmtpt1791791080tvsx1vwjg
Message-ID: <tencent_C6E63E6151EEA924DF6C23D74E35A6245108@qq.com>
X-QQ-XMAILINFO: NxKoLLhE22aTzvCIE7pSG6nJdgLbokoxr2Go7gl9ard/2proqb/ben1OZ3upP3
	 VB9uPlQWFzOjrTJWODy82N53o9+OfxSMXgzTZUHcKQDQ3cEtMO+4EixNKpyqitYYr8Hs60LBhWuN
	 Qzr4ZNdV/cfwGib5d+441+/XzFWm+BsUBUcxAW/qlQEuO90e7UwKxhlhTPJrkVmCec3bMuHm21sQ
	 bFmp1GD2je64n7pEdu8zurCQGVMmM+Axbfr4K3JZzBcsV9plWiAL+xZzt3JbD32RSr+xJngeg0et
	 d23r74GOj513qIGDl7kxurMsyFRzuZeLxT5OLf1zwXh/TWYz8M5ewRgnMvNov4M0fk5Kkrr8154a
	 0+TJZdzU87u+02qQbEFFibKkf4fQ1Oo7A+PZWgvMRpy99OYD2+QVzM+LZGiBjekj9PTiHjyeN/1J
	 ZjnHw+yfy/KIlEqaeLPw+zF3pHzFcBEGW0Nm9g2VCvXgTob3enfElctr0fBk1HfLQ1kbybdUSqYh
	 cb4tXwCJJAmmM1C+0WX/gqeTOUzK4MApLVrHv0T42ADw1sViemh5rwaaq8HZ2iBMRo1tpJCM3EUu
	 iZIpl6PXxVv0BoBhmuBgmGtp94cKdSgMJbEUeIqO1UB3ffvc+Fh6ASeVbJ9SeaV2bKpZTCcpE3Zm
	 jQWbbyFHIMPkNjd7wXuri4BvyAkMBMlXCVTUR3f0BkNWFAHMRnyhIsehbA+8Ff2riNhb7p6WVKU+
	 pu3kaBF6bNYhu/Fvy39MDUt4K5cx7+euLCaCvpzyKsicI7YBs0Z50fcvHci38Fj03xWIKIRzkCCi
	 02fWtY9RS2bZE0CVjw46f0JRQqXI7bc2YijLIR4nYVYe5UpstFN8PXTelYdGvsxU+mFz+jVt51Ax
	 SnmUl9PEarp6PUPUrIXeww1Tc5HWNwCx3bwP6CnbxQyDQioaW2hJGPrj2A3+utPKSFhKaqzYmyV0
	 TtD4WD3SaJQbzVr/IXuYzqKao2SqTbrto4DSoGCAfP2Dbc8QVfIZwMpsLWh/ei1kSM64VxnjkYON
	 TuD7sAtE5PoEaJdDNLgWon2KHaA0RKaCpfCbeE0PhQVhGlZ5MgK7+gK/S8je0yaV/g+RlnRQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: 1sh1ro <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hfs: create the internal B-tree inodes through the generic iget path
Date: Mon, 12 Oct 2026 15:44:38 +0800
X-OQ-MSGID: <20261012154438.6396-2-yangguikun19@qq.com>
In-Reply-To: <20261012154438.6396-1-yangguikun19@qq.com>
References: <fb6a6e2ff419fc197c793d9a98fccd2d1332e49d.camel@dubeyko.com> <20261012154438.6396-1-yangguikun19@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hfs_btree_open() builds the extents and catalog B-tree inodes with a raw
iget_locked() and never assigns them a file type, so both stay cached with
i_mode == 0 after every mount.  A crafted HFS image whose catalog contains
a record addressing one of the reserved B-tree CNIDs (3 or 4) makes
hfs_lookup() -> hfs_iget() return that cached inode - hfs_test_inode()
matches on i_ino alone - and the typeless inode then reaches the generic
open path, where it trips VFS_BUG_ON_INODE() in may_open() with
CONFIG_DEBUG_VFS=y:

  VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)): inode:... fs:hfs mode:0 opflags:0xc
  ------------[ cut here ]------------
  kernel BUG at fs/namei.c:4271!
  RIP: 0010:may_open+0x2ba/0x480 fs/namei.c:4271
  Call Trace:
   do_open fs/namei.c:4698 [inline]
   path_openat+0x1600/0x3de0 fs/namei.c:4863
   __x64_sys_openat+0x13f/0x1f0 fs/open.c:1385

Without CONFIG_DEBUG_VFS the assertion compiles away and the same image
silently yields an openable typeless inode, so this is not merely a
debug-config nuisance.

Fix it the way HFS+ handles its system inodes: add hfs_system_read_inode(),
which reads the fork from the MDB (the counterpart of
hfsplus_system_read_inode()), and hfs_system_iget(), which looks the inode
up through the normal inode-cache path and can fail before the inode is
published.  hfs_btree_open() now uses hfs_system_iget(), so the B-tree
inodes carry a valid S_IFREG type like every other inode.  The
extent-record validation is unchanged; it just runs after the inode has
been created.

Found by syzkaller-style fuzzing of v7.2-rc7; still reproducible on
current mainline.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/linux-fsdevel/tencent_24D928451FEFA8A35482EFFA9132A7305307@qq.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: 1sh1ro <yangguikun19@qq.com>
---
  fs/hfs/btree.c  |  25 +++++--------------------
 fs/hfs/hfs_fs.h |   1 +
 fs/hfs/inode.c  |  74 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 41b4e8f..7486707 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -155,44 +155,29 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->cnid = id;
 	tree->keycmp = keycmp;
 
-	tree->inode = iget_locked(sb, id);
-	if (!tree->inode)
+	tree->inode = hfs_system_iget(sb, id);
+	if (IS_ERR(tree->inode))
 		goto free_tree;
-	BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
-	{
-	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
-	HFS_I(tree->inode)->flags = 0;
-	mutex_init(&HFS_I(tree->inode)->extents_lock);
+
 	switch (id) {
 	case HFS_EXT_CNID:
-		hfs_inode_read_fork(tree->inode, mdb->drXTExtRec, mdb->drXTFlSize,
-				    mdb->drXTFlSize, be32_to_cpu(mdb->drXTClpSiz));
 		if (HFS_I(tree->inode)->alloc_blocks >
 					HFS_I(tree->inode)->first_blocks) {
 			pr_err("invalid btree extent records\n");
-			unlock_new_inode(tree->inode);
 			goto free_inode;
 		}
-
-		tree->inode->i_mapping->a_ops = &hfs_btree_aops;
 		break;
 	case HFS_CAT_CNID:
-		hfs_inode_read_fork(tree->inode, mdb->drCTExtRec, mdb->drCTFlSize,
-				    mdb->drCTFlSize, be32_to_cpu(mdb->drCTClpSiz));
-
 		if (!HFS_I(tree->inode)->first_blocks) {
 			pr_err("invalid btree extent records (0 size)\n");
-			unlock_new_inode(tree->inode);
 			goto free_inode;
 		}
-
-		tree->inode->i_mapping->a_ops = &hfs_btree_aops;
 		break;
 	default:
 		BUG();
 	}
-	}
-	unlock_new_inode(tree->inode);
+
+	tree->inode->i_mapping->a_ops = &hfs_btree_aops;
 
 	mapping = tree->inode->i_mapping;
 	folio = filemap_grab_folio(mapping, 0);
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e250f87..26505f7 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -219,6 +219,7 @@ extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 				u32 clump_size);
 extern struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key,
 				hfs_cat_rec *rec);
+extern struct inode *hfs_system_iget(struct super_block *sb, u32 cnid);
 extern void hfs_evict_inode(struct inode *inode);
 extern void hfs_delete_inode(struct inode *inode);
 
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2aef3c3..4316d75 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -421,6 +421,80 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	return 0;
 }
 
+/*
+ * hfs_system_read_inode
+ *
+ * Initialize one of the internal B-tree inodes.  These are described by the
+ * MDB rather than by catalog records, so they need their own read helper -
+ * the HFS counterpart of hfsplus_system_read_inode().
+ */
+static int hfs_system_read_inode(struct inode *inode)
+{
+	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
+	struct hfs_mdb *mdb = hsb->mdb;
+
+	HFS_I(inode)->flags = 0;
+	HFS_I(inode)->rsrc_inode = NULL;
+	mutex_init(&HFS_I(inode)->extents_lock);
+	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
+
+	inode->i_uid = hsb->s_uid;
+	inode->i_gid = hsb->s_gid;
+	set_nlink(inode, 1);
+
+	switch (inode->i_ino) {
+	case HFS_EXT_CNID:
+		hfs_inode_read_fork(inode, mdb->drXTExtRec, mdb->drXTFlSize,
+				    mdb->drXTFlSize, be32_to_cpu(mdb->drXTClpSiz));
+		break;
+	case HFS_CAT_CNID:
+		hfs_inode_read_fork(inode, mdb->drCTExtRec, mdb->drCTFlSize,
+				    mdb->drCTFlSize, be32_to_cpu(mdb->drCTClpSiz));
+		break;
+	default:
+		return -EIO;
+	}
+
+	/*
+	 * Assign a dummy file type, for may_open() requires that an inode has
+	 * a valid file type.  These inodes are hashed by CNID like any other
+	 * inode, so without a type a catalog record of a crafted image that
+	 * aliases CNID 3 or 4 would reach the VFS with i_mode == 0.
+	 */
+	inode->i_mode = S_IFREG;
+
+	return 0;
+}
+
+/*
+ * hfs_system_iget
+ *
+ * Look up (or create) one of the internal B-tree inodes.  hfs_btree_open()
+ * uses this instead of a raw iget_locked() so that the inode is completely
+ * initialized before it becomes visible in the inode cache, in the same way
+ * hfsplus_iget() handles the system CNIDs for HFS+.
+ */
+struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
+{
+	struct inode *inode;
+	int err;
+
+	inode = iget_locked(sb, cnid);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+	if (!(inode_state_read_once(inode) & I_NEW))
+		return inode;
+
+	err = hfs_system_read_inode(inode);
+	if (err) {
+		iget_failed(inode);
+		return ERR_PTR(err);
+	}
+
+	unlock_new_inode(inode);
+	return inode;
+}
+
 /*
  * __hfs_iget()
  *
-- 
2.39.5

