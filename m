Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049991;
	b=N9oGZKXVLI2uErzOXd1feVokcZStD8++5nFoX76aazIGqxwzstkQ4+YJhP/tqOLtXmLH
	 gIibTAnnyUlTmFh/HD/d6FLgi5JU7kfYKX5Mn+vA/DJj5qNMHpEed7fMnOy9DbazTo9iQ
	 VW3C23FXC5Nk/Qq0pQ0MtBxTwm1u+CH86iizqDDIjUEkl1Evt9tbA0Yl/PfQmE9Sqz6c8
	 Y8/vfmVfqJoaTsNcal0DC0rpoj1qPltrC6LMArL2rSdx+Wbg+risqcCCEitirIWKPCcBm
	 NZVxTEK2NDVafQ9sGs0YtBX/nl8zG3xToy6MF80/IYurItQKiIVkDaTQ24FhUVdvv4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n2zFwqrnCjfxuTYE2fhSs+piNuvmxm7pT5WDpwNQDVc=;
	b=WZgsUuhgN4JdR57Yz/64eoiLRPZ3gTHaCanchHxZe4NNu3CJ4Svt/PKnklAhwF3C1jVT
	 SC0nLws1fZ0ih5S66KnNCbGJsFQqMDw1c8xnH1Utb+PWw4H78n2PN1ze+m+oIDGvVnEGP
	 /7SA7XU87QoGMXHzfVhqR53CppdIp4DzC7dK1qUw899xKm3sa5beYIG6Ng2geKKcI9xKo
	 X16/XpksqD3vZsjSij+GhZHAyDYoz/Pno5LnZ4cCQ5FEoeExahSEU2RnKjLbqF4RfEiX4
	 Ry1BlWsRPLN32cElcvKfFQf99AAaVmyaiIhx+aunwkF8AaroIsKK1Qleci5L5WFZZtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvjqiMNS;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE965606A334
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 00:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE965606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvjqiMNS
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a315ed211so386475eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049990; x=1795654790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n2zFwqrnCjfxuTYE2fhSs+piNuvmxm7pT5WDpwNQDVc=;
        b=DvjqiMNS8oQ7J7DvVlAF8LaY16kIMYLml4ncljITaMKPEtAWrZFgtNCYUym4jzmXHy
         9DTtX0/tD1oT+YolE/rBai1KTiWiciHHoyoyd4cGbSUlsIR4V+5OC2WoJIy+XxMsBTEm
         SUjrWFD7HENRrHDAHjAZN5CzBR54kWsEj1HvbhC8c14njbwJyqqLlECdhSSSBZvfh5A5
         OEAZD3Zu05Cktacbi3NQx324ORVJe84065wvF37YGEKEicgZbaeR3XWr5grCeSUt6eDn
         ypjLVG6PE215RfB1fe0nMWBZfp4F5bo1k88x3aRGTF8DS9kwTLOfy1uMksJBjf1Ml1fu
         dKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049990; x=1795654790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n2zFwqrnCjfxuTYE2fhSs+piNuvmxm7pT5WDpwNQDVc=;
        b=f4L/oO5pB8Licz8HzWyMhI+6fT/kC043nz2GXm6duGer5kNwZjnzErkNC1Qt4WTgMg
         gF9WcY8TMyDNeG3JP1Q/cfUFDKZi6jEy9uYJtJnnuMtjvYauAvwr4JOlvTYDvX+6LvmB
         twq7xEzTB7PHi0asxknqxDFDWTM7l28ayCu+s18bgxUPiPDsgpteaoNpWvM69k8DIPF7
         /FjG9ZlBfi7h081awbZOvjJGtlGPxZo4Lsbt38h0jTiDXd31ER0fOZC/UHb18yY+LnQl
         DEeJMywF0nMotGrbEeGpW7AhTRbrGTmy8SD+/wEeBr+PZ3AkOqxfEsmC1Hhfp7SfmP1a
         EBWQ==
X-Gm-Message-State: APuU4Z9cruhzZh8b9P0Qm2Bzq0e3dcoNXXkgbcIMyY9+idQEjAUiRj/R
	vTW++B8ljhzCoEkdoODOjGGDlj2J0S44wG6HEVXdQZhJ1NXjEwyLv0m5
X-Gm-Gg: AZFdTZfzyJeZPlup9FgkofI+PQPlrif70SGBuhVwuQ37/tbJGFirIB+heXOQbeBthcm
	GUOGsYetfhwR3t9JmLeBRn02xYHj9Kd5pSWeIYnW0zKlWRz1ERHBbwQk23TrBUPBhHGASDCjzSX
	u/BrH1zKE2hxowia6fOlVAZVpVrQA5bYFzOY7hOlg6Q1zOdgqHfgyDYNPlrIbFfciVt4beTVcEo
	c5yeJTgC6zUKWqbDQdxrHDJbuoeKzMv+RJVb4bqCPeIxVKljrEkbEvqZc9kZ041HerwzpV8GeiO
	htG+x5iJsc8c8MaytSlJexMaRhLHFok3Pl+mp15kyzIMhrqrmQ2G7yevd52MOqtNkSMgHe6uWS7
	0MYA5iv+0hOHsdTiVX143iGyejlVw7MEr0QI1/EAP87KyOzPej1lhDQ9n7d6NiaMC20kWZTvrCN
	jzfuC1vxqvdDymEMPjBBbsrDAAIK0KkOMzghfIVIq51rbVH5ihRhEHE6msi33ye1ehnfZpzr2Jm
	8ocA7mw/bfmrOgFJESJ05e/KJRjBZK1TW++2rfu4yOregJV/r4RSVcP+f7/VFoiproSHDkqJeHY
	9r78dXYDi1TeV/EUDIFBzB4eazCEnu1ZLRKmhKgW0o2wesApQn2hy+vN7uF6UuNE2NLE4bErpFe
	7x7jZdD7EFceX6hG0d1nQZWo9ELEgTN+vZRF1O/2l+c9t9JoL
X-Received: by 2002:a05:7301:9a8d:b0:36a:79cd:12df with SMTP id 5a478bee46e88-384447032camr330493eec.9.1795049989804;
        Wed, 18 Nov 2026 16:59:49 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:9887:3c66:c29:4859])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm13456446eec.18.2026.11.18.16.59.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 16:59:49 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v3 1/3] hfs/hfsplus: add HFS_BNODE_DESC_SIZE for the node descriptor size
Date: Wed, 18 Nov 2026 16:59:41 -0800
Message-ID: <20261119005943.37851-2-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119005943.37851-1-ozgunkultekin@gmail.com>
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
 <20261119005943.37851-1-ozgunkultekin@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brec.c and btree.c in both drivers use the literal 14 for the size of
struct hfs_bnode_desc, which is also the offset of record 0 in a node.
Add HFS_BNODE_DESC_SIZE next to the structure and use it instead.

No functional change. The next two patches use the new name in the
hfs_bnode_read_key() calls they change.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org # prerequisite for the next two patches
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
v3: new patch, as requested by Viacheslav

 fs/hfs/brec.c              | 32 +++++++++++++++++++++-----------
 fs/hfs/btree.c             |  4 ++--
 fs/hfsplus/brec.c          | 31 ++++++++++++++++++++-----------
 fs/hfsplus/btree.c         |  4 ++--
 include/linux/hfs_common.h |  3 +++
 5 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 1ca1ee9f7..31574e562 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -156,7 +156,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		__hfs_brec_find(fd->bnode, fd);
 
 		hfs_bnode_put(new_node);
@@ -402,7 +403,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 
 	/* size difference between old and new key */
 	if (tree->attributes & HFS_TREE_VARIDXKEYS)
-		newkeylen = (hfs_bnode_read_u8(node, 14) | 1) + 1;
+		newkeylen = (hfs_bnode_read_u8(node,
+					       HFS_BNODE_DESC_SIZE) | 1) + 1;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 1;
 	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
@@ -441,7 +443,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	hfs_bnode_move(parent, start_off + diff, start_off,
 		       end_off - start_off);
 skip:
-	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
+	hfs_bnode_copy(parent, fd->keyoffset, node, HFS_BNODE_DESC_SIZE,
+		       newkeylen);
 	if (!(tree->attributes & HFS_TREE_VARIDXKEYS))
 		hfs_bnode_write_u8(parent, fd->keyoffset, newkeylen - 1);
 	hfs_bnode_dump(parent);
@@ -458,7 +461,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd);
@@ -470,7 +474,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key,
+					   HFS_BNODE_DESC_SIZE);
 		}
 		new_node = NULL;
 	}
@@ -524,28 +529,33 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
 
 	rec = tree->node_size - 2;
-	hfs_bnode_write_u16(new_node, rec, 14);
+	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_DESC_SIZE);
 
 	if (node) {
 		/* insert old root idx into new root */
 		node->parent = tree->root;
 		if (node->type == HFS_NODE_LEAF ||
 		    tree->attributes & HFS_TREE_VARIDXKEYS)
-			key_size = hfs_bnode_read_u8(node, 14) + 1;
+			key_size = hfs_bnode_read_u8(node,
+						     HFS_BNODE_DESC_SIZE) + 1;
 		else
 			key_size = tree->max_key_len + 1;
-		hfs_bnode_copy(new_node, 14, node, 14, key_size);
+		hfs_bnode_copy(new_node, HFS_BNODE_DESC_SIZE, node,
+			       HFS_BNODE_DESC_SIZE, key_size);
 
 		if (!(tree->attributes & HFS_TREE_VARIDXKEYS)) {
 			key_size = tree->max_key_len + 1;
-			hfs_bnode_write_u8(new_node, 14, tree->max_key_len);
+			hfs_bnode_write_u8(new_node, HFS_BNODE_DESC_SIZE,
+					   tree->max_key_len);
 		}
 		key_size = (key_size + 1) & -2;
 		cnid = cpu_to_be32(node->this);
-		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
+		hfs_bnode_write(new_node, &cnid,
+				HFS_BNODE_DESC_SIZE + key_size, 4);
 
 		rec -= 2;
-		hfs_bnode_write_u16(new_node, rec, 14 + key_size + 4);
+		hfs_bnode_write_u16(new_node, rec,
+				    HFS_BNODE_DESC_SIZE + key_size + 4);
 
 		hfs_bnode_put(node);
 	}
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index f07038403..4c2f82c1c 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -356,8 +356,8 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 	desc.num_recs = cpu_to_be16(1);
 	desc.reserved = 0;
 	hfs_bnode_write(node, &desc, 0, sizeof(desc));
-	hfs_bnode_write_u16(node, 14, 0x8000);
-	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
+	hfs_bnode_write_u16(node, HFS_BNODE_DESC_SIZE, 0x8000);
+	hfs_bnode_write_u16(node, tree->node_size - 2, HFS_BNODE_DESC_SIZE);
 	hfs_bnode_write_u16(node, tree->node_size - 4, tree->node_size - 6);
 
 	return node;
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index f416e562d..37e058c5d 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -166,7 +166,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
 
 		hfs_bnode_put(new_node);
@@ -409,7 +410,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	/* size difference between old and new key */
 	if ((tree->attributes & HFS_TREE_VARIDXKEYS) ||
 				(tree->cnid == HFSPLUS_ATTR_CNID))
-		newkeylen = hfs_bnode_read_u16(node, 14) + 2;
+		newkeylen = hfs_bnode_read_u16(node, HFS_BNODE_DESC_SIZE) + 2;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 2;
 	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
@@ -449,7 +450,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	hfs_bnode_move(parent, start_off + diff, start_off,
 		       end_off - start_off);
 skip:
-	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
+	hfs_bnode_copy(parent, fd->keyoffset, node, HFS_BNODE_DESC_SIZE,
+		       newkeylen);
 	hfs_bnode_dump(parent);
 
 	hfs_bnode_put(node);
@@ -464,7 +466,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
@@ -476,7 +479,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key,
+					   HFS_BNODE_DESC_SIZE);
 		}
 		new_node = NULL;
 	}
@@ -530,7 +534,7 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
 
 	rec = tree->node_size - 2;
-	hfs_bnode_write_u16(new_node, rec, 14);
+	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_DESC_SIZE);
 
 	if (node) {
 		/* insert old root idx into new root */
@@ -538,21 +542,26 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 		if (node->type == HFS_NODE_LEAF ||
 				tree->attributes & HFS_TREE_VARIDXKEYS ||
 				tree->cnid == HFSPLUS_ATTR_CNID)
-			key_size = hfs_bnode_read_u16(node, 14) + 2;
+			key_size = hfs_bnode_read_u16(node,
+						      HFS_BNODE_DESC_SIZE) + 2;
 		else
 			key_size = tree->max_key_len + 2;
-		hfs_bnode_copy(new_node, 14, node, 14, key_size);
+		hfs_bnode_copy(new_node, HFS_BNODE_DESC_SIZE, node,
+			       HFS_BNODE_DESC_SIZE, key_size);
 
 		if (!(tree->attributes & HFS_TREE_VARIDXKEYS) &&
 				(tree->cnid != HFSPLUS_ATTR_CNID)) {
 			key_size = tree->max_key_len + 2;
-			hfs_bnode_write_u16(new_node, 14, tree->max_key_len);
+			hfs_bnode_write_u16(new_node, HFS_BNODE_DESC_SIZE,
+					    tree->max_key_len);
 		}
 		cnid = cpu_to_be32(node->this);
-		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
+		hfs_bnode_write(new_node, &cnid,
+				HFS_BNODE_DESC_SIZE + key_size, 4);
 
 		rec -= 2;
-		hfs_bnode_write_u16(new_node, rec, 14 + key_size + 4);
+		hfs_bnode_write_u16(new_node, rec,
+				    HFS_BNODE_DESC_SIZE + key_size + 4);
 
 		hfs_bnode_put(node);
 	}
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 0a9b32d5c..519f07b81 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -497,8 +497,8 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 	desc.num_recs = cpu_to_be16(1);
 	desc.reserved = 0;
 	hfs_bnode_write(node, &desc, 0, sizeof(desc));
-	hfs_bnode_write_u16(node, 14, 0x8000);
-	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
+	hfs_bnode_write_u16(node, HFS_BNODE_DESC_SIZE, 0x8000);
+	hfs_bnode_write_u16(node, tree->node_size - 2, HFS_BNODE_DESC_SIZE);
 	hfs_bnode_write_u16(node, tree->node_size - 4, tree->node_size - 6);
 
 	return node;
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 802d1590e..1b639bbd1 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -495,6 +495,9 @@ struct hfs_bnode_desc {
 	u16 reserved;
 } __packed;
 
+/* Size of the node descriptor, which is also the offset of record 0 */
+#define HFS_BNODE_DESC_SIZE	sizeof(struct hfs_bnode_desc)
+
 /* HFS/HFS+ BTree node types */
 #define HFS_NODE_INDEX	0x00	/* An internal (index) node */
 #define HFS_NODE_HEADER	0x01	/* The tree header node (node 0) */
-- 
2.39.5

