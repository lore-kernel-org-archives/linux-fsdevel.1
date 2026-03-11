Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074935A39D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263630; cv=none; b=HH3+TepO7G3SeXq06Qd4Z+nGE7dcd3FYW4CE2Mdy9ofo6zE2K4AM5PYEiIczy48NESaiZMZqIvR683ts3cWrJ7KUdjQfi9nfiIINDggCT8qxZ8xmHwHWHQEG/qCdnxSHEesaWOtAE3TMZOclAE1WiZnLWJBnEbQHLhl1e1o5/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263630; c=relaxed/simple;
	bh=4thXmKGduhMDV98ppaj+5nyOXbkCKaeImokIjiD5w/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ir+8/S0njcMiN3on9IG3Zp8jJQTHuVW7FlrjmqYHEkYGvacFiQcZZuaxBlO84u+6VPEEkrYBUYwlur5zd+dDQki0yqRgBtzlr2gJnYEOs7RP6VeZ2io+r2dzAGId9e738jpx6DL2GCRtRTbfMXiAb1ljG2lDDV0X/ApJIu9AfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=XOiS04QL; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="XOiS04QL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1773263615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+TQrxR7flTMw8wFgYJ50RBayE6h3/sUUE+CKNjxcubE=;
	b=XOiS04QLk0bbc2C7agzU+va/E89ZYge5sBQv8Y0OgIsAxd5lpH/NzFPFM/4ZqA/LKsYhN2
	iWnqj01N6LVroAnk62Qxp2+Uo1+rynfm3YFLW1CraHUuQp8jdyEXqoYPGVX79aGsSFp3Ih
	6kokaFkRE+LBo81O+1G74Qh945M5tufqY+nYwQaMrYWoiUJWS8qEz4daripS2EQbqOE5lX
	QKfbIqXZ0nx/QhCzlOF1c93H6vag4ovimTaGWf0tI1H+KLvAZDK6aDlH38mUau/EVnOtq0
	sNq3ZeIFHQcxMFDEz80h6S6j2j3XdPpRLJRQB6otONlZsvII8X2eUrQJlirRvQ==
From: George Anthony Vernon <contact@gvernon.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: George Anthony Vernon <contact@gvernon.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Date: Wed, 11 Mar 2026 21:13:08 +0000
Message-ID: <20260311211309.27856-1-contact@gvernon.com>
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
Changes from V3->V4:
- Remove explicit "do nothing" case statement labels in favor of
  implicit default
- Check superblock for bad inode

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

 fs/hfs/inode.c | 65 +++++++++++++++++++++++++++++++++++++++-----------
 fs/hfs/super.c |  2 +-
 2 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..469ea6401d47 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -340,6 +340,31 @@ static int hfs_test_inode(struct inode *inode, void *data)
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
@@ -369,6 +394,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		if (!is_valid_catalog_record(rec->file.FlNum, rec->type))
+			goto make_bad_inode;
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -390,6 +417,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		if (!is_valid_catalog_record(rec->dir.DirID, rec->type))
+			goto make_bad_inode;
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
@@ -399,8 +428,13 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
+	make_bad_inode:
+		pr_warn("Invalid inode with cnid %lu\n", inode->i_ino);
+		pr_warn("Volume is probably corrupted, try performing fsck.\n");
+		fallthrough;
 	default:
 		make_bad_inode(inode);
+		break;
 	}
 	return 0;
 }
@@ -448,6 +482,11 @@ void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
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
@@ -460,20 +499,18 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
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
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a4f2a2bfa6d3..060421770147 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -369,7 +369,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	res = -EINVAL;
 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
 	hfs_find_exit(&fd);
-	if (!root_inode)
+	if (!root_inode || is_bad_inode(root_inode))
 		goto bail_no_root;
 
 	set_default_d_op(sb, &hfs_dentry_operations);
-- 
2.53.0

