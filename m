Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2C4A498D;
	Thu, 15 Oct 2026 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048037; cv=none; b=imVP76/Wwj94xT5z/dMxqsavH4nNaqUNk8QgOUba1Eg08PlvMYgaAiD5rpVSpkg7bPuW8gVF+Y0rDzB8P3y8HraDvJQNUdlDJ8FxRTD5gmkiM1hzvGKO+RPkOPMCpnppFxf/sBEkv3CmHeGwBQcoTZXcAvhphkjq/YFx5pNY28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048037; c=relaxed/simple;
	bh=opcHdVwSSRl3WV7wea/+3upLN1AdgSExbhroSPXCRUo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuzTuNWFxt8S+OOrMn1MTPY8vXXrOemjSUX6atLwDAkp1FfaO9NJ4s7IsWkFzd/QLeOTfEn0I6t4BX5Hyf1cAhtmf47bSBZZednw9aScZ0keeB6+nEgpShtUV+mmreOS8WIA4LlHU28E2r1inLNSjq5ubAzu45IoTNHLr9He8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rAYk/KhO; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rAYk/KhO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792048006; bh=VJNjF4hYwV/gzCx0plNWRdMcdWOICqfXCuydk1Mb5zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rAYk/KhOf8elFNxTO+buLnAjM0ScbEgm4HhRuEd8bmNROlyfaYcd34ss3OzzaWIeW
	 qFFBmt2erkR2m02pvG675wNLSpaU9V8OuqUEzwJrQQLkf/jmVaztMQ+vOObz1OzPqh
	 Ggj+wxwjoj60cDkEDuHkZp6P//ov3I0DxQdTl+UA=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 1AC330A1; Thu, 15 Oct 2026 15:06:44 +0800
X-QQ-mid: xmsmtpt1792048004tpnhgzu2k
Message-ID: <tencent_35A04F645468AAD977F1C899D38EA945D406@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe3/K9337Mnut62ugTanPQTVy1aMUGP7dTS4Esq0TvuNBCAtGaUi
	 9RblVnqj/pDLVl4HqbNZFqvoo69JnETCv8uYbixuQDViCTxmVzgJWTwbIVqQEYsN+flVC4wgjKd1
	 2J0TkFKY7MhUbbUiff7L8nNNKRMsASVckV7fiIamrhi1UjHS/i7oYyM8BKKPDWamfwBfTF+TY3TG
	 jXoUwi/BnGmYis2F8KcqW2Faf6oAKzmT6zT9aKyNs6ofP+ZVtYt9eB1F56UysqxsUxeOnptKnh+b
	 33dcdzPnljLaXYvSduwJS7+xckAWu9TuP4iMHCGsk1g0nDbKIynDa73f2YoqMrW/t6ehK7dSJB9c
	 dpmBA8Scz8nCVK+BjwHvTVDYzREpvpsvHlWqUpo7CvCYi4PvWSh+fFLtUwD2lkFBXVouKe+7d91O
	 oBCndwpoBjWJ1xQCfOYwB9usH+cF8nJemweNUVsieE6N5yiy0iyv3rdzK+1SDX1pQ0jILqBa7o0x
	 ceoPybIWmETD4UD2zcKT3x5YYUtFLkZJyUBOvI6e8Ct7llXEzqzoyya1Aboc6MIrCaQyiv6vLqiH
	 0H2UboG5GBJRMhiUlJvoS1QiPaTVW5bNmyf8vjC0SmG/ZATVldqcBihh+0o5hBNHD5p1n3IF3NVp
	 T6CKXwbtz6sfKv1BQEAWia9CiqNym+UNcIMktqkS7aR9tpJNu0zMOKYG4w/+j7/6BXAo1f2/wlJE
	 yUg5CCo7uy4opunlQ1YiC/qYDLwmg8I62Pb6TeSp8MFu6kpxBd7ZB/1Aj0bfs0Blqdhy74bvtbEL
	 VgPFK5aeQJtKmj2hT38ubdkxTnX5JJRKq0W+5HE2JAJ3OfvdUj0Oj30p/1LOmd18Zos8HPg7gzsM
	 vFDqmeETXLBbcII6HkVBjtd8fEpVQw+7rtpb5AvCAkxJeafn+A0gpvuJ1WQ+SSacbgdbwYOjfVDE
	 m7UjPI6eyzR6LAcgDOSC7ogorRZ+H2nRbPFSt9bqEv2IG5GLtLgdbz6feFjg4USaUtKse24x76/a
	 Ta+IU9nFHEQcR9TPWe9mi0PqpKojyxeQoJgG4/CUJDf2WZSYd/VKvgoWqDNWRhQx0c8ChKSw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: yangguikun <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] hfs: initialize B-tree inodes and validate catalog CNIDs
Date: Thu, 15 Oct 2026 15:06:44 +0800
X-OQ-MSGID: <20261015150644.61924-v5-yangguikun19@qq.com>
In-Reply-To: <b154a8939a2dc819bd011a502f835d9377351a46.camel@dubeyko.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com> <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com> <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com> <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com> <tencent_A6CC872D2A2155E7DB68E4D889C9D42E2A05@qq.com> <b154a8939a2dc819bd011a502f835d9377351a46.camel@dubeyko.com>
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
Changes in v5:
 - Remove unnecessary comments.
 - Simplify hfs_is_system_reserved_cnid().
 - Move i_mode and a_ops initialization after set_nlink().
 - Use -EIO instead of -EACCES.

 fs/hfs/btree.c  | 39 ++-----------------------------
 fs/hfs/dir.c    |  2 +-
 fs/hfs/hfs_fs.h |  6 +++++
 fs/hfs/inode.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 38 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 41b4e8f..1891ad5 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -155,44 +155,9 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
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
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index e1f1fb3..0a31304 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -36,7 +36,7 @@ static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
 	} else {
 		inode = hfs_iget(dir->i_sb, &fd.search_key->cat, &rec);
 		if (!inode)
-			inode = ERR_PTR(-EACCES);
+			inode = ERR_PTR(-EIO);
 	}
 	hfs_find_exit(&fd);
 	return d_splice_alias(inode, dentry);
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e250f87..8d52170 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -163,6 +163,11 @@ extern int hfs_cat_move(u32 cnid, struct inode *src_dir,
 extern void hfs_cat_build_key(struct super_block *sb, btree_key *key,
 			      u32 parent, const struct qstr *name);
 
+static inline bool hfs_is_system_reserved_cnid(u32 cnid)
+{
+	return cnid > HFS_ROOT_CNID && cnid < HFS_FIRSTUSER_CNID;
+}
+
 /*
  * Validate the CNID of a catalog record.
  */
@@ -219,6 +224,7 @@ extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 				u32 clump_size);
 extern struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key,
 				hfs_cat_rec *rec);
+extern struct inode *hfs_system_iget(struct super_block *sb, u32 cnid);
 extern void hfs_evict_inode(struct inode *inode);
 extern void hfs_delete_inode(struct inode *inode);
 
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2aef3c3..5a03fca 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -421,6 +421,72 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	return 0;
 }
 
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
+	/* may_open() requires a file type */
+	inode->i_mode = S_IFREG;
+	inode->i_mapping->a_ops = &hfs_btree_aops;
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
+	return 0;
+}
+
+struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
+{
+	struct inode *inode;
+	int err;
+
+	inode = iget_locked(sb, cnid);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
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
@@ -446,6 +512,11 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 	default:
 		return NULL;
 	}
+
+	if (!hfs_is_valid_cnid(cnid, rec->type) ||
+	    hfs_is_system_reserved_cnid(cnid))
+		return NULL;
+
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
 	if (inode && (inode_state_read_once(inode) & I_NEW))
 		unlock_new_inode(inode);

