Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712197;
	b=uH/IRaA13hbUtrMCHMX7pNnaQIKzbxrz7ecf/+4DNfaJbJC4He7bCecX8KM+FJRKzcYy
	 L18mSTnenmSiq/rQGJsfvNNeWDAhOl4YhBK061GxEpdHelm98zuaji/Vp2y+t+0h4CQ48
	 Ncg+dJvc3d1Gd48/zc5FXAc9HUwCdEho8SkYILjpmpC9QJLpKBYyBaH2fGdjZEODde4gS
	 mCYvrRT0U468XRL43WR/lq079KIH5uRA6TNbMkG1GPNzthQ7FrtOuawrcKfx9fsclVNGk
	 POi5dEm+qGJdgFU1mMLtDRRflNOtbARR6U5kByw9grsBROWNom49zQyER0vGsklfMcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vd0cJ9duAzPWkS9K0wzMKp/efF51QEmYJSWs3p1I1Z0=;
	b=pZOXQQNyGgCU6iXo4cHgH3aBsvTQOg2xXEhUbUxbnPznB8XSLsIlXRMSpuHum4t1NDFJ
	 tS4lEJT49idc4wotTYw2lZK94MzGiI5cRDQL2P8ztrkAl2aEPt/5qftj5UdBNh/vt1Dzt
	 jd87+prZsCM0nfiQIvFAXDT6nBkcMpbkjKtqZR9PWwGY06rFYmp7fKievQmGDo5my03Vz
	 uXyIKnfXdxpfhXvjmh7JnVQJF4yjWhbyNScb4lUuEKb6o3ewA8MqAFQyfJAPVRj8q5nKL
	 Mydr64hFNyJyOIaGAkFAb69K+Jf+lZfVS5h1OrhMauH7hia0vA5s4Hs3Rb1IjmndDaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YWEPFA6l;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265D606A745
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 23:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C265D606A745
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YWEPFA6l
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6798eb0d13fso513419d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792712196; x=1793316996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vd0cJ9duAzPWkS9K0wzMKp/efF51QEmYJSWs3p1I1Z0=;
        b=YWEPFA6luN/2OpWohFoAlb8EklkjVbTvPyIgVLi+PhE01t2fCYwAjeGq9IA9anJOb9
         laSocgVZyAZ0X5vLaAsAH4oMV0MQjWWTPlX7EcMd+8ow7Jh652Q0SiQNRFVy3ZXVfnOf
         hTx3BoHC7b5QyfMncfJD40E58RaTxbwiZgL/MLulV9hWpRsH8Ceb30musVmJTmTBCjJ3
         9vtHXR6Q10Kj4OTPBl73ONZYlQq3VLhfURNL8rg6S3Ez9bZQb9gVHO5FWdEEPZ/nr/O9
         9OwWLlxmowINoFJswGsElE1KTMR0IQwTEzQcq0ZiibCGTvtAdmML0fqJ183x7Q3BMGi4
         FeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712196; x=1793316996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vd0cJ9duAzPWkS9K0wzMKp/efF51QEmYJSWs3p1I1Z0=;
        b=T+54LhjHIltPD1l1cNf0maMkSYU7MF02ukHyBUzkFqNLkdaEgDdCOHOuNmbOeB0ZwH
         TK1qDrGX8OS4fxqCDdOerN5SVJu2N+llfKsxK8h0QZc2DwkDw+COQmGri0DlkGY68ZLU
         1ERkMcu+jfVC3p91h/KhigUCwOUqecZ64UFxcYu9czZG3HDSu/3TaIjX7EVPGVeLkAkF
         x3Rv3SrywZfbpYJ1IN4mFsdeJge9KaZxNevkQrpT7Yc2W1JD1gVaVYhux7J8qNzp2zL+
         SoTZyR2qOk8c8aX8ZH+qkgr4ENBHdv80otXJOPMwu/BYXESRMOgOmZlzWhmM5w8qzw1l
         5DLg==
X-Gm-Message-State: AFq9FYILLC2nSSaDcZ7uYeAvKIZKEhJMLVMWLFhSj8whVQN+pGr1J2PR
	XWiBDYUq934FvesmaLc8Rrzc7Dwgs9mB0NgcVI494iMcdOEsMOEGdGG+PTY49n1OWDG19ekclIr
	KR1Wle8w=
X-Gm-Gg: AYBFou0S4pf+yTWzcy9hZbpK2RmZ/RbO8MgMv1qNtaTcd1wnHkeF/atpPQWmT8BQaSU
	yVgTY5IdkoUVW4YSveovMXxKaWkU2eozlAY0B2OeOj4ezRopeZ+FfF9Uax5XCCg2h8WmcnynVJo
	IRZTCVLX7EsMF+C+gQGl/dkjW9iBBDUgyE8D/bt2GbIKedEe6HbMvZUd9MaZWZeMSyHNLLR85rj
	liimEBw9XqunjXicZcqc45Mz4AJd6QYf9e+asd2fDOTe1xU+7yv0B+6i8C6CbVrNI21SWvAMZ7g
	rQsVuYirjT0eYMbPKx8h4bojfUk9ESGadQMBiiFodCM1SC5FZVxTTbf4xz729gLPNYlUnVkiSXt
	qKX3dbyL/pAiZ2iTMTQofbyfvZNE/TH4fngCXI0NNQ9ahpl7wg4wlib/FQX9QQkIXnUYh5YpYZa
	0V27Jfyly6feM02Zw2BPME3Q2VDjwLJBviLFTSxvRyZ9UmKzlbDyRKSOXQgQetcO8ovbBLtJwN9
	zH6LTLSCWi3SoM2ggffCkd+vDFkrvZ/r3U2Cs+O/GKkmVMl/bqmI04Y0dmqzjRtHGB6cbu6r0Hn
	Q9vhUrGO5hGUytjcOzMcJKfznufCGj0roIEeX9SwR7q/34OAS4d/0BR3TI1zzI3eZsy2XJKPIYw
	h+wT1jO/vHw==
X-Received: by 2002:a05:690e:1507:b0:679:c803:98db with SMTP id 956f58d0204a3-67a35c0c3famr245359d50.149.1792712195858;
        Thu, 22 Oct 2026 16:36:35 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:5551:17ca:f374:dc57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a34009247sm487643d50.11.2026.10.22.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 16:36:34 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix potential race conditions in b-tree functionality
Date: Thu, 22 Oct 2026 16:35:48 -0700
Message-ID: <20261022233548.3481882-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022233548.3481882-1-slava@dubeyko.com>
References: <20261022233548.3481882-1-slava@dubeyko.com>
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

The HFS_BNODE_DELETED flag is checked in hfs_bnode_put()
under locked tree->hash_lock. Add locking for the case of
setting the HFS_BNODE_DELETED flag in hfs_bnode_unlink()
with the goal to avoid potential race conditions.

The hfs_btree_write() method should be called under
tree->tree_lock. Rework logic by adding locking
the tree->tree_lock for the calls of hfs_btree_write()
in hfs_write_inode() for the case of Extents and
Catalog b-tree inodes.

Also, add the lockdep_assert_held() in
hfs_bmap_reserve(), hfs_bmap_alloc(), and hfs_bmap_free().

HFS port of the HFS+ commit:
commit 6dca66d7ba17 ("hfsplus: fix potential race conditions in b-tree functionality")

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/bnode.c |  3 +++
 fs/hfs/btree.c |  5 +++++
 fs/hfs/inode.c | 13 +++++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 1b331108d9c0..93a13ece1eb4 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -271,7 +271,10 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
 		tree->root = 0;
 		tree->depth = 0;
 	}
+
+	spin_lock(&tree->hash_lock);
 	set_bit(HFS_BNODE_DELETED, &node->flags);
+	spin_unlock(&tree->hash_lock);
 }
 
 static inline int hfs_bnode_hash(u32 num)
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 4f0ddc76e8c5..b140d8597474 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -398,6 +398,8 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
 	u32 count;
 	int res;
 
+	lockdep_assert_held(&tree->tree_lock);
+
 	while (tree->free_nodes < rsvd_nodes) {
 		res = hfs_extend_file(inode);
 		if (res)
@@ -424,6 +426,8 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	u8 *data, byte, m;
 	int i, res;
 
+	lockdep_assert_held(&tree->tree_lock);
+
 	res = hfs_bmap_reserve(tree, 1);
 	if (res)
 		return ERR_PTR(res);
@@ -500,6 +504,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 
 	hfs_dbg("node %u\n", node->this);
 	tree = node->tree;
+	lockdep_assert_held(&tree->tree_lock);
 	nidx = node->this;
 	node = hfs_bnode_find(tree, 0);
 	if (IS_ERR(node))
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index cce3a7bb95e9..9dde4b43c88f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -468,6 +468,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct inode *main_inode = inode;
 	struct hfs_find_data fd;
+	struct hfs_btree *tree;
 	hfs_cat_rec rec;
 	int res;
 
@@ -481,10 +482,18 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		case HFS_ROOT_CNID:
 			break;
 		case HFS_EXT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
+			tree = HFS_SB(inode->i_sb)->ext_tree;
+			mutex_lock_nested(&tree->tree_lock,
+					  EXTENTS_BTREE_MUTEX);
+			hfs_btree_write(tree);
+			mutex_unlock(&tree->tree_lock);
 			return 0;
 		case HFS_CAT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
+			tree = HFS_SB(inode->i_sb)->cat_tree;
+			mutex_lock_nested(&tree->tree_lock,
+					  CATALOG_BTREE_MUTEX);
+			hfs_btree_write(tree);
+			mutex_unlock(&tree->tree_lock);
 			return 0;
 		default:
 			BUG();
-- 
2.43.0

