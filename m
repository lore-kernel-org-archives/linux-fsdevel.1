Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACA37A4AB;
	Sat, 17 Oct 2026 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214098; cv=none; b=DhCt/CTGLzEGfaGIqF8iCN7X0Nl+55aFAsFPSgmqbYqZwH3GmYxHXGuWRvmO0T1zA1FGrUHvydF3OjyZiPqroCBYbym+DeU3Hmr53NzK6m0VDYjlyvd9iTfxdCan/qctoYFngj1wrXq20oegWpx7r6XkYGDPnuD1iv1eh9LfnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214098; c=relaxed/simple;
	bh=L8wPbUwK7gP3tz71GUYU7reszJlST8t87w3EDL+FRko=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeDYtQk9ONgVXtn41imjFDwDfNlxHdZ5JP3GPXg+8xKUySwSe2J1laUz+ZUvJ31/PwggBKX8G/hYzR+zVk22T8zObkc7pqU75UtS040CuZ/u/SroTLk3hDQdL+7i3+ZESY0CYlIirEM7ta+6QHNf1Fqh2UwjVqCPIpMdoj09Tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=etKiXf3V; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="etKiXf3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792214082; bh=3MUILTUKwCrEVNT4m6haFoUahTeQOBu/qvTvIMYGUDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=etKiXf3VmLcH+4iSeNxcdDPJmUy/eRl0S4NIRtKmvFSGecSUOtHHs9RG2jrgRB/jP
	 BmCBmapdW8JDwGf0YYlkAeTmwxVXv9r43S/tqYhcT/LW07azZlLyE4OHIxqhZvyZ2U
	 V9YTbt5urLFGTyFM4ZdJ3YhtKcITWjedFK3tOiCM=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 3A8A3A55; Sat, 17 Oct 2026 13:14:40 +0800
X-QQ-mid: xmsmtpt1792214080thcfwnqix
Message-ID: <tencent_D7C3A89AD4D46F86915EA777538028349F07@qq.com>
X-QQ-XMAILINFO: NZFlUIrZ4HCZw/+vbjYMQNEqMPC/X0lBkt7I58MyhWwgwNjUBYSEQPyv/laE9o
	 udtixEbkUV2wgZh/KbG+kX12QVkAWub+oA+PZVBg0RnYGCcMCTnAGhsLDzV33gJO3VmjLcyZHBoc
	 dEbpwWhd8lL1I6P1gSNd8BPinwExE4+JwvEMVLxBuUMpwkwGFwSN+76Nm7Swo3DzycbTuE5dQFD8
	 IqVKkpM6xMdQtBFNH8B4njKHB6L7/pJW9YCURpRaHeKOV7JbFfxZKd0vI7KMTdIxX2fjMQxks7bM
	 bNCj7VMKeoAuy3CFuNGAnSciLRkyrLbe8e5w/wZ0PJXuSy8cbZUO1wa2Z8AblD0gfeSxCYzS4zX1
	 7JkLGQF+fkeEVorSPeHgb2gx/hJueWINkIxkoJOTQO3LHOuhOrqMI6uaPmBskPURqLwLy4+obK2o
	 BQyRGEQP6EcJc8vTkYmNueax7T7y1c+n63hkvuqslPxLuAtNm8j64VcMZdG+Nvp0ZGGPWhlIEwR9
	 WPNWGrqwttkEXTTmJU2R/Rg6htGf8YQywEXwk8dPP9yjZ1Yolf3QxUzxq250RbooTcCdXvutqxpU
	 GllJkrLPBs/3hKw6P5/E44I2DOMOprFFJlzHUA3JEc9OZgLq860o9wbd4LPcxSizX3NNTd4+txhI
	 acrdqdbWqS60R01Yvh8tqI5NqFNFjZOFGhhJXRcOquifvcDWrFyyjA56W0pwbYEgHg5n/0Kr3Xhz
	 fQGAqoBmTR2NjUw5Nd8ADTTQ0o3WteDa/RC3NH/FovPxNp3eUz8Kao4kR/1wq31kAfJy3ACvgqeM
	 3u9IIlXu7e12B97QBcBmqia0yEbZhBBsKCCosUxWRLvryaHiMrNXsMXokW7780G3VAGuWXj3iRVK
	 JVa8OxwWJXiqLWizHJFLsOaFrsJT/Cg+M0Kiw9BxzieNKKfrxwAw98wbJnnPHjYGtpmSbxB9+LDg
	 o+QwNtEyXLo9QeFHe5PlpHH2FqBDjJIQWdQ5qTlC0og6LKm5KCr7oPLWZfajdN5QiGCaOEt8HELs
	 hznqJD6/nWhxAQdygphHbKqf1Qk8gZ8P4ePOd5UsbGkfW7X88PWJDy7D1JsZfiipGOYAZXESSARj
	 0yxSWsWWZ2QlHcYFk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: yangguikun <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] hfs: initialize B-tree inodes and validate catalog CNIDs
Date: Sat, 17 Oct 2026 13:14:40 +0800
X-OQ-MSGID: <20261017131440.91180-v6-yangguikun19@qq.com>
In-Reply-To: <0ed462f8eb132699e04dfe458a69f28941d2069b.camel@dubeyko.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com> <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com> <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com> <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com> <tencent_A6CC872D2A2155E7DB68E4D889C9D42E2A05@qq.com> <b154a8939a2dc819bd011a502f835d9377351a46.camel@dubeyko.com> <tencent_35A04F645468AAD977F1C899D38EA945D406@qq.com> <0ed462f8eb132699e04dfe458a69f28941d2069b.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Slava,

Thanks for the detailed review.

On set_nlink(): I removed the explicit call, but please note that it
was a no-op: inode_init_always_gfp() sets __i_nlink = 1 (fs/inode.c:238)
for every new inode, and the original iget_locked() path in
hfs_btree_open() never cleared it. So the B-tree inodes have had
i_nlink == 1 since before this series, inode_generic_drop() returns
false for them, and the final iput() in hfs_btree_close() already took
the !drop branch with writeback. I could not construct the
still-dirty-at-put_super scenario outside of an error in the umount
sync; if you have a concrete case in mind, I am happy to test it. The
redundant set_nlink() is still worth removing for clarity.

tz_secondswest is only consumed by hfs_revalidate_dentry(), which runs
from dentries; the B-tree inodes never get one, so I removed that
initialization as well.

I will use the WARN_ON_ONCE() form for the already-cached inode case.

On hfs_iget(): agreed on both counts. Returning ERR_PTR() lets the
corruption cases (-EIO) and allocation failure (-ENOMEM) stay
distinguishable, and both callers currently guess: hfs_lookup()
translates NULL to -EACCES and hfs_fill_super() reports -EINVAL.
minix_iget() already works this way. In v5 I only did what the v4
review suggested (-EIO), but the complete fix is the ERR_PTR()
conversion, so I reverted the dir.c change and will send it as a
separate patch with the caller updates.

Patch v6 follows.

Thanks,
yangguikun

From 014ad11799ffc5fb857c23337e26121ee571f76a Mon Sep 17 00:00:00 2001
From: yangguikun <yangguikun19@qq.com>
Date: Sat, 17 Oct 2026 01:49:17 +0800
Subject: [PATCH v6] hfs: initialize B-tree inodes and validate catalog CNIDs

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
Changes in v6:
 - Drop redundant set_nlink(inode, 1); the link count remains 1.
 - Drop tz_secondswest initialization for B-tree inodes.
 - Use WARN_ON_ONCE() for an already-cached B-tree inode.
 - Defer hfs_iget() error propagation to a separate patch.

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
index 2aef3c3..a66de7b 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -421,6 +421,69 @@ static int hfs_read_inode(struct inode *inode, void *data)
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
+
+	inode->i_uid = hsb->s_uid;
+	inode->i_gid = hsb->s_gid;
+
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
+	if (WARN_ON_ONCE(!(inode_state_read_once(inode) & I_NEW))) {
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
@@ -446,6 +509,11 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
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
-- 
2.53.0.windows.1

