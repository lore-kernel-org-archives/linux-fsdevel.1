Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA93B83F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810685; cv=none; b=eEJNO2lzLuEiwOcgg20wrdT9Ui5IMTipQkZkJ1P8Bg+klRfRSnIjUjy2MDGOpTXoIvv76hVdIqPcjgeJwpzSVT0yu4aXPu6W8kQW5IwgcMdMDyJob+MNANwmcSYoYKLbg95Yt3KERlALKH/UwmmxA0MxqoBpYlpbPpyu0mR44Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810685; c=relaxed/simple;
	bh=AdNpRPqV+fI28Fo0j0plLv4SGD7R10YBRj/MzP0N7Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzUNftxM0FgiqszWznhvYcgYWEn3B20+XXOyOslcomoBL1Q3ltxnZKy/GPb+uQNxtiokXKCvkdLjcidC6OsPKslh52RS54ObI4KGH7zPPsJ7fJfIZG82XEmKtlUyd6mOwpNE5sttzvSnnpfsvdCnfsT8HmGVY+LH+1VEmoA09bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=PqVydkHy; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="PqVydkHy"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba390408cdso2095833e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790810682; x=1791415482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MZPt+knyauRCcuTfXdEq3MbkyLX4Z1IzlHXD7sMuv0=;
        b=PqVydkHyEIDpBoNW6F4OQbcBn7L14e2HYV1gJeHf6CNl/OZwndTyrsPKU6IDBju0nh
         dUNuLB6BFnGmr1waVM3M7IKJDl6zrrv1wRgUIKlcka8B7icAzUaZjZ+Md4J3V1c6EKKL
         x5KGLH4o8ETlRQs2vDNGv/k1t3q5QTcX8URDkBp84R44gdh4zZ0/9GZRJ7gDA07JTYrv
         thqC+dEszz90Pw49YLUn/ZdR/At8w+OB645fpO9LWCo0/WYHzlWb/VYI7KDm2QyCmvhR
         OAXIgoeWhAl0/SzHMwSuOdXZ0Z3VW/sMx1lfGKaQB9Kq++Mw/KJrL3Vhh4E7QCCt2KwY
         4DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790810682; x=1791415482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MZPt+knyauRCcuTfXdEq3MbkyLX4Z1IzlHXD7sMuv0=;
        b=BtJgOGF1dBRrn9AKd1bFlf9R6dv0HbM3OFaxQC8zA/bwZMGrkql3Ld/oC4XNYfFHDY
         ii8DjCv7Vz7UrNzX9hZd7YhemFehbebmfAYuZ0EOTbJ1oW3Vke8pVVFXqOpFAn+dhd6U
         PrMUOspFAUMI/WE/oA8AsXVEHOlXuJfp8lYVqzymHoOHM6Mxr2wFNoW/B9vYbx1tCnVT
         X0asJNSS1h7BDh459E/ZU3oliidXqWJaDVXh54Vun3PmMINWZx51RJN8znMmhX1sEi5K
         YZUTV9oPBl2tYAtvgDQE+2CM8GiOu3hoJeRzOcqnVMf908nnUEgiv2uM0l4FacGPAatg
         FXvg==
X-Gm-Message-State: AFq9FYKP1Z6J8KvPaaagsYK9z6Tnmn/hxOru70KTHqxBfmEunklTmBNi
	RPW+IM8W6IMcm4x+EKG4Ib5nLrq19AG5naNdXHTaXu3b0bC8Y4SFLzGRS0+Jr5jyXtbTaJL7zpA
	GP+Ab8vmUqJs=
X-Gm-Gg: AYBFou188ZaRelidzg4C+tMmukEnr6SR9EL6D+5XmzU2FBPtsmgRJCHLb8ujrVrJTGO
	KczGytkQItmpD5s4B+ALDzV64IX9p9lNMxM6FJGuJji5KQoeKhMgJ4z1c417pULuicDXTiskhWc
	ROwMTNhji6tJUWtJVH21lA1+oSJE10fYwBGBf6w7KzxQKbPVMH6SAZOlhnwlMaJiT2UTuDlk4eC
	nupI7WmJfJ+7hc3MwB84UIAUKyavTDIfFCza6yDCj2aJcoBYMTX7La+ElEUF62rQJBInY8OfJzF
	o072UEwmamDZc9H4StM1YczII/49LJKdjOqJlEdmL6kVBlIxJG9vU1IgHaaVKW+zrKlK7jLZtkU
	QW8eWkRDuxiw9boskFSfWA3WuGhlIAYAajn3xrMAUGsrgJpXZhf2ixn72XwLMDP+wDHvIPf2eDu
	6iRHz4LWDEIL7/Nm/xA6UnR9PNZoJ9ol9I5xk9DOJsNEfuRF5vYytKqtmpWlGOdJidBCUJSlnS
X-Received: by 2002:a05:6512:481b:b0:5b8:f94a:4d30 with SMTP id 2adb3069b0e04-5ba405feb9emr978132e87.49.1790810681755;
        Wed, 30 Sep 2026 16:24:41 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fc8023sm279117e87.81.2026.09.30.16.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:24:41 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH v2 2/2] hfs: free cached B-tree nodes on hfs_btree_open() error path
Date: Thu,  1 Oct 2026 01:23:12 +0200
Message-ID: <20260930232312.1405042-3-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930232312.1405042-1-guvenlik@noroxi.com>
References: <ea8cfa5978a90d27e498fae626edfdae5bf84af7.camel@dubeyko.com>
 <20260930232312.1405042-1-guvenlik@noroxi.com>
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
and call it from hfs_btree_close() and the hfs_btree_open() error path.

Found via coverage-guided fuzzing (syzkaller + kmemleak) by Noroxi.

Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
---
 fs/hfs/btree.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 41b4e8fc9..51d1e19a4 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -131,6 +131,24 @@ static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 node_bit_idx)
 }
 
 /* Get a reference to a B*Tree and do some initial checks */
+static void hfs_bnode_hash_free(struct hfs_btree *tree)
+{
+	struct hfs_bnode *node;
+	int i;
+
+	for (i = 0; i < NODE_HASH_SIZE; i++) {
+		while ((node = tree->node_hash[i])) {
+			tree->node_hash[i] = node->next_hash;
+			if (atomic_read(&node->refcnt))
+				pr_err("node %d:%d still has %d user(s)!\n",
+				       node->tree->cnid, node->this,
+				       atomic_read(&node->refcnt));
+			hfs_bnode_free(node);
+			tree->node_hash_cnt--;
+		}
+	}
+}
+
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp keycmp)
 {
 	struct hfs_btree *tree;
@@ -296,6 +314,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->inode->i_mapping->a_ops = &hfs_aops;
 	iput(tree->inode);
 free_tree:
+	hfs_bnode_hash_free(tree);
 	kfree(tree);
 	return NULL;
 }
@@ -303,23 +322,10 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 /* Release resources used by a btree */
 void hfs_btree_close(struct hfs_btree *tree)
 {
-	struct hfs_bnode *node;
-	int i;
-
 	if (!tree)
 		return;
 
-	for (i = 0; i < NODE_HASH_SIZE; i++) {
-		while ((node = tree->node_hash[i])) {
-			tree->node_hash[i] = node->next_hash;
-			if (atomic_read(&node->refcnt))
-				pr_err("node %d:%d still has %d user(s)!\n",
-				       node->tree->cnid, node->this,
-				       atomic_read(&node->refcnt));
-			hfs_bnode_free(node);
-			tree->node_hash_cnt--;
-		}
-	}
+	hfs_bnode_hash_free(tree);
 	iput(tree->inode);
 	kfree(tree);
 }
-- 
2.43.0

