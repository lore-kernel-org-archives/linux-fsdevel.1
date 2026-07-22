Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D16D349CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756307; cv=none; b=jz5oXcvqUpU36pbLXDtyVxDuyZgjiA8PZxRYr6d2INht8SJvuc4gGzgJCd/tOn88pJwDIlkbLmmPhuay0Ke2aCZVy30pLwGAlFJx+MUxV5KZqur0+nyqBHaLAfHhT6c1d298h2ji/VDn8TSWCYrP9JkrThW0tcIC2jH/012f55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756307; c=relaxed/simple;
	bh=CWXWJ5hmuX8SbX7N8OBlJrYrE0B8oDzlOUoA82cxN+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnVQZDLJH7IdpymTE9wJ3JzsAxSzz2AdyraGqnOfC1B8ljgXkGhWY/CA3mztb/BzLZ2q2sQMimzpFBefEba2j+6+ug6hK8Gf6+9jr1IoejDOd26KWfeBkfADrO56Y7RVrLsoaBjavNYltcW10wbthlMfqlRNfq/+PE26NW0+bbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=w6QZYYpk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="w6QZYYpk"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80cebd41372so120362027b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784756301; x=1785361101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUOFh3fMHA1LWo5od5sIxJvPX+8XvBOmie3ZKg1w4wU=;
        b=w6QZYYpkwXZ6egrsXUn6URARLODaaODjxfDatRSNCrDegwdEAnBjPnXtSnEC1POBqW
         M2Q0yiF4BvYWMuUFTbcJc2n7ODfdys2QCbkcZeyUhkU+J6oQUDRqTMZh/nuiYGpfSXEW
         c6j5/5T3IGGsn9ZXg6Fy2xaCf15QULj0+SvVzrZXCycgyVVwpthDIdnNN4LCeX2iryA8
         podeWs5GwnVQepvIYmzwyWVoNzBKjN/J+y1zCvDIhsnccyip1Y8EHyqgjgmCb/O/mI28
         aHu/E/7RNFMRBg0I9hkOMVJTgootaqdY9koB0aJrFGKjB1N1QMZVrmbYjcU7ttYihlSx
         t+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756301; x=1785361101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUOFh3fMHA1LWo5od5sIxJvPX+8XvBOmie3ZKg1w4wU=;
        b=nOuEHI3DBhkPoxCsnL4YhZtzmfxFM2fJBJKL+igoGGooTaCCI3ydHMbm66J0j0UNFk
         8q6kCOeQk6M+xANsvxZp1gJcwPKgfAYgZZuka3V880nzvu2A6Jd+l/uF10Jm0JFWeyne
         8RS7TsCD4KSGRFoZ7UAE2MmfOY2Rb38h6mItBZKVQxRtibcsCrnYtdCoR/SEVFUnJbjd
         7zMUKwywSbqpgWOUEwNK4uQUBlmIfxDeitd8dUNuyj2jJZZwDw43zHrPLChv7dADIJ/p
         4qdO2OygDHFpTG668ja0bnoRkE5mXtgH3RVVXdhzp+XP3kbu/xiW5t9/jINKrwWn9hmg
         HXbg==
X-Gm-Message-State: AOJu0YwrzgJ1DZpssKrSXVpA6EWAV/oZtGFIxeuUO6FTkR0/fJychgGI
	6n35Iuc2wbiPRBiQSikBo7qeqba3+8NLqhftHjyxLg7/n/yZhNxk9H+gIt9DeefjIr8=
X-Gm-Gg: AR+sD12IclTT78qrtKzIziKnkn2ItJwEHrkjAROu7Ndu7yOsMThMh1ol8AyWrdgM35Z
	62baFyUPiWgHwI+0u5ogjOGYMGh2gkzIbF91aRlHw2NMoq+eFdgXJ68MYfE+F/iU/OEv5Lc9hFX
	8nSNCVT7YpbsrrDIPG58Vd5FipFgtgP3VGYD9E9oGNPKgN5hpsCk2fpYjBM/Mi4niO/4UlLBWQv
	VKuT2go2kj9Dyd+MJcz5VExwTAZlNvAWGCy81OEPITkOezMZSXOnBXEMYs38vv0e7O7l9cu3yO1
	RkoKqZhC40YvpUSNYX+ufjW/LOA/iuBTT3Q+iiJDVtUuWVvhMyyLjhpgo2FkiEdBbO2XgXzSUxi
	CwqDf+w8SK4lHBfHfEoYKMa60ci25FfHxNhhD3lz7bZu/oNgJI8twPZGYd/zaDS/skgamF9aVbq
	424kexAKS5q3IxOktoewZdnrPPykrKALIQERMhiu3ACdycvso+a1p6jlzjaXbJZpGAh/M9ft2dj
	cTBpagU2oElvX9byG6r8nVz4Tp9tk7hJPQ=
X-Received: by 2002:a05:690c:a87:b0:81e:3e2c:6fea with SMTP id 00721157ae682-81f4c3c2a5bmr1065027b3.70.1784756301271;
        Wed, 22 Jul 2026 14:38:21 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c7706dsm20034827b3.21.2026.07.22.14.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:38:20 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/6] hfsplus: rework hfsplus_get_block() logic
Date: Wed, 22 Jul 2026 14:37:54 -0700
Message-ID: <20260722213759.1360225-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722213759.1360225-1-slava@dubeyko.com>
References: <20260722213759.1360225-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the extent-lookup/allocate logic out of hfsplus_get_block() into
a new hfsplus_map_extent(), which reports the mapping as
(dblock, max_blocks, balloc) instead of filling in a buffer_head.
hfsplus_get_block() becomes a thin wrapper around it for the
buffer_head-based callers (B-tree metadata, symlinks).

No functional change to the existing buffer_head path. This is
preparation for the iomap-based regular file I/O path added in a
later patch, which will call hfsplus_map_extent() directly.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/extents.c    | 118 +++++++++++++++++++++++++++++-----------
 fs/hfsplus/hfsplus_fs.h |   2 +
 2 files changed, 87 insertions(+), 33 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 813e68b8ecd6..c1c9b21814a0 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -48,18 +48,29 @@ static void hfsplus_ext_build_key(hfsplus_btree_key *key, u32 cnid,
 	key->ext.pad = 0;
 }
 
-static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32 off)
+/*
+ * hfsplus_ext_find_block() - find contiguous sequence of block
+ *
+ * Find the disk allocation block for 'off' within an 8-entry
+ * extent record, and the number of further allocation blocks
+ * that are contiguous with it in the same extent entry.
+ */
+static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32 off,
+				 u32 *dblock)
 {
 	int i;
 	u32 count;
 
-	for (i = 0; i < 8; ext++, i++) {
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; ext++, i++) {
 		count = be32_to_cpu(ext->block_count);
-		if (off < count)
-			return be32_to_cpu(ext->start_block) + off;
+		if (off < count) {
+			*dblock = be32_to_cpu(ext->start_block) + off;
+			return count - off;
+		}
 		off -= count;
 	}
 	/* panic? */
+	*dblock = 0;
 	return 0;
 }
 
@@ -68,7 +79,7 @@ static int hfsplus_ext_block_count(struct hfsplus_extent *ext)
 	int i;
 	u32 count = 0;
 
-	for (i = 0; i < 8; ext++, i++)
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; ext++, i++)
 		count += be32_to_cpu(ext->block_count);
 	return count;
 }
@@ -223,37 +234,46 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 	return res;
 }
 
-/* Get a block at iblock for inode, possibly allocating if create */
-int hfsplus_get_block(struct inode *inode, sector_t iblock,
-		      struct buffer_head *bh_result, int create)
+/*
+ * hfsplus_map_extent() - find or allocate a sequence of allocation blocks
+ *
+ * Looks up the allocation block at 'ablock' for inode, extending the
+ * file (via hfsplus_file_extend(), in clump_blocks-sized chunks) when
+ * 'create' is set and 'ablock' lies beyond the current allocation.
+ *
+ * On success, *dblock is the disk allocation block backing 'ablock',
+ * and *max_blocks is the number of further allocation blocks that are
+ * contiguous with it (i.e. the remaining length of the extent entry
+ * that contains 'ablock'), which may be smaller than the whole file's
+ * remaining allocation when the fork is fragmented across several
+ * extent entries. If a new extent had to be allocated to satisfy the
+ * request, *balloc (when non-NULL) is set to true.
+ */
+int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
+			u32 *dblock, u32 *max_blocks, bool *balloc)
 {
-	struct super_block *sb = inode->i_sb;
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	int res = -EIO;
-	u32 ablock, dblock, mask;
-	sector_t sector;
-	int was_dirty = 0;
+	int was_dirty;
+	int res;
 
-	/* Convert inode block to disk allocation block */
-	ablock = iblock >> sbi->fs_shift;
+	if (balloc)
+		*balloc = false;
 
-	if (iblock >= hip->fs_blocks) {
+	if (ablock >= hip->alloc_blocks) {
 		if (!create)
-			return 0;
-		if (iblock > hip->fs_blocks)
 			return -EIO;
-		if (ablock >= hip->alloc_blocks) {
-			res = hfsplus_file_extend(inode, false);
-			if (res)
-				return res;
-		}
-	} else
-		create = 0;
+		res = hfsplus_file_extend(inode, false);
+		if (res)
+			return res;
+		if (balloc)
+			*balloc = true;
+	}
 
 	if (ablock < hip->first_blocks) {
-		dblock = hfsplus_ext_find_block(hip->first_extents, ablock);
-		goto done;
+		*max_blocks = hfsplus_ext_find_block(hip->first_extents,
+						     ablock,
+						     dblock);
+		return 0;
 	}
 
 	if (inode->i_ino == HFSPLUS_EXT_CNID)
@@ -272,11 +292,44 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		mutex_unlock(&hip->extents_lock);
 		return -EIO;
 	}
-	dblock = hfsplus_ext_find_block(hip->cached_extents,
-					ablock - hip->cached_start);
+	*max_blocks = hfsplus_ext_find_block(hip->cached_extents,
+					     ablock - hip->cached_start,
+					     dblock);
 	mutex_unlock(&hip->extents_lock);
 
-done:
+	if (was_dirty)
+		mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/* Get a block at iblock for inode, possibly allocating if create */
+int hfsplus_get_block(struct inode *inode, sector_t iblock,
+		      struct buffer_head *bh_result, int create)
+{
+	struct super_block *sb = inode->i_sb;
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	u32 ablock, dblock, mask, max_blocks;
+	sector_t sector;
+	int res;
+
+	/* Convert inode block to disk allocation block */
+	ablock = iblock >> sbi->fs_shift;
+
+	if (iblock >= hip->fs_blocks) {
+		if (!create)
+			return 0;
+		if (iblock > hip->fs_blocks)
+			return -EIO;
+	} else
+		create = 0;
+
+	res = hfsplus_map_extent(inode, ablock, create, &dblock, &max_blocks,
+				  NULL);
+	if (res)
+		return res;
+
 	hfs_dbg("ino %llu, iblock %llu - dblock %u\n",
 		inode->i_ino, (long long)iblock, dblock);
 
@@ -290,9 +343,8 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		hip->phys_size += sb->s_blocksize;
 		hip->fs_blocks++;
 		inode_add_bytes(inode, sb->s_blocksize);
-	}
-	if (create || was_dirty)
 		mark_inode_dirty(inode);
+	}
 	return 0;
 }
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 7c8667d5a49c..428f56ebccb0 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -436,6 +436,8 @@ int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
 int hfsplus_ext_write_extent(struct inode *inode);
 int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		      struct buffer_head *bh_result, int create);
+int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
+			u32 *dblock, u32 *max_blocks, bool *balloc);
 int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		      struct hfsplus_fork_raw *fork, int type);
 int hfsplus_file_extend(struct inode *inode, bool zeroout);
-- 
2.43.0

