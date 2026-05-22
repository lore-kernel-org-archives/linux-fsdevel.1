Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68EE17A2E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410890; cv=none; b=aIxUIQpdU+QFCfOdUgZHF/G2OOB9GNxIAmrwR+4tF/3+b4EKinbVdpmFalVjbrtp3xkXd0CnVNgNl5iFJ1HKqNBi6OEYyzoOLDm6JCNm01rJNf7X67qt+WrHPpGl+EaILoqsdhVJygz+d+vi2U3VE+R9og3NMmWPcrneJU5M9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410890; c=relaxed/simple;
	bh=AWj7qAqmhbK41yk+phxzm2L/KqvZXbL15LYla5B3NZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKsTox240eAjhsqCOQ0Jo1prG9yRzc0hpCmKCyW/J6ILdE9mawwg+2PrVZ6X+M1YVoZ6EVnjMRkEU/l7/6UPyInKC99niE2zATaf1VLiFGRb7hw9HM4ak6hEjn9foJChsXcQpRNq3/LOfgFFxsAAFmHe7hJ/rQFBK6VcobMlaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZGXc2bs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZGXc2bs"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83d31ac4017so3317990b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410888; x=1780015688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBOwiFRsNBVa0NQLLrIYAw0qxWG+4YcJNT8Zjbdg13U=;
        b=SZGXc2bsPUOEjDOPobem+5NeLq/sTDk5Y8ZZtwBvxLFFWFuYKzTAZ83G5sZbSVrFeC
         wf+RENAM0MKC7qjK5z65nrL6Xm5BEPERvVF+95OTysNM+TSHbNw3eaNGUAv0VeRD3x7A
         37NAMZFbftLRCeKSZYl1B443sanyQxSrkfw752ndUh+pDV92PoIo5Qulk1UD+Ghsaptv
         ye7tvX/Pzv6VzilzLk8RzOyS9khC83ndB6UU+4Mb2IbZOWbzGNMOZvClX/k3IIQm3+Sm
         sYoYYKjfvbmrKFLHBDIgNsZOLIVEQSM0XNbC1fAgSPlE0t5fJRo+/gIDnKsWRlrVNEU7
         h0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410888; x=1780015688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBOwiFRsNBVa0NQLLrIYAw0qxWG+4YcJNT8Zjbdg13U=;
        b=iMcEuswW3KlPgNwyI5umwkPYiljAw1rhO1Wbz/h+uqM/HUWId+HjzfjWHG5rFYeBp9
         9PM9586FlZIfW+GK3/4iMzWszwHBLbyHZNUgJ4RP0XSX2SnYokjSCuqc1nPC6PL4mVq/
         07KNzhCVsA0Xgs2L+3JnVhCqrGPZgFR/c/GwTWwQHUAWFjmk9K41OTjDDxYfFLtuR2H/
         6bSvZVW6FWyoHbqspjLoaCrMCP1m/+Uip0gYk/PaRNqw7axUVO32ArSrUayA89po0TWp
         xIbIgdqq4x8QKgZiwHNIboV1zETucjVmyGkdSJ5huyZCVd9cBZQmQ6irTG4IClWy3jUe
         VHsA==
X-Forwarded-Encrypted: i=1; AFNElJ+M9ojih1xuSMkDoqVKF9TcnBwMJ2s22rmY5Vxt3remXKl+LzNhOZ2r14EEYwdu6RLOoXetL/nbLkgpyoV1@vger.kernel.org
X-Gm-Message-State: AOJu0YxCr+0r1MKf6DYi8E2YWPpEamFXjMJ0U8vVyrg/cVyvQPhJD5gb
	wa4ZMV3js3nItf6q2QLHn/fNhwrFLqKDHbu2RIgmBZZvPaj/06EILFgzbYv3UA==
X-Gm-Gg: Acq92OFwDd+x/grcU8BSAOneQN80qh7rLiPn2UrBO6KUYAaw3tqh7rGuFE2sMeD37zB
	EU53KCwzypMzqaszjlHDvRFUBrg7lO8+JivOn5ucqxRvDjz5G5NS6MUMyM6NaOhTIIPYgWlKmY0
	+n78dvjNu7Hu3xPZjzQwvpJwDJqmjqEE+XJHAJD1a2/T9tZi6gzcKllhGRtzXvRHR3s/abn7Z+m
	+EqkaIke0Ha9TQmgrZQkaKfLNxCzjnWSi8NL66TFcUMbapRzq7EQY/+U7RHNo7wivjDyt4oinok
	xPj85RI/POWIghQQFZPhE63jxyvIbHwQB3tWVDv2i1qgBORHxDCtjubVoCqUfcVdoUFTzLLHaB1
	t7S3Loy3tIbyAKMg3hGxDwXtKJcjxFe0/FcWjJgbb7SFygeZxncKJVL3nAeHBbldJXH6KzCnUwd
	BbJ9XKzGJj5VHEDKpGcJ1cvGPzcGf6Qnbu1ZIH9pmQ
X-Received: by 2002:a05:6a00:2d25:b0:835:3f51:72fb with SMTP id d2e1a72fcca58-8415f5aef23mr1397447b3a.12.1779410887939;
        Thu, 21 May 2026 17:48:07 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac99b0sm78484b3a.4.2026.05.21.17.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:48:06 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ntfs: validate index block header more strictly
Date: Fri, 22 May 2026 09:47:44 +0900
Message-ID: <20260522-t-fix-oob-v2-v1-1-0bea6582a361@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7776; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=AWj7qAqmhbK41yk+phxzm2L/KqvZXbL15LYla5B3NZs=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqD6Z9ltmOkpOyJgZEyWHq2Qb28Iz/tN4ByeZ6V
 IYG1b9xkL+JAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCag+mfQAKCRA08jD6945I
 0/1zD/98kLRKtSgKKu9FOehgC0fkYnexjRJBSwJh0Tc3/7G+2oCstvaH0oWFeg78EIIV2ZkysjZ
 5VYzfUo9aj8LvxF02PWNFA5nhWs12KSdmgTnxTYPTXViphVsEu5NX7sJLmdTpUZO6cjpZLJM0eJ
 7JAwb8KWiV///nF9eo8afct1Q1vN9NeTDGnP2qm7MdMooBbGAttnOs+NtaUlyLF4jT2z+TJeYyl
 pjUuQW+Ga9TykBRpQ4ETvvuXJEGX+SYbx6eohtK2WqBROSyNsS5u8JLO73Wa2AsX/h5VHHcjP29
 Lx0EZjkRcgEzKmQXXY5I6sqhj9HNxjsuG7v6pVKSlhgI2R1Vo0t3/twZ933FTwscbM2YPD6Fzkc
 sWMeF5/cj9ZaR4dqyC7R3FLQSuTRZ6qta9+KX+PZNhjqFcMlyMV0Rn8YE2TybpQ1XKUi/ybPOWY
 oUu0s5FP0PISZVfi5CwE6FbR4yrSKDQsjT3cbieVspGXgPE96xLi6DZ21GBNugOCrJv6AJEviRp
 IFVyNDZX+iMk8y/eT9B+0pAWaawr5vmeRyyAHlQZCII1wuy2Ue43NePucpgGbEe10N4gqzKSnLu
 DNwk0mjNhEYUuxe884UmUICs2DqstCkvCwhlUxzdq9AkhomyWIEJFQxcE4aa/IwAeBLutXa+nQw Q7kfmY6Z/HBX2EA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Modify ntfs_index_block_inconsisent() to perform stricter validation of
INDEX_HEADER geometry in INDX blocks, and update
ntfs_lookup_inode_by_name() to use that function to validate INDX
blocks.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/dir.c   | 38 +++++---------------------
 fs/ntfs/index.c | 85 +++++++++++++++++++++++++++++++++++++++++----------------
 fs/ntfs/index.h |  3 ++
 3 files changed, 72 insertions(+), 54 deletions(-)

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
index 146e011c1a41..c203a5ad47b6 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -303,6 +303,53 @@ static int ntfs_ie_end(struct index_entry *ie)
 	return ie->flags & INDEX_ENTRY_END || !ie->length;
 }
 
+static int ntfs_index_header_inconsistent(struct ntfs_volume *vol,
+					  const struct index_header *ih,
+					  u32 bytes_available, u64 inum)
+{
+	u32 entries_offset = le32_to_cpu(ih->entries_offset);
+	u32 index_length = le32_to_cpu(ih->index_length);
+	u32 allocated_size = le32_to_cpu(ih->allocated_size);
+
+	if (bytes_available < sizeof(struct index_header)) {
+		ntfs_error(vol->sb,
+			   "index block in inode %llu is smaller than an index header.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
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
@@ -452,20 +499,19 @@ static struct index_entry *ntfs_ie_dup_novcn(struct index_entry *ie)
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
+			   vcn, (unsigned long long)inum);
 		return -1;
 	}
 
@@ -477,27 +523,18 @@ static int ntfs_index_block_inconsistent(struct ntfs_index_context *icx,
 		return -1;
 	}
 
-	if (ib_size != icx->block_size) {
+	if (ib_size != block_size) {
 		ntfs_error(sb,
-			"Corrupt index block : s64 (%lld) of inode %llu has a size (%u) differing from the index specified size (%u)\n",
-			vcn, inum, ib_size, icx->block_size);
+			   "Corrupt index block : s64 (%lld) of inode %llu has a size (%u) differing from the index specified size (%u)\n",
+			   vcn, inum, ib_size, block_size);
 		return -1;
 	}
 
-	if (le32_to_cpu(ib->index.entries_offset) < sizeof(struct index_header)) {
-		ntfs_error(sb, "Invalid index entry offset in inode %lld\n", inum);
-		return -1;
-	}
-	if (le32_to_cpu(ib->index.index_length) <=
-	    le32_to_cpu(ib->index.entries_offset)) {
-		ntfs_error(sb, "No space for index entries in inode %lld\n", inum);
+	if (ntfs_index_header_inconsistent(vol, &ib->index,
+					   block_size -
+					   offsetof(struct index_block, index),
+					   inum))
 		return -1;
-	}
-	if (le32_to_cpu(ib->index.allocated_size) <
-	    le32_to_cpu(ib->index.index_length)) {
-		ntfs_error(sb, "Index entries overflow in inode %lld\n", inum);
-		return -1;
-	}
 
 	return 0;
 }
@@ -669,7 +706,9 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 	}
 
 	post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->block_size);
-	if (ntfs_index_block_inconsistent(icx, dst, vcn))
+	if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
+					  icx->block_size, vcn,
+					  icx->idx_ni->mft_no))
 		return -1;
 
 	return 0;
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

