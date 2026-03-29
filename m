Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D77288B1;
	Sun, 29 Mar 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774818026; cv=none; b=I2eq+VhiNFHHeR6aN1fqP3iET0tYk8ojIilI2nXegJqySIgSwbjom1EX29OQ5/LHc9EOgE+JLvvMeIoQUxxUfWqsLLvyQXMiHt5in8Q/TCL1e0QF0RLXhYSn89aHtpzOSdwY610ZkXqKNO+iLhyuQYywB/vNCzR0oQhdf6Vqny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774818026; c=relaxed/simple;
	bh=VgaEc5WygRxqzDIHpPNqToej6+br4NkW6t3d7s+WGow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuqyiG7X+TTnZPhO4KvGbh4Ba469U7CpdFTgIosgeCr/2d76D5R9GL7sIa2k1B4R7coqL453A26qaXWcQpEgkNZJyQncRbXYM2fou4WgshZHUDKhX2qs21p5J6nTScHvlKMbHIMK7zDdvx14WUY5bqUjnbDWNDb4xMA4QkS8lC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=b5hiMcYw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="b5hiMcYw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1774818021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tkfmoKTV0gg3zyPU+VPykJYmn/8VVKbz5TP/SxmAkFQ=;
	b=b5hiMcYwJ9/fFHEHUpoDg33wkBntD03p5fcfCC6D3ILTFEoqPDkZoXul32ddjbT9wP/ssf
	nhIasI0upuazFgLr4JEV6/+/lSScbwbu4SDPRrBGSB/LeOkix4rjbTl/l2vz6jwBTL3hVe
	/rk1WaknFxaJp8CjZWZrDXuwyzOeOqmJqBuvCXo5oLid4t3AgSp/7164ocutfPWo6cRh1Q
	d4a1CFOtwXLBUApcoTdx6i6Zk2JbUnWsyHbiJ+SckxPqQdEfDVZECGn2XI1TT5NHlQd3pe
	vay3yA54uQaGF4YyxrKZQsET5L7zVhvu+r/0fXKaENGkjfV3sQP71t6n9WUY7w==
From: George Anthony Vernon <contact@gvernon.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	George Anthony Vernon <contact@gvernon.com>,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: [PATCH v5] hfs: Validate CNIDs in hfs_read_inode
Date: Sun, 29 Mar 2026 21:59:49 +0100
Message-ID: <20260329205949.701267-1-contact@gvernon.com>
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

This patch was regression tested by issuing various system calls on a
mounted HFS filesystem and validating that file creation, deletion,
reads and writes all work.

Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@
I-love.SAKURA.ne.jp/T/
Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---

Thanks to Tetsuo and Slava for the reviews on V4. All correct feedback
has been addressed. Tetsuo's patch to validate the superblock on read
remains a very good further improvement.

I have tested this with syzbot's reproducer and my own reproducer.
Previous patch versions were tested with Syzbot also, however I was
unable to test this patch version with Syzbot due to
https://github.com/google/syzkaller/issues/7025.

Changes from V4->V5:
- Free bad inode in hfs_fill_super
- Make sure cnid is initialised before accessing it in warning message
- Use be32_to_cpu helpers for correct accesses of catalog record fields
- Removed syzbot tested-by tag

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

 fs/hfs/inode.c | 72 +++++++++++++++++++++++++++++++++++++++-----------
 fs/hfs/super.c |  4 +++
 2 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..833261261aba 100644
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
@@ -348,6 +373,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	struct hfs_iget_data *idata = data;
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
 	hfs_cat_rec *rec;
+	u32 cnid;
 
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
@@ -369,6 +395,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		cnid = be32_to_cpu(rec->file.FlNum);
+		if (!is_valid_catalog_record(cnid, rec->type))
+			goto make_bad_inode;
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -377,7 +406,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 					    rec->file.RPyLen, be16_to_cpu(rec->file.ClpSize));
 		}
 
-		inode->i_ino = be32_to_cpu(rec->file.FlNum);
+		inode->i_ino = cnid;
 		inode->i_mode = S_IRUGO | S_IXUGO;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
@@ -390,7 +419,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
-		inode->i_ino = be32_to_cpu(rec->dir.DirID);
+		cnid = be32_to_cpu(rec->dir.DirID);
+		if (!is_valid_catalog_record(cnid, rec->type))
+			goto make_bad_inode;
+		inode->i_ino = cnid;
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
@@ -399,8 +431,13 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
+make_bad_inode:
+		pr_warn("Invalid inode with cnid %lu\n", cnid);
+		pr_warn("Volume is probably corrupted, try performing fsck.\n");
+		fallthrough;
 	default:
 		make_bad_inode(inode);
+		break;
 	}
 	return 0;
 }
@@ -448,6 +485,11 @@ void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
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
@@ -460,20 +502,18 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
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
index a4f2a2bfa6d3..18d49db551ac 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -371,6 +371,10 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	hfs_find_exit(&fd);
 	if (!root_inode)
 		goto bail_no_root;
+	if (is_bad_inode(root_inode)) {
+		iput(root_inode);
+		goto bail_no_root;
+	}
 
 	set_default_d_op(sb, &hfs_dentry_operations);
 	res = -ENOMEM;
-- 
2.53.0

