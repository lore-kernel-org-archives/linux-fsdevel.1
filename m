Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC72868B5
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809455; cv=none; b=p4FA8T3cfLy0KhjDTozsNHfT+Q9qgvNOf4ytnBSegOfDiPaOTSfnJeva/Fd/Vz3/fC2tZhOUWYOEw0dPWEeQQTewXVVY7NTK7DWMw/9CoXz9aBTOZ+R++kKLvqZGH4FYOWMfXp6ua2L4zbSq8agwTR/C6YgqpaIaMS/submMw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809455; c=relaxed/simple;
	bh=ucnCmrpZK4oZmkzG6Jt9S94iUMt/cUtqMgjAb/QKyJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv75N1zj+ftN63dPxoRjIoSQFb5XZgFyjD3Yortl8llArxDRhsx4P6oMLCWWsmA1BkZZwmmtrHcszIrtdDBm61ojaAnXU4XqdoSJsjOAITM5Uin0ycDcwmFajB+nSG9atYbjeBbT3fyuvDaUeD25MQ5HtXHHd6JOq3gtW6ZA2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH6w70sg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH6w70sg"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84233438806so178431b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 22:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780809453; x=1781414253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BFzewBXDPu8WcOFDTKVnb1gI7mZ7ojJ9QPb768ADSw=;
        b=cH6w70sgRCfIN0l9J4ADhsBQwYYfmCW0Sc/AR59hNJXjskqAu7stC+bAxn1mgNVqU4
         j4S4o+fd9nPShKJN3P25dh15N+9i1modG+iO2Xxkv8iQsthrgBOoAKDFJE9ZmfVxziqs
         n4rbml+u9GQulS0trZa8lDULxcyXY83bUzT5ATj752Hr+jEKUihC9tTsO0fJjrRXTGVD
         7OWsbaHn7HIsJdmCRLuO+VzzfZeu6GPVvK5UJz1pglEp5umP+g185kd1/uuI8vo8knaE
         7hAJOFn/SsxurMX2H5CX7gtMKCFbcE9Ix5wath/JdiwbE+Ly/iE5Fby/C7oE46PLNmNr
         WZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780809453; x=1781414253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BFzewBXDPu8WcOFDTKVnb1gI7mZ7ojJ9QPb768ADSw=;
        b=T0ldiP2UpIi/8Swq/tr8BH78W80wRoERDkvH+5/6w6fEHVB96wngEw04Q+8owS5E9B
         Tz/uK8VOPBMD3uxM3wBubxpLmJou58JXih+dz3KxYulsEL2cHwCT8jaef0UxnKUC2z/2
         DQJBzd9BFUSKQTMySOl6EcfSeDMNYTIC0lvy6O22BTOD7ECuQzz/x3+jadvb+rvsXdrs
         /SoyDezgFl4z9LdxOU18YZAH833sYQomrAOcPnhCDiN4HNTx/X+MrWUv85Uy5UdNTTEg
         h6+0r3EhWAAwbHZlbKfvsN5ragMrcFd4hcfnD3iOX/g9vbeqxsl9SUOuQEzk6ZI83SMo
         1uKQ==
X-Gm-Message-State: AOJu0YywCk9d1L0RP/Ih4a+rlcyGp3B5Rrto8aE79erH8hqyW8vDRYcD
	m1YuGWYjOvVBl4vuj9/vZqoMOWWFX3EgTZvmV15b0wuF9oZsrhYzXzFw
X-Gm-Gg: Acq92OEQcv4R2ptAY99lgONr5euLtj7xCwFRsMqzPDRFMeKwqBCDjCMb/xwM5tmIUp4
	dPXKTaBQ0j/g+A9RYFSEtM/MZUs86vZlWIcUCupX8pvOQyoLvUF5v2QoRA6HuMw/niW4WGSKeRG
	ZqIMwKxwFVfF8cyCq5Cr2lKA0pyEBCg2i6qeBLQeX8sfmoKmN2bBT7V8EABLtf3SPoK1q+OFGVl
	RsAxF8kn2A4ehfA9zGDtbgI3DcEzdmQQtPkHBvNIHhRPLTb1ToiLVCyTn8fVGGILTsqi8yLNTsX
	U+SSZyPR873Qzgp+yo/chdUwvYKRYnYoIMvtnOGC1Kjm24T2uQaTV/UjKqsErjgbzXSWm/1Dzh5
	YsK4xXBH02xkO02F1GD8TPuWLeAHqyP8Hrr4A7ieCvvs8HRNTvOUQWIGMgM2oWB9kMWpfQA1ImO
	IX/ZaIlFQ/l7UDfFi5uPeg1kj92wTWjsZTSbZIfg==
X-Received: by 2002:a05:6a00:b45:b0:842:6fec:12a1 with SMTP id d2e1a72fcca58-842b0f46d65mr4992820b3a.7.1780809452867;
        Sat, 06 Jun 2026 22:17:32 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm14494648b3a.50.2026.06.06.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:17:32 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v5 2/4] ntfs: grow index root value before reparent header update
Date: Sun,  7 Jun 2026 14:17:21 +0900
Message-ID: <20260607051723.1499833-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607051723.1499833-1-charsyam@gmail.com>
References: <20260607051723.1499833-1-charsyam@gmail.com>
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
index 146e011c1a41..ab9a4bc36f0b 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1173,6 +1173,8 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 	struct index_entry *ie;
 	struct index_block *ib = NULL;
 	s64 new_ib_vcn;
+	u32 index_length;
+	u32 old_value_length;
 	int ix_root_size;
 	int ret = 0;
 
@@ -1220,6 +1222,21 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
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
@@ -1228,48 +1245,49 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 
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

