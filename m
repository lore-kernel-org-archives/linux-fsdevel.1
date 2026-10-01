Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC24A1E1E
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890701; cv=none; b=eOFRa8juCGtJxO/aah+1hKZRrN5qGVsW2M7ibUOk5r652rWwXulkFNjRMl81/FLwKXFby8jvdJRKbAUPH1kijq+8UFmLh4gbsbQpmVPxlCsjd2cpQqvVjZqKjhj01HWLkoSbmdfjZ3qNEICOBsEm1jlCQ5NDXxCVfigt6Pdz4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890701; c=relaxed/simple;
	bh=IW+UXRgmhoLk7+3i9YZHJVpgDSTtJ/C33grLUsVZOyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR2TMKcnQm+Xt4wGyoDJZc1cPU1OJ00lRwaB4N2O9HMNYJWe5pHQ9VVbD+0l7RZsUz3xcnmGr3g3HKNN2Qn6ZuvxDXjzNpKje1RTbuvzwKA7ymh6ldOocyouzV27jTQXFA+MgKCK5lxsW+fjN+j2DdYyxPzjX5RtF8wvkl0Q9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=iWYa0nws; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="iWYa0nws"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a776fd3b88so17398771fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790890697; x=1791495497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LM3eBDpNi8EwIHLwbUt2GzcTF92EUsjWl52nPfnnw5E=;
        b=iWYa0nwsQY8MUSrMWc7o9gkGDOljSRna5/cKVMW5EqycV9PDdmgGwVmR2yJ8HxVei+
         vFXkGoDKqhTQBFtvl+Ck3P61gvtfguxL26ErkJvFtiVSvUQvYjNIMTKNSftj3xn17d5u
         P+c+6xx8ElFeb6Q3MNYTYzpjXzqM5M8ntTgxcu5/Mc6Jo62PjfQYlgws6Esmdx581nPH
         x/MMaYbTNA/MvA+uBQgRe4/BUX6SZh2OINsFGU4FeLFDtQz1/XWGzX47qGRO6CDit8aN
         Ay5QHNEMQrB0rsYIkd9MtljEU59MNSY17e3YhbuwOZnkCfuCC3NiyaF93quOc+U3BEEk
         Wkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890697; x=1791495497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LM3eBDpNi8EwIHLwbUt2GzcTF92EUsjWl52nPfnnw5E=;
        b=2T+tJo2DlBrpnsdQ+CmdqyEL08LQmBhuFt5xfS5HVfx2cK5Afp0DCAktdS4hzfS/qe
         COiOA4hMCHT2+yhzI7wqrEATB8S9SDXl1v1+wDNhCi4WYKHCDSo0KfjI2gDEDv32deXM
         9FLtpW8lBOr9+b+qKWu12lWO8vsAK6KjeD+kJMv7RgcAmMapFR5TCrSSLFt25d6SXEcw
         gEO3mexFDu55evykhHsnyS3hQRp468tCa6kQzRWvVxsm8Tu/eQ9qCSRC/kY1V3LyjlUP
         A0dkgycKbM8xHjHeD7lyiWR85MPpF60P1eQI3578ZOQ7FjNnJ25XxrAInBnxEdbDV14z
         3vhg==
X-Gm-Message-State: AFq9FYLG2H0nZ0/Hk83K6d9f/pg9YuE+8EORgMyEXvFXgSZwFwgtxTSJ
	Wy7uF215SBa/sH0jXQZGtV/8sQyxvr11WcLtu+kO+ss2kysmrHV809rsLlPFdbR1kb1ahIpeBG1
	J5wTl09p/8ILG8A==
X-Gm-Gg: AYBFou0Kmkf+5uVubYeFRiPpS86DClZvTrfuztQB6lRVbZPpu9V9uQlQGOsG/nOm5mL
	J9IwwV16CMvi+mMvKcAsUnpRGhpyseWnEMC0e9RYuybXCClEvqxSI5Pnk2LzpxmmxOfrEczVb72
	bvk2EuGQ0xz9zhpK7umjQJwdXAM0ELmqyZ9I42UJ2FO5mbViB4HlRO/9r41De6eHOCTkeiVuyU7
	4OcOgi5Xo262K1D1U3t4H17blgjlKN+6Sf7iZ6EzIEeFalhxH/cfBcA8zB5zN6JMGbhZEgZ/pAP
	+Cp3b0FzZjGZxLLURIb/jZmfY36qkOz3+ujIYjrNzYp3Ngslvy1e79yHCfxJJyef/3/FkJlrXpY
	FnjbhM3b3eQJk5igwGVvJAp1a8qjd2Ce2dG5W0xFTOvG8K3NXI/QT6KYkD2w8tSD1/wjGQQvhx5
	+ADUr4po8KHlpZ2kBEaybHMipHaDX1+3954Xs4isYi/Q0lC639lpJ20Is7XnCl7C8wHa/2KvDe
X-Received: by 2002:a05:651c:325c:b0:3a6:5993:c98f with SMTP id 38308e7fff4ca-3a8877a9f6emr1248781fa.14.1790890696792;
        Thu, 01 Oct 2026 14:38:16 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e333cf3sm2294361fa.39.2026.10.01.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 14:38:16 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH v3 2/2] hfs: free cached B-tree nodes on hfs_btree_open() error path
Date: Thu,  1 Oct 2026 23:38:07 +0200
Message-ID: <20261001213807.1519745-3-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001213807.1519745-1-guvenlik@noroxi.com>
References: <0de056179e3e0a7c4ef525cdb143647b7493dc71.camel@dubeyko.com>
 <20261001213807.1519745-1-guvenlik@noroxi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The classic HFS driver has the same B-tree node leak as hfsplus: on the
hfs_btree_open() error path after hfs_bnode_find(tree, HFS_TREE_HEAD), an
errored head node left in tree->node_hash is not freed because free_tree:
does a bare kfree(tree) instead of walking the hash.

Apply the same fix: factor the node-hash freeing into hfs_bnode_hash_free()
and call it from hfs_btree_close() and the hfs_btree_open() error path. The
helper keeps the hash_lock serialization from commit dce0e0248205 ("hfs/hfsplus:
serialize B-tree close against folio release").

Found via coverage-guided fuzzing (syzkaller + kmemleak) by Noroxi.

Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
---
 fs/hfs/btree.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 4f0ddc76e8..140cdb5ec6 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -131,6 +131,27 @@ static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 node_bit_idx)
 }
 
 /* Get a reference to a B*Tree and do some initial checks */
+static void hfs_bnode_hash_free(struct hfs_btree *tree)
+{
+	struct hfs_bnode *node;
+	int i;
+
+	for (i = 0; i < NODE_HASH_SIZE; i++) {
+		spin_lock(&tree->hash_lock);
+		while ((node = tree->node_hash[i])) {
+			hfs_bnode_unhash(node);
+			spin_unlock(&tree->hash_lock);
+			if (atomic_read(&node->refcnt))
+				pr_err("node %d:%d still has %d user(s)!\n",
+				       node->tree->cnid, node->this,
+				       atomic_read(&node->refcnt));
+			hfs_bnode_free(node);
+			spin_lock(&tree->hash_lock);
+		}
+		spin_unlock(&tree->hash_lock);
+	}
+}
+
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp keycmp)
 {
 	struct hfs_btree *tree;
@@ -296,6 +317,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->inode->i_mapping->a_ops = &hfs_aops;
 	iput(tree->inode);
 free_tree:
+	hfs_bnode_hash_free(tree);
 	kfree(tree);
 	return NULL;
 }
@@ -303,26 +325,10 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 /* Release resources used by a btree */
 void hfs_btree_close(struct hfs_btree *tree)
 {
-	struct hfs_bnode *node;
-	int i;
-
 	if (!tree)
 		return;
 
-	for (i = 0; i < NODE_HASH_SIZE; i++) {
-		spin_lock(&tree->hash_lock);
-		while ((node = tree->node_hash[i])) {
-			hfs_bnode_unhash(node);
-			spin_unlock(&tree->hash_lock);
-			if (atomic_read(&node->refcnt))
-				pr_err("node %d:%d still has %d user(s)!\n",
-				       node->tree->cnid, node->this,
-				       atomic_read(&node->refcnt));
-			hfs_bnode_free(node);
-			spin_lock(&tree->hash_lock);
-		}
-		spin_unlock(&tree->hash_lock);
-	}
+	hfs_bnode_hash_free(tree);
 	iput(tree->inode);
 	kfree(tree);
 }
-- 
2.43.0

