Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFF3264E3
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509710; cv=none; b=P8wzVGq6rWGqqQEqWYvZW3hTZQK3N8eTS0iAoRdy6B8y7O1zN0Xv7D3yCXI9FDGvW3gpv+mETZYvLuul4PesL9Uv1uTyxGyNPaNObEDVjcB7kAOshHpCfs7wFaO5l3wsdqVbuM223V07q1BMPyMZ13r0RttswXoNzWYo+R4R4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509710; c=relaxed/simple;
	bh=46LqbPeXy4S6Qp+MoG6RKDX0X4N3JEhFCoWqH8N/us4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw2o76JhX3IazJBaNOBiiP5eJWpF54st1R1bKvvtZyMJcqEu+goFYRlXz3oVzNLKSw6XJECNg5Q6EhiOH0sFZP+CKOBPEfFihGopkWasHhyqqq2bct/WMFsnEoQxtYDkHeAd4dBcDawOT02mWF1+7sJfidmONB2guQFJ2O+aemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfQmN+Js; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfQmN+Js"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bdeed4f717so39889605ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779509708; x=1780114508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZMXkjoayFC0xSY7u2blD+NZCRaguu/ihPEWNfu9YdE=;
        b=dfQmN+Jsw2Dv+5gMwse9hzJKwDFZImFiArVZ234pmMDG5VUEs0rxHvRK1mgZtEkCsS
         jju0NrDqHegCzrq0VzvN18kL4uFRqOkjqfsv/w9fCO8pFF+QetPPoe7SoNf/1Gi76zqn
         +eeYohkGYRavlwvO63RZt7UNAsxpCwKm4IjfBwRwyJaPPLppOrdD42fgBzGQkO4IFkEi
         3mt2lNXDcO8/gAGHxHZoduUyxf03w+/te6dHV98ox7Ol7tXH1FcMnEwK4pJbCcoxdGXm
         A7273Sa7WNoR0zDIiSqi1Rq07r6il30t2h1MaQLJFhH7Squ2m8SMrL9SuUspAkE67/Vj
         mehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509708; x=1780114508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZMXkjoayFC0xSY7u2blD+NZCRaguu/ihPEWNfu9YdE=;
        b=ex7y0aZdFr7qKu3bVjjZqfKHFyHpRq0Q/rPm35LTgHOs3f3XMtf8yRZTLr9U8fEaRM
         U95v3cwexaSjR2iny/j/A+8VksaKUN/YwqIQiGtu/nIWzLPxiPAWCHLnJWynTa4XpPpv
         a382KWv84nNfmpjnxptEQKcTT8ZKJ5a5QaLT3BGV+8J80kOd/OfKhNJuDHmxhQnv3XUM
         StGxMs8B2KazIx6HMg2uqnl96OO1GFVLoQgxhLkLeBQNskIX0tlPrX4v5zTAEZINrsUU
         U4mC9QCoJv+vIoY2HVdmCCxo/QtWgcv/rFoy3lEctQM+DL4pQWxrrDh0yP0mCLd7Esz2
         7sng==
X-Forwarded-Encrypted: i=1; AFNElJ9PHORlYB57cAYjG1NUhJ/JRtlYg9nKk5w16tKo2gO9l/TLVnzfTafcmsycaZSNixfY1pNphOHJtvcmX6za@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uJknGZswIqwsuxdSuf1q8IIjva98Lif9vNYoyd/A1KYnxxll
	2QxywVcp+rojwmuZUCPi0nPZh6ZtYN3BcJTG1ekj8YGlrYs0lsgRnKo5
X-Gm-Gg: Acq92OHOp/dXQ3tJnFWdB6rDF6hn02STuf2NujfChjzKIsT63SCwg60w2HOHAXkR8FP
	Lmlr/C5mbSNLaIsarw8Th29vv1CN7Q/gBx7wtuPzfPUYvQMFOGmCN77wYXhE68bx9Wg/ioeiI4R
	qEPz8XmJVbwBVUkALKy1QQMvvcSYFRLIcod/C/qWgEDx204CVsWrhmJsN6ZZRThahasbc0aaSVS
	2+GOT7LvGX/F10MaMzH7zvOXVkt5V7O5NInjLkzJYiNhr5rqscHGllG/MVnAL+UDvKXII8YhK7P
	/gApuIrGbbGX+zdREaEXjOIQzXhES5nRdTPakeqsvcxe5fJeJFWGbETxMANNCuDp+jntGtTrqNr
	UYxEZsmVCb1UZ7WtXO1krZki5JptydeA8jYZOL/uGmNTMyPRJLKZq3xVjD0/pHh8SZ4PLiFup8p
	IGRB3YudbQQFONWqsSdu7dMK2nlh8NdQ==
X-Received: by 2002:a17:903:1b43:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2beb035b8edmr71165615ad.9.1779509707758;
        Fri, 22 May 2026 21:15:07 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591a277sm31887675ad.80.2026.05.22.21.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 21:15:07 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	woot000 <woot000@woot000.com>
Subject: [PATCH v2 3/4] ntfs: validate index entries on reading
Date: Sat, 23 May 2026 13:14:22 +0900
Message-ID: <20260523041423.2726275-4-hyc.lee@gmail.com>
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

Validate index entries immediately after reading an index root or index
block from disk. This eliminates repeated checks in lookup and readdir,
and reduce the risk of missing checks in those paths.

Tested-by: woot000 <woot000@woot000.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/dir.c   | 28 ++---------------
 fs/ntfs/index.c | 84 +++++++++++++++++++++++++++----------------------
 fs/ntfs/index.h |  8 +++--
 fs/ntfs/inode.c |  8 +++--
 4 files changed, 60 insertions(+), 68 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 6745a0e6e3e7..4b6bd5f30c65 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -135,10 +135,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 		/* Key length should not be zero if it is not last entry. */
 		if (!ie->key_length)
 			goto dir_err_out;
-		/* Check the consistency of an index entry */
-		if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLATION_FILE_NAME,
-				dir_ni->mft_no))
-			goto dir_err_out;
 		/*
 		 * We perform a case sensitive comparison and if that matches
 		 * we are done and return the mft reference of the inode (i.e.
@@ -351,7 +347,8 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 	}
 	err = ntfs_index_block_inconsistent(vol, ia,
 					    dir_ni->itype.index.block_size,
-					    vcn, dir_ni->mft_no);
+					    vcn, COLLATION_FILE_NAME,
+					    dir_ni->mft_no);
 	if (err)
 		goto unm_err_out;
 	index_end = (u8 *)&ia->index + le32_to_cpu(ia->index.index_length);
@@ -364,15 +361,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 	 * reach the last entry.
 	 */
 	for (;; ie = (struct index_entry *)((u8 *)ie + le16_to_cpu(ie->length))) {
-		/* Bounds checks. */
-		if ((u8 *)ie < (u8 *)ia ||
-		    (u8 *)ie + sizeof(struct index_entry_header) > index_end ||
-		    (u8 *)ie + sizeof(struct index_entry_header) + le16_to_cpu(ie->key_length) >
-				index_end || (u8 *)ie + le16_to_cpu(ie->length) > index_end) {
-			ntfs_error(sb, "Index entry out of bounds in directory inode 0x%llx.",
-					dir_ni->mft_no);
-			goto unm_err_out;
-		}
 		/*
 		 * The last entry cannot contain a name. It can however contain
 		 * a pointer to a child node in the B+tree so we just break out.
@@ -382,10 +370,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 		/* Key length should not be zero if it is not last entry. */
 		if (!ie->key_length)
 			goto unm_err_out;
-		/* Check the consistency of an index entry */
-		if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLATION_FILE_NAME,
-				dir_ni->mft_no))
-			goto unm_err_out;
 		/*
 		 * We perform a case sensitive comparison and if that matches
 		 * we are done and return the mft reference of the inode (i.e.
@@ -868,6 +852,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 		ictx->vcn_size_bits = vol->cluster_size_bits;
 	else
 		ictx->vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
+	ictx->cr = ir->collation_rule;
 
 	/* The first index entry. */
 	next = (struct index_entry *)((u8 *)&ir->index +
@@ -905,13 +890,6 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 		if (!next)
 			break;
 nextdir:
-		/* Check the consistency of an index entry */
-		if (ntfs_index_entry_inconsistent(ictx, vol, next, COLLATION_FILE_NAME,
-					ndir->mft_no)) {
-			err = -EIO;
-			goto out;
-		}
-
 		if (ie_pos < actor->pos) {
 			ie_pos += le16_to_cpu(next->length);
 			continue;
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 97c0e7d6a580..00e17637f771 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -28,41 +28,10 @@
  * length must have been checked beforehand to not overflow from the
  * index record.
  */
-int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx,
-		struct ntfs_volume *vol, const struct index_entry *ie,
-		__le32 collation_rule, u64 inum)
+static int ntfs_index_entry_inconsistent(const struct ntfs_volume *vol,
+					 const struct index_entry *ie,
+					 __le32 collation_rule, u64 inum)
 {
-	if (icx) {
-		struct index_header *ih;
-		u8 *ie_start, *ie_end;
-
-		if (icx->is_in_root)
-			ih = &icx->ir->index;
-		else
-			ih = &icx->ib->index;
-
-		if ((le32_to_cpu(ih->index_length) > le32_to_cpu(ih->allocated_size)) ||
-				(le32_to_cpu(ih->index_length) > icx->block_size)) {
-			ntfs_error(vol->sb, "%s Index entry(0x%p)'s length is too big.",
-					icx->is_in_root ? "Index root" : "Index block",
-					(u8 *)icx->entry);
-			return -EINVAL;
-		}
-
-		ie_start = (u8 *)ih + le32_to_cpu(ih->entries_offset);
-		ie_end = (u8 *)ih + le32_to_cpu(ih->index_length);
-
-		if (ie_start > (u8 *)ie ||
-		    ie_end <= (u8 *)ie + le16_to_cpu(ie->length) ||
-		    le16_to_cpu(ie->length) > le32_to_cpu(ih->allocated_size) ||
-		    le16_to_cpu(ie->length) > icx->block_size) {
-			ntfs_error(vol->sb, "Index entry(0x%p) is out of range from %s",
-					(u8 *)icx->entry,
-					icx->is_in_root ? "index root" : "index block");
-			return -EIO;
-		}
-	}
-
 	if (ie->key_length &&
 	    ((le16_to_cpu(ie->key_length) + offsetof(struct index_entry, key)) >
 	     le16_to_cpu(ie->length))) {
@@ -352,6 +321,44 @@ static int ntfs_index_header_inconsistent(struct ntfs_volume *vol,
 	return 0;
 }
 
+int ntfs_index_entries_inconsistent(const struct ntfs_volume *vol,
+				    const struct index_header *ih,
+				    __le32 collation_rule, u64 inum)
+{
+	struct index_entry *ie;
+	u8 *index_end = (u8 *)ih + le32_to_cpu(ih->index_length);
+
+	for (ie = ntfs_ie_get_first((struct index_header *)ih);
+	      ; ie = ntfs_ie_get_next(ie)) {
+		if ((u8 *)ie + sizeof(struct index_entry_header) > index_end ||
+		    (u8 *)ie + le16_to_cpu(ie->length) > index_end) {
+			ntfs_error(vol->sb,
+				   "Index entry out of bounds in inode %llu.",
+				   (unsigned long long)inum);
+			return -EIO;
+		}
+
+		if (le16_to_cpu(ie->length) < sizeof(struct index_entry_header)) {
+			ntfs_error(vol->sb,
+				   "Index etnry too small in inode %llu.",
+				   inum);
+			return -EIO;
+		}
+
+		if (ntfs_ie_end(ie))
+			break;
+
+		if (!ie->key_length)
+			return -EIO;
+
+		if (ntfs_index_entry_inconsistent(vol, ie,
+						  collation_rule, inum))
+			return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  *  Find the last entry in the index block
  */
@@ -503,7 +510,8 @@ static struct index_entry *ntfs_ie_dup_novcn(struct index_entry *ie)
  */
 int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 				  const struct index_block *ib,
-				  u32 block_size, s64 vcn, u64 inum)
+				  u32 block_size, s64 vcn, __le32 cr,
+				  u64 inum)
 {
 	u32 ib_size = (unsigned int)le32_to_cpu(ib->index.allocated_size) +
 		offsetof(struct index_block, index);
@@ -537,7 +545,8 @@ int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 					   offsetof(struct index_block, index),
 					   inum))
 		return -EIO;
-
+	if (ntfs_index_entries_inconsistent(vol, &ib->index, cr, inum))
+		return -EIO;
 	return 0;
 }
 
@@ -727,10 +736,9 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 
 	post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->block_size);
 	if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
-					  icx->block_size, vcn,
+					  icx->block_size, vcn, icx->cr,
 					  icx->idx_ni->mft_no))
 		return -EIO;
-
 	return 0;
 }
 
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index cad78568d8b3..9a03f53bba47 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -94,9 +94,11 @@ int ntfs_index_root_inconsistent(struct ntfs_volume *vol,
 				 const struct index_root *ir, u64 inum);
 int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 				  const struct index_block *ib,
-				  u32 block_size, s64 vcn, u64 inum);
-int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx, struct ntfs_volume *vol,
-		const struct index_entry *ie, __le32 collation_rule, u64 inum);
+				  u32 block_size, s64 vcn,
+				  __le32 cr, u64 inum);
+int ntfs_index_entries_inconsistent(const struct ntfs_volume *vol,
+				    const struct index_header *ih,
+				    __le32 collation_rule, u64 inum);
 struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni, __le16 *name,
 		u32 name_len);
 void ntfs_index_ctx_put(struct ntfs_index_context *ictx);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 63ee7acff4fc..9717fb5b4709 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -939,7 +939,9 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		}
 		ir = (struct index_root *)((u8 *)a +
 				le16_to_cpu(a->data.resident.value_offset));
-		if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mft_no)) {
+		if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mft_no) ||
+		    ntfs_index_entries_inconsistent(ni->vol, &ir->index,
+						    ir->collation_rule, ni->mft_no)) {
 			ntfs_error(vi->i_sb, "Directory index is corrupt.");
 			goto unm_err_out;
 		}
@@ -1529,7 +1531,9 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	}
 
 	ir = (struct index_root *)((u8 *)a + le16_to_cpu(a->data.resident.value_offset));
-	if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no)) {
+	if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no) ||
+	    ntfs_index_entries_inconsistent(vol, &ir->index,
+					    ir->collation_rule, ni->mft_no)) {
 		ntfs_error(vi->i_sb, "Index is corrupt.");
 		goto unm_err_out;
 	}
-- 
2.43.0

