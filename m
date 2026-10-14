Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B43D9DA7;
	Wed, 14 Oct 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965040; cv=none; b=qeNi9FDfK+3Vn5gtcEtPGkPv9sTbWnzYec+MYcbs4U0N6HE4un/0/neTHuSLJzazt7zqOiGrP1e8cO8onX6RAeFV7pu5Bm87eFrQsndiACJ98vMmD5nDN4nMUmkQgp66iXEjKu2DDcd4c8cOzSQwQ/KPWT5VpJ/tEN48u/AQ37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965040; c=relaxed/simple;
	bh=Dn/zspWbm2Uo3aJa+52Q/K5qIzB2Y5I8+vPk3dgXexs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSj/KMW8w4tZZSjh8yc+5zfRIiKaXWkgm/KATuH9hnxw57ngI3szCRHCfF37mlk1npkAX+DCV1TUXQJBA3Z7goxSAAxGFiPm9Jit94IBYSEgn7SEeHawY7NfQNrzE88dKFRWU7FZ2rVq6bpCcmwqHc8doSCNwvxUI+3FM+G/gaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nNwTsJOs; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nNwTsJOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791965026; bh=Q/W921yzorCyfDnHUE6gJSyS1WkeFGOaj5VDZkOcSSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nNwTsJOsWezX3ei6mDzk8RbcIY2pp78g4QKNjQvg+5o8PCu6+6hXTDGABrdkOSOqB
	 8X258OgWnu2jmUPXxITv7I1vcS8gogZ6gV4IlsKtR81GwqrixwpWwri65ttNSNOMe1
	 gzJPGq12nHMRDdHIJrRAftWXkeCxtEet0RbufIgU=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id EBAD8A1; Wed, 14 Oct 2026 16:03:43 +0800
X-QQ-mid: xmsmtpt1791965023tc2sf48gd
Message-ID: <tencent_A6CC872D2A2155E7DB68E4D889C9D42E2A05@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G9VEXcCy7VJlKCnmvndSppm5Lw90SiX26QQsR2vh/YLvnBt/QF6
	 dxZUFyaFPc5iYed6Yo016n1A+DQBrYe7Ar2t1ImOw2H2tjrMhYJ0+NkQA58dHXsOdswZZ08xf3XV
	 WfIUqt7qfItcQlK3PkbFUqYtX4yDb+HZ8w8j723Wczc05wjSYNRqbNnYB8YV8XVKuSzZDQYB0O24
	 tlL89UP5zApfQEOHFaQQNPOszeYHThyCzjEoqV4X6RHg1eskl3vNXQmubkMJ/mEsRYcZlLX430mH
	 koTgzaduXMftp9xxn0Fm1HUSWffm3yQPRYgQY6xb4iCEulyXMPGb9BpD+uNZTWcIgpBsyjDHcomK
	 ckpov7Q/Kc8IyJiS2TDBN4nxHu6OuHvXPhjChOWIaZNFHAQ/dCdRmXi23DwKJJNYsSZdEQwT0Il9
	 Ap/UIk1wrjCgeIbrx6cMzKQ3z4YtOu995KvfLqQMWtWndgcptesc0260YqOWYQi2l2SSkXH6lbsI
	 ROgKd4DszJi+Z1bU90uvg+dPkyuzC+n1GbyzWmfjJRFRBH65z/T4FRnHVkXS3IVSWJve1UMhvUDn
	 zGJUUwnhuSjGBFnaW7D5j/Gs2+ZyiWj7NwWRP7+2qDApEexKP1T/6v2pVAHKFuQBuk5Zf25+3tXj
	 9T6QTMd7CBs2kc2seQu7HeCPpMFg9Bh9Rg15vyub5GTT8zjhSj61ATnUOia+15Ui3wrVGhdYoyyD
	 sx3hEFpuZZC6EtQRJV4h11RnCw59aFok7Lj86YohKR7a0Ie3WPOs4tUZUdikUBZG3s1+VkIe7lfH
	 u430t1jT/HCz4OY8x2fWKJs6B6d4FI54oJVCjKOMIDvc1B/b6iH+PuJc0pxPLAYE7ABAjQArO725
	 /i8z3vdaA2V8HSB9KrBeh4j4/fUCo5j1EcRgDVq3wr1Z0cvJ5GHsnmFTU9/NFV6M9lRc1x3p1rDa
	 adYvOzeZFmkP4U4BW1pxA3wH3SO794FWYvPXpuBdz+CNAIzvYgpkCfhdD3ITvIDeyn3Ku2vnP3vc
	 Y+7tJLV7CUjxlBIaf5qcX5hL4WyzUpM9qSCLwuQi5SikCOb1gWdUqJnE8DyXIncGwuxcD8EFTYwS
	 v5WZ8nsa5vUZh1Eo0=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: yangguikun <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] hfs: initialize B-tree inodes and validate catalog CNIDs
Date: Wed, 14 Oct 2026 16:03:43 +0800
X-OQ-MSGID: <20261014160343.84460-v4-yangguikun19@qq.com>
In-Reply-To: <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com> <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com> <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com> <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hfs_btree_open() leaves the internal B-tree inodes with i_mode == 0.
A crafted catalog record naming CNID 3 or 4 can return one of these
cached inodes through hfs_iget(), triggering VFS_BUG_ON_INODE() in
may_open() with CONFIG_DEBUG_VFS=y.

Initialize the B-tree inodes with S_IFREG and their address-space
operations before publishing them. Reject attempts to reuse an
already-cached B-tree inode.

Validate catalog CNIDs and record types before the inode-cache lookup,
since cached inodes bypass hfs_read_inode() validation. This also
prevents a crafted file record from aliasing the root directory inode.

Found by syzkaller-style fuzzing of v7.2-rc7.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/linux-fsdevel/tencent_24D928451FEFA8A35482EFFA9132A7305307@qq.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: yangguikun <yangguikun19@qq.com>
---
Changes in v4:
 - set a_ops in hfs_system_read_inode(), before the inode is published.
 - hfs_system_iget(): reject an already-cached inode (the original
   BUG_ON()).
 - document why the free_tree error path is correct.
 - add hfs_is_system_reserved_cnid(), as suggested.
 - hfs_iget(): also reject records that hfs_read_inode() would reject
   (CNID 2 typed as a file, for example); an already-cached inode skips
   that check.

 fs/hfs/btree.c  |  43 ++++-------------------
 fs/hfs/hfs_fs.h |  13 +++++++
 fs/hfs/inode.c  | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 37 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 41b4e8f..454caa1 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -155,44 +155,13 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->cnid = id;
 	tree->keycmp = keycmp;
 
-	tree->inode = iget_locked(sb, id);
-	if (!tree->inode)
+	/*
+	 * hfs_system_iget() releases the inode itself when it cannot
+	 * initialize it, so there is nothing to iput here.
+	 */
+	tree->inode = hfs_system_iget(sb, id);
+	if (IS_ERR(tree->inode))
 		goto free_tree;
-	BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
-	{
-	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
-	HFS_I(tree->inode)->flags = 0;
-	mutex_init(&HFS_I(tree->inode)->extents_lock);
-	switch (id) {
-	case HFS_EXT_CNID:
-		hfs_inode_read_fork(tree->inode, mdb->drXTExtRec, mdb->drXTFlSize,
-				    mdb->drXTFlSize, be32_to_cpu(mdb->drXTClpSiz));
-		if (HFS_I(tree->inode)->alloc_blocks >
-					HFS_I(tree->inode)->first_blocks) {
-			pr_err("invalid btree extent records\n");
-			unlock_new_inode(tree->inode);
-			goto free_inode;
-		}
-
-		tree->inode->i_mapping->a_ops = &hfs_btree_aops;
-		break;
-	case HFS_CAT_CNID:
-		hfs_inode_read_fork(tree->inode, mdb->drCTExtRec, mdb->drCTFlSize,
-				    mdb->drCTFlSize, be32_to_cpu(mdb->drCTClpSiz));
-
-		if (!HFS_I(tree->inode)->first_blocks) {
-			pr_err("invalid btree extent records (0 size)\n");
-			unlock_new_inode(tree->inode);
-			goto free_inode;
-		}
-
-		tree->inode->i_mapping->a_ops = &hfs_btree_aops;
-		break;
-	default:
-		BUG();
-	}
-	}
-	unlock_new_inode(tree->inode);
 
 	mapping = tree->inode->i_mapping;
 	folio = filemap_grab_folio(mapping, 0);
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e250f87..ecdcf81 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -163,6 +163,18 @@ extern int hfs_cat_move(u32 cnid, struct inode *src_dir,
 extern void hfs_cat_build_key(struct super_block *sb, btree_key *key,
 			      u32 parent, const struct qstr *name);
 
+/*
+ * A CNID below HFS_FIRSTUSER_CNID is reserved for the system files; the
+ * root directory is the one reserved CNID that catalog records address.
+ */
+static inline bool hfs_is_system_reserved_cnid(u32 cnid)
+{
+	if (likely(cnid > HFS_ROOT_CNID && cnid < HFS_FIRSTUSER_CNID))
+		return true;
+	else
+		return false;
+}
+
 /*
  * Validate the CNID of a catalog record.
  */
@@ -219,6 +231,7 @@ extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 				u32 clump_size);
 extern struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key,
 				hfs_cat_rec *rec);
+extern struct inode *hfs_system_iget(struct super_block *sb, u32 cnid);
 extern void hfs_evict_inode(struct inode *inode);
 extern void hfs_delete_inode(struct inode *inode);
 
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2aef3c3..986a6f9 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -421,6 +421,97 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	return 0;
 }
 
+/**
+ * hfs_system_read_inode - read an internal B-tree inode
+ * @inode: inode to initialize, hashed by its CNID
+ *
+ * The extent and catalog B-trees are described by the MDB instead of by
+ * catalog records, so they do not go through hfs_read_inode().
+ *
+ * Return: 0 on success, -EIO if the MDB does not describe this CNID.
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
+		if (HFS_I(inode)->alloc_blocks > HFS_I(inode)->first_blocks) {
+			pr_err("invalid btree extent records\n");
+			return -EIO;
+		}
+		break;
+	case HFS_CAT_CNID:
+		hfs_inode_read_fork(inode, mdb->drCTExtRec, mdb->drCTFlSize,
+				    mdb->drCTFlSize, be32_to_cpu(mdb->drCTClpSiz));
+		if (!HFS_I(inode)->first_blocks) {
+			pr_err("invalid btree extent records (0 size)\n");
+			return -EIO;
+		}
+		break;
+	default:
+		return -EIO;
+	}
+
+	/*
+	 * may_open() requires a file type, and a crafted catalog record can
+	 * reach this inode by its CNID.
+	 */
+	inode->i_mode = S_IFREG;
+
+	/* Set before hfs_system_iget() publishes the inode. */
+	inode->i_mapping->a_ops = &hfs_btree_aops;
+
+	return 0;
+}
+
+/**
+ * hfs_system_iget - look up an internal B-tree inode by CNID
+ * @sb: super block
+ * @cnid: HFS_EXT_CNID or HFS_CAT_CNID
+ *
+ * Return: the inode, or an ERR_PTR() if it cannot be initialized.
+ */
+struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
+{
+	struct inode *inode;
+	int err;
+
+	inode = iget_locked(sb, cnid);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * The B-tree inodes are created once per mount, so finding one
+	 * already in the cache means the same tree was opened twice.
+	 */
+	if (!(inode_state_read_once(inode) & I_NEW)) {
+		iput(inode);
+		return ERR_PTR(-EEXIST);
+	}
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
@@ -446,6 +537,18 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 	default:
 		return NULL;
 	}
+
+	/*
+	 * hfs_test_inode() matches on i_ino alone, so a crafted record can
+	 * alias any cached inode.  hfs_read_inode() rejects an invalid CNID,
+	 * but it does not run when the inode is already cached, and a record
+	 * naming a reserved CNID would hand out a B-tree inode as a regular
+	 * dentry.
+	 */
+	if (!hfs_is_valid_cnid(cnid, rec->type) ||
+	    hfs_is_system_reserved_cnid(cnid))
+		return NULL;
+
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
 	if (inode && (inode_state_read_once(inode) & I_NEW))
 		unlock_new_inode(inode);
-- 
2.39.5

