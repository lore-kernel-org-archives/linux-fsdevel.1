Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911931E82B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573084; cv=none; b=JT5TRkXdRyqfNfT0pr4kBbnW8g1n2Ek5NNW07DLpRWWn1rPwOAeHPDr47274x2fp7TYTiK81PDTRg/x4JQgdpAaf7gC59veWIlwNBRWmfALb3azDzSg16uD3NiYZrA8m6L7Di58qShK36/Wiv5D+xCqP9hDY5Nzr3QHlCetvGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573084; c=relaxed/simple;
	bh=qk86GJ0H5rk0eynLeHl77RF1W4O2c+Gdt5Vs1Hhvp2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcCHFADdd6XU2HtlNF7S9di3908hm1PAsT0qbjvvKGhJ8HZnEN2DWF866czTIHcBtoAvu57jqsre3O444nPFox9+Abw2vY/tjd2n0DGsDpC4+4s1oWF+/QI49N/Jn9WNfr/m2r9Jgv2I4l2IJibCHF1+b6FX77mdkO1mxy2w4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Fwy0Ihc0; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Fwy0Ihc0"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e8fa1b8d6so105792627b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784573081; x=1785177881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ihSrf6LQMS9w+wk1T0NBmgrCdJJzx0W6gbWY2cD6UX4=;
        b=Fwy0Ihc0oZd4saRZBUWIZ6Kg+LC+jVVwcHLn2FbGon//ot30fJfB2ElMlf8l/IAqsp
         GePyYLg0o+kI68QWoGGitJxVt135AYP+4+z/c/IvJt0/4moFIljiYqj2DaYVQtBCPP4l
         boEBGPMqoa1RU2/qTuzFozc4JSXlfEhSlpoq0m3epNfKqrAkhCzSzpnH45Zc9th4uQO1
         65p6OqRgJz9WF+FqE0p6U+ZasU/jIdON4hyU2R9zrTk+90+r0TgVK6UXko/NupKk+Qfj
         eN2I3NeqObFKLstRClGu4wJxrqj2QjeZNxutfrdekFS+OM0Tql3TkGva/Qt5dIzujWoI
         uZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573081; x=1785177881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihSrf6LQMS9w+wk1T0NBmgrCdJJzx0W6gbWY2cD6UX4=;
        b=isPlmyOjyjCBIgZAPyfIiToUo7JVQekg5tcYi0dQ5YKQ056y4D9NzO/vYbYkgkj/I1
         J6sAKVKNuGxV3r6tcMzbbLxq13b6TcrCgaUHVySOCSr+7Zq55N8eQ/KyXmZnIsqys4tx
         zRVEAwm3JEB3V9fP+E/bOAW49N5TMPFGHlX0NSUQWtgHsBiOL6UqGrtruCOqFG0ebK09
         0ri9c23jbQf+uPFE3n01iAmqeoY2nixStsRbMaOJo1+GqT9zFwwGTCnkz+LZnZLauvhz
         Aru2RfMHUEkqfoc/ENeR5W72knw1ow3AWhCaUMiJSlD6bsS71TsKIjtYTeUINi91elp0
         exvw==
X-Forwarded-Encrypted: i=1; AHgh+RpPoXvSzDPOnDMDR5x5WrNIbZP17CyWjS519LO/l6v7L9z60xQrvtDX6D6CWj5UZPfrIAtM557niDxYNfdn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpe9Is7yCWaNOQlMY+NzATsM5qrbxTYlA5z6lA+MHo1qTREIVF
	wGvNAhzFae+xgDYYpkuhdk/4RiGlKjouH5uLb1xS+1a8M+auBkWgaBak9A8285RfP/s=
X-Gm-Gg: AR+sD13M5HYRcCrGdP2JBsLcE/vYFv/cEktL87NNc2JgHa80Ec8BgzcXVqSWCoqab/n
	YnU5bDCUq+Zagseq/1w31AxQ1yEa+DclS4+vxrzjuMnWoSU/b2R2tU8Tc3jHNJPK9xyzVIZc/oS
	cI0D10JX0e5fCfvIZ0bpnHABoEgOcODtCVlYlQYtsHJ2fJdOYMa6oteYLnx7QnbSFpx6ohHfqGt
	OLxEq9sVGkd/tBo+ofzf/UKUi6DGYvfjM3pGlVTO3mwQ9fDFyHYnpj/qwFXJ6+GKVMpFUlG9qHq
	BHlXlNAZwFDkONNFlJZRAGy7VdHlmaFaEQ6SwTvCIAF2ds7XWWFoXZBFOirIi8XVw05r/F0bcRt
	iwdYREKcr2eHbzJXNTgQVzS5OLeE2hg74W0aTFG1hMHJ4V9pOjArm3F32IACvHkLilpFRJW1OJr
	VRNg2UKxiW/B+3lHJHqNQ/Y3U0MhzL72mrsI81e6LRDxvPD0HQDWenHLuFZdLDG2MKZSpYSG74J
	QXC5B59ItMrYdYOBmkH4rockYJznynsjTib/gJ633gb
X-Received: by 2002:a05:690c:4b93:b0:80c:550e:7dcc with SMTP id 00721157ae682-81ef2825945mr49573717b3.51.1784573081342;
        Mon, 20 Jul 2026 11:44:41 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:8546:6986:b83:77a3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42ae657sm53931237b3.35.2026.07.20.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:44:40 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: samsun1006219@gmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: rework MDB locking scheme
Date: Mon, 20 Jul 2026 11:44:15 -0700
Message-ID: <20260720184414.195213-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_mdb_commit() used to hold the primary MDB buffer_head (mdb_bh)
locked for the whole commit, including writing the alternate MDB and
the volume bitmap. A corrupted image can set drVBMSt so the bitmap
block aliases mdb_bh. The bitmap writeback path then calls
lock_buffer() on that same buffer_head while it is already locked by
hfs_mdb_commit(). Finally, we have a deadlock during flushing the MDB
to the file system volume. However, even for valid images, the locking
scheme of holding the mdb_bh locked across this much unrelated I/O is
fragile anyway.

This patch adds a dedicated sbi->mdb_lock and take it around every
hfs_mdb_commit() caller (hfs_sync_fs(), flush_mdb(), and the initial
hfs_mdb_get() in hfs_fill_super()).

Additionally, this patch makes sbi->mdb/sbi->alt_mdb independent
in-memory copies (allocated with kmemdup()) instead of pointers into
mdb_bh's/alt_mdb_bh's page cache data. Every MDB field read or write in
hfs_mdb_commit(), hfs_mdb_close() and hfs_mdb_get() now operates on
these copies. Also, hfs_mdb_publish() and hfs_alt_mdb_publish() are
the only places left that touch the buffer_heads. The hfs_mdb_put()
frees the two copies.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Link: https://lore.kernel.org/all/CAEkJfYMB47v1yOWHB8q2dc8kf=uj-rLO=+yMyudwPguJ8Kd3jA@mail.gmail.com/
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/hfs_fs.h | 12 +++++--
 fs/hfs/mdb.c    | 84 ++++++++++++++++++++++++++++++++++++++-----------
 fs/hfs/super.c  | 14 +++++++--
 3 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 3df23f1f091b..e250f87a5e33 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -64,14 +64,22 @@ struct hfs_inode_info {
  * The HFS-specific part of a Linux (struct super_block)
  */
 struct hfs_sb_info {
+	struct mutex mdb_lock;			/* MDB operations lock */
 	struct buffer_head *mdb_bh;		/* The hfs_buffer
 						   holding the real
 						   superblock (aka VIB
 						   or MDB) */
-	struct hfs_mdb *mdb;
+	unsigned int mdb_offset;		/* byte offset of the MDB
+						   sector within mdb_bh's
+						   data */
+	struct hfs_mdb *mdb;			/* in-memory copy of the MDB */
 	struct buffer_head *alt_mdb_bh;		/* The hfs_buffer holding
 						   the alternate superblock */
-	struct hfs_mdb *alt_mdb;
+	unsigned int alt_mdb_offset;		/* byte offset of the alternate
+						   MDB sector within
+						   alt_mdb_bh's data */
+	struct hfs_mdb *alt_mdb;		/* in-memory copy of the
+						   alternate MDB */
 	__be32 *bitmap;				/* The page holding the
 						   allocation bitmap */
 	struct hfs_btree *ext_tree;			/* Information about
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index f4578f634302..277de712f9d4 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -85,6 +85,39 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
 	return !corrupted;
 }
 
+/*
+ * hfs_sect_offset() - get byte offset within the buffer_head.
+ */
+static unsigned int hfs_sect_offset(struct super_block *sb, sector_t sec)
+{
+	loff_t start = (loff_t)sec << HFS_SECTOR_SIZE_BITS;
+
+	return start & (sb->s_blocksize - 1);
+}
+
+/*
+ * hfs_mdb_publish() - copy the in-memory primary MDB to the on-disk buffer.
+ */
+static void hfs_mdb_publish(struct hfs_sb_info *sbi)
+{
+	lock_buffer(sbi->mdb_bh);
+	memcpy(sbi->mdb_bh->b_data + sbi->mdb_offset, sbi->mdb, HFS_SECTOR_SIZE);
+	mark_buffer_dirty(sbi->mdb_bh);
+	unlock_buffer(sbi->mdb_bh);
+}
+
+/*
+ * hfs_alt_mdb_publish() - copy the in-memory alternate MDB to its buffer.
+ */
+static void hfs_alt_mdb_publish(struct hfs_sb_info *sbi)
+{
+	lock_buffer(sbi->alt_mdb_bh);
+	memcpy(sbi->alt_mdb_bh->b_data + sbi->alt_mdb_offset, sbi->alt_mdb,
+	       HFS_SECTOR_SIZE);
+	mark_buffer_dirty(sbi->alt_mdb_bh);
+	unlock_buffer(sbi->alt_mdb_bh);
+}
+
 /*
  * hfs_mdb_get()
  *
@@ -94,7 +127,7 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
 int hfs_mdb_get(struct super_block *sb)
 {
 	struct buffer_head *bh;
-	struct hfs_mdb *mdb, *mdb2;
+	struct hfs_mdb *mdb, *alt_mdb;
 	unsigned int block;
 	char *ptr;
 	int off2, len, size, sect;
@@ -158,7 +191,14 @@ int hfs_mdb_get(struct super_block *sb)
 		return -EIO;
 	}
 
+	mdb = kmemdup(mdb, HFS_SECTOR_SIZE, GFP_KERNEL);
+	if (!mdb) {
+		brelse(bh);
+		return -ENOMEM;
+	}
+
 	HFS_SB(sb)->mdb_bh = bh;
+	HFS_SB(sb)->mdb_offset = hfs_sect_offset(sb, part_start + HFS_MDB_BLK);
 	HFS_SB(sb)->mdb = mdb;
 
 	/* These parameters are read from the MDB, and never written */
@@ -187,11 +227,18 @@ int hfs_mdb_get(struct super_block *sb)
 
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
-	bh = sb_bread512(sb, sect, mdb2);
+	bh = sb_bread512(sb, sect, alt_mdb);
 	if (bh) {
-		if (mdb2->drSigWord == cpu_to_be16(HFS_SUPER_MAGIC)) {
-			HFS_SB(sb)->alt_mdb_bh = bh;
-			HFS_SB(sb)->alt_mdb = mdb2;
+		if (alt_mdb->drSigWord == cpu_to_be16(HFS_SUPER_MAGIC)) {
+			alt_mdb = kmemdup(alt_mdb, HFS_SECTOR_SIZE, GFP_KERNEL);
+			if (alt_mdb) {
+				HFS_SB(sb)->alt_mdb_bh = bh;
+				HFS_SB(sb)->alt_mdb_offset =
+					hfs_sect_offset(sb, sect);
+				HFS_SB(sb)->alt_mdb = alt_mdb;
+			} else {
+				brelse(bh);
+			}
 		} else
 			brelse(bh);
 	}
@@ -253,7 +300,7 @@ int hfs_mdb_get(struct super_block *sb)
 		be32_add_cpu(&mdb->drWrCnt, 1);
 		mdb->drLsMod = hfs_mtime();
 
-		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
+		hfs_mdb_publish(HFS_SB(sb));
 		sync_dirty_buffer(HFS_SB(sb)->mdb_bh);
 	}
 
@@ -300,7 +347,6 @@ int hfs_mdb_commit(struct super_block *sb)
 		return -EIO;
 	}
 
-	lock_buffer(HFS_SB(sb)->mdb_bh);
 	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
@@ -314,8 +360,14 @@ int hfs_mdb_commit(struct super_block *sb)
 		mdb->drDirCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
+		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb->drXTExtRec,
+				     &mdb->drXTFlSize, NULL);
+		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb->drCTExtRec,
+				     &mdb->drCTFlSize, NULL);
+
 		/* write MDB to disk */
-		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
+		hfs_mdb_publish(HFS_SB(sb));
+		sync_dirty_buffer(HFS_SB(sb)->mdb_bh);
 	}
 
 	/* write the backup MDB, not returning until it is written.
@@ -330,18 +382,11 @@ int hfs_mdb_commit(struct super_block *sb)
 			goto out;
 		}
 
-		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb->drXTExtRec,
-				     &mdb->drXTFlSize, NULL);
-		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb->drCTExtRec,
-				     &mdb->drCTFlSize, NULL);
-
-		lock_buffer(HFS_SB(sb)->alt_mdb_bh);
-		memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb, HFS_SECTOR_SIZE);
+		memcpy(HFS_SB(sb)->alt_mdb, mdb, HFS_SECTOR_SIZE);
 		HFS_SB(sb)->alt_mdb->drAtrb |= cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
 		HFS_SB(sb)->alt_mdb->drAtrb &= cpu_to_be16(~HFS_SB_ATTRIB_INCNSTNT);
-		unlock_buffer(HFS_SB(sb)->alt_mdb_bh);
 
-		mark_buffer_dirty(HFS_SB(sb)->alt_mdb_bh);
+		hfs_alt_mdb_publish(HFS_SB(sb));
 		sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
 	}
 
@@ -377,7 +422,6 @@ int hfs_mdb_commit(struct super_block *sb)
 		}
 	}
 out:
-	unlock_buffer(HFS_SB(sb)->mdb_bh);
 	return ret;
 }
 
@@ -392,7 +436,7 @@ void hfs_mdb_close(struct super_block *sb)
 
 	HFS_SB(sb)->mdb->drAtrb |= cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
 	HFS_SB(sb)->mdb->drAtrb &= cpu_to_be16(~HFS_SB_ATTRIB_INCNSTNT);
-	mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
+	hfs_mdb_publish(HFS_SB(sb));
 }
 
 /*
@@ -408,6 +452,8 @@ void hfs_mdb_put(struct super_block *sb)
 	/* free the buffers holding the primary and alternate MDBs */
 	brelse(HFS_SB(sb)->mdb_bh);
 	brelse(HFS_SB(sb)->alt_mdb_bh);
+	kfree(HFS_SB(sb)->mdb);
+	kfree(HFS_SB(sb)->alt_mdb);
 
 	unload_nls(HFS_SB(sb)->nls_io);
 	unload_nls(HFS_SB(sb)->nls_disk);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index f203e3240fae..0713969b8af2 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -34,8 +34,14 @@ MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
+	int ret;
+
+	mutex_lock(&HFS_SB(sb)->mdb_lock);
 	is_hfs_cnid_counts_valid(sb);
-	return hfs_mdb_commit(sb);
+	ret = hfs_mdb_commit(sb);
+	mutex_unlock(&HFS_SB(sb)->mdb_lock);
+
+	return ret;
 }
 
 /*
@@ -65,9 +71,10 @@ static void flush_mdb(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
+	mutex_lock(&sbi->mdb_lock);
 	is_hfs_cnid_counts_valid(sb);
-
 	hfs_mdb_commit(sb);
+	mutex_unlock(&sbi->mdb_lock);
 }
 
 void hfs_mark_mdb_dirty(struct super_block *sb)
@@ -338,9 +345,12 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NOATIME | SB_NODIRATIME;
+	mutex_init(&sbi->mdb_lock);
 	mutex_init(&sbi->bitmap_lock);
 
+	mutex_lock(&sbi->mdb_lock);
 	res = hfs_mdb_get(sb);
+	mutex_unlock(&sbi->mdb_lock);
 	if (res) {
 		if (!silent)
 			pr_warn("can't find a HFS filesystem on dev %s\n",
-- 
2.43.0

