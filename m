Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053E3B7753
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785004; cv=none; b=GSQ/gII/AuM7nM9FE+M3OKUuvFs6eSM/v//8UsRjPiYmNqICuUEiiAPP28fUhAjEzZyOIGUTREjp+RHxZfvXpnpCwPJAdP2r82cjKwoBf4cvMqlgoIAwaiaM07V6/AjJGVHFAQ6oGdvecfErXiB5HlKZfmkJkIrHxg3EnYKPd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785004; c=relaxed/simple;
	bh=KQ9TioCk7IAXoYKsbOf3mo0CBYIbu2RGH/UJt8EFt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5wnlhUxReE+9GneVxRcbyymHNa0gdAL3xCAKCOn553xKOgq61qMqOStAjV68KmWkEen5RwMzluUT7o1gD/PpSzVSB5ZKvxeoqGraPbsRhFDBzpPJnzpp7NYUvjAeJ1XPqCqK9kM1JX95PS0O6hX43f6JbAbDdpPyfbmx2JvyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=yl+c+1Kw; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="yl+c+1Kw"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-854f9c32c76so8380207b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787784999; x=1788389799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hss3hwS5MmprOQZWPrR8lu4oaz0ib++0UrLxiJhoUVs=;
        b=yl+c+1KwG+vtC9llO++5ZXp0XorKwTOy/9Xc+piKWUefilYzFRMF8Lvk9LFo+cjtWm
         KHLnSYyV/ZtdbbHW8JfEtpJa0DQlEI26cwfPXK8JpOIxOgLsNacTouUY/FVvqnZoFMCf
         20A9OLlFacljly90trgacM5Yf96Dek752VQmnJeIDBY0zeywc9OJvae4VDm32pfkMWlJ
         XtCnmG/uSEPcBKqhPBuCGLcQEjilwiEKHsuROHeOFinnjAxLf/qchOb9VZOvn6lrXXUC
         CMCq3HUAI1SRrLxGd1Vv4NkRhZl3Q60u+bYGwbpvPNZe1PhP182iqHqcwrEMh354SOXc
         ZWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787784999; x=1788389799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hss3hwS5MmprOQZWPrR8lu4oaz0ib++0UrLxiJhoUVs=;
        b=q4OOGcaZhKJ2xLQCEtifmTLxGag/E580WgilEnQGOr51KqG2DcdedWP8hYOq9MlWr2
         G5D7fmVnFjPtoDxCPmrFTje2Wtu8iBzlgFMpQ5doQj9MQNUr+wUs9JYE8dY8Mcg2Mj13
         cYURF21lIHLOQxAqxf5RHlcBqnycD8PhXNEm5bQVBurgTGc6GpbWrprV9c/1U1ePmne+
         qaV0UR4BculfDUFm2bt79vWTMN1hybtx2+gIdcBIkUrrwN1RJbxNUJgYT3dCMzQFRwuU
         qSv5so8Jx9kdBbrrN7/NQtCRvowl43KjYJWEPGIoHFxLxs8Iuwic4XzR0L1ZJI47Tm56
         1LHQ==
X-Gm-Message-State: AFuF++ntf40kmd+8t3V89mh+Do2aNKtNto3t15N7oeYQwv1WFmMy/YND
	mj1dy+rWwyTDbFMKfxqa/EuYrpoitl1NDnQGAhNrnSEp9VQTCIZomyv3CwgkQFvwMlk=
X-Gm-Gg: AR+sD10QKLbzfuC5NDMJJnojF+aF6INlCGvq/tWhvrwh8zqtNcv8luVjkXmysSnvScn
	O1FiY5Jmy2bJiGvMnw1C05LCFJI7HCJfCuXxn17KwZdIMOyA8UIbcq+6e4Gh7p7dEzUHxCCTzm4
	w6Oprsns8kl9st3wYGP6yhYqPGX7AGuPj5SuOYtX0OvYuv9eCZ8r+ZRr3SqzboUljlSUKNxRvH+
	2NOYsOkPuNvTb7obdpPE4H7ks/hV5niYzU0u0tB0wgK6nh06KCU8d/UHPWjBbtACQJILjs1Mb3N
	kt9kDh2HLFHUrjve2iuHvDMkoJWORqqQCsTe9QJekQzykh9fzCA6nDbtoeCxc90fsYF1cW4UeqD
	K7y/ygWHeMnnt/klQi7cDlePkDeDCY4GZatYY6Va52vtH9+oioqrbkjNZRT1spbkMkhVc/JLUVw
	fVVYbqFAtwMbboaocTHOE03zsBpbaPzRNKj/TII93yyBRY6vjblvHve+Q+piMz6UDWoE7T6cbMH
	yAqKDKgEXD3PaxNF2PcG8s0NZnpxmkZIHuH2kH1kysXPqqdlqNPZK8epD/coj2EI8+SdUKrNSXR
	yf5WCt1q1iev5mO+Ng==
X-Received: by 2002:a53:b7c6:0:b0:66d:20db:f857 with SMTP id 956f58d0204a3-66e11894bc1mr693454d50.20.1787784999618;
        Wed, 26 Aug 2026 15:56:39 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:39 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 2/7] hfsplus: rework hfsplus_get_block() logic
Date: Wed, 26 Aug 2026 15:56:09 -0700
Message-ID: <20260826225614.486112-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826225614.486112-1-slava@dubeyko.com>
References: <20260826225614.486112-1-slava@dubeyko.com>
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

cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/extents.c    | 118 +++++++++++++++++++++++++++++-----------
 fs/hfsplus/hfsplus_fs.h |   2 +
 2 files changed, 87 insertions(+), 33 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d18..ffd52ad8867c 100644
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
@@ -225,37 +236,46 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
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
@@ -274,11 +294,44 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
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
 
@@ -292,9 +345,8 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
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
index 1e5b58e6a13f..67586382269b 100644
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

