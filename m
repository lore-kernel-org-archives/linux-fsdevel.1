Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2238E8C7
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848367; cv=none; b=SK2DKcQKnqTF2zV1ZJ9R2LWj2eDcqMA34LbrC77aK6mOheDmjKLDXa+mhqvppbepZCJllBCANIolLO3YRx3nM5NkoggClWj5VHLz0iqzh84dnATWmPTrXtK7xxwQ0oNV//RAwH+C5aJh2RQjIiq7JFs2z5lT54mYnu+Z5p/y9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848367; c=relaxed/simple;
	bh=id/oiviml1q3ef8E+x2djTOzF72K2pibhwhLVZap97c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0sB5lKVCdrXRD5ROpmLFYqXeSgY6X5UNKsoEhku/R/agCIS/rEi0vcJXr0pg9NwESwZoAD0cU3pG1L+KheYs5uJ+rhmPMPv4t39RThzFdjDfZVSJxea90qqVuiZAcfeBeQYVukl3xZArM4e3SxWZaiE3WoYeJpOHLAQATVRkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=Y/YChoft; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="Y/YChoft"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba42939bfeso1062631e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790848363; x=1791453163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUljElJ412kYe/nOeh5zaMdSOg0zj48HO1jKhr5xZY8=;
        b=Y/YChoftZukX2EipVlKmKgolPgkqH6lHXu1itombxqQI7HUkpCVOwQk6WStuYqabKU
         uhiHXWT3AXLo9QZsGeiVFfWHl0EUOpAQ7KeVv5/r9YF/f6Sru/HM53UITBT/lwtZkwQf
         UaYO8n9i1xHTBXfvwZj5PPdw+TADFlIZAc2Fu+d7cLO3kykZBNAyjPHqYclqo6XaPF/d
         IlsnJhwNpzNQmTTHCWvJfl8CWMVRtOxpLW4VHMRHl0l6Cqb0dk4Vodu4Tn+xel2lYosk
         4w+zt59xBltRKWEQXabBDEppIXHkCE0x3iELX8ZEGFsdSRTp+jOEZfS1YXMof0LuTchb
         Z52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848363; x=1791453163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUljElJ412kYe/nOeh5zaMdSOg0zj48HO1jKhr5xZY8=;
        b=udSpAd426EvQaIdzJYZt+lV5BYVxvdhQ6JLwnd3pFyliUw524rNNL2ThlU4uKi9JYo
         hQdXRIsa9Po4P8f+I4MFjPByHZ7HtPuzirGiWmkYFJQwn55Vye4NZbo27LWSpQskgp2W
         0pirN7qPJqxfevAgIwP2GwmzEB8r+TPCrOCbv1Urei0KhXz6K14peQOgP0fLffRG8FZY
         2i7WhFka17SLL+34I7ALIOZSYukh60TQgSSn58Cwf7CVqBtWi1e2wt03xxPZHuneWXUb
         oqvThK7TsAM7ocjT/jtCjoVD835UIQKCIS6AIrmolMVwnZZvC0zUOCyHgbSQ+6R/fJNi
         hxNw==
X-Gm-Message-State: AFq9FYIEKhqPnrwJ9TRFvZ/qWrCGEjNzdwCnxBKZmWT8FdvncIsBn88F
	rkSbUm3vNiqOn4BkA+SeYtG3MN+uT6cGnfmfWjjmlvZO8X8E830rcfeS75YMV2j4a5hxeUPK6Ql
	SvsxDA1AfBLU6gA==
X-Gm-Gg: AYBFou2vMV4VQMO2e8GLL2tNwR72oV8fay1VU2FZaZELx8FI3T2+GZMAI8kqm9ioZrw
	SGrd+OfHWUaqY4g2z4nIEVTeNzzj7SsAxs3W0ItNeJW2tEGFJKh00/dIoZY2pf07Q19tgZx9vJe
	7f9f1ds/7hTxp7VBaN/ASxosyY0+FwBCaxBg+rbsBiJAysKgMiAqcwlgyUa5SzNyGMbyv1sjK+k
	c7t7cD+Wl7Ypgciy7wrkyRh6VlKTEoRgtEKc10pthAcq8ivSNNZjh8AAPvovIAbJ9Hu2gQ6VK8s
	Xb5yp6uWR2Kz86CwHnnVFMKOM2am4I7Sfx1pRe2wXXp7ZiKOUwKhKwPkINCir6wdBesChm1s3wQ
	ieeMJzydcDYokTZB+ypBRSzl/ytZ0v/c1MKnhUNCRTA5HoVj6XgC9FWIIQ5CeUtbsdesZKQlsPI
	BRp9fAfJ0Y4SyNfeONR8OzcW0N3f+KmSlvL6Nn60eZiDlsR+KC9trelkcZsfvZq/G3difWJG7w
X-Received: by 2002:a05:6512:14f:b0:5b8:bc5e:b58b with SMTP id 2adb3069b0e04-5ba406212fbmr1259804e87.67.1790848362400;
        Thu, 01 Oct 2026 02:52:42 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fc529dsm600485e87.80.2026.10.01.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:52:42 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH] hfsplus: annotate extents_lock nesting to silence lockdep false positive
Date: Thu,  1 Oct 2026 11:52:08 +0200
Message-ID: <20261001095208.1469344-1-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8dfb90a2751df30f76ab5130960591a57c51be4d.camel@dubeyko.com>
References: <8dfb90a2751df30f76ab5130960591a57c51be4d.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lockdep reports possible recursive locking on HFSPLUS_I(inode)->extents_lock
when unlinking a file on a crafted image:

  hfsplus_file_truncate()  holds inode A ->extents_lock
   hfsplus_free_extents()
    hfsplus_block_free()   reads the allocation bitmap file
     block_read_full_folio()
      hfsplus_get_block()  takes inode B ->extents_lock

inode A is the regular file being truncated and inode B is the allocation
file (sbi->alloc_file, i_ino == HFSPLUS_ALLOC_CNID). They are two different
inodes of the same lock class, taken in a fixed order (regular file first,
then the allocation/attributes/catalog file), so this is not a real
deadlock, only a missing lock-nesting annotation.

Mirror the existing hfsplus_btree_lock_class() approach: give the special
inodes distinct extents_lock subclasses and take the lock with
mutex_lock_nested(). Regular files keep the default subclass, so a genuine
regular-vs-regular recursion would still be detected.

Found via coverage-guided fuzzing (syzkaller + lockdep) by Noroxi.

Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
---
 fs/hfsplus/extents.c    | 12 ++++++++----
 fs/hfsplus/hfsplus_fs.h | 28 ++++++++++++++++++++++++++++
 fs/hfsplus/xattr.c      |  3 ++-
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524..54a05eaa8 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -150,7 +150,8 @@ int hfsplus_ext_write_extent(struct inode *inode)
 {
 	int res;
 
-	mutex_lock(&HFSPLUS_I(inode)->extents_lock);
+	mutex_lock_nested(&HFSPLUS_I(inode)->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 	res = hfsplus_ext_write_extent_locked(inode);
 	mutex_unlock(&HFSPLUS_I(inode)->extents_lock);
 
@@ -261,7 +262,8 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	if (inode->i_ino == HFSPLUS_EXT_CNID)
 		return -EIO;
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 
 	/*
 	 * hfsplus_ext_read_extent will write out a cached extent into
@@ -454,7 +456,8 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 		return -ENOSPC;
 	}
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
@@ -576,7 +579,8 @@ void hfsplus_file_truncate(struct inode *inode)
 	blk_cnt = (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1) >>
 			HFSPLUS_SB(sb)->alloc_blksz_shift;
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 
 	alloc_cnt = hip->alloc_blocks;
 	if (blk_cnt == alloc_cnt)
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1e5b58e6a..2cbd8074c 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -36,6 +36,20 @@ enum hfsplus_btree_mutex_classes {
 	ATTR_BTREE_MUTEX,
 };
 
+/*
+ * extents_lock nested subclasses. Special inodes (allocation, attributes,
+ * catalog) use the same lock class as regular files but their extents_lock is
+ * taken while a regular file extents_lock is already held -- e.g. the
+ * allocation file is read from hfsplus_block_free() during truncate. Give them
+ * distinct subclasses so lockdep does not report a false recursive locking.
+ */
+enum hfsplus_extents_mutex_classes {
+	HFSPLUS_EXTENTS_LOCK_NORMAL,
+	HFSPLUS_EXTENTS_LOCK_ALLOC,
+	HFSPLUS_EXTENTS_LOCK_ATTR,
+	HFSPLUS_EXTENTS_LOCK_CATALOG,
+};
+
 /* An HFS+ BTree held in memory */
 struct hfs_btree {
 	struct super_block *sb;
@@ -572,6 +586,20 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 	return class;
 }
 
+static inline unsigned int hfsplus_extents_lock_class(struct inode *inode)
+{
+	switch (inode->i_ino) {
+	case HFSPLUS_ALLOC_CNID:
+		return HFSPLUS_EXTENTS_LOCK_ALLOC;
+	case HFSPLUS_ATTR_CNID:
+		return HFSPLUS_EXTENTS_LOCK_ATTR;
+	case HFSPLUS_CAT_CNID:
+		return HFSPLUS_EXTENTS_LOCK_CATALOG;
+	default:
+		return HFSPLUS_EXTENTS_LOCK_NORMAL;
+	}
+}
+
 static inline
 bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 {
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 21a1c196c..7bf4ba8f1 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -264,7 +264,8 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 						    sbi->sect_count,
 						    HFSPLUS_ATTR_CNID);
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(attr_file));
 	hip->clump_blocks = clump_size >> sbi->alloc_blksz_shift;
 	mutex_unlock(&hip->extents_lock);
 
-- 
2.43.0

