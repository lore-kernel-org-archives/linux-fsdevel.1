Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7412E49739A
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721534; cv=none; b=MQ3AmxxxYJykmggFIuU+8e9Sv6/3aZjQseBill22zisagtukgB/RKLYC8nxKyw0mfMpJmlFAe3qvRimVusyUfXgG1YLljve5y3aKEk54cZwk86Zd/sAe4zrzqw1kxMCAgCfL8Twytx2DGdVHLVhbAD3jumL9xFalzbHkfx6LFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721534; c=relaxed/simple;
	bh=y+BnAAozpYhhFlk0zWtnIJ9ZjQg831PHf3+20180TuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpJ0EmgJlUxXBMpm5WS2/xeUmE1waSqX/GH6vuDiGrOMYX15dvpOAcZ/mNlKK+nm92G/VCbHhSx0e6REAfMt4KZWbZeYdFLKxIzYwmmBSxcsFlLVXbFmJfpcOQmdDEWP6sUlnkYMQmOGjrvezmYTXJVguPVvlZKX5x0Ewg1PtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibwGW4fK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibwGW4fK"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso5503015ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789721533; x=1790326333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/PzL4UemwPCscHYaoYsX505aZOB74TtICtM5jQVGvg=;
        b=ibwGW4fKaCO8NwxMf45FOU1DxYOMJZy4ud9+806x7x3p2d8PFZiTx9xwpN0tQszP5j
         w/iQDblWThTUUaZP7cd+hccCWcqhCgLirJ/vPS3O8c4OtR9xiRbZjCMtwdaY+AiojkvF
         uxKLBJY+Ja6Woqx5RTpmnq4TX7t/gqrC9hCUOj6jIm8szifc9LP4ZKBaQUsuuyQGzcSo
         uoj4FUQ4ce6Zy1c6KVKQ7jeHiCJzaTYOgHb0D3KSiJyy0+3PZMgglgTPz96rgoUyd5Bm
         3coQgFSt6ol6vK2VRHgvP1irV6j7hQJZto+Vsq9bzEirz/864dx2SrDyS/uP8RYs8eAv
         yRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721533; x=1790326333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/PzL4UemwPCscHYaoYsX505aZOB74TtICtM5jQVGvg=;
        b=Vod/BG4y+3HT8z+yMDQ+mMi8P1a7h7EAxy6owh/58tovamCBPAuXZ5S9vJco+cR4a+
         Ji85A3tl5Kbjj4EA6gXKktzA9MMg3lD1hgRiUDdS+bjloYSZp/V6ABqnG3K7vPl4c7IU
         4r7vHPzSWSCAlwF7dgtexsyD7Tf5R+Mv53BGHThdZ4+CrP27XolXAxQ6GzzIrGN0pH76
         n1pbXtPkJOLUgmQLmxcsZjshZVRwLzqc/jvNi2uPzFhBMseKKjO98PpqMW8gW2tLQm4E
         a1TRVu5R2IG9dwwOgPiqlV8TQsrUYK987sSU4bMwh8yir/tZzJvbTGS3ec8tMwcirUW8
         OJQA==
X-Forwarded-Encrypted: i=1; AKwUvBxdiB5GUuKMZezON/sDLM7vrmmSC3zO2Cg+pn9nBB0Bxz+n1srPhpm3JDYLpOWFRYIjiRUGk2XGZDNeqlcx@vger.kernel.org
X-Gm-Message-State: AFuF++miGaLQrJxMigNmp+85E9piM+7c7dRE6z3f1CXKhJtz48bNbA9h
	HcN9C80HkfezsHdLm7pOSp3aiWbGltSAzlJhev3rGEMWv4sFsBveLADb
X-Gm-Gg: AYBFou2sr9OZiGPZtNLezrUDGziG8tpLRbRfghE9Vb2uAJbSr+1oz/jz15024PW6zJz
	cSFa3gc7egUEZSrKuVkaInV1XdEXJTdAWKrZyjfp+muSpR27uSkcSspVCpSwPVbXp40Qfr7OU/0
	31Juatv3OdmVaPWmQfihm1v5rxRGHxQcsdrHE6z5Ap3yk6cgKDggySWKwmYo82Vp67JFQGXdT8y
	SVx8CYjjHeaFe2uk9SRUO/j26h+hZIE13nhgcmjIV+AD043Z8k65xEwV2yA7aoY6ZbarzgLn3O+
	DS35qhEqX0NFur75cp63LSJEUncYiJKNWQPLL5X7gAdzAJgIe7UuQJ/2V+OyrtQKoum8eU7zodQ
	NpqGSHfUYAwKWZ2Yu5RmYveJoHuEKShMAoeKMxuQHfTsttdEfezPpov2MIlwyjWi8+/oVFfak0N
	MEXwSDsUgJm7rVkomKZyk1x8zw44xNXhxoCqv6phXWaTvmJNyqIw0oYsi9+LzQpzfSvcCJY/FWE
	W4+xI6PzhOs90VxaRca8LNjX6UfHGBe
X-Received: by 2002:a17:90b:2f50:b0:39e:14db:437c with SMTP id 98e67ed59e1d1-39e54cc2a95mr4621976a91.4.1789721532545;
        Fri, 18 Sep 2026 01:52:12 -0700 (PDT)
Received: from thangnn-Dell.vingroup.local ([202.60.105.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a0e860asm2516236a91.1.2026.09.18.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:52:12 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v6] hfsplus: validate b-tree fork extents at mount and inode read
Date: Fri, 18 Sep 2026 15:51:56 +0700
Message-ID: <20260918085156.920842-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate fork extents during inode reading and mount time to catch
on-disk corruptions early, returning appropriate errors and marking
the tree as corrupted.

v6:
 - Move fork validation logic into inode read fork function.
 - Refactor extent validation helpers, use volume_blocks, count == 0,
   and introduce HFSPLUS_EXTENT_LAST_IDX named constant.
 - Return error from hfsplus_inode_read_fork() to allow hfsplus_iget()
   to catch on-disk corruption and propagate error correctly.

Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 fs/hfsplus/extents.c | 41 ++++++++++++++++++++++++++++
 fs/hfsplus/inode.c   | 65 ++++++++++++++++++++++++++------------------
 2 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d18..eaf3bed7ede8 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -16,6 +16,47 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
+/* Index of the last extent in the fork */
+#define HFSPLUS_EXTENT_LAST_IDX 7
+
+static inline bool is_extents_btree(struct inode *inode)
+{
+    return inode->i_ino == HFSPLUS_EXT_CNID;
+}
+
+static bool hfsplus_extent_valid(struct hfsplus_extent *ext, u32 volume_blocks)
+{
+    u32 start = be32_to_cpu(ext->start_block);
+    u32 count = be32_to_cpu(ext->block_count);
+
+    if (count == 0)
+	return start == 0;
+
+    return start + count <= volume_blocks;
+}
+
+/*
+ * Returns 0 if fork extents are consistent, -EUCLEAN if extents
+ * past the first are corrupt, or -EIO if the first extent is corrupt.
+ */
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext, u32 volume_blocks)
+{
+    bool non_zero_seen = false;
+    int i;
+
+    for (i = 0; i <= HFSPLUS_EXTENT_LAST_IDX; i++, ext++) {
+	u32 count = be32_to_cpu(ext->block_count);
+
+	if (!hfsplus_extent_valid(ext, volume_blocks) || (non_zero_seen && count == 0))
+	    return i ? -EUCLEAN : -EIO;
+
+	if (count > 0)
+	    non_zero_seen = true;
+    }
+
+    return 0;
+}
+
 /* Compare two extents keys, returns 0 on same, pos/neg for difference */
 int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
 			const hfsplus_btree_key *k2)
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 2ce6de574fa6..aa201f4e80d5 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -559,34 +559,45 @@ void hfsplus_delete_inode(struct inode *inode)
 	hfsplus_mark_mdb_dirty(sb);
 }
 
-void hfsplus_inode_read_fork(struct inode *inode, struct hfsplus_fork_raw *fork)
+int hfsplus_inode_read_fork(struct inode *inode, struct hfsplus_fork_raw *fork)
 {
-	struct super_block *sb = inode->i_sb;
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
-	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	u32 count;
-	int i;
-
-	memcpy(&hip->first_extents, &fork->extents, sizeof(hfsplus_extent_rec));
-	for (count = 0, i = 0; i < 8; i++)
-		count += be32_to_cpu(fork->extents[i].block_count);
-	hip->first_blocks = count;
-	memset(hip->cached_extents, 0, sizeof(hfsplus_extent_rec));
-	hip->cached_start = 0;
-	hip->cached_blocks = 0;
-
-	hip->alloc_blocks = be32_to_cpu(fork->total_blocks);
-	hip->phys_size = inode->i_size = be64_to_cpu(fork->total_size);
-	hip->fs_blocks =
-		(inode->i_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
-	inode_set_bytes(inode, hip->fs_blocks << sb->s_blocksize_bits);
-	hip->clump_blocks =
-		be32_to_cpu(fork->clump_size) >> sbi->alloc_blksz_shift;
-	if (!hip->clump_blocks) {
-		hip->clump_blocks = HFSPLUS_IS_RSRC(inode) ?
-			sbi->rsrc_clump_blocks :
-			sbi->data_clump_blocks;
-	}
+    struct super_block *sb = inode->i_sb;
+    struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+    struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+    u32 count;
+    int i, ret;
+
+    /* Validate fork extents to catch on-disk corruption early */
+    ret = hfsplus_check_fork(sb, fork->extents, sbi->total_blocks);
+    if (ret) {
+	pr_err("hfsplus: fork check failed for inode %lu (err=%d)\n", inode->i_ino, ret);
+	set_bit(HFSPLUS_I_CORRUPT_TREE, &hip->flags);
+	sb->s_flags |= SB_RDONLY;
+	return ret; /* Return error directly to the caller */
+    }
+
+    memcpy(&hip->first_extents, &fork->extents, sizeof(hfsplus_extent_rec));
+    for (count = 0, i = 0; i <= HFSPLUS_EXTENT_LAST_IDX; i++)
+	count += be32_to_cpu(fork->extents[i].block_count);
+    hip->first_blocks = count;
+    memset(hip->cached_extents, 0, sizeof(hfsplus_extent_rec));
+    hip->cached_start = 0;
+    hip->cached_blocks = 0;
+
+    hip->alloc_blocks = be32_to_cpu(fork->total_blocks);
+    hip->phys_size = inode->i_size = be64_to_cpu(fork->total_size);
+    hip->fs_blocks =
+	(inode->i_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+    inode_set_bytes(inode, hip->fs_blocks << sb->s_blocksize_bits);
+    hip->clump_blocks =
+	be32_to_cpu(fork->clump_size) >> sbi->alloc_blksz_shift;
+    if (!hip->clump_blocks) {
+	hip->clump_blocks = HFSPLUS_IS_RSRC(inode) ?
+	    sbi->rsrc_clump_blocks :
+	    sbi->data_clump_blocks;
+    }
+
+    return 0;
 }
 
 void hfsplus_inode_write_fork(struct inode *inode,
-- 
2.43.0

