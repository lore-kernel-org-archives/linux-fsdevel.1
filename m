Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5F3F88BE;
	Mon, 18 May 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104933; cv=none; b=bPkN1JMX/+KwnDKw5LBdBE/YujvI0tyHi5IWkwjvhHv7bckC0CPHe+14F+okKWs8kex9gdk4XD8ciZrfuEFLmtIOkO/Zz8ap5rt+5ATwsbUOH3507YkcYNRGn2J+Oc0gF9yxDNjdt6MkKi/LT8faRso3TVGp3VI4LVN5EllNuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104933; c=relaxed/simple;
	bh=ePwFt6WZQWGzpjDM/17T2euZQqvsXII9mFNbn60lCqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koTE5d8/T0NtKuukQqYRxYJO6yxPoK/KpxbIFWXN7BTk5enPKEKNTcQxLpeuctpGPFnZO1Zs/ZIyl7gVB0e12oButr4pcKRL+WitJddUN25Gw85Afq408iwyBQBCLqtzao2SH4XOwa/+ryaDcJ3BkdBW5UIaNwsI/jcluHZb7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shaQCEg+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shaQCEg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F13DC2BCB7;
	Mon, 18 May 2026 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104932;
	bh=ePwFt6WZQWGzpjDM/17T2euZQqvsXII9mFNbn60lCqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=shaQCEg+Qt/GKoggDdoDTFZ5ys0eAKEhplXL1bdLIKjbi4l/PZEk127ojeiFdIq10
	 YHni3q/ntJvVvW1RrWLQ3VQBIA1VRNwxyC6iP9YDgODaJIRjXAT1ROeXmUjFGusPSZ
	 a0A0RH62+GsZi0lPXEttnm1dY9pL9yWkNedRe5GwPedJQtMoPdOaLeFzM10ipRJp+d
	 xr77GTiGm+LMBgKsKmGjfcGRWUfN3BxbQ58ObyBoUGb81mQL0jAexDr1ZiXI+XZyRj
	 Ir7HeFFRICCUYSI9lo3H/YU7R+DwjGwt0WGEvwUZOacVnzhdpiU51d85swwx7tUQWb
	 cR1kwxeNiiVZw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 05/11] exfat: add support for multi-cluster allocation
Date: Mon, 18 May 2026 20:46:59 +0900
Message-Id: <20260518114705.9601-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently exfat_map_cluster() allocates and returns only one cluster
at a time even when more clusters are needed. This causes multiple
FAT walks and repeated allocation calls during large sequential writes
or when using iomap for writes. This change exfat_map_cluster() and
exfat_alloc_cluster() to be able to allocate multiple contiguous
clusters.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/dir.c      |  2 +-
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/fatent.c   | 26 ++++++++++++++++----------
 fs/exfat/file.c     |  2 +-
 fs/exfat/inode.c    | 23 ++++++-----------------
 fs/exfat/namei.c    |  2 +-
 6 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ca9d707220df..37f324399b6b 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -295,7 +295,7 @@ int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu)
 
 	exfat_chain_set(clu, EXFAT_EOF_CLUSTER, 0, ALLOC_NO_FAT_CHAIN);
 
-	ret = exfat_alloc_cluster(inode, 1, clu, IS_DIRSYNC(inode));
+	ret = exfat_alloc_cluster(inode, 1, clu, IS_DIRSYNC(inode), false);
 	if (ret)
 		return ret;
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 9c8ab3df7a42..6e7fd6822b01 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -497,7 +497,7 @@ int exfat_clear_volume_dirty(struct super_block *sb);
 	exfat_cluster_walk(sb, (pclu), 1, ALLOC_FAT_CHAIN)
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
-		struct exfat_chain *p_chain, bool sync_bmap);
+		struct exfat_chain *p_chain, bool sync_bmap, bool contig);
 int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain);
 int exfat_ent_get(struct super_block *sb, unsigned int loc,
 		unsigned int *content, struct buffer_head **last);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 45b0b754a2e4..a917c954bd23 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -419,7 +419,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 }
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
-		struct exfat_chain *p_chain, bool sync_bmap)
+		struct exfat_chain *p_chain, bool sync_bmap, bool contig)
 {
 	int ret = -ENOSPC;
 	unsigned int total_cnt;
@@ -470,14 +470,20 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 
 	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) !=
 	       EXFAT_EOF_CLUSTER) {
-		if (new_clu != hint_clu &&
-		    p_chain->flags == ALLOC_NO_FAT_CHAIN) {
-			if (exfat_chain_cont_cluster(sb, p_chain->dir,
-					p_chain->size)) {
-				ret = -EIO;
-				goto free_cluster;
+		if (new_clu != hint_clu) {
+			if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+				if (exfat_chain_cont_cluster(sb, p_chain->dir,
+							     p_chain->size)) {
+					ret = -EIO;
+					goto free_cluster;
+				}
+				p_chain->flags = ALLOC_FAT_CHAIN;
+			}
+
+			if (contig && p_chain->size > 0) {
+				hint_clu--;
+				goto done;
 			}
-			p_chain->flags = ALLOC_FAT_CHAIN;
 		}
 
 		/* update allocation bitmap */
@@ -507,9 +513,9 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		last_clu = new_clu;
 
 		if (p_chain->size == num_alloc) {
+done:
 			sbi->clu_srch_ptr = hint_clu;
-			sbi->used_clusters += num_alloc;
-
+			sbi->used_clusters += p_chain->size;
 			mutex_unlock(&sbi->bitmap_lock);
 			return 0;
 		}
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index d0ecdcb4bf7a..1effdf08ab69 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -56,7 +56,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	clu.flags = ei->flags;
 
 	ret = exfat_alloc_cluster(inode, new_num_clusters - num_clusters,
-			&clu, inode_needs_sync(inode));
+			&clu, inode_needs_sync(inode), false);
 	if (ret)
 		return ret;
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index a10d4f3c66a1..7b09d94ac464 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -137,9 +137,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	unsigned int num_to_be_allocated = 0, num_clusters;
 
 	num_clusters = exfat_bytes_to_cluster(sbi, exfat_ondisk_size(inode));
-
-	if (clu_offset >= num_clusters)
-		num_to_be_allocated = clu_offset - num_clusters + 1;
+	if (clu_offset > num_clusters ||
+	    *count > num_clusters - clu_offset)
+		num_to_be_allocated = clu_offset + *count - num_clusters;
 
 	if (!create && (num_to_be_allocated > 0)) {
 		*clu = EXFAT_EOF_CLUSTER;
@@ -182,7 +182,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		}
 
 		ret = exfat_alloc_cluster(inode, num_to_be_allocated, &new_clu,
-				inode_needs_sync(inode));
+				inode_needs_sync(inode), true);
 		if (ret)
 			return ret;
 
@@ -216,20 +216,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		}
 
 		*clu = new_clu.dir;
+		*count = new_clu.size;
 
-		inode->i_blocks +=
-			exfat_cluster_to_sectors(sbi, num_to_be_allocated);
-
-		/*
-		 * Move *clu pointer along FAT chains (hole care) because the
-		 * caller of this function expect *clu to be the last cluster.
-		 * This only works when num_to_be_allocated >= 2,
-		 * *clu = (the first cluster of the allocated chain) =>
-		 * (the last cluster of ...)
-		 */
-		if (exfat_cluster_walk(sb, clu, num_to_be_allocated - 1, ei->flags))
-			return -EIO;
-		*count = 1;
+		inode->i_blocks += exfat_cluster_to_sectors(sbi, new_clu.size);
 		if (balloc)
 			*balloc = true;
 	}
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 752fbec9316b..87e55c5c1bf4 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -341,7 +341,7 @@ int exfat_find_empty_entry(struct inode *inode,
 		}
 
 		/* allocate a cluster */
-		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode));
+		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode), false);
 		if (ret)
 			return ret;
 
-- 
2.25.1

