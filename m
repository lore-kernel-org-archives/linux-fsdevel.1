Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC72F690F
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509700; cv=none; b=HQsE/NW+j3WnYZryhV5076KmZG2en/uBFZxcmLDyd7elEC6elR85QpqQnV3BsbsCiKAjCg5/QlXWPm3T9oZm5BdHlG1BvkMiKiXY5UsLmJpvZeg4+/2RER1vFwP9yttWWWLBZYxZUBvfL0njv4K7zKkf1dAxUTyAMwOarTKLOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509700; c=relaxed/simple;
	bh=Sj4TYlqsEDJ1E31zDNcwz8WQKjkuNqBUsRzmM/JS7m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1oqNAf9uCAb3+ax1T/7Dewi5IChpxQjS2TpatO4Kanfke45kO9Y0MGQex4iKvKF2GdIG3vyrQgiwfNEvcUhchD+b7YzZnEF01kClcXmwO5hyfQphTUSoGy+BCTJtWv1c8XK7hXQmV43tJYAp/0jR/x4RZbyG0R/qNZoPl07uAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA4/M0vG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA4/M0vG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bccb978bd9so53400125ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 21:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779509697; x=1780114497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPHBFgx2JoaZqgDjoqYVl+IzgvEea3y23kJ9Tps9FIk=;
        b=LA4/M0vGsCpsET6fxYomucSjNVfJ3f142u3gnqKmrqt8WgKnjc5/by+zxnGkBAGrl4
         b0MjcOReHlDuFJql2pI231yZw5ATgDxNxMQ2+HzVB8L1g1lhecI/JvTAlXYi/0Av1m4T
         86nohoHbk0UlEfGxwWwgY/CsUz1apv49jVKC4i+VWh172jqLCIx6zy6h9/nWR3DG67tv
         mfNX93PjBgZEYPcsYh9B4yvinhZiBqaoJxwttDog4VvCjg4Ddi4gNkvcRHaMc2HE9MC8
         E/BInw8ofv9ls5s+eqNWV0pX80NadFLrdvFtnkWIAfH50Su4atud5EcnBZjDzlfglXRT
         SUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509697; x=1780114497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPHBFgx2JoaZqgDjoqYVl+IzgvEea3y23kJ9Tps9FIk=;
        b=M79MFygVkcQMYQOH57rQyZvrczQGVf7E1AJfKLLcLJB14Lx3Pv/x2RSZqn6Q1rPCjN
         etZr1UKay/+dytHMOaIWPP+N2EPhupLtIx3bN39TQlpvf+T8pMPE+xtmpkCwLIQuhTIz
         OwLSVHNzNdc71ig/RRlKWcsSZlPhYTzkJHz324rO/TgFg4ioRwj1hRR9hn4cPHVNHO5C
         15xTlhUAwJ1ykuaz7HdSMif8Bs/Ts0sn2ESfxYqr1Wntt6u9O25FSAaP3KeZBCyyy31K
         oQFmA43ZFa81gh6G2IQB9vuMYyiLRZjGwoGoDTaIctZoLr0x/aosDGZUA+dnv+PpyaHA
         L4wQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Q1jeZeZUMI8mMxzA105e4kLmIbYoPYl1vRW471vHwl87AKjqBwl0XokdNjUVtDSWjSVD8puTOnCWqW/z2@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+1eGuO0PG4MksPw5aQ2lhFJLBekDeluWQtl2Oe28mLFiFu+y
	LawGF/oUTD14iaxOcQG4WQl+AQGS9l9tKPNEAdmpU3826LPzhJJ5yyzn
X-Gm-Gg: Acq92OEG5hxQx/qsictygh11LEZeUj+XVVH3KC8yPCHElYWBrZKZW9Pg4LKjp23smb0
	iXkomiF8LdZFjaBEWVfaujgNrmKTXH7GPD/ZG6XCnROYKlywl5xm28cco3T/Ss5KP4OHQAGvcqx
	C32OtjqIUEZFYvhhnfGg1fKcdPLCPgWlSaoDhcUhBBEy6HUUdOnUr9XG9bA4Hhnj5NfjKRJ51U2
	GrfQS2OuR2SwOUU/7WHE3u3IyUYJMk3/D8/MyCoe++YuqJ4lST3wurTcJjl85H3fEqQB/laibV5
	kUCR+0pz8nnBsDGpHlT/Bnflr9pccIvNJ+m6QeJm4zlOihavvSs89MT8kno9LzQKnZky7TDOKWt
	T0QboiNzV8348q1GA+nge/rdbo4ZHfScR/NuyZ+Ar5LfFBziPIStmML+0xRi6Ggd4am4M3rjvG5
	7ddbBXKRGx7UAUy9f2pzTuS3u9AQ2p+g==
X-Received: by 2002:a17:903:41c4:b0:2ba:21c2:d6cb with SMTP id d9443c01a7336-2beb08843d7mr52197895ad.16.1779509696527;
        Fri, 22 May 2026 21:14:56 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591a277sm31887675ad.80.2026.05.22.21.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 21:14:55 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	woot000 <woot000@woot000.com>
Subject: [PATCH v2 1/4] ntfs: validate index block header more strictly
Date: Sat, 23 May 2026 13:14:20 +0900
Message-ID: <20260523041423.2726275-2-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523041423.2726275-1-hyc.lee@gmail.com>
References: <20260523041423.2726275-1-hyc.lee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify ntfs_index_block_inconsisent() to perform stricter validation of
INDEX_HEADER geometry in INDX blocks, and update
ntfs_lookup_inode_by_name() to use that function to validate INDX
blocks.

Tested-by: woot000 <woot000@woot000.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/dir.c   |  38 ++++--------------
 fs/ntfs/index.c | 101 ++++++++++++++++++++++++++++++++++--------------
 fs/ntfs/index.h |   3 ++
 3 files changed, 81 insertions(+), 61 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 20f5c7074bdd..6745a0e6e3e7 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -342,43 +342,19 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 			dir_ni->mft_no);
 		goto unm_err_out;
 	}
-	/* Catch multi sector transfer fixup errors. */
-	if (unlikely(!ntfs_is_indx_record(ia->magic))) {
-		ntfs_error(sb,
-			"Directory index record with vcn 0x%llx is corrupt.  Corrupt inode 0x%llx.  Run chkdsk.",
-			vcn, dir_ni->mft_no);
-		goto unm_err_out;
-	}
-	if (le64_to_cpu(ia->index_block_vcn) != vcn) {
-		ntfs_error(sb,
-			"Actual VCN (0x%llx) of index buffer is different from expected VCN (0x%llx). Directory inode 0x%llx is corrupt or driver bug.",
-			le64_to_cpu(ia->index_block_vcn),
-			vcn, dir_ni->mft_no);
-		goto unm_err_out;
-	}
-	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
-			dir_ni->itype.index.block_size) {
-		ntfs_error(sb,
-			"Index buffer (VCN 0x%llx) of directory inode 0x%llx has a size (%u) differing from the directory specified size (%u). Directory inode is corrupt or driver bug.",
-			vcn, dir_ni->mft_no,
-			le32_to_cpu(ia->index.allocated_size) + 0x18,
-			dir_ni->itype.index.block_size);
-		goto unm_err_out;
-	}
 	index_end = (u8 *)ia + dir_ni->itype.index.block_size;
 	if (index_end > kaddr + PAGE_SIZE) {
 		ntfs_error(sb,
-			"Index buffer (VCN 0x%llx) of directory inode 0x%llx crosses page boundary. Impossible! Cannot access! This is probably a bug in the driver.",
-			vcn, dir_ni->mft_no);
+			   "Index buffer (VCN 0x%llx) of directory inode 0x%llx crosses page boundary. Impossible! Cannot access! This is probably a bug in the driver.",
+			   vcn, dir_ni->mft_no);
 		goto unm_err_out;
 	}
-	index_end = (u8 *)&ia->index + le32_to_cpu(ia->index.index_length);
-	if (index_end > (u8 *)ia + dir_ni->itype.index.block_size) {
-		ntfs_error(sb,
-			"Size of index buffer (VCN 0x%llx) of directory inode 0x%llx exceeds maximum size.",
-			vcn, dir_ni->mft_no);
+	err = ntfs_index_block_inconsistent(vol, ia,
+					    dir_ni->itype.index.block_size,
+					    vcn, dir_ni->mft_no);
+	if (err)
 		goto unm_err_out;
-	}
+	index_end = (u8 *)&ia->index + le32_to_cpu(ia->index.index_length);
 	/* The first index entry. */
 	ie = (struct index_entry *)((u8 *)&ia->index +
 			le32_to_cpu(ia->index.entries_offset));
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 146e011c1a41..9713b082b03d 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -303,6 +303,55 @@ static int ntfs_ie_end(struct index_entry *ie)
 	return ie->flags & INDEX_ENTRY_END || !ie->length;
 }
 
+static int ntfs_index_header_inconsistent(struct ntfs_volume *vol,
+					  const struct index_header *ih,
+					  u32 bytes_available, u64 inum)
+{
+	u32 entries_offset, index_length, allocated_size;
+
+	if (bytes_available < sizeof(struct index_header)) {
+		ntfs_error(vol->sb,
+			   "index block in inode %llu is smaller than an index header.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
+
+	entries_offset = le32_to_cpu(ih->entries_offset);
+	index_length = le32_to_cpu(ih->index_length);
+	allocated_size = le32_to_cpu(ih->allocated_size);
+
+	if (entries_offset < sizeof(struct index_header) ||
+	    entries_offset > bytes_available) {
+		ntfs_error(vol->sb,
+			   "Invalid index entry offset in inode %llu.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
+
+	if (index_length <= entries_offset) {
+		ntfs_error(vol->sb,
+			   "No space for index entries in inode %llu.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
+
+	if (allocated_size < index_length) {
+		ntfs_error(vol->sb,
+			   "Index entries overflow in inode %llu.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
+
+	if (allocated_size > bytes_available || index_length > bytes_available) {
+		ntfs_error(vol->sb,
+			   "Index entries in inode %llu exceed the available buffer.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  *  Find the last entry in the index block
  */
@@ -437,7 +486,7 @@ static struct index_entry *ntfs_ie_dup_novcn(struct index_entry *ie)
  * The size of block is assumed to have been checked to be what is
  * defined in the index root.
  *
- * Returns 0 if no error was found -1 otherwise (with errno unchanged)
+ * Returns 0 if no error was found, -EIO otherwise
  *
  * |<--->|  offsetof(struct index_block, index)
  * |     |<--->|  sizeof(struct index_header)
@@ -452,21 +501,20 @@ static struct index_entry *ntfs_ie_dup_novcn(struct index_entry *ie)
  *
  * size(struct index_header) <= ent_offset < ind_length <= alloc_size < bk_size
  */
-static int ntfs_index_block_inconsistent(struct ntfs_index_context *icx,
-		struct index_block *ib, s64 vcn)
+int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
+				  const struct index_block *ib,
+				  u32 block_size, s64 vcn, u64 inum)
 {
 	u32 ib_size = (unsigned int)le32_to_cpu(ib->index.allocated_size) +
 		offsetof(struct index_block, index);
-	struct super_block *sb = icx->idx_ni->vol->sb;
-	unsigned long long inum = icx->idx_ni->mft_no;
+	struct super_block *sb = vol->sb;
 
 	ntfs_debug("Entering\n");
 
 	if (!ntfs_is_indx_record(ib->magic)) {
-
 		ntfs_error(sb, "Corrupt index block signature: vcn %lld inode %llu\n",
-				vcn, (unsigned long long)icx->idx_ni->mft_no);
-		return -1;
+			   vcn, (unsigned long long)inum);
+		return -EIO;
 	}
 
 	if (le64_to_cpu(ib->index_block_vcn) != vcn) {
@@ -474,30 +522,21 @@ static int ntfs_index_block_inconsistent(struct ntfs_index_context *icx,
 			"Corrupt index block: s64 (%lld) is different from expected s64 (%lld) in inode %llu\n",
 			(long long)le64_to_cpu(ib->index_block_vcn),
 			vcn, inum);
-		return -1;
+		return -EIO;
 	}
 
-	if (ib_size != icx->block_size) {
+	if (ib_size != block_size) {
 		ntfs_error(sb,
-			"Corrupt index block : s64 (%lld) of inode %llu has a size (%u) differing from the index specified size (%u)\n",
-			vcn, inum, ib_size, icx->block_size);
-		return -1;
+			   "Corrupt index block : s64 (%lld) of inode %llu has a size (%u) differing from the index specified size (%u)\n",
+			   vcn, inum, ib_size, block_size);
+		return -EIO;
 	}
 
-	if (le32_to_cpu(ib->index.entries_offset) < sizeof(struct index_header)) {
-		ntfs_error(sb, "Invalid index entry offset in inode %lld\n", inum);
-		return -1;
-	}
-	if (le32_to_cpu(ib->index.index_length) <=
-	    le32_to_cpu(ib->index.entries_offset)) {
-		ntfs_error(sb, "No space for index entries in inode %lld\n", inum);
-		return -1;
-	}
-	if (le32_to_cpu(ib->index.allocated_size) <
-	    le32_to_cpu(ib->index.index_length)) {
-		ntfs_error(sb, "Index entries overflow in inode %lld\n", inum);
-		return -1;
-	}
+	if (ntfs_index_header_inconsistent(vol, &ib->index,
+					   block_size -
+					   offsetof(struct index_block, index),
+					   inum))
+		return -EIO;
 
 	return 0;
 }
@@ -665,12 +704,14 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 		else
 			ntfs_error(icx->idx_ni->vol->sb,
 				"Failed to read full index block at %lld\n", pos);
-		return -1;
+		return -EIO;
 	}
 
 	post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->block_size);
-	if (ntfs_index_block_inconsistent(icx, dst, vcn))
-		return -1;
+	if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
+					  icx->block_size, vcn,
+					  icx->idx_ni->mft_no))
+		return -EIO;
 
 	return 0;
 }
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index e68d6fabaf9f..3451ec8a1c4e 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -89,6 +89,9 @@ struct ntfs_index_context {
 	bool sync_write;
 };
 
+int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
+				  const struct index_block *ib,
+				  u32 block_size, s64 vcn, u64 inum);
 int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx, struct ntfs_volume *vol,
 		const struct index_entry *ie, __le32 collation_rule, u64 inum);
 struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni, __le16 *name,
-- 
2.43.0

