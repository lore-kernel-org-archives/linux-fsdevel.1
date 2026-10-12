Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9F4BB293;
	Mon, 12 Oct 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825089; cv=none; b=bognFgYnfYBc9c6X6C6vq4jdYlphOcV9dbwojSq3KLwHl2Ck9zRgmsSlyGkj0trKhzhiquo3WKzqGZaRAZeauNrOz4NAFjAoi31iHrmqx9PB2SxmmX6G59e8mL+Ba/L3sG1LA2dkyALG6m3gQ+Lz6SNcXGjkIYa6ve72FwKpntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825089; c=relaxed/simple;
	bh=bq9n0C2W49WuWQMPx1mq1hu0fQtznO8Qg5MBuoMPNbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLb6/oRBc7YK9XvyNYorqowszHCVUdP17gaXKlWMUSK5s9Gt1DlT6gB8ngyUxh63N4tusF0DEyIYy0MiBbR5JRsS0eg3o71wBdlxxndkpZFtHL0dKw6Oty4gQqJODunmHYWEi5AY7iAA1ylvZpCoq2IoUcN8CCpn5+KqlkPiTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=1yZDkT9s; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="1yZDkT9s"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 0CD4E121121;
	Mon, 12 Oct 2026 14:11:15 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791825075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AekpOn0RQNvYktcb9eJqXpRgLVmePdgHhuHcsjY2Z1A=;
	b=1yZDkT9sWqo2L6Es35RF6Bx3jARqN5pMplCSMms8nfMWsvyj+3s0qLcd8Aridn6N7tYr/p
	bbG90FYDNptMacthgBGbjhMxCo0BmXv+pEOGTj0XHVbM8/nyBDFbtLV1nslt7O0t+aHlKg
	dtJBpTXISNrPs8aBianiXdcdRXiT5seMFbnQ2qxE5OLzbUaLraOZxbZj7JKp9fmx50DuLW
	8Khjt99WhFJHPtUq1qQwKeX7WBxtY8zLC1VMl3bdRRtf6lVu3cRaWLIj/vgaB7upv+iMwA
	9z2VSO5zGvX0XS6TzhxROVCxG3SDkhHDOMVtFRZ0X3IIz27Nj4E8Z9kMHJ5aZg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2 1/3] fat: remove cluster allocation size limit
Date: Mon, 12 Oct 2026 14:11:04 -0300
Message-ID: <20261012171106.146243-2-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fat_alloc_clusters() currently BUG()s when asked to allocate more than
MAX_BUF_PER_PAGE / 2 clusters. This limit comes from the buffer_head
array used to defer syncing and mirroring.

Remove the allocation size limit by doing buffer_head batching like
fat_free_clusters() does.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fatent.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f0801d99d..bfab8eab5 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -468,6 +468,26 @@ static void fat_collect_bhs(struct buffer_head **bhs, int *nr_bhs,
 	}
 }
 
+static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
+			 int *nr_bhs, bool sync)
+{
+	int err, i;
+
+	if (sync) {
+		err = fat_sync_bhs(bhs, *nr_bhs);
+		if (err)
+			return err;
+	}
+	err = fat_mirror_bhs(sb, bhs, *nr_bhs);
+	if (err)
+		return err;
+	for (i = 0; i < *nr_bhs; i++)
+		brelse(bhs[i]);
+	*nr_bhs = 0;
+
+	return 0;
+}
+
 int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 {
 	struct super_block *sb = inode->i_sb;
@@ -477,8 +497,6 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
 	int i, count, err, nr_bhs, idx_clus;
 
-	BUG_ON(nr_cluster > (MAX_BUF_PER_PAGE / 2));	/* fixed limit */
-
 	lock_fat(sbi);
 	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
 	    sbi->free_clusters < nr_cluster) {
@@ -509,14 +527,21 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 				if (prev_ent.nr_bhs)
 					ops->ent_put(&prev_ent, entry);
 
-				fat_collect_bhs(bhs, &nr_bhs, &fatent);
-
 				sbi->prev_free = entry;
 				if (sbi->free_clusters != -1)
 					sbi->free_clusters--;
 
 				cluster[idx_clus] = entry;
 				idx_clus++;
+
+				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
+					err = fat_flush_bhs(sb, bhs, &nr_bhs,
+							    inode_needs_sync(inode));
+					if (err)
+						goto out;
+				}
+				fat_collect_bhs(bhs, &nr_bhs, &fatent);
+
 				if (idx_clus == nr_cluster)
 					goto out;
 
@@ -606,17 +631,10 @@ int fat_free_clusters(struct inode *inode, int cluster)
 		}
 
 		if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
-			if (sb->s_flags & SB_SYNCHRONOUS) {
-				err = fat_sync_bhs(bhs, nr_bhs);
-				if (err)
-					goto error;
-			}
-			err = fat_mirror_bhs(sb, bhs, nr_bhs);
+			err = fat_flush_bhs(sb, bhs, &nr_bhs,
+					    sb->s_flags & SB_SYNCHRONOUS);
 			if (err)
 				goto error;
-			for (i = 0; i < nr_bhs; i++)
-				brelse(bhs[i]);
-			nr_bhs = 0;
 		}
 		fat_collect_bhs(bhs, &nr_bhs, &fatent);
 	} while (cluster != FAT_ENT_EOF);
-- 
2.43.0

