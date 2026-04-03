Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42480346A0A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257582; cv=none; b=oSQGa6LtS5MHAHLZKHiYvRwO2xMSTFxySczQnhNH9vORtU5GPdUQaYPrGHj697hs8ADR+oc3yiumyeUFNlAvs+ZKB2584iCBeQnvANq0QF9RG9WTjmDUe1mTaxhtVnw6ggLK0gShYDWTd5Gxb5jD0/aWHtWWg7mjC7c1me9Nftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257582; c=relaxed/simple;
	bh=rebc0l6yGO9fLL2OQgjBfnrKwkX10a4TUhi+grigmAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isaG9yDHdafJK2Spii12/ND44niQqcFONC+wTfnlbhmgtKWTTRSjUyC3z1t9xOHFqReYoTP+YTZrokgCgoI5Xpn0VypC6PJQkC/UE0T7Tu6YZZqlXD+rHQYGrc0yY68adBIIZQYYAu19U+BnZMAh5lmDX9VkoDDkfQmqLG53sZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Da/3qc4g; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Da/3qc4g"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4645dde00a7so2456602b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 16:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775257580; x=1775862380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae70NIvjC7ZSfASEXTl8Vw5RXG00g51NYOijRwURkyY=;
        b=Da/3qc4gwOzR77StpKNnY4QcP6dHzXMOm3ODaG59OCvFhc5f1JFGpFO+AAzKfOfoDv
         /YijDQJkVETVAX2l7W3cw+21yTPEyU9tjlWs/mDhhCVUoSbLZwJ2s3zy8dlwpq0/6e2J
         DUOurq/600y0zjjZuvkxXfshVEymbMhbUpUsVW+1d1+PgJn32vreyEiqXRyCGvBVK6mb
         byekbsse2M0x0J2TDGwLME6Vt93CvcH1a/MGO+lTXjVpq0ZdQkiQp4J9JPLZbUmnzP4T
         wm1+0Y2fTuhzsiG2qQ+pPRHhygz4BCQ96nh2AlYJo6zzOCBXL0YOl+Ypa5GU5TUY5pTI
         BwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257580; x=1775862380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ae70NIvjC7ZSfASEXTl8Vw5RXG00g51NYOijRwURkyY=;
        b=Anx0uyGMj4e2gOLB+UuYh9gEBa0ha9iJPrrmJl/7r51w3p2Rn/hOBgBfMjFbBwVovx
         CDd4W4w6vJlFxjRY8Nndb7gTOspOQue7jzWbR4ejfyH/GxamVMmAj6w4SGbiOHEPW2bu
         Qqnl/GmRqk/8og2HzQc/G8v4C7+dzh65s0OcjOBVnDlNovfO39kHxBkcGx+jC77SDImD
         niqQeN9rR/CqajiWpW6gNBTosIH4hSNjXiJxm4voyfZOZEjj724jg2SUQub41Quq6/a9
         jf6+ISjHnU9ib09ZatdB23jQbPq9Sz9oIcGaPAfTy68QOp5xIMKSSvBXtjykXpP9ZP5u
         5Org==
X-Forwarded-Encrypted: i=1; AJvYcCV5C/YSPbdmsAgfgKXYrM/Dle2A6MHdas0Mm4B/FeJJZrBxhybWADEuPyhKgB8PrBVF8mRvnRwiHrQtsGSn@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKYOi3KqVXsROhIrD1GefyisKT2A3lwAhu2vNZNK9BhpN/7l2
	4ysdcCmR6OqFYbW7hxKGYDlwF/Itv8wtDAbDhb9DFkYNQOBYUuBom41NACALpGA38TjISixW2+U
	BAoH5BOc=
X-Gm-Gg: ATEYQzzdGJOmErk8NL7nfzVvjig/XjMAKvf8MGqdufEg+1bd2PA33LkePFe+OlKFeIO
	+mxNXafZYbRHkW6hW6O2/qqjAkMYDIbjrOGbR3ezdtDnr4Gvn4Roiz7u4HnnrzeEb9XRvj6dwQl
	8URyKwSsJv0EgTe4iG1OtnBkMykIdTamCd+U+xV6hTZrhzLkq5zzAfE4gQNXbe/eQKjCLWqwsDZ
	H7dwqXzUszdjDG+/BrAAQPJQ7UqNGPEM3ICbZPA2w1QnSZwi/PO5h51rhOTgam5yIAZ63mCnjpf
	BQUuw16Z0SlJbEhQpyAYUO0tN2AfSx3NjmrDAiLDWu1QycEkymXLVgTA3b52pP9Olb2lnK7ec/t
	JQ+ofVn0z+tnfVzO469KBznM0dsift+69qHNn6fV3Odv2XLqNI9xjLeDJ0UX46hflcz7/SPPD+Y
	hN8gLY80T5q00iEU7KtO8ImXJvGxLC521Xz9PvedGNVPM5f51NPLFFGhueKrpLaggtBPqp3/HcL
	/RubMy9nJrvVGuqdk6SzlbN
X-Received: by 2002:a05:6808:1525:b0:45a:6adf:4d44 with SMTP id 5614622812f47-46de0a24fb4mr4268558b6e.12.1775257580056;
        Fri, 03 Apr 2026 16:06:20 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:92cd:838f:83ea:d7f2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7183dfesm5523210a34.9.2026.04.03.16.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:06:19 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 3/5] hfsplus: fix logic of alloc/free b-tree node
Date: Fri,  3 Apr 2026 16:05:54 -0700
Message-ID: <20260403230556.614171-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403230556.614171-1-slava@dubeyko.com>
References: <20260403230556.614171-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hfs_bmap_alloc() and hfs_bmap_free() modify
the b-tree's counters and nodes' bitmap of b-tree.
However, hfs_btree_write() synchronizes the state of
in-core b-tree's counters and node's bitmap with
b-tree's descriptor in header node. Postponing this
synchronization could result in inconsistent state of
file system volume. This patch adds calling of
hfs_btree_write() in hfs_bmap_alloc() and hfs_bmap_free()
methods.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/btree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 80aa816ae1c0..761c74ccd653 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -564,6 +564,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 						set_page_dirty(page);
 						kunmap_local(data);
 						tree->free_nodes--;
+						hfs_btree_write(tree);
 						mark_inode_dirty(tree->inode);
 						hfs_bnode_put(node);
 						return hfs_bnode_create(tree,
@@ -585,6 +586,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		if (!nidx) {
 			hfs_dbg("create new bmap node\n");
 			next_node = hfs_bmap_new_bmap(node, idx);
+			hfs_btree_write(tree);
 		} else
 			next_node = hfs_bnode_find(tree, nidx);
 		hfs_bnode_put(node);
@@ -655,6 +657,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 			nidx, node->type);
 	} else {
 		tree->free_nodes++;
+		hfs_btree_write(tree);
 		mark_inode_dirty(tree->inode);
 	}
 
-- 
2.43.0

