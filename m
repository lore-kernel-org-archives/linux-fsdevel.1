Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948C48987B
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810653; cv=none; b=sD74outMuXN6sotpURQkDYmxqmC/WP1P0I7udU4S+xBTmauKN14fhj+WZGr0HplwNU01bmy6SEX0VPNFBVfUBFOxboRvH00U554Ya6lYxKV0sRS5SP4ibEJl3vqV7Tpm0fk7ylDINU2GhUaPoVNAXLJHgaqYdL/GG/bb1wXdeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810653; c=relaxed/simple;
	bh=BlsXZI6hBuJoZssYWqE3/aU74sAG0IWl3+di5nW8rBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARxZg6BC2kvY1lAWyM5uUzS4qNG1V7z8Sos/8QnCaHDNx82rZCcaJKAQqIiUYyXLrDdK8CjsVLCbl1U5zGT1QsEhMmUCTNSZBWnme3UZOdajeefZPZwp920y54xYnO4ZwD+It2yWiEmI6iqJkLnYo1kEVWvxQQUzwq01VSvtxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=kv12k8mO; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="kv12k8mO"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba418c79ccso714025e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790810644; x=1791415444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CRhw0Id6strr6ueBVzXyHWWSKhLWhS5obNSqyYPwwPY=;
        b=kv12k8mOjYwf1jKXpz5SEfwF6Uhy6b1ijxykLpaEUjLRfSKc79CK0IMo5vBAb8APA0
         SxvS4+8b7NrQftQBZrh1cbikkWoiE2JdMiR2oma/TC8aG0X5ir9Cc58V36dqomPZRJ0a
         ugKDdJq4HWANNB3Bhqqe8pGOeuaWm0KIBSCdrFaiucknT5kYXlZQYX8YWDhYdcAYD4AI
         rsKTLEURVfzE6EGR7tJ2o+DmunoyMPZXDfGQ4HX7vU/NGqMIX+cQcx69k97NkJGKna64
         8Uahj0W7ydPiYv52IgtxM4mRTLss/ogyT4fLQY/WSxD+CDdlY/bOY7nJmAs9SnZGRCu6
         SZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790810644; x=1791415444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRhw0Id6strr6ueBVzXyHWWSKhLWhS5obNSqyYPwwPY=;
        b=BmY5dOmKf7ITo7bqL+DQW+UoVbGj+Ma69n8cSRv+QzO/Xs6Phe0lRU2W8fpzdaP7F7
         OV4OZC6P/lvqH6iQNCRD43fKFziRoUx0RTTQlCMlYLcw7b5tX+46oGnWZwMfc8fMx4JG
         JmwWcIH2J9r4Ch2VvhNamT6THBhM1Ge6x+ZgKUq8YwBw6HnCMVjasCY1lTBR/aW31Yaf
         DLJ1GdKK6iqFJA5DvxQjsGpVVn+AcGfwnlJ8AsJTBzrmuoSSdsVUauv4FYWYdpFFFRPK
         RKzsKql57Cw2wzOwHXwbGtwNGUDprI369iqxkQatN4pOxVaFSOVX6UcsJkBGnZhRBvNZ
         B21A==
X-Gm-Message-State: AFq9FYLlXds8xXbPbWYIe9AiNmLYOymA3L3dmYktmfO1n3h9L2Oq8wo9
	zpsWVBRVqUQaTOnjA5SW+5DsPtPlpjDcBO2dop5YlvF0xlu+HQxo0N5sP3AAIz7+TX+PyMKXrQG
	/tWtIFSoZiR4=
X-Gm-Gg: AYBFou08QTRcq+hXf9uedUBwHmJXGPppG8FYdhgSHnx7GAI90mvJIcu1UPDF0obSlbb
	t45ByiRlmpCA2w/ZmULuBHvnxTLats7/T6ije2P/p+LMuJz/P4JRi4z1cx+Jd+zezdE6dzeGhSI
	WX77fZb5rFwWsRZpyNy+d3CAPZS5JEMKizJr2mb7AYkTYNUEaIxGOaNy43LVBrBW2MJ0/jkhOWn
	MlMzLn+o5/WSYSMR+oJZrmLeVU2EsvVCdmDMJM65rmGsTf7fpebsZI8OqXkEQr/QG1ZV+l4jtOm
	NbT0yTCoP++YjOCSLkPUEc0QOeAHn402SeRKHHJKRdhWl8AVWy6AKc9LBu9MKUJQj3g9vwxxpsF
	Z0TOj8XFzS51rLCLAyLDeazqHH4Y5Z9BLnXdm0SFC/o4dGgxZuZ6nK5i3zJE9rnHgVW4h2B6l9E
	utkPsIYi54wyeJYgZh2vt6mfly4JOaKQn7dLSlZC7pt5IQ3S/1Imf12wApxiGDAG1/0qBErv9s
X-Received: by 2002:a05:6512:15a7:b0:5b8:edc5:c9f4 with SMTP id 2adb3069b0e04-5ba403e92b7mr1163263e87.13.1790810643443;
        Wed, 30 Sep 2026 16:24:03 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fc8023sm279117e87.81.2026.09.30.16.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:24:03 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH v2 1/2] hfsplus: free cached B-tree nodes on hfs_btree_open() error path
Date: Thu,  1 Oct 2026 01:23:11 +0200
Message-ID: <20260930232312.1405042-2-guvenlik@noroxi.com>
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

hfs_btree_open() can fail after hfs_bnode_find(tree, HFSPLUS_TREE_HEAD) has
already inserted the head node into tree->node_hash.

__hfs_bnode_create() inserts the new bnode into tree->node_hash before it
reads the node pages; if a page read fails it sets HFS_BNODE_ERROR and
returns the node still hashed. hfs_bnode_find() then takes its node_error
path and calls hfs_bnode_put(), which only frees a node once its refcount
reaches zero *and* HFS_BNODE_DELETED is set. For the errored head node that
flag is not set, so it stays in tree->node_hash with a zero refcount.

hfs_btree_open() then sees IS_ERR(node) and jumps to free_tree:, doing a
bare kfree(tree). Only hfs_btree_close() walks tree->node_hash[] and frees
the cached nodes, so the head node is leaked. Mounting a crafted HFS+ image
whose head B-tree node fails to read leaks kernel memory on every attempt.

Factor the node-hash freeing out of hfs_btree_close() into a small helper
hfs_bnode_hash_free() and call it from both hfs_btree_close() and the
hfs_btree_open() error path. No hash_lock is taken because the tree is not
published yet, so no other thread can reach it.

Found via coverage-guided fuzzing (syzkaller + kmemleak) by Noroxi.

Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
---
 fs/hfsplus/btree.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd565..41e01380d 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -265,6 +265,24 @@ static const char *hfs_btree_name(u32 cnid)
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
+				pr_crit("node %d:%d still has %d user(s)!\n",
+					node->tree->cnid, node->this,
+					atomic_read(&node->refcnt));
+			hfs_bnode_free(node);
+			tree->node_hash_cnt--;
+		}
+	}
+}
+
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 {
 	struct hfs_btree *tree;
@@ -403,6 +421,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	tree->inode->i_mapping->a_ops = &hfsplus_aops;
 	iput(tree->inode);
  free_tree:
+	hfs_bnode_hash_free(tree);
 	kfree(tree);
 	return NULL;
 }
@@ -410,24 +429,10 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
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
-				pr_crit("node %d:%d "
-						"still has %d user(s)!\n",
-					node->tree->cnid, node->this,
-					atomic_read(&node->refcnt));
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

