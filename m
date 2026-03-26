Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC63F65EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525886; cv=none; b=fFiG/evU28if4boR7hJN6EhLBOJH7OyEtN49A90PCgZIPVKVplUHoSxxWpVbdacQ4fyoKeNj6dew6v5gF31KWRd5MD+qBHe/HhWQAu8JZbBMVY02pKEWfknEgNzx9b5/c4pPs5baohs+T9Z2QDvPvC9bJ4gTOq8dFOBO+BA6bLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525886; c=relaxed/simple;
	bh=FHAgZwNmZ6YeTnKrQSYRwqSmGNTa6089KBrxF+sbr/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCgzohtTmPR5hqTAya71+ko0DBfdod+Tkp8bGOwaEMzBBFveifpikuF726K566IqSDZ3/qWT1wKP2yk4weBIjX+S79J08x9s4l0BDqLe6rD+bjF5+pTbdszeOXoL6VIK82+aLK24yZ5iTVDRBqSN1BzBAVKKiLa+HuuwiB8wAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0afa0210bso4510855ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 04:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525882; x=1775130682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=piCpGpUvKt0FEtrBr/+FMZAoJUXJa78mnuAnSg92uEs=;
        b=kKEgMxOvF2Qyyoeb1WmLcUo9L3W11/HZs7O/O+vugz1+MlRyZCSktLaB8tNlKmIuD1
         B+2JGfwXUk2QVCVHRaROuqRn520ab5xP+4M/AR232jB8wp6tIAlu4RLVTQGHylq8hL40
         YGkDVs46EQ2qvDq737tFM2a6Or79pcvfS5pjst+9ki/pCjDUGbQCTGi/ko4ICRWteQ4m
         M1IacHMvb5TzzyYBsvTfWHLhStt9s2QRmMyN2YRvjeENSxKpDDWMkh9yo8g6cjPfLkoQ
         cfW1Gqvif+lH/m7968cIYXvv+sgFiz87L4DjK0cFCLZU0yNPxTiYJWu3EE6DuaKl60vk
         tbtQ==
X-Gm-Message-State: AOJu0YwS8xZcb84oC0f5PAqeqSKVfuBUBCZo61u9mw2ULj0Lsnf9mYbv
	heh+kiDKupcBnrqihoyyzwDxkd8RuP6nNtNWCPwiVf6aZK0TVrW5/sca
X-Gm-Gg: ATEYQzx+yGANP5PHGsswWa8ZDEVKGHcuNRNpgbvt4b90WSCVrwtTeP4FC7bCCOZ0nKi
	B8ohgfTgS2ToSTdqWUS5ZpFPHHy8CEuL9eeKt7uctBq5QwtDh2DYqH5x32XucNQIkJa4kaxOJAh
	yCAo6Z7LmGtZlYPA/jbfMNxFfwAaagksJz7KcFwKu/tvFi/7e6A1GQ4WkApPqbl+9b/BSYfHyCt
	WMc+slWEo73Tl5F1jFoSxubfe7ZB848VtwqL+8XBI9K6SArRiN9SH/RPlgmNeltVNzsq1KZlXfE
	IMXe+qOAYOZjU4Cjov1jdpANpSj+vGqJIsvSGtxsN6lOAKAAgwLWZEBO1y/mqKxFfajvPaRJpQ7
	EjkX9dvIW0PM1YxPrfz2mp1aHzzMny9ZFwAGVaD0vkd4QY03V6IeoXh0fI2PLJKJQ6PHirL6SiD
	iNB3LpRaCQy/6JCEYuJVQ+I2S5Y/PEg15YLv9grw==
X-Received: by 2002:a17:902:f542:b0:2b0:6323:1739 with SMTP id d9443c01a7336-2b0b0af8590mr70472815ad.41.1774525882371;
        Thu, 26 Mar 2026 04:51:22 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm28425285ad.2.2026.03.26.04.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:51:21 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	hch@lst.de,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 4/5] exfat: add support for multi-cluster allocation
Date: Thu, 26 Mar 2026 20:50:44 +0900
Message-Id: <20260326115045.9525-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260326115045.9525-1-linkinjeon@kernel.org>
References: <20260326115045.9525-1-linkinjeon@kernel.org>
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

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/dir.c      |  2 +-
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/fatent.c   | 26 ++++++++++++++++----------
 fs/exfat/file.c     |  2 +-
 fs/exfat/inode.c    | 32 +++++---------------------------
 fs/exfat/namei.c    |  2 +-
 6 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index a2c2b998808c..857b22e431cd 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -308,7 +308,7 @@ int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu)
 
 	exfat_chain_set(clu, EXFAT_EOF_CLUSTER, 0, ALLOC_NO_FAT_CHAIN);
 
-	ret = exfat_alloc_cluster(inode, 1, clu, IS_DIRSYNC(inode));
+	ret = exfat_alloc_cluster(inode, 1, clu, IS_DIRSYNC(inode), false);
 	if (ret)
 		return ret;
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 54da001a8f55..5992755b5ab3 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -448,7 +448,7 @@ int exfat_clear_volume_dirty(struct super_block *sb);
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu, NULL)
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
-		struct exfat_chain *p_chain, bool sync_bmap);
+		struct exfat_chain *p_chain, bool sync_bmap, bool contig);
 int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain);
 int exfat_ent_get(struct super_block *sb, unsigned int loc,
 		unsigned int *content, struct buffer_head **last);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index f2e5d5dde393..758c2d971e73 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -424,7 +424,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 }
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
-		struct exfat_chain *p_chain, bool sync_bmap)
+		struct exfat_chain *p_chain, bool sync_bmap, bool contig)
 {
 	int ret = -ENOSPC;
 	unsigned int total_cnt;
@@ -475,14 +475,20 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 
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
@@ -512,9 +518,9 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
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
index 5f85e2e0a71e..d7857aec072b 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -57,7 +57,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	clu.flags = ei->flags;
 
 	ret = exfat_alloc_cluster(inode, new_num_clusters - num_clusters,
-			&clu, inode_needs_sync(inode));
+			&clu, inode_needs_sync(inode), false);
 	if (ret)
 		return ret;
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index c53ae9293cfe..46dc98ef1afb 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -128,14 +128,10 @@ int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	unsigned int local_clu_offset = clu_offset;
-	unsigned int num_to_be_allocated = 0, num_clusters;
+	unsigned int num_to_be_allocated = *count, num_clusters;
 
 	num_clusters = EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);
-
-	if (clu_offset >= num_clusters)
-		num_to_be_allocated = clu_offset - num_clusters + 1;
-
-	if (!create && (num_to_be_allocated > 0)) {
+	if (!create && clu_offset >= num_clusters) {
 		*clu = EXFAT_EOF_CLUSTER;
 		return 0;
 	}
@@ -176,7 +172,7 @@ int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		}
 
 		ret = exfat_alloc_cluster(inode, num_to_be_allocated, &new_clu,
-				inode_needs_sync(inode));
+				inode_needs_sync(inode), true);
 		if (ret)
 			return ret;
 
@@ -210,26 +206,8 @@ int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		}
 
 		*clu = new_clu.dir;
-
-		inode->i_blocks += EXFAT_CLU_TO_B(num_to_be_allocated, sbi) >> 9;
-
-		/*
-		 * Move *clu pointer along FAT chains (hole care) because the
-		 * caller of this function expect *clu to be the last cluster.
-		 * This only works when num_to_be_allocated >= 2,
-		 * *clu = (the first cluster of the allocated chain) =>
-		 * (the last cluster of ...)
-		 */
-		if (ei->flags == ALLOC_NO_FAT_CHAIN) {
-			*clu += num_to_be_allocated - 1;
-		} else {
-			while (num_to_be_allocated > 1) {
-				if (exfat_get_next_cluster(sb, clu))
-					return -EIO;
-				num_to_be_allocated--;
-			}
-		}
-		*count = 1;
+		*count = new_clu.size;
+		inode->i_blocks += EXFAT_CLU_TO_B(new_clu.size, sbi) >> 9;
 		*balloc = true;
 	}
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index d0ea1ff81c09..6261cd994d1d 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -347,7 +347,7 @@ int exfat_find_empty_entry(struct inode *inode,
 		}
 
 		/* allocate a cluster */
-		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode));
+		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode), false);
 		if (ret)
 			return ret;
 
-- 
2.25.1

