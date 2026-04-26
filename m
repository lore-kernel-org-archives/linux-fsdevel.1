Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E428A3FA
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 04:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777176160; cv=none; b=oxby6pCVbjg4GK/UHdbtM5WiljWCmS9+jMiT6bngEgeV4jDCUvwPfh4p5WEZNz64QFHM8Tetaw5GRBO56jLe5ucy4WVBWmZylbZoeQlvkuhJifflDr3umM3NUpRynljQ8Ub86n2Q+tIfFpHWfJFNJ+8oEct42lcJ/kLuMo0B11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777176160; c=relaxed/simple;
	bh=NOPrFI7RLm8u7swVuJKgRPinfyrR/M4hXTZLZJbep1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ2RFPCvpGC6STBu4+Js1BZ1D5z+JRYZDOXN0UwMZKV0BmNUPABpXqy3VZD//Y7Ipmo2Yj7U7CjO2KTMsSURpGOmLD1Lla+TuW3f6mGHNTpgKM/ehBB5MOiOXU+ovN6vTCuU39C9CWgCvva9OJ85ffv8zuKczC10IxpDEQXNDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWymFA4D; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWymFA4D"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae1255a90bso7052915ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777176159; x=1777780959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzH7L75D2jOePwdGm5ThItXQqqZktxKIOM1J4bLi7lU=;
        b=ZWymFA4DPxhvGuMocQnpnGiaioct8X1Hmj68vq2WIjTOajGew3mzR85Zfx/4DWsuMd
         UpAcnAjVyFeL4O/nMizX1i8TNU8rjrKCtyFES4zyNugqdMIIWRkzDHQS0r3zTR5cN/Y5
         mlu43hXFCDXN2NqcmIF5399w0vtlAclWYomSZXyUsuLko4v2gUJxdOAaJu3p5dZ0Gnej
         B8jKyAiUosgm1GpJeQ8HVDvTSsO0pN7PbPsfBqJL2uI50r2vOhrHlEA5YIWMbQjkRWG1
         zzGiFmTopCRn6kZ0mgQ/sK1SNgnV2w2WtPrjFqt6+v+cZRZqkSXAHpVuFLf1Mzl52tbL
         9pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777176159; x=1777780959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WzH7L75D2jOePwdGm5ThItXQqqZktxKIOM1J4bLi7lU=;
        b=CYsnH4sn1docTRpP/JGfA6lcSYdd61Cx4eUapPdciJ2nu/w5FJZRiWBEVxJNETOp3m
         5KAvKNVdZTX8/0l/ZEJCcp14F54e89LfwN4W2npCYGChpT46rfBxrGx5BEDBC5XEMsB8
         uVL5EDsKFiDUx+QHPCQ3JmGEBxzTtLLqCpzNvBc6+VVy/HF2B4zrdRIXfUPiFTAIaEiZ
         fr+83C3/3lS+QwO0zUM6w6+z4FfIfmADQKP2lMA+5Prl2vdDdvfg/luGyemvw23coCZC
         U7t3m6FTj7HVGtWM3hv7v2KKm+nAXT22ttuVpGFTBe8uXLkHO4zj5uZmcElrWorXUsjt
         OJUA==
X-Gm-Message-State: AOJu0YyzQL2kWPfBvSakISJB6xL2OT1Ecz6IxgEsY2L/B9ipK6uMpzIV
	VrdquigOGQ7D1ZIRkDrGEgNWbwztOC5PqF60yAyXNc12+nNfIJee+olh
X-Gm-Gg: AeBDiev+g9GLiN+NLb8KrioNJJYPWp7joKj6FkoiAXpgZzRSNNl5I8PKzaaT7VNuljg
	5+RzWVyTSr2+f1a6sbtYYQJmhHH5TuD9CMIh53SWbz4tFJBBcwMTu2Ub+SFFMg+l4UCpfP0K7P6
	VHCsYHsvnjvudUHe62EyehBzswXV1Li6u+7mfaXs3XNYFe1U6klUS15EwI/lMOq/OuCt3j/ySAK
	TdTymaUocR+q8AUAEQaRv7ZxByZJK6F+aU/boMHOaqeYqsNzF/YH1l749uAOXu047HQm5maiP/J
	xELTRuQauInwlaiqUfoUupY3DxhLSJ13+Apv5GVQ7ZZOLvnKd5Jtw3Tx0gifw7NjR+LoJXgpi5w
	RJQfPx/vfxH1YuBTBTHqEhyaabzcQBHvLr6IM+xJKyf1KXKamRzWDwTpNMyR5y2JY0hSuwFHS0G
	/6ploRjAu4sr7jZ1IkpBEAN8M/Lr4=
X-Received: by 2002:a17:902:8696:b0:2b2:5c84:32ba with SMTP id d9443c01a7336-2b5f9ece9f3mr149677855ad.2.1777176158608;
        Sat, 25 Apr 2026 21:02:38 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0c17esm265149125ad.41.2026.04.25.21.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 21:02:38 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 1/2] ntfs: fix NULL dereference in ntfs_index_walk_down()
Date: Sun, 26 Apr 2026 13:02:31 +0900
Message-ID: <411dcca8f8b760bf9744a2b590becaf3fb871d84.1777175371.git.charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777175371.git.charsyam@gmail.com>
References: <cover.1777175371.git.charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_index_walk_down() allocates ictx->ib when descending from the root
into an index allocation block. If that allocation fails, the old code
still passes the NULL buffer to ntfs_ib_read(), which can write through
it via ntfs_inode_attr_pread().

Allocate the index block into a temporary pointer and return -ENOMEM
before changing the index context on allocation failure. Also propagate
ERR_PTR() through ntfs_index_next() and ntfs_readdir() so walk-down
allocation or index block read failures are not mistaken for normal
index iteration inside the filesystem.

ntfs_readdir() keeps the existing userspace-visible behavior of
suppressing readdir errors after marking end_in_iterate; this change only
prevents the walk-down failure path from dereferencing NULL internally.

The failure was reproduced with failslab fail-nth injection on getdents64;
the original module hits a NULL pointer dereference in memcpy_orig through
ntfs_ib_read(), while the patched module reaches the same
ntfs_index_walk_down() allocation failure without crashing.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/dir.c   | 13 ++++++++++---
 fs/ntfs/index.c | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index bfa904d2ce66..20f5c7074bdd 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -911,8 +911,8 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 
 	if (next->flags & INDEX_ENTRY_NODE) {
 		next = ntfs_index_walk_down(next, ictx);
-		if (!next) {
-			err = -EIO;
+		if (IS_ERR(next)) {
+			err = PTR_ERR(next);
 			goto out;
 		}
 	}
@@ -920,7 +920,14 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	if (next && !(next->flags & INDEX_ENTRY_END))
 		goto nextdir;
 
-	while ((next = ntfs_index_next(next, ictx)) != NULL) {
+	while (1) {
+		next = ntfs_index_next(next, ictx);
+		if (IS_ERR(next)) {
+			err = PTR_ERR(next);
+			goto out;
+		}
+		if (!next)
+			break;
 nextdir:
 		/* Check the consistency of an index entry */
 		if (ntfs_index_entry_inconsistent(ictx, vol, next, COLLATION_FILE_NAME,
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 2080f3969137..a547bdcfa456 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1969,15 +1969,19 @@ int ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key, const u32 keyl
 struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_index_context *ictx)
 {
 	struct index_entry *entry;
+	struct index_block *ib;
 	s64 vcn;
 
 	entry = ie;
 	do {
 		vcn = ntfs_ie_get_vcn(entry);
 		if (ictx->is_in_root) {
+			ib = kvzalloc(ictx->block_size, GFP_NOFS);
+			if (!ib)
+				return ERR_PTR(-ENOMEM);
 			/* down from level zero */
 			ictx->ir = NULL;
-			ictx->ib = kvzalloc(ictx->block_size, GFP_NOFS);
+			ictx->ib = ib;
 			ictx->pindex = 1;
 			ictx->is_in_root = false;
 		} else {
@@ -1991,8 +1995,8 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
 			ictx->entry = ntfs_ie_get_first(&ictx->ib->index);
 			entry = ictx->entry;
 		} else
-			entry = NULL;
-	} while (entry && (entry->flags & INDEX_ENTRY_NODE));
+			entry = ERR_PTR(-EIO);
+	} while (!IS_ERR(entry) && (entry->flags & INDEX_ENTRY_NODE));
 
 	return entry;
 }
@@ -2097,10 +2101,15 @@ struct index_entry *ntfs_index_next(struct index_entry *ie, struct ntfs_index_co
 
 		/* walk down if it has a subnode */
 		if (flags & INDEX_ENTRY_NODE) {
-			if (!ictx->ia_ni)
+			if (!ictx->ia_ni) {
 				ictx->ia_ni = ntfs_ia_open(ictx, ictx->idx_ni);
+				if (!ictx->ia_ni)
+					return ERR_PTR(-EIO);
+			}
 
 			next = ntfs_index_walk_down(next, ictx);
+			if (IS_ERR(next))
+				return next;
 		} else {
 
 			/* walk up it has no subnode, nor data */
-- 
2.43.0

