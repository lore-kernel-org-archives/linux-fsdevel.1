Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EE3B42E7
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429210; cv=none; b=EyBNBeYEXJRaGJAaHhXDeqOdWQR0XAWVyb7WVCSEDiccs9+4Zad8xiMs+VUFfQefLM06sfmLPV0LbKbBQRGzNHknqfPCu/yUSNxRYT7wLVKJd7UnTsnkd3BkfQQbf2A+ktqV3AJOp1WcdNKwLNRzgSZpUowTJS9YYNmXLNry4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429210; c=relaxed/simple;
	bh=KQ9TioCk7IAXoYKsbOf3mo0CBYIbu2RGH/UJt8EFt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwtT5lZjAyZgpZF8MDTM0JcXSBNB9CvaB1iP4wRb4fkxE+ekTg/6n+BlVER7akJY+KIEOq3HKFJ8iFeMAl3rVQIBAtMl5T9UKmdqfDfLod0LRSCFD3+1ek167TMCvoeKpS6qOQyZEl+007x3S5shpVDcTybfZd9jEiH+CKVtF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=swZ6bKWN; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="swZ6bKWN"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab20f4bso2369046d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 16:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789429207; x=1790034007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hss3hwS5MmprOQZWPrR8lu4oaz0ib++0UrLxiJhoUVs=;
        b=swZ6bKWNREIpHz6S2Q0AJj+n4NIiJsvlNdJR9hKksm3Rbx7hTrcpeKapg5GdCqmspu
         E7bNogZ000x/Q7z+AkOX862ek2pdoysduEkssEDLslYIiYPKjtRCB360FdO7EtG1rzjg
         6Hr/3S0xgrMKYyWKQGLuDKH3MvtTUekzxjCWddES5T3Ji+5atuOcRq9kbjSuDXpaV/fz
         wmPj6LMR2YyM7tqRdj+DI3AarHvyF2CZXi10UGAcNGbkmTEx59/gjw82l9K+UNePgl1o
         Ck03IRloD5osrYLGjQNGK35u8hrKvniwmxr/bZkpDTgTONVe+cBHbsPgKoXaLM7Eyw/K
         bmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789429207; x=1790034007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hss3hwS5MmprOQZWPrR8lu4oaz0ib++0UrLxiJhoUVs=;
        b=EfAaOyStl5H7EbIQtLcVD4BW9jkDyCgc+7wA71ag73ZRbKeoA0H2joSGQWIU8pzDaA
         UHNdoVItwBZXVty/BC3SS/16QPb583uyb3DawXYkL4JCs38RuFOSt/vAGAMKMU81l5vt
         IuP6CKgDU+dQfWbxlrn6J42m2e/QiBCwWeBBGjhXxUmcCHTK7cv/x+4bADHBESJ/zd3U
         YZ1u9OppgGu5FwNa5sUkSAtPoD12rDHp8LpqcA3KkTokFMydvHZS4Gnbkru7qLhWd84U
         3/gC59W03DfxtHTXfZcEgVwdcF1wAdhUCcBLNuYp5AA3hwxgfoMFAj3XlH2BMXewXKod
         lxZg==
X-Gm-Message-State: AFuF++kZmabeSzm0UL+hS0B6uBRRmoWNIGvUHgY7jskTqPcbdQXMPdtN
	Omye0CEVungSF4zH7waoBY/UQ4dwilf7vby1w0k5DydxL6xImcDidQczPSTAo3xcjvs=
X-Gm-Gg: AYBFou289mxQRBtE8NEQQytssa4noeKlOxvKYXkUXXv7mgC8Ku7DWCXl9PD4jNXl8Es
	xr2poQkipCfe9IEf+OLelKnPxwcvNTYhYJABUtBjRU4Y4MVxlmVRdxVEcxcVT3J6a7ij3VDaIHJ
	zkC2ud6bRVlSn2lasf4vXm8KILAaw4jf8McuSIgxgV1V6DXN+BUBi0/s5/VYVThPyBa17W4RWXZ
	XgMi8G/AG5cvssIG4IPzccHm0/ewCNLy+ksG9J4ymoW5horkbBg+yjn/jTNuUYx3wpA8/t+c+uh
	GfOQ2jog7dm6JFzyYAPwZSyf/CAVkNaIK6rvKMKx2UgJkwxTYQ+ajIAqexyAmX7q0LaNn4nntKa
	c1OxMad1C6CTkTCHIBxRJ0f9z+fOVCOlPsKyNHfxYs9UJtlPjFoHIM4w9cPakBiavT02SgBEDj8
	J473PJmj1rvf5NWXdv2fPlLEOYz8YNJ3JCOGf3vGSxp6YR3NE3UXPJbxAZJindEYDUfDDhsfZ3x
	gTQ6TIz7YzNMueObeCA35uaXmEVYNMy3ZYkN6KgEtjnNCO8NX33uVs4/Olbsmg650d1NuFBe850
	okC0DouOgAw5fOHNtTuHkELKQe4F
X-Received: by 2002:a05:690e:454e:20b0:671:214:30a6 with SMTP id 956f58d0204a3-6714e1a2387mr1003980d50.94.1789429207416;
        Mon, 14 Sep 2026 16:40:07 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:df87:8743:655b:3824])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e3fa87sm5207804d50.14.2026.09.14.16.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:40:06 -0700 (PDT)
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
Subject: [PATCH v4 2/7] hfsplus: rework hfsplus_get_block() logic
Date: Mon, 14 Sep 2026 16:39:36 -0700
Message-ID: <20260914233941.2966421-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914233941.2966421-1-slava@dubeyko.com>
References: <20260914233941.2966421-1-slava@dubeyko.com>
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

