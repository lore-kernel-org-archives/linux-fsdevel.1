Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6631716B
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509705; cv=none; b=NaC8t1IV4oRdNE1aRYcqQh0gweh1HDcXHn4fvdeiDIPI3nU4aZREFBH6WqHSa1ysTqncNfdL+ZYfA7kPdDK2pl7j+0Zv8Hld4yzm0fkpYEHjcq3aVwaP9gZT/MEUJSIRVpUveiWyVLWLcSUdixMJV0HXY+L4hILMtV4hcW4DLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509705; c=relaxed/simple;
	bh=6jofB/yXxm47kMPOD05SB9GL4SDnN6o6L7Cg9O4IUpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edjNf4avFXFxlao7EqD9RiZY28b6onXYlIkOKMqUfHLj1qJCuRVYUrPJXjanFvmvO64s+cfX/18gp6DpzkKuW9MLRvbn/ioIiyvd+r6kAbKCiYV7EcO1aywy2SejnwPusRA7WLY3yMOhWMTyveMfsa7isShOzk6zty7Au30cfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/qzTQdA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/qzTQdA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2be75f658f3so33061695ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 21:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779509703; x=1780114503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ9Wd6u4olIlHGlFZFpAmnHsxCYKujM9D/BFLc8A9dQ=;
        b=O/qzTQdAzdr2PQBHgxwQaerwOZD08fdqraUpa3zQa0fhIG3EPlC2BV8YRv5/CFGC1c
         xfOFSf0+Ce8pd4A3dtXDJ9pzOqAJW2aNUbp4Ai1NYDINMtA0uq+e/uO5orxMMLDA86Xj
         7ZQrXJa11NtBgXqHcVBSwIrGcW/fyt81jTiA2NXc79e9V/2z37XNxxTQz43hDlmtWjyH
         jqlLhxtJutryMmmfJ6CHarD4GaCk/cln8pNvdNKWj3Wo6Hpl+bQxdVsReD/ezZgdQlsY
         fvdozMPfvxiM8tQySUv004tbgnfse2JvXesz9OIBcm+kZLgj5xtYR+FbHvJpSdYjRbVh
         WHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509703; x=1780114503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJ9Wd6u4olIlHGlFZFpAmnHsxCYKujM9D/BFLc8A9dQ=;
        b=LLEKvOTtYqdHJgofmoUFmT9nMoKOdc75LhoLWMC9hzCzWZ4kBVv9UiAt/ER2EESVRQ
         20jZrlh7snCxUd5sH9H8f3rKOVQm6sbN5r7GQfwsD/prkohfmOyKxQ7y+/CJsWPdjbYK
         BvpZAcP0gvcBmBz2Gyd4vUJRmtfLi8WTEkUVZNR0lNtoBniU3PKEMN3e0c31ZSPRbqJc
         dGoBuRXI0PHUaQOHYnt6gnbBu0a+wUeekBIy4W01I5OKFmW3KZ7DkJLUPEOs2CeGE1Uk
         HoVqgzACZDaZ9AANSQZ2P2Mq5lVjrOlKoKH7z5fw85VB4jjGm796dIcfN6DImuluxmxA
         YLZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8942v4yFEYozb8u6sUS3jaV9/q8vz3i1fDQicRFxhGfIUonqUYPFZI7VmoMoKdq7Gwj957iI8tG1R2g4BG@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOkhcMvUI3jTp/JYzpCRJcV8jv8R4Cnro+svriYhDtnTajQyN
	syU0N9/TyH818Brj6JSjp53+kSf26MTtiPB1X8UWumsJsQXizhvnjhWh
X-Gm-Gg: Acq92OHqLNROf2Kgj+sbdSDcgAWW2b0GG3iKPrTZ8DZNldkfXXKxAD+z1LKhnTx8cIL
	ULn886TqQzmPhPyD9HKpdLjVFC8+o/Q0/nPMxbA9HUt+E3LDzfHKNwRsncE1UCinRx8x2Y5hhyR
	Fbq1TELGrxunzNWl1fHfkOkkwRgB+27PSEtRO1/n4626/VpNUnCt31EMdveQlEe4p1I0A3N+1Gn
	WrDnb+WejTpzvlhuM7zEEUCadZJf+hUI8kjdhE3F3bNu+ZDm9LZLfPUVxD0sLt9RpQOzMi6BYjn
	swaeHafU3xAK71wuODblrnIydD9+tvMFYb07W64pZXg+0HfBkWDOGU92ZdCfbPuck7XJi/GstPR
	t6GCNEqVqsfu975HTPpgAic5u73LybWu22k3snTPOgcOnnqiQvcYGHOgMmAjGognf9c+8dtB2kO
	p/cvq3xcg+zAqBNrKDDeVq0X3Rvnw2gw==
X-Received: by 2002:a17:903:2348:b0:2bd:a403:1d82 with SMTP id d9443c01a7336-2beb074fa6amr69071215ad.21.1779509703599;
        Fri, 22 May 2026 21:15:03 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591a277sm31887675ad.80.2026.05.22.21.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 21:15:03 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	woot000 <woot000@woot000.com>
Subject: [PATCH v2 2/4] ntfs: centalize $INDEX_ROOT header validation
Date: Sat, 23 May 2026 13:14:21 +0900
Message-ID: <20260523041423.2726275-3-hyc.lee@gmail.com>
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

Add a dedicated helper to perform stricter validation of $INDEX_ROOT and
use it for both directory inodes and named index inodes. This keeps the
root size and header geometry checks consistent across both read paths.

Tested-by: woot000 <woot000@woot000.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/index.c | 18 ++++++++++++++++++
 fs/ntfs/index.h |  3 +++
 fs/ntfs/inode.c | 11 ++---------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 9713b082b03d..97c0e7d6a580 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -541,6 +541,24 @@ int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 	return 0;
 }
 
+int ntfs_index_root_inconsistent(struct ntfs_volume *vol,
+				 const struct attr_record *a,
+				 const struct index_root *ir, u64 inum)
+{
+	u32 value_length = le32_to_cpu(a->data.resident.value_length);
+
+	if (value_length < offsetof(struct index_root, index)) {
+		ntfs_error(vol->sb, "$INDEX_ROOT in inode %llu is too small.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
+
+	return ntfs_index_header_inconsistent(vol, &ir->index,
+					      value_length -
+					      offsetof(struct index_root, index),
+					      inum);
+}
+
 static struct index_root *ntfs_ir_lookup(struct ntfs_inode *ni, __le16 *name,
 		u32 name_len, struct ntfs_attr_search_ctx **ctx)
 {
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index 3451ec8a1c4e..cad78568d8b3 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -89,6 +89,9 @@ struct ntfs_index_context {
 	bool sync_write;
 };
 
+int ntfs_index_root_inconsistent(struct ntfs_volume *vol,
+				 const struct attr_record *a,
+				 const struct index_root *ir, u64 inum);
 int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 				  const struct index_block *ib,
 				  u32 block_size, s64 vcn, u64 inum);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 360bebd1ee3f..63ee7acff4fc 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -890,7 +890,6 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 */
 	if (S_ISDIR(vi->i_mode)) {
 		struct index_root *ir;
-		u8 *ir_end, *index_end;
 
 view_index_meta:
 		/* It is a directory, find index root attribute. */
@@ -940,10 +939,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		}
 		ir = (struct index_root *)((u8 *)a +
 				le16_to_cpu(a->data.resident.value_offset));
-		ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
-		index_end = (u8 *)&ir->index +
-				le32_to_cpu(ir->index.index_length);
-		if (index_end > ir_end) {
+		if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mft_no)) {
 			ntfs_error(vi->i_sb, "Directory index is corrupt.");
 			goto unm_err_out;
 		}
@@ -1483,7 +1479,6 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	struct attr_record *a;
 	struct ntfs_attr_search_ctx *ctx;
 	struct index_root *ir;
-	u8 *ir_end, *index_end;
 	int err = 0;
 
 	ntfs_debug("Entering for i_ino 0x%llx.", ni->mft_no);
@@ -1534,9 +1529,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	}
 
 	ir = (struct index_root *)((u8 *)a + le16_to_cpu(a->data.resident.value_offset));
-	ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
-	index_end = (u8 *)&ir->index + le32_to_cpu(ir->index.index_length);
-	if (index_end > ir_end) {
+	if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no)) {
 		ntfs_error(vi->i_sb, "Index is corrupt.");
 		goto unm_err_out;
 	}
-- 
2.43.0

