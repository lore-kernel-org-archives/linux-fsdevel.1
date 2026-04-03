Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99410346A0A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257580; cv=none; b=MaMO7DKzUtyGlzQSS3ESqylcM5xdcGSP7/XuebPtaTD7QKwig7ghrVXj9OqiSZY1WpBWZeWWNuA3K5VTvKlTljwuzZRXWIZsnUqIz0j9Yl8+t0nBLtLhtSPnl1pHcbxSJ+lWpBpUSOI8w/ESlV71uqJyOofHg4e6ZUNAO2m+QvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257580; c=relaxed/simple;
	bh=tMvRVaju8zMn/cfnzDapZubkpCSemsVmAtUcjtJuGt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB9MJRUSNJHb/E5g2kESy37KgGxPfMHS4JEDhUuOpUSRpP88mL8D0Kv1zNJ2sNZ1j/t7jmmAuzjRhgxf/Wiv9RMXonz0s9sCZyY8uXdOT4RwzGRfaoQMRoFgzTg/EuZ/LoCUjC3oCzaCViBfbMa3AjxE3BV9Lhi/6+0Upm1UmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=sauc9cs3; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="sauc9cs3"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7ebe11bffso1995888a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775257577; x=1775862377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOjTOAvA3/H6wazwmW4CDUt1d2jo/3kJKjQJxZVzW8w=;
        b=sauc9cs3iCmQg897tbM0rWWv26UUMC99/XZlhtdmB0l0+vngf2DTewiS2OjC5Hb9Iy
         69uNasXfpfj7CPbsNFcsXNC+XACgOSOnbyg15/6YlkBO5j0/cjCwo8IQ9DdR4k6IY8qs
         k2ybrMpP4tebLPIiLXf09r/yZT6Qikth2Ywrh3RqAbj2Ko1DRhxbw1Bf8jjecXq/7QHT
         UiGf4jnunJBowVNuEPxIb6bZroaLNTzypEVkAwHL1Yjl13r6zfUZX6fodSmSkz1XX8HP
         XzJScJ+Yo1XjmJOqtnCq7ObMyaECHEZRvmBJhOR1SjJb1JVYuuehBozMlR4vtHLG7XOB
         EilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257577; x=1775862377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOjTOAvA3/H6wazwmW4CDUt1d2jo/3kJKjQJxZVzW8w=;
        b=Xr04+nGMNl/0Lqso7fEflbteiw0vKSEf4vqve27YcQN+OrjtHd2IHf61ZPmtJeCz/X
         u33PjaW2O78neK1osH5R0uu4e5JAgyRMj2JmTzbLe/yElTXbIu2HYmMM9CASI9qj/sYD
         JrLGiZAoNwNx4lroDlnxddPvsE4KCOcztGQ9XAm/Ib35x9a2+DwBWHGd+2IW9pXLu1wI
         r6DqJxfY2Aifp70OozhM9tMqW0Gc7BHpPun1LIhwDGckvw2mJ6jRLioPKN4mxGD6uM4P
         3I8xOE6q7vmfwd2+YdYjXCkXBMig8FXPWyQvF9RIFvLDPKSesucCl3G4wjsFqqt55rxE
         rR+g==
X-Forwarded-Encrypted: i=1; AJvYcCUXEUDlj4m5XVAymESrUS8gIgRA1qzIZOjZlQOy5IcgOtEjjqqbmYJKOj1xJR8zDC7LMWal98evuUbA4u37@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkTOujLyL8hn94Voyqm/OXxOkfiOWQICqMWz3oUfMlxITRgRP
	hfweoDmpClX/Cco0jL3dd+hd9fpFBGY3TYDZqjaPP+gcobTyFLxAvk8eEtNf0RKrnqc=
X-Gm-Gg: ATEYQzwptgzKudnVxxMk6zFJZTCjWzn9ykcNlJYH7XJwFsyJ8RGofPizM1/Po6Yogh5
	c62d8ZeKuyk2eFohM0zTSK9ZWDCZcMLhUOs5dBs7RB07Yc3Q6G2t8mVCyTMLOqWGwi1mRYW+z8c
	kBonzcaPFiefKnYXQsnZm2TjtzRJRM7K6PI6KxvF1kZTOyy3wUDUIGhH3x2nIwJo3V1H+4sURZ+
	okHPzOfYqR/7oGklwraL+1Fmlw7DnAKuYZscLctAFofxurukCp6qJaLIZ3PUSbLj5/jY/3B336G
	Hf8y9tRpyCpQcK0IeDWTiqyKdHkSY0zpRYn18rppSR/H3uuWSSKyGnkN3qzcnLYSaF2sYFjmll4
	IS7I422PHFpZYK82xLWyCPOC0qgJRYs2SJAOVx0Bkpx3A+rb90j64AqXCigyQVSI8AmSRJ22RGo
	EvCl+QnfcC6+t/NbNeT/kI/tbxKixPDO+fpSpz6t0Of74RwWYscNOVGk5qeIKj6fXTiaZ0adQjo
	zxEGjqrPyTNxg6zXfhKjVhw
X-Received: by 2002:a05:6830:448e:b0:7d8:7d95:fa56 with SMTP id 46e09a7af769-7dbb6cbceebmr2937996a34.0.1775257577469;
        Fri, 03 Apr 2026 16:06:17 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:92cd:838f:83ea:d7f2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7183dfesm5523210a34.9.2026.04.03.16.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:06:16 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/5] hfsplus: fix potential race conditions in b-tree functionality
Date: Fri,  3 Apr 2026 16:05:52 -0700
Message-ID: <20260403230556.614171-2-slava@dubeyko.com>
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

The HFS_BNODE_DELETED flag is checked in hfs_bnode_put()
under locked tree->hash_lock. This patch adds locking
for the case of setting the HFS_BNODE_DELETED flag in
hfs_bnode_unlink() with the goal to avoid potential
race conditions.

The hfs_btree_write() method should be called under
tree->tree_lock. This patch reworks logic by adding
locking the tree->tree_lock for the calls of
hfs_btree_write() in hfsplus_cat_write_inode() and
hfsplus_system_write_inode().

This patch adds also the lockdep_assert_held() in
hfs_bmap_reserve(), hfs_bmap_alloc(), and hfs_bmap_free().

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/bnode.c |  3 +++
 fs/hfsplus/btree.c |  5 +++++
 fs/hfsplus/inode.c | 15 +++++++--------
 fs/hfsplus/super.c |  3 +++
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 250a226336ea..f8b5a8ae58ff 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -420,7 +420,10 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
 		tree->root = 0;
 		tree->depth = 0;
 	}
+
+	spin_lock(&tree->hash_lock);
 	set_bit(HFS_BNODE_DELETED, &node->flags);
+	spin_unlock(&tree->hash_lock);
 }
 
 static inline int hfs_bnode_hash(u32 num)
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 04304f952f6b..f1ed7c336593 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -500,6 +500,8 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
 	u32 count;
 	int res;
 
+	lockdep_assert_held(&tree->tree_lock);
+
 	if (rsvd_nodes <= 0)
 		return 0;
 
@@ -529,6 +531,8 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	u8 *data, byte, m;
 	int i, res;
 
+	lockdep_assert_held(&tree->tree_lock);
+
 	res = hfs_bmap_reserve(tree, 1);
 	if (res)
 		return ERR_PTR(res);
@@ -607,6 +611,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	hfs_dbg("node %u\n", node->this);
 	BUG_ON(!node->this);
 	tree = node->tree;
+	lockdep_assert_held(&tree->tree_lock);
 	nidx = node->this;
 	node = hfs_bnode_find(tree, 0);
 	if (IS_ERR(node))
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index cdf08393de44..e8f359d69328 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -720,20 +720,19 @@ int hfsplus_cat_write_inode(struct inode *inode)
 					 sizeof(struct hfsplus_cat_file));
 	}
 
+	res = hfs_btree_write(tree);
+	if (res) {
+		pr_err("b-tree write err: %d, ino %lu\n",
+		       res, inode->i_ino);
+		goto out;
+	}
+
 	set_bit(HFSPLUS_I_CAT_DIRTY,
 		&HFSPLUS_I(HFSPLUS_CAT_TREE_I(inode->i_sb))->flags);
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
 
-	if (!res) {
-		res = hfs_btree_write(tree);
-		if (res) {
-			pr_err("b-tree write err: %d, ino %lu\n",
-			       res, inode->i_ino);
-		}
-	}
-
 	return res;
 }
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 8bd1627ffc9c..44635f92ada9 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -153,7 +153,10 @@ static int hfsplus_system_write_inode(struct inode *inode)
 	}
 	hfsplus_inode_write_fork(inode, fork);
 	if (tree) {
+		mutex_lock_nested(&tree->tree_lock,
+				  hfsplus_btree_lock_class(tree));
 		int err = hfs_btree_write(tree);
+		mutex_unlock(&tree->tree_lock);
 
 		if (err) {
 			pr_err("b-tree write err: %d, ino %lu\n",
-- 
2.43.0

