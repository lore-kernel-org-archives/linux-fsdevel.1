Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D85233924
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410909; cv=none; b=T9mWOlkPEv5FBAWAy/JwY4r32ZeqcyIlsp/tXMW8Kfkhrz1xKEzuL+k5R1+KDcmwPt+PTQA84yJtreDTSaZ/rCKWn1rQh1AZt2vjd9FKtAXf+Wc1u62GXwcjr31VTBR4u+Fb+2DANX1R1y77X4UXeS86D1Mk1yTWAi2t3UuZ3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410909; c=relaxed/simple;
	bh=dcCWOB4BeVqjZPJUd0+HQG4oF8oQzhW58FogfZUawoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYYt+kRy8L66zOvHv0PTZcquAQzAtnUr9XhdPTpboWPVoM+CnjaTV6OIoSnFB2iWcGCmS8R37x91KfJi2dRfypuHKvo+dbIhg7mdlpG2yARz5Yf8y8+//IPYIwYALQtdHdTt1MyH6Q6UF+c8bfqpaXb74xkLRFWk0YkpyVfQajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LipX0gyM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LipX0gyM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso3298273b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410907; x=1780015707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVlt00jdkrtb4Wx5jimUgpYV6iF7+tQ5Xz5hxOJ/pOI=;
        b=LipX0gyM60UDhofice6nRfpierbaf5iX0oAaT8+sN1khgpvzSYb2JjX/FzczOs+ni6
         ShjtqVP5jBweLSekEun+hG3JdwNhuMxP6Mz7uE/oyNSzlLJywzkyGSJdb6MmN7nogfrf
         /q7jPAtFR0cR1/mB7OAlVhLAiQ7zH9gqMxcUelMOrtSXfuM0X/Sfd4XsMuA9FlexvgS+
         eSO6cvijA+aRmw9N48L5lOv+AIXsqbxjbNic7YjHvOyRlgmSG/XmDbivEgF2uo2fGU2V
         IcMPfLlOhATodvUM7P2cf54Auwu/S/Ndbt3Io5c6BL5tmGffVINGJAtVyUCaey5Vo1F3
         Uvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410907; x=1780015707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVlt00jdkrtb4Wx5jimUgpYV6iF7+tQ5Xz5hxOJ/pOI=;
        b=fmRs1dF9c745OfQ4poh/8rV5KzlRbYpE90SBflwpyiZZxbhL4Yby2UDBoeFNkVnwI6
         8v7lAwHW8aP4e6Z9mZpF7DBzrvcP069tRYxUMpvtb+BcGXZjibVSaLEOyVW446kKwBk9
         +ebzJerHhST5EhGsZg/7iRhmy3zQWAPEwis7PzZwF0zk8p4P70F33+QVBw4jOqaO4fyj
         p7V5N1Pw8khqBwYZHRM83xq0iJ5mEk40BzwDW8ClCOf/GeTf4YIYD42Rt8z0LzikiGft
         Ur8JNYUeEZnxbFmQOutJQo7sZ5eSZ9c7LTCOJ/WwKjPKcVoKRFO2DlWkdZTV08YTtewC
         sVRg==
X-Forwarded-Encrypted: i=1; AFNElJ+LYPcHE0HVFi+Vx4DBEFTDZkzTtoVhVNow+iGt6QeOhfAAOWo6/DEU5BM/9mI1W0GU3mZLxdX3LFH3OwEK@vger.kernel.org
X-Gm-Message-State: AOJu0YwvW8tq4xeMoUS8dvD9yQjb2daDlH9o+7j5BTPZLm4U6bJYiSy3
	H23CWVbLze7EqZHjVHsrnTUXBXwuqibfV/AhCrzFLgBXLlEq9YLMecY0
X-Gm-Gg: Acq92OGewdrYN8X+UumDi23D/HWDhjrWYTDIwRxXAH1pPjN2nQJ7fMqnb8X6n2LUScv
	E0AHYhsFG2RB/847J5fDxjW4QviP4hWMkVuaJ7ed1aPa1b91upyBqrhaSycNuUOC79yeiEW3fOR
	2a94RMNQvJayYPIjoZjXSZIhoWi0IrTz0qqRbr9udUESMlpCU+/O6bE+Tm3OUx3ByL9MnzODC0m
	d/SqNTynMZ0O7JBC9i0Vr3uehpU54r+P+Pu8MoWBRW6llaZHostzY6SMutvwH91rPC3W3X6wRKp
	l7IC/1GMu3VvXIzq4E2Jh1klRn9N15GK2Y0nIUD6ctHIur8HKSdIHlIdrKCr9dqGqrYhd2IHWBY
	CWkCrJUc6BRPW1aftjsOWs4jv+N74cU9QXEwiym5WDdptFWq1yliAJaf8aNMWdw1z5ZtzmS6un4
	J/3jzLLmki/8Q0PmLNr9vJcYGAS4wCsFaZjLg9xrtD
X-Received: by 2002:a05:6a00:bc8a:b0:82f:39df:dd54 with SMTP id d2e1a72fcca58-8414b40f5c6mr4195197b3a.8.1779410906721;
        Thu, 21 May 2026 17:48:26 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac99b0sm78484b3a.4.2026.05.21.17.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:48:25 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ntfs: validate index entries on reading
Date: Fri, 22 May 2026 09:47:46 +0900
Message-ID: <20260522-t-fix-oob-v2-v1-3-0bea6582a361@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10630; i=hyc.lee@gmail.com; h=from:subject:message-id; bh=dcCWOB4BeVqjZPJUd0+HQG4oF8oQzhW58FogfZUawoQ=; b=kA0DAAoBNPIw+veOSNMByyZiAGoPpn6iqM4AEFykhObBdEVg0Rr95uE3JUqGn5Yg3fMOC49qd IkCMwQAAQoAHRYhBNWFKcxTduNtbh5vYjTyMPr3jkjTBQJqD6Z+AAoJEDTyMPr3jkjT9IgP/1qn Bc1fD/iqN/vK3D9fBAT0LmiJrgyl+tH0W9jx2pBVm8LFzoD6Scte5bru36pRntASZgCxHIoAaT5 SnUohXfER1PjIHXCeHA6DwSXBxMkJ3QT6juBdhBvyAY+7Ihqu3AZsR2cee9JIUTSZ5X2KO/hWCP QHVXGojOJelUV2VMhkFceoBAJFwb7kyHdcs+13sKeVo1F5ZdgCB/1L0zHx7VsPydvjaG/VHEu4H Dubr+yRbPnBRlsMay7vGVi55XGmLRDNeY9GwT6EnB/7bnVlpcLE730kUBqRU2bM66kdBnXwfNKB 0DAsRFEAGxUQwTCzCpHZdujCNoLCRJWpiEKxIGs9YBoUlXIMuFgQBGTvClK1jQ8Tcfpc0bB6wsI YmKuL/aonc19iLz1lMvwJW57qmgOoSKgv/ABgWLD8W3gP5OTJvbMv9BHpYOwnekrsSneuijyl/n 2kBzKx+IFguYUeHPOJkSFmw4wa2rkwKFd05GpFyAvxWuCHpaokyE8KQ7eboq6cBuBThwPtUNUhZ vDvThoCOMm/jjxfHiRxPvsP6DY02ao0e8Vmx/LbuwUKqtzcJf5WuNyx8Ms0SEwHNHPLNN94Ehml nPIG/oc7LoR9ihTNOz6kf064ADLogpiUaC8lPIhelRpKAKsBwhV5kolLUKQNb8J6PmLBKDkQjH2 L19n9
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Validate index entries immediately after reading an index root or index
block from disk. This eliminates repeated checks in lookup and readdir,
and reduce the risk of missing checks in those paths.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/dir.c   | 28 ++---------------
 fs/ntfs/index.c | 96 +++++++++++++++++++++++++++++++--------------------------
 fs/ntfs/index.h |  8 +++--
 fs/ntfs/inode.c |  8 +++--
 4 files changed, 66 insertions(+), 74 deletions(-)

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
index 91fcaa79f8ac..456e195ca5c9 100644
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
@@ -350,6 +319,44 @@ static int ntfs_index_header_inconsistent(struct ntfs_volume *vol,
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
@@ -501,7 +508,8 @@ static struct index_entry *ntfs_ie_dup_novcn(struct index_entry *ie)
  */
 int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 				  const struct index_block *ib,
-				  u32 block_size, s64 vcn, u64 inum)
+				  u32 block_size, s64 vcn, __le32 cr,
+				  u64 inum)
 {
 	u32 ib_size = (unsigned int)le32_to_cpu(ib->index.allocated_size) +
 		offsetof(struct index_block, index);
@@ -512,7 +520,7 @@ int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 	if (!ntfs_is_indx_record(ib->magic)) {
 		ntfs_error(sb, "Corrupt index block signature: vcn %lld inode %llu\n",
 			   vcn, (unsigned long long)inum);
-		return -1;
+		return -EIO;
 	}
 
 	if (le64_to_cpu(ib->index_block_vcn) != vcn) {
@@ -520,22 +528,23 @@ int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 			"Corrupt index block: s64 (%lld) is different from expected s64 (%lld) in inode %llu\n",
 			(long long)le64_to_cpu(ib->index_block_vcn),
 			vcn, inum);
-		return -1;
+		return -EIO;
 	}
 
 	if (ib_size != block_size) {
 		ntfs_error(sb,
 			   "Corrupt index block : s64 (%lld) of inode %llu has a size (%u) differing from the index specified size (%u)\n",
 			   vcn, inum, ib_size, block_size);
-		return -1;
+		return -EIO;
 	}
 
 	if (ntfs_index_header_inconsistent(vol, &ib->index,
 					   block_size -
 					   offsetof(struct index_block, index),
 					   inum))
-		return -1;
-
+		return -EIO;
+	if (ntfs_index_entries_inconsistent(vol, &ib->index, cr, inum))
+		return -EIO;
 	return 0;
 }
 
@@ -720,15 +729,14 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 		else
 			ntfs_error(icx->idx_ni->vol->sb,
 				"Failed to read full index block at %lld\n", pos);
-		return -1;
+		return -EIO;
 	}
 
 	post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->block_size);
 	if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
-					  icx->block_size, vcn,
+					  icx->block_size, vcn, icx->cr,
 					  icx->idx_ni->mft_no))
-		return -1;
-
+		return -EIO;
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

