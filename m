Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55735F5E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207491; cv=none; b=oazhsvkMdRdGU59qRrpv2DSxK156dA/eKfmGQgcRTmFuJB9OA0/IWm/mfBiYI/lKAltAuP2JhJ3lmU5eFDsYQhOHqQGcNOYYkIBzasosdFhprjoMTjGcT4kdl3Opml/AKwfcFxaDFRUv070RGLRT/riXgKWaG0j5Gu/37Xc7LyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207491; c=relaxed/simple;
	bh=0LH2Wk96XCyQ9QPmB3zJdq3TVqhmoWH8uSvEK9uSjdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTvopIiTqYEO2Dmz9RP0vaBCRD0cAzZCmKgdgQMpqQoyksCbnHjvn8TjF0OSOaF3ndxXABFdvxYdLT3dqeLOkfzBmw9vqLvkJnFSkG47kVYfY4f7pYO+uRICTVsEZYGVGXg+37F07f+EXmgx6fX9w0yiXMUaTF/rGzitvlObMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJBg1hfO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJBg1hfO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf20f6be6bso36050795ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782207490; x=1782812290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNVcLnkL3WxXcfZi/S6Z0bWfgjPDQAPL7NsbQXzozmw=;
        b=tJBg1hfORfazvw5I7UhaNG3MffF9CrY9a0PCJk+rIeKsKyiGlwuU7co9I1IcAybDRu
         psjMlL+ARoATOQ3CxNP+6WLWi/vsPOzRq1zQHK3mFnrzSvsm4MmYAAI4ZxSe7rmfVm/A
         zNT7RhMkUR3TqnVrpvESvGdrpRHCDaCarHfUZzHEw5uefRf8GwfjCUlJCLNf1ns0oJiL
         rZiuKIMLUpjNajdjOK7awW/G26Q2HqPWDX1RmiCvalmIfLbcwNqqWVBcJs/LzdePQzhE
         PMYvnrf4pfQB5pA1pgbkJHPZaI620hxteTpbzBxO3rzWY6YpSG06XQLL4aK/gK5AD/y9
         HR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207490; x=1782812290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNVcLnkL3WxXcfZi/S6Z0bWfgjPDQAPL7NsbQXzozmw=;
        b=crpZsvNAL/AFSF4dFwIoFByE8ZmRlBwoapmWQigJj589UaG2Nbf+Uo1ChF3l/ux7lP
         +m2erpwUB1Y/ekDpnRA+L494/xddPuuB0+VnN10gABczyCetqnuhp+jD9VUvZL0FjtcD
         rcBkDILzDH2/GbZAWOnJuGtyrH+xkY22LuP14Rfa5mGatm2WLFUrFPuUthM7lcJbBtVc
         mxUrb/v/BUHt0oOJ1qz7f0Wjey0VD4LD2UEuusPBeMUPBfFFFUdNvDQBdu765giMpRV1
         F8M7wtmYwUFKd8YeR5YRiOYYNoTtYmheCVW/qZ06tjFkhcJBukKTOAd+Po2+XUfh8j1s
         7CFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8oSnrGJy0aW5oIMfAbGHdx5KlQ3aajfJShJEOc4LBZzaHkPytRBkWgXKu5xIR9iUCE3t92KYMBgR7c0tg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Y7K8qYLAx4wpbmEPZLGFD6RtEopf00uKLxnWgsP0lROgNIx5
	2NI8Y/KB9/w7g51roMtMj9eA03vl38B+j/ywL4f/Fpb6JxdYwSbAY2kQQ6KsCY5e6lw=
X-Gm-Gg: AfdE7cldM53zhOb5gIJFaiJwtEWCT+S7nO+djahl8t95iy5LK9W6masGUd9Qhk46zH6
	wu5AgQgHBqzxRBoq0LnT9ZHN8F2aEOOPYOgiBw8dcniaO/9//qRxttAhB+MoC490N8WZ2vdY0C/
	jsSBEjTRp/4aeNWSdcRNDeqlHxCTO1Wjv/QaLZNvnGNc/+8MlLxA8UxsPR5zcq7cQqkk45DNQFj
	yMgMA0+bZN8kXlpHF16USO2QWjgMaql1rJxBeCx/c+TZws/ajZIE/oStQ1mVgSG1zWKdmvBE+ec
	g9L7jcByRtxlIgfH32pOPfvjWHc6IXeCSC7hotRS8wnjV+3OuQKUvIB3nFaHh2FyXTw/cIHGBI+
	UDSX6urE0CpbqDvDJ66SiR8fAZ+vm0l6dOMbHl4mJaVgrAaFeZp7s2WHzSu0PcCUfRClAiN1qxz
	mmlSb4dC1j1XP6PeeUK0mvuBnsJW2cD7MwzITLwbNYNJY++GPwxMhN+4qpZiE1CB4iHq0efWRU1
	clGlNF+5HPq2dgr2QbmCskAAurkNCh3kCna3BHNnYTRTvYLqbFjecYaTxBdNZFgLaoKw2Mn6FZg
	QynNQ+alkZEiA7QIre3ZmL1roQ==
X-Received: by 2002:a17:902:cf43:b0:2c7:d4ba:4885 with SMTP id d9443c01a7336-2c7d4ba4c8fmr6598755ad.3.1782207489828;
        Tue, 23 Jun 2026 02:38:09 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.d33bddc1d573818c7-tp.internal (69.129.240.35.bc.googleusercontent.com. [35.240.129.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436aff98sm100841445ad.3.2026.06.23.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:38:09 -0700 (PDT)
From: Aditya Srivastava <aditya.ansh182@gmail.com>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH] hfs: port HFS+ b-tree bitmap corruption check
Date: Tue, 23 Jun 2026 09:37:50 +0000
Message-ID: <20260623093750.2311-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>

In HFS+ filesystems, during b-tree open (hfs_btree_open()), the code
verifies that the allocation map bit for the tree header (node 0) is set.
If not, it indicates a corrupted map record/bitmap and mounts the volume
as read-only (SB_RDONLY) to prevent further damage.

HFS filesystems share the same b-tree structure but currently lack this
corruption detection check, which was highlighted by the maintainer.

Port this check to HFS:
1. Implement hfs_bmap_test_bit() in fs/hfs/btree.c (which safely traverses
   the b-tree map nodes to inspect the desired bit, identical to HFS+).
2. Invoke hfs_bmap_test_bit() for node 0 at the end of hfs_btree_open(),
   warning and forcing read-only if corruption is detected.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com/T/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/hfs/btree.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/hfs/btree.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2eb37a2f64e8..4293399d377e 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -155,6 +155,14 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	kunmap_local(head);
 	folio_unlock(folio);
 	folio_put(folio);
+
+	if (!hfs_bmap_test_bit(tree, 0)) {
+		pr_warn("(%s): %s (cnid 0x%x) map record invalid or bitmap corruption detected, forcing read-only.\n",
+			sb->s_id, id == HFS_EXT_CNID ? "extents" : "catalog", id);
+		pr_warn("Run fsck.hfs to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
 	return tree;
 
 fail_folio:
@@ -356,6 +364,50 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	}
 }
 
+bool hfs_bmap_test_bit(struct hfs_btree *tree, u32 nidx)
+{
+	struct hfs_bnode *node;
+	struct page *page;
+	u16 off, len;
+	u8 *data, byte, m;
+	bool res = false;
+
+	node = hfs_bnode_find(tree, 0);
+	if (IS_ERR(node))
+		return false;
+
+	len = hfs_brec_lenoff(node, 2, &off);
+	while (nidx >= len * 8) {
+		u32 i;
+
+		nidx -= len * 8;
+		i = node->next;
+		if (!i) {
+			hfs_bnode_put(node);
+			return false;
+		}
+		hfs_bnode_put(node);
+		node = hfs_bnode_find(tree, i);
+		if (IS_ERR(node))
+			return false;
+		if (node->type != HFS_NODE_MAP) {
+			hfs_bnode_put(node);
+			return false;
+		}
+		len = hfs_brec_lenoff(node, 0, &off);
+	}
+	off += node->page_offset + nidx / 8;
+	page = node->page[off >> PAGE_SHIFT];
+	data = kmap_local_page(page);
+	off &= ~PAGE_MASK;
+	m = 1 << (~nidx & 7);
+	byte = data[off];
+	res = (byte & m) != 0;
+	kunmap_local(data);
+	hfs_bnode_put(node);
+	return res;
+}
+
 void hfs_bmap_free(struct hfs_bnode *node)
 {
 	struct hfs_btree *tree;
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 99be858b2446..efe88f66c856 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -93,6 +93,7 @@ extern void hfs_btree_write(struct hfs_btree *tree);
 extern int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes);
 extern struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree);
 extern void hfs_bmap_free(struct hfs_bnode *node);
+extern bool hfs_bmap_test_bit(struct hfs_btree *tree, u32 nidx);
 
 /* bnode.c */
 extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
-- 
2.47.3

