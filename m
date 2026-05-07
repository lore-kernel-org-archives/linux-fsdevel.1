Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439B40DFCC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120317; cv=none; b=QMvCGUWqG6R/auU68xGV8cBpFTd/B4P7E44VjES21eDOyMWRzOOfIuGsaP5akxVxfAxusNnY4nJez4KrrgXV1zAlN3u6D4oUAsMFBH2x+x8sgBEoBiHAv2+wRya4imY6p68tDynfYi4SCFU0tu2nj6yM3RFcokoczm2T9IAJyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120317; c=relaxed/simple;
	bh=ZrCFww4ECwWfkhoTbDCSwXoIXXrKkY8X/i5G6H9JP1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgtySlxCjGcjBgQoiOxHZkkvsevmbhQYmnVXZfNzVhmxgBhDq5A2rMLnxyQNPsPKk0z7my4Iy8nJWsD+zYQPSdNCTw+J4B3EWVl0EfL7CXMbgWCNxddgeAsLYLFMD9fiVIcYmzF+Dd9v3MnHQ3kFu2/ykFZExMfXhRJH4Lf/6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCjnghtu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCjnghtu"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-364d13df3ccso55667a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 19:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778120316; x=1778725116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn/rXSpLj+R/ku7nBy1V0OPJZZmEvQ+YBVAy/f5BFj0=;
        b=bCjnghtu6AYIxTiJpjj9SoDw4PPdpANtR03JrDReJwR+MTQQ2hFTWjMVFh0jhFAAVD
         S1K09A1Nsu4qWqc4+wYfVEJn3lliahVQWY6UNI1kiJcuASaEjFTWdqU0SKn9+ofX0saz
         hzkFg2PGPA/K+gW+yl+TjAZjDWHtZN9BZi/Hj/9FMMvzYjD0Y6huxNq5pWPzwCy0wRxr
         fUPnln7sgdXQrbYTEw9Fa19N0EQP+cKGypBeFX0RIPlmXvTWKEto5tfhrPrNPX0lODMO
         VDmtJpLHwNLWigWNYPLfeZJYn3X+csOa4e9PHa5jpZXUxlYUIkSZYJP0zyJtfU06dSPg
         T7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778120316; x=1778725116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fn/rXSpLj+R/ku7nBy1V0OPJZZmEvQ+YBVAy/f5BFj0=;
        b=NDggjPkyzTnDjp7SMsy+YnrHlc62GMDcVUrKQf+8ggRhp0Sqm3ESDqDJlfoFKztb9b
         LZq208MwUJxm4UxwhMzRCdyEHeOdNl+Axh6O12I9dXYMnqZzt49jtBCANVzVRLY1iLGn
         eKKL+ITtefI9uwDO5d8rJhIEMrKAAhTPiXekEOYDQwwviw6jAk7dkzfWQZG0kd0TfU5S
         wXH0LD5WDbptEUodKXGH11gpb/wU4lKxd77jo1tYXdHRwAEiDI4ZN8XygRuwkti3EJEf
         Ts+121jdL5AzCheAv8Ikw2Yc7csxX099vNooo5fFnP39Ih8nNXHg+WD/aMYXDQf73Z8F
         CAqw==
X-Gm-Message-State: AOJu0YzjiG2CLMf+x+5ys9bA11QfPL6OG1LCFFiYtFqY58+4g8bljCrT
	h9DolG9mHS2AQaNN+xyuNpQgdWpDyI78fvMviRNIPZfhcae20yWGKrPDT6RM/g==
X-Gm-Gg: AeBDieu2WPhQjfhojIBQeUc9lRfMm6IKqPpJcOeitSjGcW8+h+9BdoyqR6m9dYvqBNc
	Y4gyaEKd/IKIVjoAN8iDuzrjgQuVg+K6681HiNO3kfk9zeBjgxxPsG+ggaQpyNYHkgQabx9Gysj
	Gm//dPVb1RgkKjmMBH/X7/GDwtJTgehoridqtpTRzaUBD/yq5t4gidpEF090P/rB8+WJKAI7Sji
	flrhiQGzw9dQuQrg8NrTv9i3ZoGCfv7LXEk8Nr156zLP/LvrWUiEWKmA6GkKgSH65DvdIlYE2/9
	shSADNh5XQpZdhd7yI9ouYyULtNok33u9/Ish2TnrRaTeNXuESmXHgPLNvhemnecvaTHrIj30G6
	6PVZYRGXLbpCcSwbdXcsFdagzFWWMtbpKaExVsT4SzbZ+dE+s7smtWTBjU0hvupOsO7jTNb8wWO
	AZ/Ave96IbD//LuqFKEEdBivMS/kX6e37KxrM9qA==
X-Received: by 2002:a17:90a:e60f:b0:366:1075:ba with SMTP id 98e67ed59e1d1-36610750520mr96545a91.0.1778120315720;
        Wed, 06 May 2026 19:18:35 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babadd2314sm6002305ad.54.2026.05.06.19.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:18:35 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ntfs: fix out-of-bounds write in ntfs_index_walk_down()
Date: Thu,  7 May 2026 11:18:31 +0900
Message-ID: <20260507021831.1196548-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506153850.774060-1-charsyam@gmail.com>
References: <20260506153850.774060-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_index_walk_down() used to update the index traversal depth
directly before writing parent_pos[] and parent_vcn[]. A malformed
directory index with too many child-node levels can therefore advance
pindex past MAX_PARENT_VCN and write past the fixed arrays in struct
ntfs_index_context, corrupting context state used by later index
traversal.

Use ntfs_icx_parent_inc() for walk-down transitions so the existing
depth limit is enforced before the arrays are updated. Make the helper
check the limit before incrementing pindex so failed callers do not
leave the context at an out-of-range depth.

This is reachable by iterating a crafted NTFS directory after the volume
has been mounted, including read-only mounts. The reproducer uses
getdents64() on an index root that points to an excessively deep chain
of child index blocks.

A crafted directory index with a chain of child-node entries reproduced
UBSAN array-index-out-of-bounds reports in ntfs_index_walk_down() and
subsequent KASAN reports in ntfs_index_walk_up(). With this change, the
same image is rejected with "Index is over 32 level deep" and no KASAN
or UBSAN report is emitted.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Changes since v1:
  - In the is_in_root walk-down branch, drop the ntfs_icx_parent_inc()
    call and the kvfree(ib) error handling; restore the direct
    ictx->pindex = 1 assignment, per review by Namjae Jeon. The helper
    call there was unnecessary because is_in_root == true implies
    pindex == 0, and the resulting error path was dead code. Add a
    comment documenting the invariant. The non-root walk-down branch
    keeps using ntfs_icx_parent_inc() since pindex can approach
    MAX_PARENT_VCN there.

 fs/ntfs/index.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index a547bdcfa456..146e011c1a41 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -677,11 +677,11 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 
 static int ntfs_icx_parent_inc(struct ntfs_index_context *icx)
 {
-	icx->pindex++;
-	if (icx->pindex >= MAX_PARENT_VCN) {
+	if (icx->pindex >= MAX_PARENT_VCN - 1) {
 		ntfs_error(icx->idx_ni->vol->sb, "Index is over %d level deep", MAX_PARENT_VCN);
 		return -EOPNOTSUPP;
 	}
+	icx->pindex++;
 	return 0;
 }
 
@@ -1970,6 +1970,7 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
 {
 	struct index_entry *entry;
 	struct index_block *ib;
+	int err;
 	s64 vcn;
 
 	entry = ie;
@@ -1979,14 +1980,20 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
 			ib = kvzalloc(ictx->block_size, GFP_NOFS);
 			if (!ib)
 				return ERR_PTR(-ENOMEM);
-			/* down from level zero */
+			/*
+			 * Descending from root index (level 0) to the first
+			 * child level. is_in_root == true implies pindex == 0,
+			 * so advance to level 1.
+			 */
+			ictx->pindex = 1;
 			ictx->ir = NULL;
 			ictx->ib = ib;
-			ictx->pindex = 1;
 			ictx->is_in_root = false;
 		} else {
 			/* down from non-zero level */
-			ictx->pindex++;
+			err = ntfs_icx_parent_inc(ictx);
+			if (err)
+				return ERR_PTR(err);
 		}
 
 		ictx->parent_pos[ictx->pindex] = 0;
-- 
2.43.0

