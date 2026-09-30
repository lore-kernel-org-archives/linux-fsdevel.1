Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD113C2775
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794246; cv=none; b=YTZgZEUmh+f6KKakA0/1pa3mOQLWhpMv7MzEfwsoypaGk7MHBrC1WtNNqxP02u8ruxAquFIBzyhZvfnLmsz8zHSTHskCZRZv7OOBOixtH+i7teRuojuZlweUaa2d9vWgxkYxosuiv+ZtCq+l9/PZywmo38kxZeKvHX6SUCdcruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794246; c=relaxed/simple;
	bh=yO2FXLNSAKLZLbKK4DBCKqAe6GllfIPBhVj0RDbnLQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2uNC26pC+2enNkMxaMbpvF8wM38AbdwZPhyCzP3aVlX50ikcjtnETnFfzrm5BCL12FkNTW/rJPuxcYU6noE1EXCWb8xlDW3nE19AjSD5hry8uAbqjqcBrk5knyjt0BJ2DpKT0wnoZoxcM44oIk+sq3TqzUS6nIjGu874TBZ/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=H/nqfeMb; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="H/nqfeMb"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8ea203e5bso4885758e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790794242; x=1791399042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5b4LTz7m0DFLrfxivAZmdGHfGQ+Px1ZEYD2UiqRZ9Bo=;
        b=H/nqfeMbIJQ8q2TGUtSCU98GgCZ7T5nzKFBa+RYDQWWG0/Rh3ILm6w2dTXbmNLXT3c
         3lG6oW1OSSCPuX6OLzeASxesf3a21jlnaoTW9y7CBjvaoZj0PlX+X/s3QkcUpA/i6UfW
         aI1g+DRG4FZlDq8wnJ0DglYNdFm9nwNsy/SzKrj79WpiSYe2oFrA0FB8vCPzO53uKG62
         XIBf9L3cz29+uoaEHFVEtXr1FLfy7MbZS//CY39E5PDQdOO9BWQ/kLk6EgkdXcamg3eE
         qjmIaalTfGVjNZtlmfIlnD1ctQXnWqA03qpyoumUoSSgfRxQXC2QbxluNcAu1oimfa3S
         TA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790794242; x=1791399042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5b4LTz7m0DFLrfxivAZmdGHfGQ+Px1ZEYD2UiqRZ9Bo=;
        b=NePtZFGpsu7TGpwHkjTRTd3qX6ZD9vh7aVMcnLebypBh5bjXLWqpV7OIom1qzW02Nk
         ebjk8pScXV938+4t5X5TLHl0SgCuICPzHr2Jlu24oWDN8Sdvso1hwx01IdVrpWKp7MgK
         IH0IpBBY+HzThPkTkJE9K1sVZlpKdS9+rd8C5bxt9EnXZQIqy6tCI5RoADPFuhpx/jyR
         YLEdSKAB2GMRdtnEnZGLUAI1KdseRMMIRsaMzwAGBmDTKh6+R1HK7sbGKUhhNTsvilpP
         Ob23ww0WG/QMGY406jsNXWal+gFqkR9KvHO/JH01QxPyQczynSZoZ7yLcxQWCg6JvYSi
         lySQ==
X-Gm-Message-State: AFq9FYJtPFZMGZ+69htimmySpKTBGC3r8c1VauXiRWkvtJv+ybxQI1iy
	e1/FscaH7dOEQGDnXsY95AA85mJSXA+/oOAdwE7CvSXJqrtVbm4X7Vmh/d2Rla8Aq1GXBiuNakU
	SLWCKPa3ouXi9fw==
X-Gm-Gg: AYBFou2WQEeXNBPNhel1zvv3Jzq2J2thcBXwYcTyjqro5s4pHJyKZzzQVEIUaDxxWSq
	TM3MvNmhuKEHrU/dWaXyF05fVLrGZcAeJpKxPZ+2SErzgHgV34BTSkkn2Qs3E36fprnxhGrr8Tj
	/QjG1BzDU8NNwQEsZ+zWqmoPrvn5xhKLUfQ3mEhzA0IycR57MlzpbBiE5HC42+04MqBmIlbfTju
	2BbNS23/DNH2Tygfyq7OV/WzvFzF1PbC5VF9oWVne3jSEybk2utE5eUsFUHAhSQsZNaWbg4q1+a
	NtaadY8Z9RTUzodIot4L488ewkJsQFmapyLWZPNC3Y5xTrUo4stngHdE/i4TkPBS9lvdMN8sPY4
	33iBu9lG9PSGJrwAnaMFDc7L7Pn9z0gVYi2rtZbDZFyN9bHcbQ/OYNLhPBof8jZ6NPsLxCmciOs
	BaK5uomVjtcSA+Wi7MsYLMbOyytZTMW6EmdoTd3tGcqlZ2WIaLbUBq5r5Z9iWRLWS4JdJ9Di37
X-Received: by 2002:a05:6512:b0f:b0:5b8:b419:b90 with SMTP id 2adb3069b0e04-5ba4061a36bmr927262e87.67.1790794241866;
        Wed, 30 Sep 2026 11:50:41 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42f7c767sm166456e87.9.2026.09.30.11.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:50:41 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH] hfsplus: free cached B-tree nodes on hfs_btree_open() error path
Date: Wed, 30 Sep 2026 20:50:33 +0200
Message-ID: <20260930185033.1335238-1-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_btree_open() can fail after hfs_bnode_find(tree, HFSPLUS_TREE_HEAD)
has already inserted the head node into tree->node_hash.

__hfs_bnode_create() inserts the new bnode into tree->node_hash before
it reads the node's pages; if a page read fails it sets HFS_BNODE_ERROR
and returns the node still hashed. hfs_bnode_find() then takes its
node_error path, which calls hfs_bnode_put(). hfs_bnode_put() only frees
a node once its refcount reaches zero *and* HFS_BNODE_DELETED is set; for
the errored head node that flag is not set, so the node stays in
tree->node_hash with a zero refcount.

hfs_btree_open() then sees IS_ERR(node) and jumps to free_tree:, which
does a bare kfree(tree). Only hfs_btree_close() walks tree->node_hash[]
and frees the cached nodes, so the head node is leaked. Mounting a
crafted HFS+ image whose head B-tree node fails to read therefore leaks
kernel memory on every attempt.

Reported by kmemleak while fuzzing HFS+ image mounts:

  BUG: memory leak
  unreferenced object (size 192):
    __hfs_bnode_create+0x105/0x8d0 fs/hfsplus/bnode.c
    hfsplus_bnode_find             fs/hfsplus/bnode.c
    hfsplus_btree_open             fs/hfsplus/btree.c
    hfsplus_fill_super             fs/hfsplus/super.c

Free any nodes still present in tree->node_hash on the error path before
freeing the tree. The paths that reach free_tree before hfs_bnode_find()
have an empty hash, so the loop is a no-op there.

Found via coverage-guided fuzzing (syzkaller + kmemleak) by Noroxi.

Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
---
 fs/hfsplus/btree.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd565..3de32f221 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -403,6 +403,24 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	tree->inode->i_mapping->a_ops = &hfsplus_aops;
 	iput(tree->inode);
  free_tree:
+	/*
+	 * A B*tree node may already have been inserted into tree->node_hash
+	 * (e.g. an errored head node from hfs_bnode_find()).  Only
+	 * hfs_btree_close() frees hashed nodes, so a bare kfree(tree) here
+	 * leaks them.  Release them before freeing the tree.
+	 */
+	{
+		int i;
+		struct hfs_bnode *node;
+
+		for (i = 0; i < NODE_HASH_SIZE; i++) {
+			while ((node = tree->node_hash[i])) {
+				tree->node_hash[i] = node->next_hash;
+				hfs_bnode_free(node);
+				tree->node_hash_cnt--;
+			}
+		}
+	}
 	kfree(tree);
 	return NULL;
 }
--
2.43.0
