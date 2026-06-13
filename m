Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033D33D4F8
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329632; cv=none; b=Y2PtY+hzhOfr4E+Uec+/bfgaTGCL0Yum38O7vy92+Vnnqk6zRZ/8i49EGn9QspbFob5WRjd22Zw6DKrZFaOQ9sMKycXtTWgfya3eSc+KNg1dQJlI2+H7+LDuDTeABMPPp6eQu+aZEOzeB1M3C5lwsPfTQDQ4m/qcSAUOUVhOCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329632; c=relaxed/simple;
	bh=AOjEqPKCQrqTGh0pF1cuCKakr5rY3HnUPP7+WPrhGqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdXIyzRT6uiDZTp7W0QygXRXMofKm64skRlJ1dDUjFq5XbpGBgxBIrFePGObqYOIxLGq+Bzzh7SXz9c/es3hvCwLtw9c+Kd0lHGY+XlvAiuvzhbeLImJ2qqOkUptwQlpZRJFqktrYG4Fk+I1QWiKbCNXQ7zC5MMQLDtVSu6VaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWnrGuCC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWnrGuCC"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8573e75425so646109a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 22:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781329631; x=1781934431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwnshp7zR4sNT8SWmjVGKqVi8Bk3S1osxU+32NV0AD0=;
        b=ZWnrGuCCXCVoFfYZSflYjDgh33nWHm8aQZeqGtm8P3oPGrVANu5/+HRsFIaNo+sLIl
         PvgieRIC8Opc7YtAh7m/oSCuQ99Ol8fZKdiSd1cQ5c4++M/xoewrW/Lncjezi83o7pho
         LnLhljXGHP+wDSDGCZOcfvf0gF2eRM9bxxbU4/o0jB3P+JpcyepuptcMWoEz3JrC5F/C
         b3WU8+5eIL8BHmyPEmrXfcwwzhGzdXdm9ObxjVm880AhjBk9TUQRwPVuae8Pn46ARpCs
         WR5s64s/knEWpCMAfZSSul0XT80dwNhmleQ5BNz+KreDwlW84QieK1eSOFdMxzSIf5fF
         GdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781329631; x=1781934431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dwnshp7zR4sNT8SWmjVGKqVi8Bk3S1osxU+32NV0AD0=;
        b=UYns8/K6yLorOx6Qk0gc1YrszUaC6K88DW57Jo2jbE7wO6uvmo7wIhW4zg+EgmUb3x
         jdoXuStjcXQxjmWWNNR3sPU1jUT+RQzoYiAPFboEOPn/xikPNcPbn9WXizfazaRkry0w
         pDzlqVJCzfgcT0CouzrvxxxN7b3FHM7fgdl4M/G7sxoJIo37EkJJvzTJfsnGDH7NDX3o
         rQ2wCd20RugB3aeg7OFCvBWkmYX6p6gaPuXaxxjyC6QKnebTS5xFsmHBv6g7hqK51IdR
         HHEy4z1b3OqB3RsDqwaf5PnLgSTtAKmPtSYRf10foNTcvS0V5FxnZYtbZviI2cnLsRJX
         tUTQ==
X-Gm-Message-State: AOJu0Yy92eNOlCWWrafQj5azFU2ZaA9K85pW6g/GSV37Ly8usI9sC2hc
	IZ07x/+NxJbMxIyBkj7eIecCLLXax8SsaLdrrz2MP4CbqJGD8A/McWTh
X-Gm-Gg: Acq92OGrVfO+edDTBFTZXOiAOOI/EDEc3f8PY7WW9UWj74Kyekt/tSoSk6Rr66d3ys6
	wYQgtUFKekJWIWUkp3SgD9GCj3j4j/lA3shqf9WkpTRDGfCTfDFQDU5FM7ndBHylUelfhmY4mr8
	q70Gkv1LJ7ktYuCqE0ILem2yYLQAGy6D2RlUCinKA8W5EXvb+yZJ4dZc3/c1lUFWC4KVv5pwspr
	jIzp7atfPrRFaVfLMfZhkph1UekKkN9gRBvsD7+kcmucsSsMwkQ9WEEuxlAEKWdXjVhxIaw3w3d
	AAQY/IWTdH5YW0ygNAMl6f1wLaMOoyTWA2LJL24ItH7rBm5rg/MSkZhb+h+unA3sGbM8ANfzG7D
	Obj9Q3zCVh1wH5EEZBEFwkd1kf6RE9cSu8pobaelRNfZ1Q82y3CgTC0X+fMS6oakjVAsOIjB+iO
	1Zvm/e48s0det7zpSPGwktjVhh7EF4XQOuzk6Pjm0S
X-Received: by 2002:a05:6a00:4fcf:b0:842:5711:9a2f with SMTP id d2e1a72fcca58-8434cf4f362mr6533389b3a.36.1781329630530;
        Fri, 12 Jun 2026 22:47:10 -0700 (PDT)
Received: from gmail.com (vps-787f8425.vps.ovh.us. [2604:2dc0:202:300::17a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acffd04sm3898597b3a.26.2026.06.12.22.47.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 22:47:09 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Sun <samsun1006219@gmail.com>
Subject: [PATCH v3] hfs: avoid deadlock in hfs_mdb_commit()
Date: Sat, 13 Jun 2026 13:47:02 +0800
Message-ID: <20260613054702.54437-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529103428.99099-1-samsun1006219@gmail.com>
References: <20260529103428.99099-1-samsun1006219@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sam Sun <samsun1006219@gmail.com>

hfs_mdb_commit() currently uses the primary MDB buffer lock as a broad
commit lock. It keeps HFS_SB(sb)->mdb_bh locked while it may also write
the alternate MDB and the volume bitmap.

This can deadlock. A corrupted image can set drVBMSt so that the bitmap
block maps to the same buffer_head as the primary MDB. The bitmap
writeback path then calls lock_buffer() on the same buffer_head while
mdb_bh is already locked by hfs_mdb_commit(). A similar locking problem
can also happen on valid images when hfs_mdb_commit() performs I/O while
mdb_bh remains locked.

Do not use mdb_bh as the HFS commit serialization lock. Add an HFS-level
mdb_lock and take it around hfs_mdb_commit() callers. Then keep mdb_bh
locked only while updating the primary MDB buffer and marking it dirty.

The catalog/extents fork records and sizes are fields in the primary MDB,
so update them in the primary MDB write section, not in the alternate MDB
section. The alternate MDB sync and bitmap writeback then run after
mdb_bh has been unlocked.

HFS_FLG_ALT_MDB_DIRTY is set together with HFS_FLG_MDB_DIRTY when the
catalog or extents overflow files grow, so the primary MDB fork records
are refreshed before the alternate MDB copies the primary MDB contents.

Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/all/CAEkJfYMB47v1yOWHB8q2dc8kf=uj-rLO=+yMyudwPguJ8Kd3jA@mail.gmail.com/
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sam Sun <samsun1006219@gmail.com>
---
Changes in v3:
- Follow Viacheslav's suggestion to move hfs_inode_write_fork() into
  the primary MDB write section.
- Rework the fix as MDB commit locking instead of corrupted-layout
  validation.
- Add mdb_lock to serialize HFS MDB commits.
- Keep mdb_bh locked only while updating the primary MDB buffer.
- Leave alternate MDB sync and bitmap writeback outside the mdb_bh lock.

Changes in v2:
- Added a commit-time guard before locking volume bitmap buffer_heads.
- Replaced the v1 bitmap byte-range check with a simple drVBMSt check.
- Reused the existing bitmap writeback size calculation.

v1:
- Initial mount-time check rejecting volume bitmap/MDB aliasing.

 fs/hfs/hfs_fs.h |  1 +
 fs/hfs/mdb.c    | 15 ++++++++-------
 fs/hfs/super.c  |  9 +++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..00651f42ba38 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -66,6 +66,7 @@ struct hfs_inode_info {
  * The HFS-specific part of a Linux (struct super_block)
  */
 struct hfs_sb_info {
+	struct mutex mdb_lock;			/* MDB operations lock */
 	struct buffer_head *mdb_bh;		/* The hfs_buffer
 						   holding the real
 						   superblock (aka VIB
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..c2f4bda6fd00 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -291,8 +291,9 @@ void hfs_mdb_commit(struct super_block *sb)
 	if (sb_rdonly(sb))
 		return;
 
-	lock_buffer(HFS_SB(sb)->mdb_bh);
 	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
+		lock_buffer(HFS_SB(sb)->mdb_bh);
+
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
 		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
@@ -305,8 +306,14 @@ void hfs_mdb_commit(struct super_block *sb)
 		mdb->drDirCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
+		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb->drXTExtRec,
+				     &mdb->drXTFlSize, NULL);
+		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb->drCTExtRec,
+				     &mdb->drCTFlSize, NULL);
+
 		/* write MDB to disk */
 		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
+		unlock_buffer(HFS_SB(sb)->mdb_bh);
 	}
 
 	/* write the backup MDB, not returning until it is written.
@@ -314,11 +321,6 @@ void hfs_mdb_commit(struct super_block *sb)
 	 * files grow. */
 	if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)->flags) &&
 	    HFS_SB(sb)->alt_mdb) {
-		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb->drXTExtRec,
-				     &mdb->drXTFlSize, NULL);
-		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb->drCTExtRec,
-				     &mdb->drCTFlSize, NULL);
-
 		lock_buffer(HFS_SB(sb)->alt_mdb_bh);
 		memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb, HFS_SECTOR_SIZE);
 		HFS_SB(sb)->alt_mdb->drAtrb |= cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
@@ -360,7 +362,6 @@ void hfs_mdb_commit(struct super_block *sb)
 			size -= len;
 		}
 	}
-	unlock_buffer(HFS_SB(sb)->mdb_bh);
 }
 
 void hfs_mdb_close(struct super_block *sb)
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a4f2a2bfa6d3..06ab904b3a42 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
 	is_hfs_cnid_counts_valid(sb);
+
+	mutex_lock(&HFS_SB(sb)->mdb_lock);
 	hfs_mdb_commit(sb);
+	mutex_unlock(&HFS_SB(sb)->mdb_lock);
+
 	return 0;
 }
 
@@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
 
 	is_hfs_cnid_counts_valid(sb);
 
+	mutex_lock(&sbi->mdb_lock);
 	hfs_mdb_commit(sb);
+	mutex_unlock(&sbi->mdb_lock);
 }
 
 void hfs_mark_mdb_dirty(struct super_block *sb)
@@ -339,9 +345,12 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NODIRATIME;
+	mutex_init(&sbi->mdb_lock);
 	mutex_init(&sbi->bitmap_lock);
 
+	mutex_lock(&sbi->mdb_lock);
 	res = hfs_mdb_get(sb);
+	mutex_unlock(&sbi->mdb_lock);
 	if (res) {
 		if (!silent)
 			pr_warn("can't find a HFS filesystem on dev %s\n",
