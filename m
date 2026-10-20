Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491580;
	b=SoBNW7ev1+ojWxgdwmJMPbFyitmSHyi47GEeQ21gysRSlnaqVtXeEIIuyRxHEvQ/dKx2
	 lOoeWHbIJ1j//w4zzNUI4NUTvOYFZqMp5KObs2ALuEldcjfx8orToyPpF+uNdiBfsz1Tq
	 ivk4ICRC3Ig2EKaqj9/oX7V/DiY4iCOdNIBNF4gquanTOdOR4tjZG4JJZqlhF9J9mlzbA
	 YL9+yWoHTICou7w3H8bJM6hyJXikkm+lh8PHUH0DYaGJnEjHbUWMT5CFKJ0MsEV96SHr2
	 zoRmAb945eUDoe6worPhtT8EcQNt0hzDSs4lVgyue5ee/IcpbzcFcmBsk5ncfRRctGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491580;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DaYL+lq2X1jkyL5DAV0JgOaO+hwBEe6efZ7/qxEoSk4=;
	b=nHX5Os1GpxCHMbobzFh7FBvZ80cyA4sh/QLXvG2gLL19biF9inwRKatlDf+szn6Nw+sb
	 Z0xJxNvfaX4YFn+cd3lxeVZZ0clqB2VuGd/chCYt+QBLqgq3PStoeXiQ8fsVZWUPYTEMK
	 O3kI4QgeuPnP+EdMALUPrVTZtZpKpzf5ZrR7+VdNeeIsmsfrUwsnol9rNwzgkroQX/8th
	 JOfeIKRFG17NPzvz1DVy2LHvTrM5cUtfTj/A3093cTZLh29jrY32oqkfygQuDrMHb7XJu
	 EV5TcqY+OKikQuAswKTKfa53l/s37ZZ62Ca+ClOHwx3hOg+dQyQ8fK/MEyYbuKD1fBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WFQxwIvq;
	arc=none smtp.remote-ip=203.205.221.202
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A7606A31B;
	Tue, 20 Oct 2026 10:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824A7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WFQxwIvq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792491575; bh=DaYL+lq2X1jkyL5DAV0JgOaO+hwBEe6efZ7/qxEoSk4=;
	h=From:To:Cc:Subject:Date;
	b=WFQxwIvqXYvgxkRhBXt0IY2eCVjCQxN4tygHLfyeB6Ld/8sBzk3Ci1sYkCGEprbr6
	 FUocmCdC3PLyim5yX8GPY4zrH4To201PFDQwqCVJv1vgjoCn0e8CD4Cp3uC0Dv8fSE
	 XFrGVZiQ8A0xVMnYQUIxpyYSHSP2PRIXzNY4tUVc=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4E1B60EE; Tue, 20 Oct 2026 18:19:33 +0800
X-QQ-mid: xmsmtpt1792491573t30mnsrro
Message-ID: <tencent_63539C28151F9BA8C854BF6FAF9101A72707@qq.com>
X-QQ-XMAILINFO: MipYEBg1qKqI2mwv4N+CJ2cDOe962AMH64FB71X/1VumkB693IqGWhfmqeVdBk
	 JF5+Nc2qgkowGV/6/6cSTFh+/2TrH90Hu2yE5BKhAkBVht9zLwibhO7D04E80a5pdFKzxHolShlC
	 p7yBUKLAZ+mBdVjxPXs7V1C1SysdaRp20qsKO+8Z2wAbVQp2eCGl19WZnlvI1z5/k1Uiqa/JzAUo
	 c9svj0GDXE71+JIZ4RXQbCH2UR/lrcsDiyTCulQeO2Kkb3dgBp15MCp0ZUYKRLL68BDyJJWjn7QZ
	 r7DYpagRKlRjaaE+5fVwc0P+wCvWsTMClfnMEihOw+1pOFRVynTSrYp4iTX6H3jf6wyx6TQUXhsR
	 pRVIpGdgQGb2MAg1gyqXuk5Tvd5VFjnecBHlmhfAUWNnpQBOV//Knm8etVRyNOOPOW4AYWSiluQx
	 1x2PHIBtPil1kXZeKHEy1RvYZlrPrn/63L8oYnnhwtlsDfrzGhL/yMv1gQAQZ+T79j342SA4mw0j
	 H1Rd+ZGSpYGaCQdLMpiSKvLQV7lLChBHz9PtI9Ffq/LwVvQvYerP7fDP7iSkL6XEW5OwV4N1XUkp
	 8s5MHqI4WSjzlgFFEAUfxkAMyH0D5iytmEHc/eyNp3Vf+jhNJQdDoulms7gxPMScIL3Yu8xPcARj
	 OEFv/GZ/HtaxUDq2s8XczOVWcekUE1XgaNIcOcoVHMboafFSjCWEH/0PlaFHY2G9+siTX7JQPYW/
	 AN7y+OC450nnVmbJCRmOrIhzarWzLps1tgP8a1AHF67ml7WqtLXrlJI8WWgY2amZKB2brms8vzDv
	 fryXkopScdhbWyF60JcucXXj+Hdio3R3kT3MhLsO/Yleh6rXThfotq18XRyyQkFfJ7zPCzukVA3A
	 BA9PeRRJor+ZbQe9+piZSuNogmxmIcRJ6wzGEnS0Pmf4sj1Vf33JDSopkRVFG5+URGGW+cWoIGXH
	 UdTSzgoSPOMP1zuss1McP5GW0eX5GCUVQGfT8R64nVqjGAaUFlj3GQOGhq6r2iKdClVytBYjQMlr
	 Cu8rJpKsiX+Xaf8dKLIjUAbrnfUDwRCqHKy1UFHYErA5l+uzXYZmC9JxBlxnz+6WPpdxq2UxSQRe
	 +QCByBhVOMNTlbzGD93VlBW8aXWg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: yangguikun <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] hfs: initialize B-tree inodes and validate catalog CNIDs
Date: Tue, 20 Oct 2026 18:19:33 +0800
X-OQ-MSGID: <20261020181933.18360-v612-yangguikun19@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
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
Changes in v6:
 - Drop set_nlink() and tz_secondswest initialization for B-tree inodes.
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

