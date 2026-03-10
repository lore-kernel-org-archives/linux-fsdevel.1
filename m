Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDC9443
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101463; cv=none; b=ZuWxVZ8okgKajKdaXO6jUDT0vBcdcQcyV58PCqlsbDDheQi2eD8cUojYsMyjzlw5haMHjmmTJiorhheq7yzGZUHltW7Kw6FLnxQA4Xa21SFoCx03Iu9S8FdXUIzybpOLubEGwfhY1KUbUcYkzTic4LOZMJDjEPvw+xoHazQgRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101463; c=relaxed/simple;
	bh=pZgPnUhwQg9HrI4oR9YMCfRFsSIhjvnMQML6w1PM9cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDGUagHdUgo/JYwC2qcBJm9YzVzJeLPuGUVPTnaCJQi1de6n6A3bHLrXe2JX6k9Ezw1YYP+QpPcjdrr5bGmH5/73a8nqGbcf4iUm0aQ4lOT/D8RHvzFUk3UsKsL5OINpD2noGYJmkM3rIfPnlt+WzljN6Rb7eUTwDUVrtBOIN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=axF+0CYu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="axF+0CYu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1773101459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M/YA/+6tHG2nCCofZZDZQ0fIl3hIxYzvdSgk46xJWiw=;
	b=axF+0CYuVzV4REwKsgryhYlt56Bo5qhuIQYXPsEicQn+Pwgg7jQFO5SYitTxVp1WeCHpWj
	hpxRCw+jEsZrryjQW3phure8DrW7ldem/LFSkZIF08Pf1G+nOgbJBuJgAKxQNOcyJzgHNY
	R8xslpHBruLj1r9ZlfEt0UDZgD1gSiezA6YHxGSbjvr2RoA2mSYtnBdAfyZJfkBrJPrR/G
	6V8O25QZ9oJ7J6Xp3lOeurdd962aDpoJ0LCs0pNgtXqkenCahZQDP6vULbhSSdzIbfhK2u
	ZroPIyaSbAW7x6w52ibl+/uxzQnJaPjfJ8gHjjZwHV3rJsIgmcRzZsMfv5977w==
From: George Anthony Vernon <contact@gvernon.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: George Anthony Vernon <contact@gvernon.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v3] hfs: Validate CNIDs in hfs_read_inode
Date: Tue, 10 Mar 2026 00:08:23 +0000
Message-ID: <20260310000826.242674-1-contact@gvernon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

hfs_read_inode previously did not validate CNIDs read from disk, thereby
allowing inodes to be constructed with disallowed CNIDs and placed on
the dirty list, eventually hitting a bug on writeback.

Validate reserved CNIDs as specified for HFS according to
"Inside Macintosh: Files."

This issue was discussed at length on LKML previously, the discussion
is linked below.

Syzbot tested this patch on mainline and the bug did not replicate.
This patch was regression tested by issuing various system calls on a
mounted HFS filesystem and validating that file creation, deletion,
reads and writes all work.

Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@
I-love.SAKURA.ne.jp/T/
Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---

Sorry there was a long wait for V3! I have now reviewed the feedback
given in response to V2, which I very greatly appreciate.

Most of the changes here are directly implementing changes requested. I
disagree that CNID 5 should be considered valid and have added some
comments referencing the documentation. This is linked to the change
from is_valid_cnid() -> is_valid_catalog_record(). I believe it is now
semantically correct, because CNID 5 is a valid CNID, but it can not
belong to a catalog record.

Thanks,

George

Changes from V2->V3:
- Use HFS-specific references in preference to TN1150
- Remove Tetsuo's additional superblock check from patch series
- Rename is_valid_cnid() -> is_valid_catalog_record()
- Add static inline hfs_inode_type() helper function
- Do not BUG() on detected bad inode, use pr_warn()

Changes from V1->V2:
- is_valid_cnid prototype now takes u32 and u8 types
- Add fsck advice in dmesg
- Replace make_bad_inode calls in hfs_read_inode with gotos
- Reuse same check in hfs_write_inode
- Disallow HFS_POR_CNID, HFS_BAD_CNID, and HFS_EXCH_CNID
- Add Tetsuo's patch to mine and make it a patch series

 fs/hfs/inode.c | 76 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..db31b9840371 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -340,6 +340,42 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	}
 }
 
+/*
+ * is_valid_catalog_record
+ *
+ * Validate the CNID of a catalog record
+ */
+static inline
+bool is_valid_catalog_record(u32 cnid, u8 type)
+{
+	if (likely(cnid >= HFS_FIRSTUSER_CNID))
+		return true;
+
+	switch (cnid) {
+	case HFS_ROOT_CNID:
+		return type == HFS_CDR_DIR;
+	case HFS_EXT_CNID:
+	case HFS_CAT_CNID:
+		return type == HFS_CDR_FIL;
+	case HFS_POR_CNID:
+		/* No valid record with this CNID */
+		break;
+	case HFS_BAD_CNID:
+		/*
+		 * Bad block file "doesn't have a file record in the catalog" as per TN1150 (HFS+).
+		 * Inside Macintosh: Files chapter 5-8 tells us for plain old HFS:
+		 * "... the bad block sparing algorithm does not create any new
+		 * entries in the volume's catalog file".
+		 */
+		break;
+	default:
+		/* Invalid reserved CNID */
+		break;
+	}
+
+	return false;
+}
+
 /*
  * hfs_read_inode
  */
@@ -369,6 +405,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		if (!is_valid_catalog_record(rec->file.FlNum, HFS_CDR_FIL))
+			goto make_bad_inode;
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -390,6 +428,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		if (!is_valid_catalog_record(rec->dir.DirID, HFS_CDR_DIR))
+			goto make_bad_inode;
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
@@ -399,8 +439,13 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
+	make_bad_inode:
+		pr_warn("Invalid cnid %lu\n", inode->i_ino);
+		pr_warn("Volume is probably corrupted, try performing fsck.\n");
+		fallthrough;
 	default:
 		make_bad_inode(inode);
+		break;
 	}
 	return 0;
 }
@@ -448,6 +493,11 @@ void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
 					 HFS_SB(inode->i_sb)->alloc_blksz);
 }
 
+static inline u8 hfs_inode_type(struct inode *inode)
+{
+	return S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL;
+}
+
 int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct inode *main_inode = inode;
@@ -460,20 +510,18 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (res)
 		return res;
 
-	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
-		switch (inode->i_ino) {
-		case HFS_ROOT_CNID:
-			break;
-		case HFS_EXT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
-			return 0;
-		case HFS_CAT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
-			return 0;
-		default:
-			BUG();
-			return -EIO;
-		}
+	if (!is_valid_catalog_record(inode->i_ino, hfs_inode_type(inode)))
+		return -EIO;
+
+	switch (inode->i_ino) {
+	case HFS_EXT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
+		return 0;
+	case HFS_CAT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
+		return 0;
+	default:
+		break;
 	}
 
 	if (HFS_IS_RSRC(inode))
-- 
2.53.0

