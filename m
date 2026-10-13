Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5230C37C;
	Tue, 13 Oct 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873981; cv=none; b=jOFemq4qXfTzNq3xPZHKjpWhsQahFHLZFSMbVtsCyo956HzHD4zwMjYFZa1cUOgzQFnUu7SbQECDdQ7AguypRD3DDUWpRGVPR2lirKrtFAJg0c4APqaha3/KD950F8N4rFdQ5sqdkpLDMC67Lqjkm0tfvPnqtWmglKub6BzQT1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873981; c=relaxed/simple;
	bh=9F5lYEbCXmw93zYDFhrQp2NfGyDOeAjykTP4ZcjvrNg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei4qLEDn8hq+54rIZCDg+bLK60UF4zAxNjbcJXGWeg2ZM8fOtbYkyl98MItPYbdNLLGrpZ9IxN7bNcfLpJ8K+Y2K520gHuJP8MfbHXn7M0Nj5cuwW/fuS9Vrj5sMFnTfHAXZlE/aWvlYy9nkAASSbzZo3m84Nc87AkUvKHDnrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=opD8L0UF; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="opD8L0UF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791873969; bh=zKKmVLulewA7HWX/v9UDW8EOo9mYFaQfpEtzozemk1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opD8L0UFGZg3Ub6E2rWAjGKkUtV4p0zYfxrSqrb9VQ0fEdNcWelPV0Pm69bUUw+yr
	 K1jcDJLM+QnZSDDD55h/TgQiPI9SNxb/fRxvQ4ztoXARtSZmgSvcxQGPsWzKkWMxO6
	 4D9JeS58Tus+uLBiX8OPfRRm2PWIW/ZRs5xMbf4w=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B3BA709C; Tue, 13 Oct 2026 14:44:59 +0800
X-QQ-mid: xmsmtpt1791873899tr852pbap
Message-ID: <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTpn8/Vy3mOgrDTE4YAvgok9CGlCMZHKBnikcopf987380BPiRiEf
	 /blFJkLSAJG6Yd3X0+Oa5xsZOkXAu2e8w8tw2rPUO8TCgPQ5yrdYzn3nqLMkc0TG43cRSXPUUCO/
	 ennThmEeDSIvbna5n8m4vRL5r5/WM/2ClYGzYnh0ieiNDNSEBYblm4hFLJZ33YkpWM76qTBdERoP
	 zLBMA7zhBfRGJS+g28XhvxkxJFfhqrfIPkRiBSiu2YeacmgquPAf2PEdQWlE2Y0aX2RSzeEGfz14
	 eV4nraJCz/01WIC5VrU/ouemTcPeUsiwM9+2ep/+sh6hl5a1vMOwHnL6H5UJ6Sy7sL1WR5zO6P36
	 WPqe+FXcvyoZpDbHT/ikemWe6LGtX9l1XNNeFIo8vzqpHAKZ6KbCflVm6pNkcRw0SnbSaxEXQGuk
	 vu1B3F+0yry8CBUf5f7MZ0imBftdrrj610CA9TpbOp3yIZYgxp5cTdOt4UhKUptAE79l7rTF3G8h
	 GHCEH0qhCqhHRyZhLnk1FI9G/iCp/7vfRqkHlegzk0auurFau7CoI9q0cKf9IdRNVxq4jBbSzOEX
	 ymNFJ/EIsPQE3ZkMJIzi7BRoYssC5M6gjRghCWCxaxEG7fVOxme8VyTpR3c+/g9mPjWiA0DOZGjK
	 oDWi6VrIyVwwDJ1o9KaK+OeLJQHyTwtnsDpSUYlm4zQxuD2yYWL97KjNF0E7ZsP4GYemEN7bfD+b
	 evfiw+7R9t+qXY4uUJZhBeXvN+pYUYkZGuuA9fDDQKan5cJhbnYjt2EW8XpWjG76ug5JtptXLpcj
	 NG1ifcSI58HwaNYxOEFndqa/kNHgOSmjiy0Q67Ewoupu97RuuxwHDmHFasioK0Dw01AaxsjNGbdI
	 Fz8sTqILMM+Gey1P1SE2zY/vev4q0A3hccJxBfXCy37XEAI2lUGVjFukv8S0WbX4DHLMXIiKXQaZ
	 wNEts7kPum8FMOSTXP+f4rF4Hh1V4wRM+Ke/8KE9bqFM+wpNcImZib/o0qghNTv+zUseRR/NtzPU
	 njnu1IS2bVqPalXvoheGmVhCtKhGpttIapNrsiE71Jb5m/x/WDOt8bM6RqxVMzJImco+BlYarjCG
	 pQDWDYkkksF+fmhe6wzZESN2rs/A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: yangguikun <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] hfs: give the internal B-tree inodes a type and keep catalog records off them
Date: Tue, 13 Oct 2026 14:44:59 +0800
X-OQ-MSGID: <20261013144459.38872-v3-yangguikun19@qq.com>
In-Reply-To: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com> <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com>
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
i_mode == 0 after every mount.  Two problems follow from that, and both are
reachable from a crafted image.

First, a catalog record that names CNID 3 or 4 makes hfs_lookup() -> hfs_iget()
return the cached B-tree inode - hfs_test_inode() matches on i_ino alone - and
the typeless inode then reaches the generic open path, where it trips
VFS_BUG_ON_INODE() in may_open() with CONFIG_DEBUG_VFS=y:

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

Second, once the inode has a type, such a record still hands the internal
B-tree file out as a regular dentry: it can be opened and read, which exposes
the B-tree, and from then on the VFS treats an inode that has no catalog
record behind it as an ordinary file.  hfs_is_valid_cnid() does not close this
path: it runs from hfs_read_inode(), and a lookup that hits the already cached
B-tree inode never reaches that function.

Fix both.  Add hfs_system_read_inode(), which reads the fork from the MDB and
assigns S_IFREG - the counterpart of hfsplus_system_read_inode() - and
hfs_system_iget(), which looks the inode up through the normal inode-cache path
and can fail before the inode is published.  hfs_btree_open() now uses
hfs_system_iget(), and the extent-record validation moves into the new read
helper.  hfs_iget() refuses catalog records that name a reserved CNID below
HFS_FIRSTUSER_CNID; the root directory, the one reserved CNID that legitimately
comes through there, is exempt.

Found by syzkaller-style fuzzing of v7.2-rc7; still reproducible on current
mainline.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/linux-fsdevel/tencent_24D928451FEFA8A35482EFFA9132A7305307@qq.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: yangguikun <yangguikun19@qq.com>
---
 fs/hfs/btree.c  | 39 +++------------------------
 fs/hfs/hfs_fs.h |  1 +
 fs/hfs/inode.c  | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 41b4e8f..b5892de 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -155,44 +155,11 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
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
index 2aef3c3..5c00383 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -421,6 +421,87 @@ static int hfs_read_inode(struct inode *inode, void *data)
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
@@ -446,6 +527,15 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 	default:
 		return NULL;
 	}
+
+	/*
+	 * hfs_test_inode() matches on i_ino only, so a catalog record naming
+	 * a reserved CNID would hand out a B-tree inode as a regular dentry.
+	 * The root directory is the one reserved CNID that comes through here.
+	 */
+	if (cnid != HFS_ROOT_CNID && cnid < HFS_FIRSTUSER_CNID)
+		return NULL;
+
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
 	if (inode && (inode_state_read_once(inode) & I_NEW))
 		unlock_new_inode(inode);
-- 
2.39.5

