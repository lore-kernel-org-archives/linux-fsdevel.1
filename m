Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D830D405
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933775; cv=none; b=Bp7kGZwM/3QtypVHuCIRzhTJcvSfI6Y4ZR52N/MRNSw8V/qsrNpmQeuihesh2vGJuhgwl5ijDndIfuCfNd76mdNw0RScNyzZryNRVbb2BFyMYKhzRcaSQWDKShcw2Lm1hS9/dAFse8tFA2FM8M0Sx2nkBJqNf3SwCgsid+/oB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933775; c=relaxed/simple;
	bh=8ibx/uagjRxDQTHvvSKBRxRKs2/CWaFGKepFUGfMVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPpfLLTYjgOPeXJTzb7AQX2jxwjnVtDriEf4J87j9VfQHqXtKdp4+ZH5lIPoFaK+TAaMWw3F9h1olEhVHY/CzrVQ/xv0rTj31jZ3S+V8oKmIActTX5MpRorEkjzMYUzyFo5ANuEqGYANhIkpjqOtvFiutMbWSrlmc1qeKs2N9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Eipmz9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Eipmz9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf258aba12so9383745ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933774; x=1781538574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijOWtnNcZJdG/aazJeUEEW6pNqwgUu8kPGOAev0o5dI=;
        b=T0Eipmz9CeI5b0IvSRxIsJHd68AqoDbV99SFcGaxe4hibpMN86uMgLeTm6G5RdsVCX
         3D6Bykk1UFxmzTlhjRTEQqQ54i3NuHlc02sjF0gOVuMbQ+oNGkTENLfKFymBq8SLEbed
         kplSSJN3PlLvd7wUFsMK1pfAfDrbxr76DeLRX/j6Uko63ifpEfgtqwGVLCsXO7vebvCw
         A70L2hTlyYfM3DFjza+8frlr126bwNmS1JYtqTK1bD1X4lVmzgRYImpzPjVdNftjLUVD
         flIjWEz64OK4zA0Z5+jhtTQPly2eueCz0QtrHimGRH51XPIo5/hNixvvSUL3tWZmZlVS
         uYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933774; x=1781538574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijOWtnNcZJdG/aazJeUEEW6pNqwgUu8kPGOAev0o5dI=;
        b=ixT9MD3Pa5pPIuc2sTgNKdZ2kRFsBEfJ5G04D+2LT2GwcQoABDdKMO6y2nUXZsZfoU
         0jRrJHRUPZUEAV3PfZwCJorh/CYGRcvJW8WGuNGaV3nsP+0NNo9eH/tI6FTGSLdgDHg2
         gEI9OLDDnHdeqNcHLE97oYqzxADpkMcmlf12zG5RHpVvZPw4Tu5vsQsFihiJwL3G5jb9
         CmNzQ731EAwS6BfKRMgkbO5KP98pYOIDOA32f3e7LTJGF42Z3OLDRRnpF36bJInqtLkM
         5lSq/b/mg1zEb91vN9bjPeSuwSVxWGnJvysxJ26j9iAu+j7w2dFarH1Qw4Coaex8zfHP
         4RtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N9hiZTUwZhxewmFkxrxPJMAfefL+8ghXTGwcKvJAYLKDyXhejVwGpgV5vTIGmLaKrLp3eelHnZcMGR/U8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/anOqyCgaqKPtZ1AaPTR/uiAP+AGbgKNNPza5z+nF8oPst5Ej
	1PJELjuXbyk0OArbskNaDAPW3IYaFOKsT9pB9ciqruC64K9elGUaxVxF
X-Gm-Gg: Acq92OEFR5mBzDmeL47l9nnZj7kuUDg8tsha0OYUHWPuQPz2hlhU/hKlYyJs6ywaeq6
	H3wKCbYTD/TfOnuTTJIn/ttUBQW+F3vEtsLWpJcO+Cshk5CENoZV5RnF3+JDjPCKwzYEG8rVG7T
	qaEXD20TQmOmVZ7b/Xzt2bhNaT1FfZg32XtgesF7jBsZdeRxGvl70NiCh/N1LR4FN61pyGE0meG
	Vn4XXtVryc+U07WsPKxpJrL+oOaUpRzv2zAYwmu5+3mKnwV8ISeQKve54DeOSLfa1FkBMoazywP
	+KWv3p7dSSJUtAk0dTMbi5wdnWs6jV1X0+BFe8/ibC5BZCjP5vsqhdj/vbbOap2WEJ8pvJvZxaa
	O3QnyFO9S/0T3qQZkL58tclp3n4TSsFXzATcSiBwcbRhqDbpEQJbWdTl9wHXWYNIY7GYCJtlNcm
	I7HDgT7i5+I1LwiU/hcY733TLGxOM=
X-Received: by 2002:a17:903:1a70:b0:2bf:2256:7335 with SMTP id d9443c01a7336-2c1e823b788mr85175325ad.3.1780933774116;
        Mon, 08 Jun 2026 08:49:34 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm15937526a12.18.2026.06.08.08.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:49:33 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v6 2/4] ntfs: grow index root value before reparent header update
Date: Tue,  9 Jun 2026 00:49:15 +0900
Message-ID: <20260608154917.2703739-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608154917.2703739-1-charsyam@gmail.com>
References: <20260608154917.2703739-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_ir_reparent() moves the resident index root entries into an index
block and leaves a small root stub containing the child VCN. That root
stub can be larger than the existing resident value. For example, an
empty root with value_length 48 has an index area of 32 bytes, while the
large-index root stub needs index_length and allocated_size of 40 bytes.

The current code publishes the larger index.index_length and
index.allocated_size before resizing the resident value. If the resize
returns -ENOSPC, the recovery path can call ntfs_inode_add_attrlist(),
which looks attributes up again while the root header says
allocated_size 40 but the resident value still only provides 32 bytes of
index area. Lookup-time $INDEX_ROOT validation then correctly rejects
that transient layout as corrupt.

This reproduces as a generic/013 failure under qemu. In the failing run,
the transient root had value_len=48, index_size=32, index_length=40, and
allocated_size=40, and ntfsprogs-plus ntfsck reported "Corrupt index
root in MFT record 1177".

When the root stub grows, resize the resident value before publishing the
larger root header. If the resize fails, the old root remains valid for
recovery lookups. Keep the existing header-before-resize ordering for
shrink or same-size cases so the resident value never temporarily
exposes an allocated_size beyond its bounds.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/index.c | 78 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 8371ff4303e7..052d80fddbbc 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1240,6 +1240,8 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 	struct index_entry *ie;
 	struct index_block *ib = NULL;
 	s64 new_ib_vcn;
+	u32 index_length;
+	u32 old_value_length;
 	int ix_root_size;
 	int ret = 0;
 
@@ -1287,6 +1289,21 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 		goto clear_bmp;
 	}
 
+	old_value_length = le32_to_cpu(ctx->attr->data.resident.value_length);
+	index_length = le32_to_cpu(ir->index.entries_offset) +
+		sizeof(struct index_entry_header) + sizeof(s64);
+	ix_root_size = offsetof(struct index_root, index) + index_length;
+	/* Grow the resident value before publishing the larger root header. */
+	if (ix_root_size > old_value_length) {
+		ret = ntfs_resident_attr_value_resize(ctx->mrec, ctx->attr, ix_root_size);
+		if (ret)
+			goto resize_failed;
+
+		icx->idx_ni->data_size = ix_root_size;
+		icx->idx_ni->initialized_size = ix_root_size;
+		icx->idx_ni->allocated_size = (ix_root_size + 7) & ~7;
+	}
+
 	ntfs_ir_nill(ir);
 
 	ie = ntfs_ie_get_first(&ir->index);
@@ -1295,48 +1312,49 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 
 	ir->index.flags = LARGE_INDEX;
 	NInoSetIndexAllocPresent(icx->idx_ni);
-	ir->index.index_length = cpu_to_le32(le32_to_cpu(ir->index.entries_offset) +
-			le16_to_cpu(ie->length));
+	ir->index.index_length = cpu_to_le32(index_length);
 	ir->index.allocated_size = ir->index.index_length;
 
-	ix_root_size = sizeof(struct index_root) - sizeof(struct index_header) +
-		le32_to_cpu(ir->index.allocated_size);
-	ret  = ntfs_resident_attr_value_resize(ctx->mrec, ctx->attr, ix_root_size);
-	if (ret) {
-		/*
-		 * When there is no space to build a non-resident
-		 * index, we may have to move the root to an extent
-		 */
-		if ((ret == -ENOSPC) && (ctx->al_entry || !ntfs_inode_add_attrlist(icx->idx_ni))) {
+	if (ix_root_size <= old_value_length) {
+		ret = ntfs_resident_attr_value_resize(ctx->mrec, ctx->attr, ix_root_size);
+		if (ret)
+			goto resize_failed;
+
+		icx->idx_ni->data_size = ix_root_size;
+		icx->idx_ni->initialized_size = ix_root_size;
+		icx->idx_ni->allocated_size = (ix_root_size + 7) & ~7;
+	}
+	ntfs_ie_set_vcn(ie, new_ib_vcn);
+	goto err_out;
+
+resize_failed:
+	/*
+	 * When there is no space to build a non-resident
+	 * index, we may have to move the root to an extent
+	 */
+	if ((ret == -ENOSPC) && (ctx->al_entry || !ntfs_inode_add_attrlist(icx->idx_ni))) {
+		ntfs_attr_put_search_ctx(ctx);
+		ctx = NULL;
+		ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
+		if (ir && !ntfs_attr_record_move_away(ctx, ix_root_size -
+				le32_to_cpu(ctx->attr->data.resident.value_length))) {
+			if (ntfs_attrlist_update(ctx->base_ntfs_ino ?
+						 ctx->base_ntfs_ino : ctx->ntfs_ino))
+				goto clear_bmp;
 			ntfs_attr_put_search_ctx(ctx);
 			ctx = NULL;
-			ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
-			if (ir && !ntfs_attr_record_move_away(ctx, ix_root_size -
-					le32_to_cpu(ctx->attr->data.resident.value_length))) {
-				if (ntfs_attrlist_update(ctx->base_ntfs_ino ?
-							 ctx->base_ntfs_ino : ctx->ntfs_ino))
-					goto clear_bmp;
-				ntfs_attr_put_search_ctx(ctx);
-				ctx = NULL;
-				goto retry;
-			}
+			goto retry;
 		}
-		goto clear_bmp;
-	} else {
-		icx->idx_ni->data_size = icx->idx_ni->initialized_size = ix_root_size;
-		icx->idx_ni->allocated_size = (ix_root_size  + 7) & ~7;
 	}
-	ntfs_ie_set_vcn(ie, new_ib_vcn);
-
+clear_bmp:
+	ntfs_ibm_clear(icx, new_ib_vcn);
+	goto err_out;
 err_out:
 	kvfree(ib);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 out:
 	return ret;
-clear_bmp:
-	ntfs_ibm_clear(icx, new_ib_vcn);
-	goto err_out;
 }
 
 /*
-- 
2.43.0

