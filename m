Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8733D75A1
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901505; cv=none; b=DBKD/zLWwpkRvvSOFDpaRD2Aoo5+vXPLkNrL8RXJ0LMmJPQegOlem81TARmGI2bM4lYjbIAs/5SdSTAYagyvJd2ujBFaeYYnUdU4pybTu3+l0R2dbqt3eUGbRDWLid6Lfdx7GVinJo8j+Dp/AnFhngHBfxpKCJsds5V2WSh9gI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901505; c=relaxed/simple;
	bh=KQ9TioCk7IAXoYKsbOf3mo0CBYIbu2RGH/UJt8EFt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAvfN9NPnxWbenXgTg11G2ADJcC0sYL9LQUldmWk7BoCmkFXKszA4J3s8wRzh3iHQEnqlJlp6h7Q4HK1I877An+R5FuTtvvGXoZR0bJQ0u6rcV8rXEd6UzSYUAeS57HT2THunGfudnrLjbMDuqwTDvDx/ENHD/1msOhduMbAu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=t7yO1YTc; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="t7yO1YTc"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c7127a73dso5602872d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788901502; x=1789506302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hss3hwS5MmprOQZWPrR8lu4oaz0ib++0UrLxiJhoUVs=;
        b=t7yO1YTc4AtG8rnpyV+YzwuDQ1ANE1oSCBzp9xrmZ0oDoLaPmqdQPAA1Y1eDGKx1Jn
         BjR1lN8HdsRc2J30tHHUZguq6sTyAzcLwd0qsXKNzRkKBPL0Yfkldw5U5Q73YMlysiw8
         HFTOeoUpiWeN7Ty7iOwL3wIKIcIvnxKUsmzgXA9t5W0hkfVmqdNb+sXQ8NuSi/CysLcx
         Jdr9CQyix3lhO7PLSkeTSWn46jlRnks/gHUHIGTkR9Lo496SfaJ9r6FkgVmTFJ/LfbZ6
         5aP1OgkPhYUDUj6dHFuGQQpuMMzZf9YsnvQEw/UcIweEVsnJ2JEOGItoW+EMLPa0RChr
         CqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901502; x=1789506302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hss3hwS5MmprOQZWPrR8lu4oaz0ib++0UrLxiJhoUVs=;
        b=Th+WVNRhtWEpSh/rt5TT88J+HheXzqZX0HNMAU+YZa5hA5wIvUObHYRWHQziU42LV+
         gJaTFJfCYsns6j1EgMAk2Fhb0zupsb6mQI06rr6IFxyzzVmmDbuAHBGxgFAybdvEVu0F
         EbVOxc6nlIEYsnhCwcB8kjRybMvteCabn8exiDD9Sszq93gJphEIO5Lbv9C9qB+9tkbr
         Tj8S6ncVRFWui4/rhu4FlhI1Ldcgmoza+feH/oIvEKzAuKsky1yWVgnZGVyTDNikRin2
         a0YWhelcmK6lRj8CJ82OBbWZkaljdB/j7b4DLon+kATC4DOLZq36TznQA/tql/hASRku
         Z1gw==
X-Gm-Message-State: AFuF++ndy7nKZRZ0qx0rPedRgTJYXq9PEFZi6gDiauImG8JGXL1qx2I0
	Y0cX8utpwG94Lq9dyhylQzCTglp3nlHPJVmKm4UWcSOyW1E8GTEMAtb6Nqf55Xi+x3Y=
X-Gm-Gg: AYBFou1v+5EGQ6QgyDuEnqhzRYageTqyY7gTTVgJmKKCK/JXhQsR6CiaLBvlYhqJKkp
	36uxJFWyg9XWYHZIBu6Mz1VLgGq3x86cDdFOSLy5YIEMDuGqb/9ze6+NgQRUbL8ODlaGcmsRAtC
	e5B8BBboPuJflGq0RIQSflU+OHDsK6T7lOuKkxzLFitauk2fwgG0RrnzX9UfW9BMsOt7paYQcig
	g6a316/+y+PArXZN2aCl9V3sZ+eZz3AUN81zmc7Q5dIGeq+qTowE2q6jfFPookipqRnWwPTAj98
	dehFq0f6hxXImmhF2OWKFzhU4tyNzT5EOU70bi+GSezppu+1K4VEFeTqU305r/FjMx3LjjPE7fv
	1iDw7gtNsPUGZgKWQJnzXXuolq4uV0NmfASpmExc9/V7OfaNpVrNJzxbSoaRTlj2GK83wbkOILi
	u+iGt5Wac+x8yExJHjZ15/HX0Ajm9iPfciBFyaZqhAwzm6c23rPPJlful4Rkr8pg+sH6n3kmgyS
	uipgEwbyQUmaWW3EezjbYo0N1XT+CVu7lYOcAd0HsoduWpy84xx2bLsR9BNVPZs+2cnbRy67uCr
	cs5J7NPBBWvlIAQ4
X-Received: by 2002:a05:690e:138a:b0:66f:c323:2bbb with SMTP id 956f58d0204a3-66fc32335f3mr7152359d50.74.1788901502034;
        Tue, 08 Sep 2026 14:05:02 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1eca:212:86d0:4e87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb495eccesm11078129d50.18.2026.09.08.14.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:05:01 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 2/7] hfsplus: rework hfsplus_get_block() logic
Date: Tue,  8 Sep 2026 14:04:43 -0700
Message-ID: <20260908210448.296772-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908210448.296772-1-slava@dubeyko.com>
References: <20260908210448.296772-1-slava@dubeyko.com>
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

